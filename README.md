# ppt-html-embed

PowerPoint 슬라이드 안에 인터랙티브 HTML(`index.html`)을 띄우는 콘텐츠 추가 기능입니다. 발표 중 인터넷 연결이 필요합니다.

## Windows
1. 이 저장소의 `install-windows.cmd`를 내려받아 더블클릭합니다. (SmartScreen 경고가 뜨면 "추가 정보 → 실행")
2. PowerPoint를 완전히 종료 후 다시 엽니다.
3. 삽입 → 추가 기능 → 내 추가 기능 → **개발자 추가 기능** → "이림 TIME CREATOR"

요구 사항: Microsoft 365 또는 Office 2021 이상 (Edge WebView2 사용). 제거는 `uninstall-windows.cmd`.

## Mac
```bash
mkdir -p ~/Library/Containers/com.microsoft.Powerpoint/Data/Documents/wef && curl -fsSL https://raw.githubusercontent.com/shopwaveglobal-cpu/ppt-html-embed/main/manifest.xml -o ~/Library/Containers/com.microsoft.Powerpoint/Data/Documents/wef/manifest.xml
```
PowerPoint 재시작 → 삽입 → 추가 기능 → 내 추가 기능 → 개발자 추가 기능.

## 내용 수정
`index.html`만 고치면 모든 PC에 반영됩니다(캐시로 몇 분 지연 가능).
