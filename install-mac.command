#!/bin/bash
# 1im HTML Player - Mac 설치 (같은 폴더의 manifest.xml 사용, 다운로드 없음)
HERE="$(cd "$(dirname "$0")" && pwd)"
SRC="$HERE/manifest.xml"
DIR="$HOME/Library/Containers/com.microsoft.Powerpoint/Data/Documents/wef"

echo ""
echo " 1im HTML Player - Mac 설치"
echo " ========================="
if [ ! -f "$SRC" ]; then
  echo " [오류] 이 파일 옆에 manifest.xml이 없습니다. zip을 통째로 푼 뒤 다시 실행하세요."
  read -n1 -p " 아무 키나 누르면 닫힙니다..."; exit 1
fi
if pgrep -x "Microsoft PowerPoint" >/dev/null; then
  echo " [!] PowerPoint가 켜져 있습니다. ⌘Q로 완전히 종료한 뒤 다시 실행하세요."
  read -n1 -p " 아무 키나 누르면 닫힙니다..."; exit 1
fi
mkdir -p "$DIR"
rm -f "$DIR/manifest.xml" "$DIR/1im-html-player.xml"
cp "$SRC" "$DIR/1im-html-player.xml"
if [ -f "$DIR/1im-html-player.xml" ]; then
  echo " 완료! PowerPoint를 열고:"
  echo "   삽입 > 추가 기능 > 내 추가 기능 > 개발자 추가 기능 > 1im HTML Player"
else
  echo " [오류] 복사에 실패했습니다."
fi
echo ""
read -n1 -p " 아무 키나 누르면 닫힙니다..."
