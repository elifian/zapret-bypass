@echo off
chcp 65001 >nul
:: 65001 - UTF-8

tasklist /FI "IMAGENAME eq winws.exe" 2>NUL | find /I "winws.exe" >NUL
if "%ERRORLEVEL%"=="0" (
    powershell -Command "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.Interaction]::MsgBox('Before starting, turn off the zapret service!', '16', 'Zapret')"
)

cd /d "%~dp0"

set BIN=%~dp0bin\

start "zapret" /min "%~dp0bin\winws.exe" --wf-tcp=80,443 --wf-udp=443,50000-50100 ^
--filter-udp=443 --ipset="%~dp0lists\list-ipset.txt" --hostlist="%~dp0lists\list.txt" --hostlist="%~dp0lists\list-additional.txt" --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-auto-fail-time=3 --hostlist-auto-fail-threshold=1 --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%~dp0fake\quic_google.bin" --new ^
--filter-udp=50000-50100 --dpi-desync=fake,disorder2 --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --new ^
--filter-tcp=80 --ipset="%~dp0lists\list-ipset.txt" --hostlist="%~dp0lists\list.txt" --hostlist="%~dp0lists\list-additional.txt" --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-auto-fail-time=3 --hostlist-auto-fail-threshold=1 --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --ipset="%~dp0lists\list-ipset.txt" --hostlist="%~dp0lists\list.txt" --hostlist="%~dp0lists\list-additional.txt" --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-auto-fail-time=3 --hostlist-auto-fail-threshold=1 --dpi-desync=split --dpi-desync-split-pos=1 --dpi-desync-autottl --dpi-desync-fooling=badseq --dpi-desync-repeats=8