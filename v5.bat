    @echo off
setlocal enabledelayedexpansion
chcp 65001 > nul
cd /d "%~dp0"

    REM if "%1"=="list" (
    REM netsh advfirewall firewall show rule Blockit | findstr RemoteIP
    REM exit/b
    REM )

    REM Deleting existing block on ips
    REM netsh advfirewall firewall delete rule name="Blockit"

:main
@echo. 
@echo		Y (그렇다)		규칙을 적용 할까요?			
@echo		N (종료)		아무 것도 하지 않고 종료 한다	   
@echo		D (규칙제거)		자작으로 만든 규칙을 모두 제거 한다
@echo		C (국가차단)		중국 러시아 북한 악성 ip 차단	 
@echo		R (국가차단)		러시아 북한 악성 ip 차단		 
@echo		B (백업)		규칙을 백업 합니다.			 
@echo		S (복구)		내가 저장한 규칙복구	          
@echo.
@echo		만일을 위해서 미리 백업을 하세요. 
@echo		다른 먼져 규칙을 적용 하려면 규칙제거를 하세요.
@echo. 
set choice=
set /p choice=선택 하세요.
echo "%choice%".|findstr /x /i "\"[yndcrbs]\"\." 2>nul>nul&&goto :%choice%||goto :main

goto :quit

:y	
REM 악성만 차단 하는 버전
REM 다운로드 하기 중국 cn 러시아 ru 북한 kp cn.netset 차단 하고 싶지 않은 나라가 있다면 앞에 주석 처리 REM 하세요. https://mirror.dk.team.blue/firehol/ip2location_country/ 제공 합니다 
powershell -Command "& {Invoke-WebRequest -Uri "https://iplists.firehol.org/files/firehol_level1.netset" -OutFile $env:temp\firehol_level1.netset}"
REM powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_cn.netset" -OutFile $env:temp%\ip2location_country_cn.netset}"
REM powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_ru.netset" -OutFile $env:temp%\ip2location_country_ru.netset}"
REM powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kp.netset" -OutFile $env:temp%\ip2location_country_kp.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kr.netset" -OutFile $env:temp%\ip2location_country_kr.netset}"

REM 모두 다 하나에 뭉치기
type "%temp%\firehol_level1.netset" > %temp%\out.txt
REM type %temp%\ip2location_country_cn.netset >> %temp%\out.txt
REM type %temp%\ip2location_country_ru.netset >> %temp%\out.txt
REM type %temp%\ip2location_country_kp.netset >> %temp%\out.txt

REM 걸러내기 같은 out.txt 라서 out2.txt로 해야 정상적으로 작동 된다.
REM 차단 주소에서 가정집 공유기 구글 dns를 제외 합니다. 그래야 인터넷이 되니깐요.
type %temp%\out.txt | findstr /blv "# 0.0.0. 192.168.0.0/16 224.0.0.0/16 172.30. 192.168. 224.0. 168.126. 210.220. 219.250. 61.41. 1.214. 164.124. 203.248. 180.182. 94.140. 208.67. 1.1. 1.0. 8.8. 9.9. 149.112. 194.242. 185.222. 45.11. 10.0. 172.162" > %temp%\out2.txt

REM 차단목록에서 혹시나 있을 한국은 제외 하기
findstr /VG:%temp%\ip2location_country_kr.netset < %temp%\out2.txt > %temp%\out.txt

REM 중복 제거
sort /C /UNIQUE "%temp%\out.txt" /O "%temp%\out.txt"

REM 다른 이름으로 저장
copy %temp%\out.txt "%temp%\out_BAD_ip.csv" /y

