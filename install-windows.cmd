@echo off
setlocal
set "DIR=%USERPROFILE%\1im-ppt-addin"
set "URL=https://raw.githubusercontent.com/shopwaveglobal-cpu/ppt-html-embed/main/manifest.xml"
set "KEY=HKCU\Software\Microsoft\Office\16.0\WEF\Developer"

echo [1/3] Downloading manifest...
if not exist "%DIR%" mkdir "%DIR%"
curl -fsSL "%URL%" -o "%DIR%\manifest.xml"
if errorlevel 1 (
  echo Download failed. Check internet connection.
  pause
  exit /b 1
)

echo [2/3] Registering add-in for PowerPoint...
reg add "%KEY%" /v "dbecfc0c-8ac0-42a1-bac8-72f88b412abf" /t REG_SZ /d "%DIR%\manifest.xml" /f >nul
if errorlevel 1 (
  echo Registry update failed.
  pause
  exit /b 1
)

echo [3/3] Done.
echo.
echo Close PowerPoint completely, reopen it, then:
echo   Insert ^> Add-ins ^> My Add-ins ^> Developer Add-ins ^> "1im HTML Player"
echo.
pause
