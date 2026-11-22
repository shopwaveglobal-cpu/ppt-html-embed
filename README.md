# 1im HTML Player (ppt-html-embed)

PowerPoint 슬라이드에 인터랙티브 HTML을 넣는 콘텐츠 추가 기능. 이 저장소는 **플레이어 호스팅용**입니다.
사용자는 배포 zip(설명서 포함)만 받으면 되고, 이 저장소를 직접 볼 필요가 없습니다.

## 구조
| 경로 | 역할 |
|---|---|
| `index.html` | 플레이어 — GitHub Pages(`gh-pages` 브랜치)로 서비스 |
| `manifest.xml` | 배포용 manifest (Pages 주소를 가리킴) |
| `install-*.cmd/.command`, `설명서.txt` | 배포 zip 구성 파일 (manifest를 같은 폴더에서 복사, 다운로드 없음) |
| `privacy.html`, `support.html`, `assets/` | 공개 페이지·아이콘 |
| `store/` | Microsoft Marketplace 제출 자료 (별도 ID) |
| `scripts/check-manifest.py` | 오프라인 manifest 검사 |

## 배포 전 체크 (필수)
```bash
python3 scripts/check-manifest.py manifest.xml store/manifest-store.xml   # 오프라인 규칙
npx office-addin-manifest validate manifest.xml                            # 공식 검증(인터넷 필요)
npx office-addin-manifest validate store/manifest-store.xml
```
- ContentApp의 `RequestedWidth`/`RequestedHeight`는 **32 ~ 1000**. 넘으면 데스크톱 PowerPoint가 오류 없이 목록에서 뺌 (웹은 통과해서 놓치기 쉬움)
- manifest를 바꾸면 `Version`을 올릴 것 (캐시 무효화)
- push 시 GitHub Actions(`.github/workflows/validate-manifest.yml`)가 위 검사를 자동 실행

## 반영 규칙
`main`에 push한 뒤 `git push origin main:gh-pages`로 Pages에도 반영해야 플레이어가 갱신됩니다.
