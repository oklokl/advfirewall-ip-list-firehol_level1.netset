    @echo off
setlocal enabledelayedexpansion

:main
@echo. 
@echo		Y (�׷���)		��Ģ�� ���� �ұ��?			
@echo		N (����)		�ƹ� �͵� ���� �ʰ� ���� �Ѵ�	   
@echo		D (��Ģ����)		�������� ���� ��Ģ�� ��� ���� �Ѵ�
@echo		C (��������)		�߱� ���þ� ���� �Ǽ� ip ����	 
@echo		R (��������)		���þ� ���� �Ǽ� ip ����		 
@echo		B (���)		��Ģ�� ��� �մϴ�.			 
@echo		S (����)		���� ������ ��Ģ����	          
@echo.
@echo		������ ���ؼ� �̸� ����� �ϼ���. 
@echo		�ٸ� ���� ��Ģ�� ���� �Ϸ��� ��Ģ���Ÿ� �ϼ���.
@echo. 
set choice=
set /p choice=���� �ϼ���.
echo "%choice%".|findstr /x /i "\"[yndcrbs]\"\." 2>nul>nul&&goto :%choice%||goto :main

goto :quit

:y	
REM �Ǽ��� ���� �ϴ� ����
REM �ٿ�ε� �ϱ� �߱� cn ���þ� ru ���� kp cn.netset ���� �ϰ� ���� ���� ���� �ִٸ� �տ� �ּ� ó�� REM �ϼ���. https://mirror.dk.team.blue/firehol/ip2location_country/ ���� �մϴ� 
powershell -Command "& {Invoke-WebRequest -Uri "https://iplists.firehol.org/files/firehol_level1.netset" -OutFile $env:temp\firehol_level1.netset}"
REM powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_cn.netset" -OutFile $env:temp%\ip2location_country_cn.netset}"
REM powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_ru.netset" -OutFile $env:temp%\ip2location_country_ru.netset}"
REM powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kp.netset" -OutFile $env:temp%\ip2location_country_kp.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kr.netset" -OutFile $env:temp%\ip2location_country_kr.netset}"

REM ��� �� �ϳ��� ��ġ��
type "%temp%\firehol_level1.netset" > %temp%\out.txt
REM type %temp%\ip2location_country_cn.netset >> %temp%\out.txt
REM type %temp%\ip2location_country_ru.netset >> %temp%\out.txt
REM type %temp%\ip2location_country_kp.netset >> %temp%\out.txt

REM �ɷ����� ���� out.txt �� out2.txt�� �ؾ� ���������� �۵� �ȴ�.
REM ���� �ּҿ��� ������ ������ ���� dns�� ���� �մϴ�. �׷��� ���ͳ��� �Ǵϱ��.
type %temp%\out.txt | findstr /blv "# 0.0.0. 192.168.0.0/16 224.0.0.0/16 172.30. 192.168. 224.0. 168.126. 210.220. 219.250. 61.41. 1.214. 164.124. 203.248. 180.182. 94.140. 208.67. 1.1. 1.0. 8.8. 9.9. 149.112. 194.242. 185.222. 45.11. 10.0. 172.162" > %temp%\out2.txt

REM ���ܸ�Ͽ��� Ȥ�ó� ���� �ѱ��� ���� �ϱ�
findstr /VG:%temp%\ip2location_country_kr.netset < %temp%\out2.txt > %temp%\out.txt

REM �ߺ� ����
sort /C /UNIQUE "%temp%\out.txt" /O "%temp%\out.txt"

REM �ٸ� �̸����� ����
copy %temp%\out.txt "%temp%\out_BAD_ip.csv" /y

REM 200 �پ� �����ͼ� �� �ٷ� ���� ȭ�鿡 ���.
REM 200 �پ� ip ����ϱ�
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

REM ��Ģ�� �� ��� �ϰ� ���� ���
gpupdate /force
echo.
echo [�˸�: �� ����]
echo ������Ű+R  WF.msc
echo.
goto :quit

:n
REM �ƹ� �͵� ���� �ʰ� ������
echo.
echo [�˸�]
echo �ƹ� �͵� ���� �ʰ� ��ġ ������ ���� �մϴ�.
echo.
goto :quit

:d
echo.
echo DEL! �������� ����� Blockit ��Ģ�� ��� ����ڽ��ϴ�. ���� ���� ������ �ٸ� ���� �������� �ʽ��ϴ�.
echo.
netsh advfirewall firewall delete rule name="Blockit"
gpupdate /force
echo.
echo [�˸�: �� ����]
echo ������Ű+R  WF.msc
echo.
goto :quit

:c
REM �߱� ���þ� ���� �Ǽ� ���� ����
REM �ٿ�ε� �ϱ� �߱� cn ���þ� ru ���� kp cn.netset ���� �ϰ� ���� ���� ���� �ִٸ� �տ� �ּ� ó�� REM �ϼ���. https://mirror.dk.team.blue/firehol/ip2location_country/ ���� �մϴ�
powershell -Command "& {Invoke-WebRequest -Uri "https://iplists.firehol.org/files/firehol_level1.netset" -OutFile $env:temp\firehol_level1.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_cn.netset" -OutFile $env:temp%\ip2location_country_cn.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_ru.netset" -OutFile $env:temp%\ip2location_country_ru.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kp.netset" -OutFile $env:temp%\ip2location_country_kp.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kr.netset" -OutFile $env:temp%\ip2location_country_kr.netset}"

