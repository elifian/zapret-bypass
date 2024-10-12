@echo off
curl -o "lists\list.txt" https://antifilter.download/list/domains.lst
curl -o "lists\list-additional.txt" https://raw.githubusercontent.com/elifian/zapret-bypass/refs/heads/main/lists/list-additional.txt
sc query zapret | findstr "RUNNING" >nul && sc stop zapret >nul & timeout /t 1 /nobreak & sc start zapret >nul