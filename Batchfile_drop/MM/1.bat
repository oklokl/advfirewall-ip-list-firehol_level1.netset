@echo off
cd /d "%~dp0"
chcp 65001>2>nul>nul
setlocal>iplist2.txt

REM "모꼬모지님이 추가로 알려 주셨네요"
REM "https://kin.naver.com/qna/detail.naver?d1id=1&dirId=104&docId=432706973"
set "z_file=myip.ms-blacklist.txt"

for /f "eol=# delims= " %%f in ('type %z_file%') do (set /a "z_sum+=1")
call set /a z_"avg=z_sum/100"


for /f "eol=# delims= " %%f in ('type %z_file%') do (
call set /a "z_summ+=1"
call :gage %%z_summ%%

call set "z_var=%%~f"
call set "z_var=%%z_var: =%%"
call echo %%z_var%%>>iplist2.txt
)

goto :end

:gage
set /a "z_avgg1=%1/%z_avg%"
set /a "z_avgg2=%1 %%%z_avg%"

set /a "z_e=!!(!(%z_avgg1% %%10)*!%z_avgg2%)"
set /a "z_g=%1*!(%z_avgg2%)

set "z_p=00%z_avgg1%"
set "z_p=%z_p:~-3%

if %z_e% equ 1 set "z_gagee=%z_gagee%■"
if %z_avgg2% equ 1 (
cls
echo %z_file% [%z_p% %%]%z_gagee%
title %z_file% [%z_p% %%]%z_gagee%
)
goto :eof
:end
endlocal
pause
