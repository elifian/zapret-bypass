@echo off
%~dp0service install > NUL
sc start zapret > NUL
chcp 65001 > NUL
sc query zapret | findstr "PENDING RUNNING STOPPED" > NUL && powershell -Command "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.Interaction]::MsgBox('Служба установлена', 'OKOnly,Information', 'Zapret')" || powershell -Command "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.Interaction]::MsgBox('Служба не установлена!', '16', 'Zapret')"
exit