#!/bin/bash
# 1im HTML Player - Mac 설치 (더블클릭 실행)
DIR="$HOME/Library/Containers/com.microsoft.Powerpoint/Data/Documents/wef"
URL="https://raw.githubusercontent.com/shopwaveglobal-cpu/ppt-html-embed/main/manifest.xml"
echo "[1/2] PowerPoint 추가 기능 폴더 준비..."
mkdir -p "$DIR" || { echo "폴더를 만들 수 없습니다."; read -n1; exit 1; }
rm -f "$DIR/manifest.xml"  # 이전 버전 정리
echo "[2/2] manifest 다운로드..."
if curl -fsSL "$URL" -o "$DIR/1im-html-player.xml"; then
  echo ""
  echo "완료! PowerPoint를 완전히 종료(⌘Q) 후 다시 열고:"
  echo "  삽입 > 추가 기능 > 내 추가 기능 > 개발자 추가 기능 > 1im HTML Player"
else
  echo "다운로드 실패. 인터넷 연결을 확인하세요."
fi
echo ""
read -n1 -p "아무 키나 누르면 닫힙니다..."
