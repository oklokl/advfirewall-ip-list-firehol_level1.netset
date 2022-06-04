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

echo 중국 러시아 북한의 ip 주소를 다운로드 받고 합치겠습니다.

:: 다운로드 하기 중국 cn 러시아 ru 북한 kp cn.netset 차단 하고 싶지 않은 나라가 있다면 앞에 주석 처리 :: 하세요. https://mirror.dk.team.blue/firehol/ip2location_country/ 제공 합니다
powershell "(new-Object System.Net.WebClient).DownloadFile('https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_cn.netset', '%temp%\ip2location_country_cn.netset')"
powershell "(new-Object System.Net.WebClient).DownloadFile('https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_ru.netset', '%temp%\ip2location_country_ru.netset')"
powershell "(new-Object System.Net.WebClient).DownloadFile('https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kp.netset', '%temp%\ip2location_country_kp.netset')"	
powershell "(new-Object System.Net.WebClient).DownloadFile('https://mirror.dk.team.blue/firehol/ip2location_country/ip2location_country_kr.netset', '%temp%\ip2location_country_kr.netset')"	

:: 모두 다 하나에 뭉치기
type %temp%\ip2location_country_cn.netset > %temp%\out.txt
type %temp%\ip2location_country_ru.netset >> %temp%\out.txt
type %temp%\ip2location_country_kp.netset >> %temp%\out.txt

:: 걸러내기 같은 out.txt 라서 out2.txt로 해야 정상적으로 작동 된다.
:: 차단 주소에서 가정집 공유기 구글 dns를 제외 합니다. 그래야 인터넷이 되니깐요.
type %temp%\out.txt | findstr /blv "# 0.0.0. 192.168.0.0/16 224.0.0.0/16 172.30. 192.168. 224.0. 168.126. 210.220. 219.250. 61.41. 1.214. 164.124. 203.248. 180.182. 94.140. 208.67. 1.1. 1.0. 8.8. 9.9. 149.112. 194.242. 185.222. 45.11. 10.0. 172.162" > %temp%\out2.txt

:: 차단목록에서 혹시나 있을 한국은 제외 하기
findstr /VG:%temp%\ip2location_country_kr.netset < %temp%\out2.txt > %temp%\out.txt

:: 중복 제거
sort /C /UNIQUE "%temp%\out.txt" /O "%temp%\out.txt"

:: 복사해서 사용자 바탕 화면에 보냅니다.
copy %temp%\out.txt "%USERPROFILE%\Desktop\blockit.csv" /y

echo 수고 하셨습니다 성공 하길 빌어요 저도 초보자 이기 때문에.. 잘 될지는 모르겠습니다.
echo 바탕 하면은 안보이면 마우스 우클릭 새로 고침을 하세요.
echo 파일 이름은 blockit.csv 입니다.
echo 사용법 https://www.sans.org/blog/windows-firewall-script-to-block-ip-addresses-and-country-network-ranges/
