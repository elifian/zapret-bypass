@echo off
chcp 65001 >nul
:: 65001 - UTF-8

cd /d "%~dp0"

tasklist /FI "IMAGENAME eq winws.exe" 2>NUL | find /I "winws.exe" >NUL
if "%ERRORLEVEL%"=="0" (
    powershell -Command "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.Interaction]::MsgBox('Before starting, turn off the zapret service!', '16', 'Zapret')"
)

start "zapret" /min "%~dp0bin\winws.exe" --wf-tcp=80,443,2053,2083,2087,2096,8443,1024-65535 --wf-udp=443,3478,7777-7876,19294-19344,50000-50100 ^
--filter-udp=443 --hostlist-exclude="%~dp0lists\list-exclude.txt" --ipset="%~dp0lists\list-ipset.txt" --hostlist="%~dp0lists\list.txt" --hostlist="%~dp0lists\list-additional.txt" --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-auto-fail-time=3 --hostlist-auto-fail-threshold=1 --dpi-desync=fake --dpi-desync-repeats=11 --dpi-desync-fake-quic="%~dp0fake\quic_google.bin" --new ^
--filter-udp=19294-19344,50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-fake-discord="%~dp0fake\quic_google.bin" --dpi-desync-fake-stun="%~dp0fake\quic_google.bin" --dpi-desync-repeats=6 --new ^
--filter-tcp=2053,2083,2087,2096,8443 --hostlist-domains=discord.media --dpi-desync=fake,multisplit --dpi-desync-split-seqovl=654 --dpi-desync-split-pos=1 --dpi-desync-fooling=ts --dpi-desync-repeats=8 --dpi-desync-split-seqovl-pattern="%~dp0fake\tls_4pda.bin" --dpi-desync-fake-tls="%~dp0fake\tls_4pda.bin" --new ^
--filter-tcp=443 --hostlist-exclude="%~dp0lists\list-exclude.txt" --ipset="%~dp0lists\list-ipset.txt" --hostlist="%~dp0lists\list.txt" --hostlist="%~dp0lists\list-additional.txt" --hostlist-auto="%~dp0lists\autohostlist.txt" --hostlist-auto-fail-time=3 --hostlist-auto-fail-threshold=1 --ip-id=zero --dpi-desync=fake,multisplit --dpi-desync-split-seqovl=681 --dpi-desync-split-pos=1 --dpi-desync-fooling=ts --dpi-desync-repeats=8 --dpi-desync-split-seqovl-pattern="%~dp0fake\tls_4pda.bin" --dpi-desync-fake-tls="%~dp0fake\tls_4pda.bin" --new ^
--filter-udp=443 --ipset="%~dp0lists\list-cloudflare&amazon.txt" --hostlist-exclude="%~dp0lists\list-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=11 --dpi-desync-fake-quic="%~dp0fake\quic_google.bin" --new ^
--filter-tcp=80,443,1024-65535 --ipset="%~dp0lists\list-cloudflare&amazon.txt" --hostlist-exclude="%~dp0lists\list-exclude.txt" --dpi-desync=fake,multisplit --dpi-desync-split-seqovl=654 --dpi-desync-split-pos=1 --dpi-desync-fooling=ts --dpi-desync-repeats=8 --dpi-desync-split-seqovl-pattern="%~dp0fake\tls_4pda.bin" --dpi-desync-fake-tls="%~dp0fake\tls_4pda.bin" --new ^
--filter-udp=443 --ipset="%~dp0lists\list-cloudflare&amazon.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%~dp0fake\quic_google.bin" --new ^
--filter-udp=3478,7777-7876 --ipset="%~dp0lists\list-cloudflare&amazon.txt" --hostlist="%~dp0lists\list-steam-p2p.txt" --dpi-desync=disorder --new ^
--filter-udp=19294-19344,50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-repeats=6 --new ^