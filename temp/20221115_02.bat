@echo off
cd /d %~dp0
setlocal enabledelayedexpansion
chcp 65001 > nul
set "DropPath=%1 %2 %3"
BCDEDIT > nul 

if "%ERRORLEVEL%" EQU "1" Powershell.exe -Command "& {Start-Process """%0""" """ %DropPath%"""  -Verb RunAs}" & exit

title 관리자 권한이 시작 되었습니다.

REM "전승환님께서 만들어 주셨습니다. ㄳ 합니다."
REM "https://kin.naver.com/qna/detail.naver?d1id=1&dirId=104&docId=432652378"
REM "설명 https://cafe.daum.net/candan/GGFN/394"
REM "실행 방법 영상 https://youtu.be/R6b0Z511k70"
REM "다운로드 받는곳 https://github.com/firehol/blocklist-ipsets"
REM "https://iplists.firehol.org/?ipset=graphiclineweb"
REM "777777777777777777777777777777777"
REM "for /f "delims=" %%a in ('type "%DropPath%"') do ("
REM "netsh advfirewall firewall add rule name="AAA" dir=in action=block protocol=ANY remoteip="%%a""
REM ")"
REM "777777777777777777777777777777777"

:main
@echo		"이 버전은 사용자가 드래그 추가 하는 버전 입니다"
@echo. 
@echo		"해당 iplists.firehol.org, dk.team.blue 제공 하는 필터 입니다"
@echo		"윈도우의 기존 방어벽에 나쁜 IP들을 차단등록 할것 입니다"
@echo		"등록후 윈도우키 + R 엔터 WF.msc로 살펴 보세요"
@echo		"해당 배치 파일 주소 https://github.com/oklokl/advfirewall-ip-list-firehol_level1.netset "
@echo. 
@echo		Y (그렇다)		"기본 IP 차단 규칙을 적용 할까요?	firehol	"
@echo		N (종료)		"아무 것도 하지 않고 종료 한다 NO RUN.. OUT.. EXIT"
@echo. 
@echo		D (규칙제거)		자작으로 만든 규칙을 모두 제거 한다
@echo		B (백업)		규칙을 백업 합니다.
@echo		S (복구)		내가 저장한 규칙복구
@echo.
@echo		만일을 위해서 미리 백업을 하세요. 
@echo		다른 먼져 규칙을 적용 하려면 규칙제거를 하세요.
@echo.
@echo		"제작 해주신 분들 호경이님, 모꼬모지, 전승환님 두분께서 만들어 주셨습니다"
@echo		"jerry-jeremiah, stephan 외국분 들이 답변 주셨습니다 모두 ㄳ 합니다"
@echo.
set choice=
set /p choice="[선 택] 알파벳을 Y N ..D.. 중 입력 하시고 엔터.."
echo "%choice%".|findstr /x /i "\"[yndbs]\"\." 2>nul>nul&&goto :%choice%||goto :main

goto :quit

:y
cls
color 0c
REM powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kp.netset" -OutFile $env:temp%\ip2location_country_kp.netset}"
REM powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kr.netset" -OutFile $env:temp%\ip2location_country_kr.netset}"

REM " # 걸러내기 내가 성공한 약식 https://cafe.daum.net/candan/GGFN/386 더 간단하게 성공 했다 전승환님 수정 도와주심"
REM " 당구장 표시 두개를 해야 합니다"
REM "PowerShell -Command "& {Get-Content "%DropPath%" | %%{$_ -replace ' # [ -~]*'} > %temp%\out555.txt}" "
PowerShell -Command "& {Get-Content """"%DropPath%"""" | select-object -skip 23 | %%{$_ -replace ' # [ -~]*'} | %%{$_ -replace '# Format[ -~]*'} | %%{$_ -replace '# [ -~]*'}| %%{$_ -replace '#'}| %%{$_ -replace ' '}| %%{$_ -replace '	'}> """"%temp%\out444.txt""""}"

REM "텝제거 이게 무지 어려웠다 후"
pause

REM 모두 다 하나에 뭉치기
type %temp%\firehol_level1.netset > %temp%\out.txt
REM type %temp%\ip2location_country_cn.netset >> %temp%\out.txt
REM type %temp%\ip2location_country_ru.netset >> %temp%\out.txt
type %temp%\ip2location_country_kp.netset >> %temp%\out.txt

REM "threat 샵제거된 문서 합치기"
type %temp%\out444.txt >> %temp%\out.txt

REM 걸러내기 같은 out.txt 라서 out2.txt로 해야 정상적으로 작동 된다.
REM 차단 주소에서 가정집 공유기 구글 dns를 제외 합니다. 그래야 인터넷이 되니깐요.
type %temp%\out.txt | findstr /blv "# 0.0.0. 192.168.0.0/16 224.0.0.0/16 172.30. 192.168. 224.0. 168.126. 210.220. 219.250. 61.41. 1.214. 164.124. 203.248. 180.182. 94.140. 208.67. 1.1. 1.0. 8.8. 9.9. 149.112. 194.242. 185.222. 45.11. 10.0. 172.162" > %temp%\out2.txt

REM 차단목록에서 혹시나 있을 한국은 제외 하기
findstr /VG:%temp%\ip2location_country_kr.netset < %temp%\out2.txt > %temp%\out.txt

REM 중복 제거
sort /C /UNIQUE "%temp%\out.txt" /O "%temp%\out.txt"

REM "out_BAD_ip22.csv 라고 이름만 수정 하였음"
REM 다른 이름으로 저장
copy %temp%\out.txt "%temp%\out_BAD_ip22_Blockit_Drop_txt_ip.csv" /y

REM 200 줄씩 가져와서 한 줄로 만들어서 화면에 출력.
REM 200 줄씩 ip 등록하기
set /a CountLine=0
set "str="
for /f "delims=" %%a in ('type "%temp%\out_BAD_ip22_Blockit_Drop_txt_ip.csv"') do (
set /a CountLine=!CountLine!+1
set "str=!str!,%%a"
if !CountLine! EQU 200 (
set /a CountLine=0
REM echo !str!
netsh advfirewall firewall add rule name="Blockit_Drop_txt_ip" protocol=any dir=in action=block remoteip=!str!
netsh advfirewall firewall add rule name="Blockit_Drop_txt_ip" protocol=any dir=out action=block remoteip=!str!
set "str="
)
)

REM 규칙을 다 등록 하고 오는 장소
gpupdate /force
echo.
echo [알림: 방어벽 설정]
echo 윈도우키+R  WF.msc
echo.
goto :quit

:n
REM 아무 것도 하지 않고 나가기
echo.
echo [알림]
echo 아무 것도 하지 않고 배치 파일을 종료 합니다.
echo.
goto :quit

:d
echo.
echo DEL! 자작으로 만드신 Blockit 규칙을 모두 지우겠습니다. 걱정 하지 마세요 다른 것은 지워지지 않습니다.
echo.
netsh advfirewall firewall delete rule name="Blockit_Drop_txt_ip"
gpupdate /force
echo.
echo [알림: 방어벽 설정]
echo 윈도우키+R  WF.msc
echo.
goto :quit

:quit
color 07
REM 최종 목적지 배치 파일 종료
echo.
echo "저작권 회사들 Copyright Companies"
echo.
echo "해당 필터 리스트는 무료 사용 가능합니다"
echo "https://iplists.firehol.org/files/firehol_level1.netset"
echo "https://mirror.dk.team.blue"
echo "https://ipthreat.net/"
echo.
endlocal
pause