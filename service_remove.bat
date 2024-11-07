@echo off

sc stop zapret > NUL
sc stop windivert > NUL
cd /d "%~dp0"
zapret.exe uninstall
exit