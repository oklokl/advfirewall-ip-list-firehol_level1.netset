@echo off
setlocal enabledelayedexpansion
chcp 65001 > nul
cd /d "%~dp0"

:main
echo == 중국IP주소 차단룰 설정중입니다. 잠시만기다려주세요..... ==
echo == 서비스를 이용해 주셔서 감사합니다. (주)스마일서브 ==
REM	20220612 동우가 수정해봄
REM
REM   China_block
REM
REM   (주) 스마일서브 기술지원팀 김성태대리 2007-12-11

@echo.
@echo		Y		(그렇다)	규칙을 적용 할까요?
@echo		N		(종료)	아무 것도 하지 않고 종료 한다
@echo		D		(규칙제거)	자작으로 만든 규칙을 모두 제거 한다
@echo.
set choice=
set /p choice=선택 하세요.
echo "%choice%".|findstr /x /i "\"[ynd]\"\." 2>nul>nul&&goto :%choice%||goto :main

goto :quit

:y
REM 로컬룰지정
netsh ipsec static set store location=local

REM 최초 룰정책 생성
netsh ipsec static add policy name=China_IP_block_list activatedefaultrule=yes (주)스마일서브-중국IP리스트-차단정책 assign=yes

REM 필터리스트 추가
REM netsh ipsec static add filterlist name=All
netsh ipsec static add filterlist name=China_block
netsh ipsec static add filterlist name=Local

REM 허용/거부룰 설정
netsh ipsec static add filteraction name=Permit action=Permit
netsh ipsec static add filteraction name=Block action=Block

REM 모든트래픽허용
REM netsh ipsec static add filter filterlist=All srcaddr=ANY dstaddr=me dstmask=255.255.255.0 protocol=ANY mirrored=yes


REM 동우가 추가한 부분 시작

echo 중국 러시아 북한의 ip 주소를 다운로드 받고 합치겠습니다.

REM 다운로드 하기 중국 cn 러시아 ru 북한 kp cn.netset 차단 하고 싶지 않은 나라가 있다면 앞에 주석 처리 REM 하세요. https://mirror.dk.team.blue/firehol/ip2location_country/ 제공 합니다
powershell "(new-Object System.Net.WebClient).DownloadFile('https://iplists.firehol.org/files/firehol_level1.netset', '%temp%\firehol_level1.netset')"	
powershell "(new-Object System.Net.WebClient).DownloadFile('https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_cn.netset', '%temp%\ip2location_country_cn.netset')"
powershell "(new-Object System.Net.WebClient).DownloadFile('https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_ru.netset', '%temp%\ip2location_country_ru.netset')"
powershell "(new-Object System.Net.WebClient).DownloadFile('https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kp.netset', '%temp%\ip2location_country_kp.netset')"	
powershell "(new-Object System.Net.WebClient).DownloadFile('https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kr.netset', '%temp%\ip2location_country_kr.netset')"	

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

REM 복사해서 temp에 보냅니다.
copy %temp%\out.txt "%temp%\out.csv" /y

REM 중국IP차단 자동으로 바군 부분
REM Block new ips (while reading them from blockit.txt)
for /f %%i in (%temp%\out.csv) do ( 
netsh ipsec static add filter desc=%%i filterlist=China_block srcaddr=%%i srcmask=255.255.0.0 dstaddr=ANY protocol=ANY mirrored=yes
)

REM 중국IP차단
REM netsh ipsec static add filter desc=58.14.0.0 filterlist=China_block srcaddr=58.14.0.0 srcmask=255.255.0.0 dstaddr=ANY protocol=ANY mirrored=yes

REM 로컬트래픽허용
netsh ipsec static add filter filterlist=Local srcaddr=me dstaddr=localhost dstmask=255.255.255.0 protocol=ANY mirrored=yes

REM  필터룰 추가
REM netsh ipsec static add rule name=2 policy=China_IP_block_list filter=All filteraction=Permit
netsh ipsec static add rule name=3 policy=China_IP_block_list filter=China_block filteraction=Block
netsh ipsec static add rule name=1 policy=China_IP_block_list filter=Local filteraction=Permit


REM 규칙을 다 등록 하고 오는 장소
gpupdate /force
echo.
echo [알림: 방어벽 설정]
echo 윈도우키+R  gpedit.msc
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
netsh ipsec static delete policy China_IP_block_list
REM netsh ipsec static delete filteraction name=Permit
REM netsh ipsec static delete filteraction name=Block
gpupdate /force
echo.
echo [알림: 방어벽 설정]
echo 윈도우키+R  gpedit.msc
echo.
goto :quit

:quit
REM 최종 목적지 배치 파일 종료
endlocal
pause
