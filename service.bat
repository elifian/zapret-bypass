@echo off

cd /d "%~dp0"
zapret.exe install > NUL
sc start zapret > NUL
chcp 65001 > NUL
sc query zapret | findstr "PENDING RUNNING" > NUL
if %errorlevel% == 0 ( powershell -Command "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.Interaction]::MsgBox('Zapret запущен', 'OKOnly,Information', 'Zapret')" ) else ( powershell -Command "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.Interaction]::MsgBox('Служба не установлена!', '16', 'Zapret')" )
exit