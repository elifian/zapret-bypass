@echo off
setlocal

reg query "HKU\S-1-5-19\Environment" >nul 2>&1
if "%Errorlevel%" NEQ "0" (
    PowerShell.exe -WindowStyle Hidden -NoProfile -NoLogo -Command ^
    "Start-Process -Verb RunAs -FilePath '%~f0' -ArgumentList '%*'" 
    exit /b
)

set "file=%~dp0zapret.xml"
set "Arguments=--wf-tcp=80,443 --wf-udp=443,50000-50100 --filter-udp=443 --hostlist=lists\list.txt --hostlist=lists\list-additional.txt --hostlist-auto=lists\autohostlist.txt --hostlist-auto-fail-time=3 --hostlist-auto-fail-threshold=1 --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=fake\quic_google.bin --new --filter-udp=50000-50100 --dpi-desync=fake,disorder2 --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --new --filter-tcp=80 --hostlist=lists\list.txt --hostlist=lists\list-additional.txt --hostlist-auto=lists\autohostlist.txt --hostlist-auto-fail-time=3 --hostlist-auto-fail-threshold=1 --dpi-desync=fake,disorder2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new --filter-tcp=443 --hostlist=lists\list.txt --hostlist=lists\list-additional.txt --hostlist-auto=lists\autohostlist.txt --hostlist-auto-fail-time=3 --hostlist-auto-fail-threshold=1 --dpi-desync=fake,disorder2 --dpi-desync-autottl=2 --dpi-desync-repeats=6 --dpi-desync-fooling=badseq --dpi-desync-fake-tls=fake\tls_google.bin"

powershell -Command "(Get-Content '%file%') -replace '(?<=<arguments>).*?(?=</arguments>)', '%Arguments%' | Set-Content '%file%'" >nul 2>&1

sc query zapret >nul 2>&1
if %errorlevel%==0 (
    sc stop zapret >nul
    sc stop windivert >nul
    sc delete zapret >nul
    timeout /t 2 >nul
)

"%~dp0zapret.exe" install >nul
sc start zapret >nul

for /f "tokens=3" %%i in ('sc query zapret ^| findstr /i "RUNNING START_PENDING"') do set SERVICE_STATUS=%%i

if /i not "%SERVICE_STATUS%"=="2" if /i not "%SERVICE_STATUS%"=="4" (
    powershell -Command "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.Interaction]::MsgBox('Zapret is not running!', '16', 'Zapret')"
    exit /b
)

set SITE_STATUS=0
for %%A in ("https://youtube.com" "https://discord.com") do (
    curl -I --max-time 1 %%A >nul 2>&1
    if %errorlevel%==0 set SITE_STATUS=1
)

if %SITE_STATUS%==0 (
    powershell -Command "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.Interaction]::MsgBox('Zapret is running, but Discord/YouTube domains are not responding, please try other options (service1-3).`nZapret is not running!', '16', 'Zapret')"
    sc stop zapret >nul
    sc stop windivert >nul
    sc delete zapret >nul
    exit /b
)


powershell -Command "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.Interaction]::MsgBox('Zapret is running!', 'OKOnly,Information', 'Zapret')"
exit /b