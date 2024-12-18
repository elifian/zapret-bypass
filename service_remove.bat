@echo off
chcp 65001 > NUL

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

sc stop zapret > NUL
sc stop windivert > NUL
sc delete zapret > NUL
exit