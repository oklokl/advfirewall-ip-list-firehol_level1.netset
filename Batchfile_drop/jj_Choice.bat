@echo off
chcp 65001 > nul

REM "https://kin.naver.com/qna/detail.naver?d1id=1&dirId=104&docId=432820783"
REM "전승환님께서 만들어 주신 선택 배치파일"

:main1
echo 1
set "s=n"
set /p "s=y나n을 누르세요 : "
if /i "%s%" EQU "y" goto :y
if /i "%s%" EQU "n" goto :n
goto :main1

:y
echo y를 통과
goto :next1
:n
echo n를 통과
:next1

:main2
set "s=n"
set /p "s=y나n을 누르세요 : "
if /i "%s%" == "y" goto :yy
if /i "%s%" == "n" goto :nn
goto :main2

:yy
echo yy를 통과
goto :next2
:nn
echo nn를 통과
:next2
pause