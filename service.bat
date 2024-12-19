@echo off
chcp 65001 >nul
:: 65001 - UTF-8

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"

set BIN=%~dp0bin\
set BIN_PATH=%BIN%winws.exe
set ARGS=--wf-tcp=80,443 --wf-udp=443,50000-50100 ^
--filter-udp=443 --hostlist="%~dp0lists\list.txt" --hostlist="%~dp0lists\list-additional.txt" --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-auto-fail-time=3 --hostlist-auto-fail-threshold=1 --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%~dp0fake\quic_google.bin" --new ^
--filter-udp=50000-50100 --dpi-desync=fake,disorder2 --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --new ^
--filter-tcp=80 --hostlist="%~dp0lists\list.txt" --hostlist="%~dp0lists\list-additional.txt" --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-auto-fail-time=3 --hostlist-auto-fail-threshold=1 --dpi-desync=fake,disorder2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --hostlist="%~dp0lists\list.txt" --hostlist="%~dp0lists\list-additional.txt" --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-auto-fail-time=3 --hostlist-auto-fail-threshold=1 --dpi-desync=fake,disorder2 --dpi-desync-autottl=2 --dpi-desync-repeats=6 --dpi-desync-fooling=badseq --dpi-desync-fake-tls="%~dp0fake\tls_google.bin"

sc create zapret binPath= ""%~dp0bin\winws.exe" %ARGS%" DisplayName= "zapret" start= auto
sc start zapret

sc query zapret | findstr "PENDING RUNNING" > NUL
if %errorlevel% == 0 (
    powershell -Command "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.Interaction]::MsgBox('Zapret is running', 'OKOnly,Information', 'Zapret')"
) else (
    powershell -Command "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.Interaction]::MsgBox('Zapret is not running!', '16', 'Zapret')"
)