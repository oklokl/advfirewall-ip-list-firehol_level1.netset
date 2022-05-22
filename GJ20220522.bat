@echo off

setlocal enabledelayedexpansion

chcp 65001 > nul

title 방화벽 보안 프로그램

mode con cols=78 lines=30

​

rem 관리자 권한으로 배치파일 실행.

BCDEDIT > nul 

if "%ERRORLEVEL%" EQU "1" Powershell.exe -Command "& {Start-Process """%0""" -Verb RunAs}" & exit

​

color 0A

cd /d "%~dp0"

​

:: if "%1"=="list" (

:: netsh advfirewall firewall show rule Blockit | findstr RemoteIP

:: exit/b

:: )

​

:: Deleting existing block on ips

:: netsh advfirewall firewall delete rule name="Blockit"

​

:main

@echo ==============================================================================

@echo Y (그렇다) 규칙을 적용 할까요?

@echo N (종료) 아무 것도 하지 않고 종료 한다

@echo D (규칙제거) 자작으로 만든 규칙을 모두 제거 한다

@echo ==============================================================================

set /p "choice=선택 하세요 : "

echo "%choice%".|findstr /x /i "\"[ynd]\"\." 2>nul>nul&&goto :%choice%||goto :main

​

goto :quit

​

:y 

:: 다운로드 하기

powershell "(new-Object System.Net.WebClient).DownloadFile('https://iplists.firehol.org/files/firehol_level1.netset', '%temp%\firehol_level1.netset')" 

​

:: 다운로드 된 파일 제외 하기

type %temp%\firehol_level1.netset | findstr /blv "# 0.0.0. 192.168.0.0/16 224.0.0.0/16 172.30. 192.168. 224.0. 168.126. 210.220. 219.250. 61.41. 1.214. 164.124. 203.248. 180.182. 94.140. 208.67. 1.1. 1.0. 8.8. 9.9. 149.112. 194.242. 185.222. 45.11. 10.0. 172.162" > %temp%\out.txt

​

:: 더 많은 ip를 제외 하려고 하면 아래 식으로 계속 추가 해서 등록 하면 되네요 하지만 너무 많은 줄이 생기면 느려지겠죠? 일단 :: 주석 처리 하니 필요 하면 주석 해제 하고 써보세요. 한대 테스트는 안해봤어요 ㅎㅎ

:: type %temp%\out.txt | findstr /blv "# 123.123. 144.144. 122.22." > %temp%\out.txt

​

:: Block new ips (while reading them from blockit.txt)

​

rem 등록할 규칙에 갯수를 저장.

set /a "CountRuleLen=0"

for /f %%i in (%temp%\out.txt) do set /a "CountRuleLen=!CountRuleLen!+1"

​

rem 현재 적용할 규칙이 몇개인지, 몇번째인지 진행률이 몇퍼센트인지 실시간으로 출력.

set /a "CountLine=0"

for /f %%i in (%temp%\out.txt) do (

set /a "CountLine=!CountLine!+1"

echo Set fso = CreateObject^("Scripting.FileSystemObject"^) : Wscript.echo ^(!CountLine!/!CountRuleLen!*100^) >"%temp%\VBS.vbs"

for /f "delims=" %%a in ('cscript /nologo "%temp%\VBS.vbs"') do set Percent=%%a

set /a Percent=!Percent!+0 2>nul

set /a CountRule=!CountRuleLen!-!CountLine!

call :progress !Percent!

echo 등록할 총 규칙 : !CountRuleLen! 남은규칙 : !CountRule!

echo 등록된 IP : %%i"

echo.

echo 규칙을 적용 하고 있습니다...

netsh advfirewall firewall add rule name="Blockit" protocol=any dir=in action=block remoteip=%%i > nul

netsh advfirewall firewall add rule name="Blockit" protocol=any dir=out action=block remoteip=%%i > nul

)

del /q "%temp%\VBS.vbs" > nul

​

:: 규칙을 다 등록 하고 오는 장소

echo 변경 내용을 시스템에 적용 중입니다...

gpupdate /force

echo.

echo [알림: 방어벽 설정]

echo 윈도우키+R WF.msc

echo.

:: pause

:: call %0 list

goto :quit

​

​

​

:n

:: 아무 것도 하지 않고 나가기

echo.

echo [알림]

echo 아무 것도 하지 않고 배치 파일을 종료 합니다.

echo.

goto :quit

​

​

:d

rem 규칙이 전체 몇개 있는지 확인하여 변수에 저장하고 있기.

set /a "CountRuleLen=0"

for /f "delims=" %%a in ('netsh advfirewall firewall show rule name^=Blockit ^| findstr /i "Blockit"') do set /a "CountRuleLen=!CountRuleLen!+1"

​

rem 삭제할 규칙이 없다면 :quit로 바로 이동.

if !CountRuleLen! EQU 0 (echo 삭제할 규칙이 더 이상 존재하지 않습니다. && goto :quit)

​

rem 규칙 삭제하는 cmd창 만들어서 따로 사용.

start /min "" cmd /c netsh advfirewall firewall delete rule name=Blockit

​

rem 현재 남은 규칙이 몇개인지 실시간으로 출력

:Loop

set /a "CountRule=0"

for /f "delims=" %%a in ('netsh advfirewall firewall show rule name^=Blockit ^| findstr /i "Blockit"') do set /a "CountRule=!CountRule!+1"

set /a ReverseCount=!CountRuleLen!-!CountRule!

echo Set fso = CreateObject("Scripting.FileSystemObject") : Wscript.echo (!ReverseCount!/!CountRuleLen!*100) >"%temp%\VBS.vbs"

for /f "delims=" %%a in ('cscript /nologo "%temp%\VBS.vbs"') do set Percent=%%a

set /a Percent=!Percent!+0 2>nul

call :progress !Percent!

echo 삭제할 총 규칙 : !CountRuleLen! 남은규칙 : !CountRule!

echo.

echo DEL! 자작으로 만드신 Blockit 규칙을 모두 지우겠습니다. 

echo 걱정 하지 마세요 다른 것은 지워지지 않습니다.

echo.

if "!CountRule!" EQU "0" goto :Next

goto :Loop

:Next

del /q "%temp%\VBS.vbs" 2>nul>nul

​

echo 규칙 삭제가 완료 되었습니다.

:: pause

​

echo 변경 내용을 시스템에 적용 중입니다...

gpupdate /force

echo.

echo [알림: 방어벽 설정]

echo 윈도우키+R WF.msc

echo.

goto :quit

​

:quit

:: 최종 목적지 배치 파일 종료

:: call this batch again with list to show the blocked IPs

:: call %0 list

echo 모든 과정이 끝났습니다 (아무키나 누르면 프로그램이 종료 됩니다)

endlocal

pause > nul

exit

​

:progress

cls && set "Square=" && set "SquareA=■" && set "SquareB=□"

if %~1 GEQ 0 (if %~1 LSS 10 (((for /l %%a in (1,1,10) do set "Square=!Square!!SquareB!") && echo 진행 상태 : [!Square!] %~1%% && exit /b)))

if %~1 GEQ 10 (if %~1 LSS 20 (((for /l %%a in (1,1,1) do set "Square=!Square!!SquareA!") && (for /l %%a in (2,1,10) do set "Square=!Square!!SquareB!") && echo 진행 상태 : [!Square!] %~1%% && exit /b)))

if %~1 GEQ 20 (if %~1 LSS 30 (((for /l %%a in (1,1,2) do set "Square=!Square!!SquareA!") && (for /l %%a in (3,1,10) do set "Square=!Square!!SquareB!") && echo 진행 상태 : [!Square!] %~1%% && exit /b)))

if %~1 GEQ 30 (if %~1 LSS 40 (((for /l %%a in (1,1,3) do set "Square=!Square!!SquareA!") && (for /l %%a in (4,1,10) do set "Square=!Square!!SquareB!") && echo 진행 상태 : [!Square!] %~1%% && exit /b)))

if %~1 GEQ 40 (if %~1 LSS 50 (((for /l %%a in (1,1,4) do set "Square=!Square!!SquareA!") && (for /l %%a in (5,1,10) do set "Square=!Square!!SquareB!") && echo 진행 상태 : [!Square!] %~1%% && exit /b)))

if %~1 GEQ 50 (if %~1 LSS 60 (((for /l %%a in (1,1,5) do set "Square=!Square!!SquareA!") && (for /l %%a in (6,1,10) do set "Square=!Square!!SquareB!") && echo 진행 상태 : [!Square!] %~1%% && exit /b)))

if %~1 GEQ 60 (if %~1 LSS 70 (((for /l %%a in (1,1,6) do set "Square=!Square!!SquareA!") && (for /l %%a in (7,1,10) do set "Square=!Square!!SquareB!") && echo 진행 상태 : [!Square!] %~1%% && exit /b)))

if %~1 GEQ 70 (if %~1 LSS 80 (((for /l %%a in (1,1,7) do set "Square=!Square!!SquareA!") && (for /l %%a in (8,1,10) do set "Square=!Square!!SquareB!") && echo 진행 상태 : [!Square!] %~1%% && exit /b)))

if %~1 GEQ 80 (if %~1 LSS 90 (((for /l %%a in (1,1,8) do set "Square=!Square!!SquareA!") && (for /l %%a in (9,1,10) do set "Square=!Square!!SquareB!") && echo 진행 상태 : [!Square!] %~1%% && exit /b)))

if %~1 GEQ 90 (if %~1 LSS 100 (((for /l %%a in (1,1,9) do set "Square=!Square!!SquareA!") && (for /l %%a in (10,1,10) do set "Square=!Square!!SquareB!") && echo 진행 상태 : [!Square!] %~1%% && exit /b)))

if %~1 EQU 100 ((for /l %%a in (1,1,10) do set "Square=!Square!!SquareA!") && echo 진행 상태 : [!Square!] %~1%% && exit /b)

exit /b