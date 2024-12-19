@echo off
chcp 65001 >nul

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"

set BIN=%~dp0bin\

start "zapret" /min "%~dp0bin\winws.exe" --wf-tcp=80,443 --wf-udp=443,50000-50100 ^
--filter-udp=443 --hostlist="%~dp0lists\list.txt" --hostlist="%~dp0lists\list-additional.txt" --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-auto-fail-time=3 --hostlist-auto-fail-threshold=1 --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%~dp0fake\quic_google.bin" --new ^
--filter-udp=50000-50100 --dpi-desync=fake,disorder2 --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --new ^
--filter-tcp=80 --hostlist="%~dp0lists\list.txt" --hostlist="%~dp0lists\list-additional.txt" --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-auto-fail-time=3 --hostlist-auto-fail-threshold=1 --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --hostlist="%~dp0lists\list.txt" --hostlist="%~dp0lists\list-additional.txt" --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-auto-fail-time=3 --hostlist-auto-fail-threshold=1 --dpi-desync=split --dpi-desync-split-pos=1 --dpi-desync-autottl --dpi-desync-fooling=badseq --dpi-desync-repeats=8