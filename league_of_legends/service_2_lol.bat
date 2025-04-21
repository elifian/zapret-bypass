@echo off
echo Please, wait...

set lockfile=%TEMP%\batchlock.txt
if exist "%lockfile%" (
    exit /b
) else (
    echo 1 > "%lockfile%"
)

reg query "HKU\S-1-5-19\Environment" >nul 2>&1
if "%Errorlevel%" NEQ "0" (
    PowerShell.exe -WindowStyle Hidden -NoProfile -NoLogo -Command ^
    "Start-Process -Verb RunAs -FilePath '%~f0' -ArgumentList '%*'" 
    exit /b
)

set "file=%~dp0..\zapret.xml"
set "Arguments=--wf-tcp=80,443 --wf-udp=443,50000-50100 --filter-udp=443 --hostlist-exclude=lists\list-exclude.txt --ipset=lists\list-ipset.txt --hostlist=lists\list.txt --hostlist=lists\list-additional.txt --hostlist-auto=lists\autohostlist.txt --hostlist-auto-fail-time=3 --hostlist-auto-fail-threshold=1 --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=fake\quic_google.bin --new --filter-udp=50000-50100 --dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --new --filter-tcp=80 --hostlist-exclude=lists\list-exclude.txt --ipset=lists\list-ipset.txt --hostlist=lists\list.txt --hostlist=lists\list-additional.txt --hostlist-auto=lists\autohostlist.txt --hostlist-auto-fail-time=3 --hostlist-auto-fail-threshold=1 --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new --filter-tcp=443 --hostlist-exclude=lists\list-exclude.txt --ipset=lists\list-ipset.txt --hostlist=lists\list.txt --hostlist=lists\list-additional.txt --hostlist-auto=lists\autohostlist.txt --hostlist-auto-fail-time=3 --hostlist-auto-fail-threshold=1 --dpi-desync=split2 --dpi-desync-split-seqovl=652 --dpi-desync-split-pos=2 --dpi-desync-split-seqovl-pattern=fake\tls_google.bin --filter-tcp=2099 --ipset=lists\league_of_legends.txt --dpi-desync=syndata --filter-udp=443 --ipset=lists\league_of_legends.txt --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=fake\quic_google.bin --filter-tcp=80 --ipset=lists\league_of_legends.txt --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --filter-tcp=443 --ipset=lists\league_of_legends.txt --dpi-desync=split --dpi-desync-split-pos=1 --dpi-desync-autottl --dpi-desync-fooling=badseq --dpi-desync-repeats=8"

powershell -Command "(Get-Content '%file%') -replace '(?<=<arguments>).*?(?=</arguments>)', '%Arguments%' | Set-Content '%file%'" >nul 2>&1

sc query zapret >nul 2>&1
if %errorlevel%==0 (
    sc stop zapret >nul
    sc stop windivert >nul
    sc delete zapret >nul
    powershell -Command "Start-Sleep -Milliseconds 1100" >nul
)

"%~dp0..\zapret.exe" install >nul
sc start zapret >nul

for /f "tokens=3" %%i in ('sc query zapret ^| findstr /i "RUNNING START_PENDING"') do set SERVICE_STATUS=%%i

if /i "%SERVICE_STATUS%"=="2" goto RunZapret
if /i "%SERVICE_STATUS%"=="4" goto RunZapret
powershell -Command "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.Interaction]::MsgBox('Zapret is not running!', '16', 'Zapret')"
del "%lockfile%"

:RunZapret
powershell -Command "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.Interaction]::MsgBox('Zapret is running', 'OKOnly,Information', 'Zapret')"
del "%lockfile%"