REM 200 줄씩 가져와서 한 줄로 만들어서 화면에 출력.
REM 200 줄씩 ip 등록하기
set /a CountLine=0
set "str="
for /f "delims=" %%a in ('type "%temp%\out_BAD_ip.csv"') do (
set /a CountLine=!CountLine!+1
set "str=!str!,%%a"
if !CountLine! EQU 200 (
set /a CountLine=0
REM echo !str!
netsh advfirewall firewall add rule name="Blockit" protocol=any dir=in action=block remoteip=!str!
netsh advfirewall firewall add rule name="Blockit" protocol=any dir=out action=block remoteip=!str!
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
netsh advfirewall firewall delete rule name="Blockit"
gpupdate /force
echo.
echo [알림: 방어벽 설정]
echo 윈도우키+R  WF.msc
echo.
goto :quit

:c
REM 중국 러시아 북한 악성 차단 버전
REM 다운로드 하기 중국 cn 러시아 ru 북한 kp cn.netset 차단 하고 싶지 않은 나라가 있다면 앞에 주석 처리 REM 하세요. https://mirror.dk.team.blue/firehol/ip2location_country/ 제공 합니다
powershell -Command "& {Invoke-WebRequest -Uri "https://iplists.firehol.org/files/firehol_level1.netset" -OutFile $env:temp\firehol_level1.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_cn.netset" -OutFile $env:temp%\ip2location_country_cn.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_ru.netset" -OutFile $env:temp%\ip2location_country_ru.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kp.netset" -OutFile $env:temp%\ip2location_country_kp.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kr.netset" -OutFile $env:temp%\ip2location_country_kr.netset}"

REM 모두 다 하나에 뭉치기
type %temp%\firehol_level1.netset > %temp%\out.txt
type %temp%\ip2location_country_cn.netset >> %temp%\out.txt
type %temp%\ip2location_country_ru.netset >> %temp%\out.txt
type %temp%\ip2location_country_kp.netset >> %temp%\out.txt

REM 걸러내기 같은 out.txt 라서 out2.txt로 해야 정상적으로 작동 된다.
REM 차단 주소에서 가정집 공유기 구글 dns를 제외 합니다. 그래야 인터넷이 되니깐요.
type %temp%\out.txt | findstr /blv "# 0.0.0. 192.168.0.0/16 224.0.0.0/16 172.30. 192.168. 224.0. 168.126. 210.220. 219.250. 61.41. 1.214. 164.124. 203.248. 180.182. 94.140. 208.67. 1.1. 1.0. 8.8. 9.9. 149.112. 194.242. 185.222. 45.11. 10.0. 172.162" > %temp%\out2.txt

REM 차단목록에서 혹시나 있을 한국은 제외 하기
findstr /VG:%temp%\ip2location_country_kr.netset < %temp%\out2.txt > %temp%\out.txt

REM 중복 제거
sort /C /UNIQUE "%temp%\out.txt" /O "%temp%\out.txt"

REM 다른 이름으로 저장
copy %temp%\out.txt "%temp%\out_CN_RU_KP_BAD_ip.csv" /y

REM 200 줄씩 가져와서 한 줄로 만들어서 화면에 출력.
REM 200 줄씩 ip 등록하기
set /a CountLine=0
set "str="
for /f "delims=" %%a in ('type "%temp%\out_CN_RU_KP_BAD_ip.csv"') do (
set /a CountLine=!CountLine!+1
set "str=!str!,%%a"
if !CountLine! EQU 200 (
set /a CountLine=0
REM echo !str!
netsh advfirewall firewall add rule name="Blockit" protocol=any dir=in action=block remoteip=!str!
netsh advfirewall firewall add rule name="Blockit" protocol=any dir=out action=block remoteip=!str!
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

:r
REM 중국을 제외 한 버전 러시아 북한 악성 ip만 차단 
REM 다운로드 하기 중국 cn 러시아 ru 북한 kp cn.netset 차단 하고 싶지 않은 나라가 있다면 앞에 주석 처리 REM 하세요. https://mirror.dk.team.blue/firehol/ip2location_country/ 제공 합니다
powershell -Command "& {Invoke-WebRequest -Uri "https://iplists.firehol.org/files/firehol_level1.netset" -OutFile $env:temp\firehol_level1.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_cn.netset" -OutFile $env:temp%\ip2location_country_cn.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_ru.netset" -OutFile $env:temp%\ip2location_country_ru.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kp.netset" -OutFile $env:temp%\ip2location_country_kp.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kr.netset" -OutFile $env:temp%\ip2location_country_kr.netset}"

REM 모두 다 하나에 뭉치기
type %temp%\firehol_level1.netset > %temp%\out.txt
REM type %temp%\ip2location_country_cn.netset >> %temp%\out.txt
type %temp%\ip2location_country_ru.netset >> %temp%\out.txt
type %temp%\ip2location_country_kp.netset >> %temp%\out.txt

REM 걸러내기 같은 out.txt 라서 out2.txt로 해야 정상적으로 작동 된다.
REM 차단 주소에서 가정집 공유기 구글 dns를 제외 합니다. 그래야 인터넷이 되니깐요.
type %temp%\out.txt | findstr /blv "# 0.0.0. 192.168.0.0/16 224.0.0.0/16 172.30. 192.168. 224.0. 168.126. 210.220. 219.250. 61.41. 1.214. 164.124. 203.248. 180.182. 94.140. 208.67. 1.1. 1.0. 8.8. 9.9. 149.112. 194.242. 185.222. 45.11. 10.0. 172.162" > %temp%\out2.txt

REM 차단목록에서 혹시나 있을 한국은 제외 하기
findstr /VG:%temp%\ip2location_country_kr.netset < %temp%\out2.txt > %temp%\out.txt

REM 중복 제거
sort /C /UNIQUE "%temp%\out.txt" /O "%temp%\out.txt"

REM 다른 이름으로 저장
copy %temp%\out.txt "%temp%\out_RU_KP_BAD_ip.csv" /y

REM 200 줄씩 가져와서 한 줄로 만들어서 화면에 출력.
REM 200 줄씩 ip 등록하기
set /a CountLine=0
set "str="
for /f "delims=" %%a in ('type "%temp%\out_RU_KP_BAD_ip.csv"') do (
set /a CountLine=!CountLine!+1
set "str=!str!,%%a"
if !CountLine! EQU 200 (
set /a CountLine=0
REM echo !str!
netsh advfirewall firewall add rule name="Blockit" protocol=any dir=in action=block remoteip=!str!
netsh advfirewall firewall add rule name="Blockit" protocol=any dir=out action=block remoteip=!str!
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

:b
REM 규칙을 백업 합니다
del /f "%temp%\advfirewall_file.wfw" 2> null
netsh advfirewall export "%temp%\advfirewall_file.wfw"
echo.
echo [알림: 방어벽 설정]
echo 윈도우키+R  WF.msc
echo.
goto :quit

:s
REM 규칙을 복구 합니다.
echo 먼져 백업을 하지 않았다면 복구는 되지 않습니다.
netsh advfirewall import "%temp%\advfirewall_file.wfw"
echo.
echo [알림: 방어벽 설정]
echo 윈도우키+R  WF.msc
echo.
goto :quit

:quit
REM 최종 목적지 배치 파일 종료
endlocal
pause