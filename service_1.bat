@echo off
echo Please, wait...

set lockfile=%TEMP%\batchlock.txt
if exist "%lockfile%" (
    powershell -Command "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.Interaction]::MsgBox('Service install is running!', '16', 'Zapret')"
    exit /b
) else (
    echo 1 > "%lockfile%"
)

cd %~dp0

reg query "HKU\S-1-5-19\Environment" >nul 2>&1
if "%Errorlevel%" NEQ "0" (
    PowerShell.exe -WindowStyle Hidden -NoProfile -NoLogo -Command ^
    "Start-Process -Verb RunAs -FilePath '%~f0' -ArgumentList '%*'" 
    exit /b
)

set "zapret=%~dp0zapret.xml"
set "general=%~dp0general_1.bat"

powershell -Command "$lines=Get-Content '%general%'; $commandLines=@(); $collecting=$false; foreach($line in $lines){if($line -match '^start\s+\""zapret\""'){$collecting=$true}; if($collecting){if($line -match '^\s*$'){continue}; $cleanLine=$line -replace '\s*\^\s*$',''; $commandLines+=$cleanLine; if($line -notmatch '\^\s*$'){break}}}; $command=$commandLines -join ' '; $Arguments=''; if($command -match '\""%%~dp0bin\\winws\.exe\""(\s+(.+))?'){$Arguments=$matches[2];if($Arguments){$Arguments=$Arguments -replace '\""%%~dp0([^\""]+)\""','$1'}}; [xml]$xml=Get-Content '%zapret%'; $xml.service.arguments=$Arguments.Trim(); $xml.Save('%zapret%')"

sc query zapret >nul 2>&1
if %errorlevel%==0 (
    sc stop zapret >nul
    sc stop windivert >nul
    sc delete zapret >nul
    powershell -Command "Start-Sleep -Milliseconds 1100" >nul
)

"%~dp0zapret.exe" install >nul
sc start zapret >nul

for /f "tokens=3" %%i in ('sc query zapret ^| findstr /i "RUNNING START_PENDING"') do set SERVICE_STATUS=%%i

if /i "%SERVICE_STATUS%"=="2" goto RunZapret
if /i "%SERVICE_STATUS%"=="4" goto RunZapret
powershell -Command "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.Interaction]::MsgBox('Zapret is not running!', '16', 'Zapret')"
del "%lockfile%"

:RunZapret
powershell -Command "Add-Type -AssemblyName 'Microsoft.VisualBasic'; [Microsoft.VisualBasic.Interaction]::MsgBox('Zapret is running', 'OKOnly,Information', 'Zapret')"
del "%lockfile%"