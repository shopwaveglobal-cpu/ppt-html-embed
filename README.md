# 1im HTML Player (ppt-html-embed)

PowerPoint 슬라이드 안에 인터랙티브 HTML을 넣어 발표 중에 클릭·입력·애니메이션이 그대로 동작하게 하는 콘텐츠 추가 기능입니다.
HTML 파일을 끌어놓으면 **내용이 PPTX 파일 안에 저장**되므로, 새 HTML을 만들 때마다 따로 올릴 필요가 없습니다.

## 설치 (PC마다 한 번)
[1im-PPT-HTML-Kit.zip](1im-PPT-HTML-Kit.zip) 내려받아 압축 해제 →
- Windows: `install-windows.cmd` 더블클릭
- Mac: `install-mac.command` 우클릭 → 열기

PowerPoint 재시작 → 삽입 → 추가 기능 → 내 추가 기능 → 개발자 추가 기능 → **1im HTML Player**

## 사용
창을 슬라이드 크기로 늘리고 HTML 파일을 끌어놓기. 바꾸려면 ⚙ (슬라이드쇼에선 숨김).
자세한 내용은 `사용법.txt`.

## 구조
- `index.html` : 플레이어 (모든 슬라이드 공용)
- `manifest.xml` : 추가 기능 등록 정보
- `examples/` : 예시 HTML
