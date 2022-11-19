@echo off
chcp 65001
setlocal

REM "모꼬모지님이 조언 만들어 주셨어요"
REM "https://blog.naver.com/mokomoji/222932556551"

:main
choice /t 9999 /c uyrcn /d u /m "[선 택] 알파벳을 UYRCN..중 입력 하시고 엔터 누르세요"
goto :fx_%errorlevel%
:fx_1
echo u
goto :main2

:fx_2
echo y
goto :main2

:fx_3
echo r
goto :main2

:fx_4
echo c
goto :main2

:fx_5
echo n
goto :end


:main2
choice /t 9999 /c yn /d n /m "[선 택] 알파벳을 Y/N 중 누르세요.."
call :fy_%errorlevel%
goto :%z_go%

:fy_1
echo yy
set "z_go=main"
goto :eof

:fy_2
echo nn
set "z_go=main3"
goto :eof


:main3
set choice=u
set /p choice="[선 택] 알파벳을 UYRCN..중 입력 하시고 엔터 누르세요.. "
echo "%choice%".|findstr /x /i "\"[uyrcn]\"\." 2>nul>nul&&goto :fx_%choice%||goto :main3
goto :main4

:fx_u
echo uuu
goto :main4

:fx_y
echo yyy
goto :main4

:fx_r
echo rrr
goto :main4

:fx_c
echo ccc
goto :mian4

:fx_n
echo nnn
goto :end

:main4

set choice2=y
set /p choice2="[선 택] 알파벳을 Y/N 중 누르세요.. "
echo "%choice2%".|findstr /x /i "\"[yn]\"\." 2>nul>nul&&(
call :fy_%choice2%&call goto :main%%errorlevel%%)||goto :main4
pause

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
