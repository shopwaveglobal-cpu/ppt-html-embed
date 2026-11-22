# Microsoft Marketplace 제출 자료 — 1im HTML Player

`{{PUBLISHER}}` / `{{CONTACT_EMAIL}}` 는 Partner Center 게시자 이름·연락처로 바꿔야 함
(manifest-store.xml, ../privacy.html, ../support.html 모두)

## 기본 정보
- 이름: 1im HTML Player
- 카테고리: Productivity / Presentation
- 지원 앱: PowerPoint (Windows, Mac, Web)
- 개인정보처리방침 URL: https://shopwaveglobal-cpu.github.io/ppt-html-embed/privacy.html
- 지원 URL: https://shopwaveglobal-cpu.github.io/ppt-html-embed/support.html
- 아이콘: ../assets/icon-300.png (스토어), icon-32/64 (manifest)
- 스크린샷(1366×768): screenshot-1-setup.png, screenshot-2-playing.png, screenshot-3-interactive.png
  → 가능하면 실제 PowerPoint 화면 캡처로 교체 권장

## 짧은 설명 (Summary, 100자 이내)
EN: Put live, interactive HTML on a PowerPoint slide. Clicks, typing and animations keep working in Slide Show.
KO: PPT 슬라이드에 인터랙티브 HTML을 그대로. 발표 중에도 클릭·입력·애니메이션이 동작합니다.

## 상세 설명 (Description)
EN:
1im HTML Player lets you present interactive HTML right inside PowerPoint.
Insert the add-in on a slide, drop an HTML file onto it, and present. Buttons, sliders, search boxes, charts and animations work during Slide Show — no switching to a browser.

• Drop an HTML file, or enter an https URL
• The HTML is saved inside the PowerPoint file — just share the .pptx
• Different HTML on every slide
• Click once in Slide Show to give the content keyboard focus (arrow keys go to your HTML)
• The ⚙ button (edit view only) replaces the content
• No sign-in, no account, no data collection. Free.

Requirements: internet connection while presenting; PowerPoint on the web, or PowerPoint for Microsoft 365 / 2021 or later (Windows, Mac). Office 2019 and earlier are not supported.

KO:
1im HTML Player는 PowerPoint 안에서 인터랙티브 HTML을 그대로 발표할 수 있게 해 줍니다.
슬라이드에 추가 기능을 넣고 HTML 파일을 끌어놓으면 끝. 발표 중에도 버튼·슬라이더·검색창·그래프·애니메이션이 동작해 브라우저로 넘어갈 필요가 없습니다.

• HTML 파일 끌어놓기 또는 https 주소 입력
• HTML은 PPT 파일 안에 저장 — .pptx만 공유하면 됨
• 슬라이드마다 다른 HTML 가능
• 슬라이드쇼에서 한 번 클릭하면 키보드(화살표)가 HTML로 연결
• ⚙ 버튼(편집 화면에서만 보임)으로 내용 교체
• 로그인·계정·데이터 수집 없음. 무료.

필요 조건: 발표 중 인터넷 연결, 웹 PowerPoint 또는 Microsoft 365 / 2021 이상 (Windows·Mac). Office 2019 이하 미지원

## 심사자용 테스트 안내 (Testing notes)
1. Open PowerPoint (web or desktop) and create a blank presentation.
2. Insert > Add-ins > 1im HTML Player. A setup panel appears in the content frame.
3. Download the sample file: https://shopwaveglobal-cpu.github.io/ppt-html-embed/examples/1im-promo.html (Save As .html)
4. Drag the file onto the panel (or click the dashed area and choose the file). The interactive page appears.
5. Start Slide Show. Click the content once ("keyboard connected" badge appears), then click or press the right arrow to advance pages inside the HTML; use the slider on page 1.
6. Close and reopen the file: the HTML is restored from the document (no network storage).
7. Alternative: click ⚙ (edit view), enter https://shopwaveglobal-cpu.github.io/ppt-html-embed/examples/1im-promo.html and click 불러오기 (Load).
No sign-in or account is required. The add-in does not collect any data.
