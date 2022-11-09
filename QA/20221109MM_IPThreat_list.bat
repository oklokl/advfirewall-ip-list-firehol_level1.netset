@echo off
cd /d "%~dp0"
setlocal>iplist.txt
REM "IPThreat and IPBan Pro and IPBan"
REM "https://kin.naver.com/qna/detail.naver?d1id=1&dirId=104&docId=432320290 "
REM "https://lists.ipthreat.net/file/ipthreat-lists/threat/threat-100.txt.gz "
REM "https://ipthreat.net/ https://ipthreat.net/lists " 

for /f "eol=# delims= " %%f in ('type threat-100.txt') do (
echo %%f>>iplist.txt
)



endlocal
pause
