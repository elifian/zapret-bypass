@echo off
%~dp0service install > NUL 2>&1
sc start zapret > NUL 2>&1
sc query zapret | find "RUNNING" >nul && echo SERVICE ZAPRET INSTALLED || echo SERVICE NOT INSTALLED
sleep 2