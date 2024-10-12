@echo off
%~dp0service install > NUL 2>&1
sc start zapret > NUL 2>&1
sc query zapret | find "PENDING" >nul && echo SERVICE ZAPRET INSTALLED || echo SERVICE NOT INSTALLED
timeout /t 1 /nobreak