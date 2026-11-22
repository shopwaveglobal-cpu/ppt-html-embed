@echo off
setlocal EnableExtensions
title 1im HTML Player - Windows Install

rem ------------------------------------------------------------
rem  1im HTML Player installer (Windows, PowerPoint for Microsoft 365)
rem  - Uses manifest.xml placed next to this file (no download)
rem  - Copies it to C:\1im-addin (English-only path)
rem  - Method A: Developer add-in registry  (no admin needed)
rem  - Method B: Shared folder catalog      (only when run as admin)
rem ------------------------------------------------------------

set "SRC=%~dp0manifest.xml"
set "DIR=C:\1im-addin"
set "ADDIN_ID=dbecfc0c-8ac0-42a1-bac8-72f88b412abf"
set "DEVKEY=HKCU\Software\Microsoft\Office\16.0\WEF\Developer"
set "CAT_ID={2f6b3432-1246-4b66-bde6-a4ac09ffd8d8}"
set "CATKEY=HKCU\Software\Microsoft\Office\16.0\WEF\TrustedCatalogs\%CAT_ID%"
set "SHARE=1im-addin"

echo.
echo  1im HTML Player - Install
echo  =========================
echo.

if not exist "%SRC%" (
  echo  [ERROR] manifest.xml not found next to this file.
  echo          Unzip the whole folder first, then run this file again.
  goto :fail
)

echo  [1/4] Copying manifest to %DIR% ...
if not exist "%DIR%" mkdir "%DIR%" 2>nul
copy /Y "%SRC%" "%DIR%\manifest.xml" >nul 2>&1
if not exist "%DIR%\manifest.xml" (
  set "DIR=%PUBLIC%\1im-addin"
  if not exist "%PUBLIC%\1im-addin" mkdir "%PUBLIC%\1im-addin" 2>nul
  copy /Y "%SRC%" "%PUBLIC%\1im-addin\manifest.xml" >nul 2>&1
)
if not exist "%DIR%\manifest.xml" (
  echo  [ERROR] Could not copy manifest.xml.
  goto :fail
)
echo         OK: %DIR%\manifest.xml

echo  [2/4] Registering developer add-in (registry) ...
reg add "%DEVKEY%" /v "%ADDIN_ID%" /t REG_SZ /d "%DIR%\manifest.xml" /f >nul 2>&1
reg query "%DEVKEY%" /v "%ADDIN_ID%" >nul 2>&1
if errorlevel 1 (
  echo  [WARN] Registry value was NOT created.
  echo         Use the shared folder method in the manual ^(section 3-B^).
  set "REG_OK=0"
) else (
  echo         OK: registered
  set "REG_OK=1"
)

echo  [3/4] Shared folder catalog ...
net session >nul 2>&1
if errorlevel 1 (
  echo         Skipped ^(not admin^). To set it up automatically,
  echo         right-click this file - "Run as administrator".
  set "CAT_OK=0"
  goto :clear
)
net share %SHARE% >nul 2>&1 || net share %SHARE%="%DIR%" /GRANT:Everyone,READ >nul 2>&1
reg add "%CATKEY%" /v Id /t REG_SZ /d "%CAT_ID%" /f >nul 2>&1
reg add "%CATKEY%" /v Url /t REG_SZ /d "\\%COMPUTERNAME%\%SHARE%" /f >nul 2>&1
reg add "%CATKEY%" /v Flags /t REG_DWORD /d 1 /f >nul 2>&1
reg query "%CATKEY%" /v Url >nul 2>&1
if errorlevel 1 (
  echo  [WARN] Catalog was NOT registered.
  set "CAT_OK=0"
) else (
  echo         OK: \\%COMPUTERNAME%\%SHARE%
  set "CAT_OK=1"
)

:clear
echo  [4/4] Clearing Office add-in cache ...
tasklist /FI "IMAGENAME eq POWERPNT.EXE" 2>nul | find /I "POWERPNT.EXE" >nul
if not errorlevel 1 (
  echo  [!] PowerPoint is running. Close PowerPoint completely, then run this file again
  echo      ^(cache could not be cleared^).
) else (
  if exist "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" rd /S /Q "%LOCALAPPDATA%\Microsoft\Office\16.0\Wef" 2>nul
  echo         OK
)

echo.
if "%REG_OK%%CAT_OK%"=="00" (
  echo  RESULT: Automatic registration failed. Follow manual section 3-B.
  goto :fail
)
echo  DONE. Open PowerPoint, then:
echo    Insert tab ^> My Add-ins
if "%REG_OK%"=="1" echo      - "DEVELOPER ADD-INS" ^> 1im HTML Player
if "%CAT_OK%"=="1" echo      - or "SHARED FOLDER" ^> Refresh ^> 1im HTML Player
echo.
pause
exit /b 0

:fail
echo.
pause
exit /b 1
