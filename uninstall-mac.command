#!/bin/bash
DIR="$HOME/Library/Containers/com.microsoft.Powerpoint/Data/Documents/wef"
rm -f "$DIR/1im-html-player.xml" "$DIR/manifest.xml"
echo " 제거 완료. PowerPoint를 다시 시작하세요. (이미 만든 PPT 안의 HTML은 남아 있습니다)"
read -n1 -p " 아무 키나 누르면 닫힙니다..."
