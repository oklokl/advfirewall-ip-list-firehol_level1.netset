@echo off
cd /d %~dp0
setlocal enabledelayedexpansion
chcp 65001 > nul
set "DropPath=%1 %2 %3"
BCDEDIT > nul 

REM "if "%ERRORLEVEL%" EQU "1" Powershell.exe -Command "& {Start-Process """%0""" """ %DropPath%"""  -Verb RunAs}" & exit"
REM "설명 https://cafe.daum.net/candan/GGFN/398"
REM "다운로드 싸이트 https://github.com/oklokl/advfirewall-ip-list-firehol_level1.netset"

:main
@echo		"=================================================================================" 
@echo.
@echo		"이 버전은 사용자가 직접 파일을 넣는 방식 이에요"
@echo		"드롭한(지금 넣은) 파일에서 ip 들을 제외 또는 추가 추출 합니다"
@echo.
@echo		"해당 배치 파일 주소"
@echo		"https://github.com/oklokl/advfirewall-ip-list-firehol_level1.netset"
@echo.
@echo		"=================================================================================" 
@echo.
@echo		U (미국)		"미국만 ip만 리스트에서 삭제 한다"
@echo. 
@echo		R (중러일)		"중국 러시아 일본의 ip만 추가 한다"
@echo. 
@echo		C (중국)		"중국만 추가 한다"
@echo. 
@echo		N (종료)		"아무 것도 하지 않고 종료 합니다"
@echo.
@echo		(한국제외)		"한국은 기본적으로 제외 됩니다"
@echo.
@echo		"================================================================================="
@echo.
@echo		"제작 해주신 분들 호경이님, 모꼬모지, 전승환님 두분께서 만들어 주셨습니다"
@echo.
@echo		"jerry-jeremiah, stephan 외국분 들이 답변 주셨습니다 모두 ㄳ 합니다"
@echo.
@echo		"================================================================================="
@echo.
set choice=
set /p choice="[선 택] 알파벳을 U R C..N.. 중 입력 하시고 엔터 누르세요.."
echo "%choice%".|findstr /x /i "\"[uyrcn]\"\." 2>nul>nul&&goto :%choice%||goto :main

goto :quit

:u
:y
cls
REM "미국 한국만 제외 하기"
findstr /vl "USA KOR korea" %DropPath% > %temp%\USA_remove_ipblocklist.txt

REM "걸러 낸거 샵제거 하기 위해 다른 이름으로 만들기"
copy /y %temp%\USA_remove_ipblocklist.txt %temp%\remove_sharp_ipblocklist.txt >nul

REM "완료 하고 오는 곳"
echo.
echo "[알림:] 파일에서 미국을 ip를 제외 했습니다"
echo. 
echo.
goto :quit

:r
cls
REM "중국 러시아 일본 추출해서 추가하기"
findstr /c:"CHN" %DropPath% > %temp%\CHN_RUS_JPN_ipblocklist.txt
findstr /c:"RUS" %DropPath% >> %temp%\CHN_RUS_JPN_ipblocklist.txt
findstr /c:"JPN" %DropPath% >> %temp%\CHN_RUS_JPN_ipblocklist.txt

REM "일본에서 ms 코리아가 있어서 한국을 빼주기 
findstr /vl "USA KOR korea" %temp%\CHN_RUS_JPN_ipblocklist.txt > %temp%\CHN_RUS_JPN_ipblocklist222.txt

REM "걸러 낸거 샵제거 하기 위해 다른 이름으로 만들기"
copy /y %temp%\CHN_RUS_JPN_ipblocklist222.txt %temp%\remove_sharp_ipblocklist.txt >nul

REM "완료 하고 오는 곳"
echo.
echo "[알림:] 중국 러시아 일본 ip 들을 추출 하였습니다"
echo. 
echo.
goto :quit

:c
cls
REM "중국 추출해서 추가하기"
findstr /c:"CHN" %DropPath% > %temp%\CHN_ipblocklist.txt

REM "걸러 낸거 샵제거 하기 위해 다른 이름으로 만들기"
copy /y %temp%\CHN_ipblocklist.txt %temp%\remove_sharp_ipblocklist.txt >nul

REM "완료 하고 오는 곳"
echo.
echo "[알림:] 중국 ip 들을 추출 하였습니다"
echo. 
echo.
goto :quit

:n
REM 아무 것도 하지 않고 나가기
echo.
echo [알림]
echo 아무 것도 하지 않고 배치 파일을 종료 합니다.
echo.
goto :quit


:quit
REM "마지막에 오는 곳 추가 수정"
REM "새로 추가 주석 제거 질문"
REM "여기서 부터는 20221116 두번째 선택"

:Two_end

REM "https://stackoverflow.com/questions/21534486/batch-choice-command-with-errorlevel-isnt-working"
REM "https://learn.microsoft.com/ko-kr/windows-server/administration/windows-commands/choice 선택에 대한 공부"
echo.
echo "만들어진 txt 파일에서 #을 제외 할까요? #은 주석입니다 즉 설명 이라고 합니다"
echo.
REM "Choice/c yn"
choice /c yn /t 11 /d n /n /m "Yes(y), No(n), 고르세요?"
echo.

if errorlevel 2 goto no
if errorlevel 1 goto yes

:yes

echo " 주석 제거"
REM "https://kin.naver.com/qna/detail.naver?d1id=1&dirId=104&docId=432706973&scrollTo=answer1"
REM "정말 잘 안되서 겨우 성공 했네요 전승환님께서 많이 변경 해주셨습니다"
PowerShell -Command "& {Get-Content """"%temp%\remove_sharp_ipblocklist.txt"""" | select-object -skip 23 | %%{$_ -replace ' # [ -~]*'} | %%{$_ -replace '# Format[ -~]*'} | %%{$_ -replace '# [ -~]*'}| %%{$_ -replace '#'}| %%{$_ -replace ' '}| %%{$_ -replace '	'}> """"%USERPROFILE%\Downloads\Remove_C_iplist.txt""""}"
goto end

:no
echo " 주석 #을 제거 하지 않았습니다"
REM "아무것도 하지 않기 다운로드 폴더로 파일을 복사함"
copy /y %temp%\remove_sharp_ipblocklist.txt %USERPROFILE%\Downloads\Remove_C_iplist.txt >nul
goto end

:end
echo "다운로드 폴더에 파일을 저장 합니다"
echo "Remove_C_iplist.txt 파일 이름 입니다 잘쓰세요"

color 07
REM 최종 목적지 배치 파일 종료
echo.
echo "저작권 회사들 [Copyright Companies]"
echo.
echo "해당 필터 리스트는 무료 사용 가능합니다"
echo "https://iplists.firehol.org/files/firehol_level1.netset"
echo "https://mirror.dk.team.blue"
echo "https://ipthreat.net/"
echo.
echo.
echo.
echo "수고 하셨습니다"
echo.
echo " ^^ :) "
echo.
echo "엔터를 누르면 검은 화면이 꺼집니다"
endlocal
pause
