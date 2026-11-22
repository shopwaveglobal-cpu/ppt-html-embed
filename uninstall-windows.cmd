@echo off
setlocal
set "ADDIN_ID=dbecfc0c-8ac0-42a1-bac8-72f88b412abf"
set "CAT_ID={2f6b3432-1246-4b66-bde6-a4ac09ffd8d8}"
reg delete "HKCU\Software\Microsoft\Office\16.0\WEF\Developer" /v "%ADDIN_ID%" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Office\16.0\WEF\TrustedCatalogs\%CAT_ID%" /f >nul 2>&1
net share 1im-addin /delete >nul 2>&1
if exist "C:\1im-addin\manifest.xml" del /Q "C:\1im-addin\manifest.xml"
if exist "%PUBLIC%\1im-addin\manifest.xml" del /Q "%PUBLIC%\1im-addin\manifest.xml"
echo Removed. Restart PowerPoint. (Existing PPT files keep their HTML.)
pause
