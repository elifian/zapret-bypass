@echo off

curl -o "lists\list.txt" https://antifilter.download/list/domains.lst
sc query zapret | findstr "RUNNING PENDING" >nul && sc stop zapret >nul & timeout /t 2 & sc start zapret >nul
exit