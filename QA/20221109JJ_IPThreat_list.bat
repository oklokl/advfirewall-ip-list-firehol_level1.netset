@echo off
setlocal enabledelayedexpansion
chcp 65001 > nul
REM "전승환님 버전 ㄳ 합니다 덛글에 달아 주셨습니다"
REM "IPThreat and IPBan Pro and IPBan"
REM "https://kin.naver.com/qna/detail.naver?d1id=1&dirId=104&docId=432320290 "
REM "https://lists.ipthreat.net/file/ipthreat-lists/threat/threat-100.txt.gz "
REM "https://ipthreat.net/ https://ipthreat.net/lists "

for /f "skip=1 delims=#" %%a in ('type "C:\Users\jsh89\Desktop\threat-100.txt"') do (
set "Str1=%%a"
for /f "delims=" %%a in ('echo !Str1! ^| find /c "/"') do set "Check1=A%%a"
if "!Check1!" EQU "A1" (
for /f "tokens=1-2 delims=/" %%a in ('echo !Str1!') do echo %%a
) else (
for /f "delims=" %%a in ('echo !Str1! ^| find /c "-"') do (
if %%a EQU 1 (
for /f "tokens=1-2 delims=-" %%a in ('echo !Str1!') do (

echo %%a
echo %%b
)
) else (
echo !Str1!
)
)
)
)
pause
