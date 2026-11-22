#!/usr/bin/env python3
"""
오프라인 manifest 검사 (Office Add-in XML manifest v1.1, ContentApp 기준)
- 공식 검증(npx office-addin-manifest validate)은 Microsoft 서버가 필요하므로,
  서버 없이도 잡을 수 있는 규칙을 여기서 먼저 확인한다.
사용법: python3 scripts/check-manifest.py manifest.xml store/manifest-store.xml
"""
import re
import sys
import xml.etree.ElementTree as ET

NS = "{http://schemas.microsoft.com/office/appforoffice/1.1}"
XSI = "{http://www.w3.org/2001/XMLSchema-instance}type"

# OfficeApp 공통 순서 + ContentApp 확장 순서 (OfficeAppManifestV1_1.xsd)
ORDER = ["Id", "AlternateId", "Version", "ProviderName", "DefaultLocale", "DisplayName",
         "Description", "IconUrl", "HighResolutionIconUrl", "SupportUrl", "AppDomains",
         "Hosts", "Requirements", "DefaultSettings", "Permissions", "AllowSnapshot"]
REQUIRED = ["Id", "Version", "ProviderName", "DefaultLocale", "DisplayName", "Description",
            "IconUrl", "SupportUrl", "DefaultSettings", "Permissions"]
PERMS = {"Restricted", "ReadDocument", "WriteDocument", "ReadWriteDocument"}
GUID = re.compile(r"^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
VERSION = re.compile(r"^\d{1,5}(\.\d{1,5}){1,3}$")


def check(path):
    errs, warns = [], []
    try:
        root = ET.parse(path).getroot()
    except ET.ParseError as e:
        return [f"XML 파싱 실패: {e}"], []

    if root.tag != NS + "OfficeApp":
        errs.append("루트가 OfficeApp(appforoffice/1.1)이 아님")
    if root.get(XSI) != "ContentApp":
        errs.append(f"xsi:type이 ContentApp이 아님: {root.get(XSI)}")

    children = [c.tag.replace(NS, "") for c in root]
    for r in REQUIRED:
        if r not in children:
            errs.append(f"필수 요소 없음: {r}")
    known = [c for c in children if c in ORDER]
    if known != sorted(known, key=ORDER.index):
        errs.append(f"요소 순서가 스키마와 다름: {known}")

    def text(tag):
        el = root.find(NS + tag)
        return el.text.strip() if el is not None and el.text else ""

    def attr(tag):
        el = root.find(NS + tag)
        return el.get("DefaultValue", "") if el is not None else ""

    if not GUID.match(text("Id")):
        errs.append(f"Id가 GUID 형식이 아님: {text('Id')}")
    if not VERSION.match(text("Version")):
        errs.append(f"Version 형식 오류: {text('Version')}")
    if len(text("ProviderName")) == 0 or len(text("ProviderName")) > 125:
        errs.append("ProviderName 비었거나 125자 초과")
    if "{{" in text("ProviderName"):
        warns.append("ProviderName에 자리표시자({{...}})가 남아 있음 — 스토어 제출 전 교체")
    if len(attr("DisplayName")) > 125:
        errs.append("DisplayName 125자 초과")
    if len(attr("Description")) > 250:
        errs.append("Description 250자 초과")

    for tag in ["IconUrl", "HighResolutionIconUrl", "SupportUrl"]:
        v = attr(tag)
        if v and not v.lower().startswith("https://"):
            errs.append(f"{tag}는 https여야 함: {v}")

    ds = root.find(NS + "DefaultSettings")
    if ds is not None:
        src = ds.find(NS + "SourceLocation")
        if src is None or not src.get("DefaultValue", "").lower().startswith("https://"):
            errs.append("SourceLocation 없음 또는 https 아님")
        for tag in ["RequestedWidth", "RequestedHeight"]:
            el = ds.find(NS + tag)
            if el is not None:
                try:
                    n = int(el.text)
                    if not 32 <= n <= 1000:
                        errs.append(f"{tag}={n} — 32 ~ 1000 범위 밖 (데스크톱 PowerPoint가 조용히 걸러냄)")
                except (TypeError, ValueError):
                    errs.append(f"{tag} 값이 정수가 아님")
        order = [c.tag.replace(NS, "") for c in ds]
        if order != [t for t in ["SourceLocation", "RequestedWidth", "RequestedHeight"] if t in order]:
            errs.append(f"DefaultSettings 내부 순서 오류: {order}")

    if text("Permissions") not in PERMS:
        errs.append(f"Permissions 값 오류: {text('Permissions')}")

    hosts = root.find(NS + "Hosts")
    if hosts is None or not any(h.get("Name") == "Presentation" for h in hosts):
        errs.append("Hosts에 Presentation 없음")

    domains = root.find(NS + "AppDomains")
    if domains is not None:
        for d in domains:
            if not (d.text or "").startswith("https://"):
                errs.append(f"AppDomain은 https로 시작해야 함: {d.text}")

    return errs, warns


def main(paths):
    failed = False
    for p in paths:
        errs, warns = check(p)
        status = "FAIL" if errs else "OK"
        print(f"[{status}] {p}")
        for e in errs:
            print(f"   ✗ {e}")
        for w in warns:
            print(f"   ! {w}")
        failed |= bool(errs)
    sys.exit(1 if failed else 0)


if __name__ == "__main__":
    main(sys.argv[1:] or ["manifest.xml"])