REM ��� �� �ϳ��� ��ġ��
type %temp%\firehol_level1.netset > %temp%\out.txt
type %temp%\ip2location_country_cn.netset >> %temp%\out.txt
type %temp%\ip2location_country_ru.netset >> %temp%\out.txt
type %temp%\ip2location_country_kp.netset >> %temp%\out.txt

REM �ɷ����� ���� out.txt �� out2.txt�� �ؾ� ���������� �۵� �ȴ�.
REM ���� �ּҿ��� ������ ������ ���� dns�� ���� �մϴ�. �׷��� ���ͳ��� �Ǵϱ��.
type %temp%\out.txt | findstr /blv "# 0.0.0. 192.168.0.0/16 224.0.0.0/16 172.30. 192.168. 224.0. 168.126. 210.220. 219.250. 61.41. 1.214. 164.124. 203.248. 180.182. 94.140. 208.67. 1.1. 1.0. 8.8. 9.9. 149.112. 194.242. 185.222. 45.11. 10.0. 172.162" > %temp%\out2.txt

REM ���ܸ�Ͽ��� Ȥ�ó� ���� �ѱ��� ���� �ϱ�
findstr /VG:%temp%\ip2location_country_kr.netset < %temp%\out2.txt > %temp%\out.txt

REM �ߺ� ����
sort /C /UNIQUE "%temp%\out.txt" /O "%temp%\out.txt"

REM �ٸ� �̸����� ����
copy %temp%\out.txt "%temp%\out_CN_RU_KP_BAD_ip.csv" /y

REM 200 �پ� �����ͼ� �� �ٷ� ���� ȭ�鿡 ���.
REM 200 �پ� ip ����ϱ�
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

REM ��Ģ�� �� ��� �ϰ� ���� ���
gpupdate /force
echo.
echo [�˸�: �� ����]
echo ������Ű+R  WF.msc
echo.
goto :quit

:r
REM �߱��� ���� �� ���� ���þ� ���� �Ǽ� ip�� ���� 
REM �ٿ�ε� �ϱ� �߱� cn ���þ� ru ���� kp cn.netset ���� �ϰ� ���� ���� ���� �ִٸ� �տ� �ּ� ó�� REM �ϼ���. https://mirror.dk.team.blue/firehol/ip2location_country/ ���� �մϴ�
powershell -Command "& {Invoke-WebRequest -Uri "https://iplists.firehol.org/files/firehol_level1.netset" -OutFile $env:temp\firehol_level1.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_cn.netset" -OutFile $env:temp%\ip2location_country_cn.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_ru.netset" -OutFile $env:temp%\ip2location_country_ru.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kp.netset" -OutFile $env:temp%\ip2location_country_kp.netset}"
powershell -Command "& {Invoke-WebRequest -Uri "https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kr.netset" -OutFile $env:temp%\ip2location_country_kr.netset}"

REM ��� �� �ϳ��� ��ġ��
type %temp%\firehol_level1.netset > %temp%\out.txt
REM type %temp%\ip2location_country_cn.netset >> %temp%\out.txt
type %temp%\ip2location_country_ru.netset >> %temp%\out.txt
type %temp%\ip2location_country_kp.netset >> %temp%\out.txt

REM �ɷ����� ���� out.txt �� out2.txt�� �ؾ� ���������� �۵� �ȴ�.
REM ���� �ּҿ��� ������ ������ ���� dns�� ���� �մϴ�. �׷��� ���ͳ��� �Ǵϱ��.
type %temp%\out.txt | findstr /blv "# 0.0.0. 192.168.0.0/16 224.0.0.0/16 172.30. 192.168. 224.0. 168.126. 210.220. 219.250. 61.41. 1.214. 164.124. 203.248. 180.182. 94.140. 208.67. 1.1. 1.0. 8.8. 9.9. 149.112. 194.242. 185.222. 45.11. 10.0. 172.162" > %temp%\out2.txt

REM ���ܸ�Ͽ��� Ȥ�ó� ���� �ѱ��� ���� �ϱ�
findstr /VG:%temp%\ip2location_country_kr.netset < %temp%\out2.txt > %temp%\out.txt

REM �ߺ� ����
sort /C /UNIQUE "%temp%\out.txt" /O "%temp%\out.txt"

REM �ٸ� �̸����� ����
copy %temp%\out.txt "%temp%\out_RU_KP_BAD_ip.csv" /y

REM 200 �پ� �����ͼ� �� �ٷ� ���� ȭ�鿡 ���.
REM 200 �پ� ip ����ϱ�
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

REM ��Ģ�� �� ��� �ϰ� ���� ���
gpupdate /force
echo.
echo [�˸�: �� ����]
echo ������Ű+R  WF.msc
echo.
goto :quit

:b
REM ��Ģ�� ��� �մϴ�
del /f "%temp%\advfirewall_file.wfw" 2> null
netsh advfirewall export "%temp%\advfirewall_file.wfw"
echo.
echo [�˸�: �� ����]
echo ������Ű+R  WF.msc
echo.
goto :quit

:s
REM ��Ģ�� ���� �մϴ�.
echo ���� ����� ���� �ʾҴٸ� ������ ���� �ʽ��ϴ�.
netsh advfirewall import "%temp%\advfirewall_file.wfw"
echo.
echo [�˸�: �� ����]
echo ������Ű+R  WF.msc
echo.
goto :quit

:quit
REM ���� ������ ��ġ ���� ����
endlocal
pause