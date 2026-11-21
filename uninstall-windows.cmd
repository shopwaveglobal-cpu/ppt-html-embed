@echo off
reg delete "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "dbecfc0c-8ac0-42a1-bac8-72f88b412abf" /f
echo Removed. Restart PowerPoint.
pause
