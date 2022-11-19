@echo off
chcp 65001
setlocal

REM "모꼬모지님이 조언 만들어 주셨어요"
REM "https://blog.naver.com/mokomoji/222932556551"

:main3
set "choice=u"
set /p choice="[선 택] 알파벳을 UYRCN..중 입력 하시고 엔터 누르세요.. "
for /f "delims=" %%f in ('echo "%choice%".^|findstr /i /x "^
\"[abcduyrcn]\"\. ^
\"[1-9]\"\. ^
\"[1-9][0-9]\"\. ^
\"[1-9][0-9][0-9]\"\."'
) do (
call :fx_%choice% 2>nul&&goto :main4
)
goto :main3

:fx_1
echo 1
:fx_2
echo 2
:fx_10
echo 3
:fx_11
echo 11
:fx_a
echo a
:fx_b
echo b
:fx_c
echo c
:fx_d
echo d
:fx_u
echo u--%errorlevel%
exit /b 0

:fx_100
echo 100
goto :eof

:fx_y
echo yyy
goto :eof

:fx_r
echo rrr
goto :eof

:fx_c
echo ccc
goto :eof

:fx_n
echo nnn
goto :eof

:main4

set choice2=y
set /p choice2="[선 택] 알파벳을 Y/N 중 누르세요.. "
echo "%choice2%".|findstr /x /i "\"[yn]\"\." 2>nul>nul&&(
call :fy_%choice2%&call goto :main%%errorlevel%%)||goto :main4

:fy_y
echo yyyyyyy
exit /b 3

:fy_n
echo nnnnnnn
exit /b 5

:mian5
:END
endlocal
pause
