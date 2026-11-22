# 1im HTML Player (ppt-html-embed)

PowerPoint 슬라이드 안에 인터랙티브 HTML을 넣어, 발표 중에 클릭·입력·애니메이션이 그대로 동작하게 하는 콘텐츠 추가 기능입니다.
HTML 파일을 끌어놓으면 **내용이 PPTX 파일 안에 저장**됩니다.

## 두 가지 사용 방식
| 트랙 | 환경 | 설치 |
|---|---|---|
| 1 | 웹 PowerPoint | 추가 기능 → 내 추가 기능 업로드 → `manifest.xml` |
| 2 | Microsoft 365 / Office 2021+ (Windows·Mac) | [1im-PPT-HTML-Kit.zip](1im-PPT-HTML-Kit.zip)의 설치 파일 실행 |

Office 2019 이하는 미지원. 자세한 내용은 `사용법.txt`, [지원 페이지](https://shopwaveglobal-cpu.github.io/ppt-html-embed/support.html).

## 구조
- `index.html` : 플레이어 (GitHub Pages로 서비스 — main 변경 시 gh-pages에도 반영)
- `manifest.xml` : 추가 기능 등록 정보
- `privacy.html`, `support.html`, `assets/` : 공개 페이지·아이콘
- `store/` : Microsoft Marketplace 제출 자료
- `examples/` : 예시 HTML
