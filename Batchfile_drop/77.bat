@echo off
chcp 65001 > nul
set "DropPath=%1"
BCDEDIT > nul 

if "%ERRORLEVEL%" EQU "1" Powershell.exe -Command "& {Start-Process """%0""" """ %DropPath%"""  -Verb RunAs}" & exit

title 관리자 권한이 시작 되었습니다.

for /f "delims=" %%a in ('type "%DropPath%"') do (

netsh advfirewall firewall add rule name="AAA" dir=in action=block protocol=ANY remoteip="%%a"

)

REM "전승환님 작품 https://cafe.daum.net/candan/GGFN/394 설명은 여기에 작성 되어 있음"
REM "https://kin.naver.com/qna/detail.naver?d1id=1&dirId=104&docId=432652378"
pause
