    @echo off
chcp 65001
setlocal
cd /d "%~dp0"

    :: if "%1"=="list" (
    :: netsh advfirewall firewall show rule Blockit | findstr RemoteIP
    :: exit/b
    :: )

    :: Deleting existing block on ips
    :: netsh advfirewall firewall delete rule name="Blockit"

:main
@echo ================================================
@echo               Y (그렇다)     규칙을 적용 할까요?
@echo               N (종료)       아무 것도 하지 않고 종료 한다
@echo               D (규칙제거)   자작으로 만든 규칙을 모두 제거 한다
@echo ================================================
set choice=
set /p choice=선택 하세요.
echo "%choice%".|findstr /x /i "\"[ynd]\"\." 2>nul>nul&&goto :%choice%||goto :main

goto :quit

:y	
:: 다운로드 하기
powershell "(new-Object System.Net.WebClient).DownloadFile('https://iplists.firehol.org/files/firehol_level1.netset', '%temp%\firehol_level1.netset')"	

:: 다운로드 된 파일 제외 하기
type %temp%\firehol_level1.netset | findstr /blv "# 0.0.0. 192.168.0.0/16 224.0.0.0/16 172.30. 192.168. 224.0. 168.126. 210.220. 219.250. 61.41. 1.214. 164.124. 203.248. 180.182. 94.140. 208.67. 1.1. 1.0. 8.8. 9.9. 149.112. 194.242. 185.222. 45.11. 10.0. 172.162" > %temp%\out.txt

:: 더 많은 ip를 제외 하려고 하면 아래 식으로 계속 추가 해서 등록 하면 되네요 하지만 너무 많은 줄이 생기면 느려지겠죠? 일단 :: 주석 처리 하니 필요 하면 주석 해제 하고 써보세요. 한대 테스트는 안해봤어요 ㅎㅎ
:: type %temp%\out.txt | findstr /blv "# 123.123. 144.144. 122.22." > %temp%\out.txt
		
    :: Block new ips (while reading them from blockit.txt)
    for /f %%i in (%temp%\out.txt) do ( 

call set /a z_num+=1
call echo "%%z_num%%----------------------%%i"

    netsh advfirewall firewall add rule name="Blockit" protocol=any dir=in action=block remoteip=%%i

    netsh advfirewall firewall add rule name="Blockit" protocol=any dir=out action=block remoteip=%%i 

    )

:: 규칙을 다 등록 하고 오는 장소
gpupdate /force
echo.
echo [알림: 방어벽 설정]
echo 윈도우키+R  WF.msc
echo.
:: pause
:: call %0 list
goto :quit



:n
:: 아무 것도 하지 않고 나가기
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

:quit
:: 최종 목적지 배치 파일 종료
endlocal
pause

    :: call this batch again with list to show the blocked IPs
    :: call %0 list