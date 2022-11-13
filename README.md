# advfirewall-ip-list-firehol_level1.netset
Windows default firewall.. Utilize. Easy to register for filter list. > firehol_level1.netset

[다운로드, 실행 및 사용법 youtube](https://youtu.be/W_InIAXNEx8)

![11](https://user-images.githubusercontent.com/1571600/169641629-b1fe40a7-03bc-4e7f-a19f-5c0f9d8dbfcd.png)

https://cafe.daum.net/candan/BLQD/89 최종버전 v15.bat

나의 개인 홈페이지 입니다. 여기에 주로 업로드 합니다.

사용법 해당 파일을 클릭 하고 메모장에 다름 이름 모든파일로 하여 저장 하고 v15.bat 명령프롬포트에서 관리자 권한으로 실행 하시면 됩니다.

[v15.bat 클릭](https://github.com/oklokl/advfirewall-ip-list-firehol_level1.netset/blob/main/v15.bat)

```
http://www.johnwillis.com/2015/12/windows-how-to-firewall-block-list-of.html
이 블러그를 보고 만들었습니다

https://stackoverflow.com/questions/72291436/findstr-this-is-a-batch-file-but-it-doesnt-work-very-well

https://kin.naver.com/qna/detail.nhn?d1id=1&dirId=104&docId=393122073

https://kin.naver.com/qna/detail.naver?d1id=1&dirId=104&docId=419918246&scrollTo=answer1
도와주신분들

https://jujun.tistory.com/ 호경이님께서 큰 도움 되셨습니다 인코딩 문제 도와 주셨습니다 글깨지는 문제 
```

.

[fireho
l_level1.netset](https://iplists.firehol.org/files/firehol_level1.netset) 다운로드 주소

[ipthreat](https://lists.ipthreat.net/file/ipthreat-lists/threat/threat-100.txt) 다운로드 주소

### ip필터 저작권 https://iplists.firehol.org, https://mirror.dk.team.blue, https://ipthreat.net/

### 다운로드 무료 입니다. ^^ :) IP filter Free blocklist

제공 싸이트 악성 ip를 리스트로 제공 하는 싸이트 입니다. 하지만 파워쉘 및 리눅스 기반이기 때문에 cmd에 윈도우에 맞지 않아서 제가 찾다가 만들게 되었습니다.

.

배치 파일은 명령 프롬포트를 관리자 권한으로 하셔서 실행 하셔야 합니다 cmd 관리자 권한 실행 확장자는 bat로 되어 있어야 하고 

규칙을 등록 할 경우 리스트에 있는 아이피 모두를 차단 하게 됩니다. 제외 하고 싶다면. 저의 개인 홈페이지에 기제 되어 있으니 참고 하세요.

```
REM type %temp%\입력_out1.txt | findstr /blv "# 123.123. 144.144. 122.22." > %temp%\출력_out2.txt
type %temp%\입력_out1.txt | findstr /blv "# 123.123. 144.144. 122.22." > %temp%\출력_out2.txt
```

이부분의 주석 REM 을 제거 하고 자신이 원하는 ip를 등록 하면 됩니다.

인터넷이 안될 경우 방화벽 로그를 활성화 시키고 차단 된 ip를 확인 해서 리스트에서 제외 시키세요. 로그 보는 방법은 카페에 있습니다 구차니즘 ㅎ https://cafe.daum.net/candan/AurF/100

.

.

파일 정보. 약한 차단을 원하시면 아래와 같이 아웃을 REM 주석 처리 하여 해제 하시면 외부 연결은 차단 되지 않습니다.

```
netsh advfirewall firewall add rule name="Blockit" protocol=any dir=out action=block remoteip=!str!`
REM netsh advfirewall firewall add rule name="Blockit" protocol=any dir=out action=block remoteip=!str!`
```

GJ20220522.bat(아웃,인) 게이지바 기능 추가. 전승환님께서 많이 수정해주셨습니다. 2022.05.22

.

.

수동으로 제거 하려면 또는 로그 켜려면 윈도우키+R  WF.msc 

```
gpupdate /force 
```

정책 업데이트 이것을 해야 적용 됩니다. 수동으로 수정 한후.

방어벽 정책 백업 하기

.

.
```
del %temp%\advfirewall_file.wfw
```
먼져 있을수 있으니 제거 부터 해주세요. 또는 백업 파일 advfirewall_file.wfw 이름으로 변경 하거나 백업 할때 advfirewall_file222.wfw 이런식으로요
```
netsh advfirewall export "%temp%\advfirewall_file.wfw"
```
백업


```
netsh advfirewall import "%temp%\advfirewall_file.wfw"
```
복구


.

```
notepad  %systemroot%\system32\LogFiles\Firewall\pfirewall.log
```
로그 보는 방법 인터넷이 안될때 로그 부분을 보세요.

```
Powershell -Command "& {Start-Process -FilePath """cmd""" -ArgumentList """/c""","""start""","""notepad""",""""%systemroot%\system32\LogFiles\Firewall\pfirewall.log""""-Verb RunAs}"
```
로그 바로 가기 만들기. 로그가 켜지지 않고 관리자 권한을 원할 경우 활용 할수 있어요. https://cafe.daum.net/candan/AurF/100 전승환님께서 만들어 주셨습니다.

어베스트 방어벽이 활성화 되어 있으면 윈도우 기본 방어벽을 사용 못하니 참고 하시고요 http://www.avast.com/index 무료 방어벽 있는 중에 지금 애가 가장 좋아요.

https://www.ahnlab.com/kr/site/product/productView.do?prodSeq=8&tab=14 

v3 라이프 사용 하지만 방어벽이 없는 분들은 쓸만 할꺼에요.

기타.

https://www.henrypp.org/product/simplewall [simplewall 사용법](https://cafe.daum.net/candan/AurF/74)

이 프로그램 좋아요 가볍고. 이것도 기본 방어벽을 사용 하여 차단 하는 기능을 합니다.

https://youtu.be/h_woyjWTsq4 사용법 영상이에요. 처음에는 무지 어려운대.. 


마지막으로 저는 컴퓨터 잘 못하기 때문에 대부분 지식인에 물어 봐서 수정 하곤 해요. 저에게 물어 보기 보다는 구글 검색이나 지식인이 도움이 되실꺼에요.

아참 그리고 지금. 규칙 삭제 하는 경우. 게이지바 부분에 게이지를 넣고 싶은대 쉽지가 않네요. 도와 주실분은 답변 남겨 주세요.

.

제외 시킨 dns

https://namu.wiki/w/DNS 구글 dns, http://www.codns.com/b/B05-52 회사별 공유기 접속 번호, 기타 vpn 192.168.0.1 을 차단 하면 공유기 관리자 접속이 안되네요.

기타 192.168.0.1의 경우 앞 글자만 적으면 되네요 그럼 뒷자도 자동으로 삭제 되요 192.168. 이렇게만 적어 주면 되네요.

.

[전문가 주소]

https://www.sans.org/blog/windows-firewall-script-to-block-ip-addresses-and-country-network-ranges/

https://blueteampowershell.com/  여기에서 파일을 다운로드 받으시면 되네요.

드디어 찾았네요 전문가가 만든 것이라 정말로 잘 되네요. 오래 걸리지도 않고. 

참고 하세요

https://cafe.daum.net/candan/AurF/104 전문가 주소를 활용한 방법 https://youtu.be/-D5GlUwQdPE

![2022-11-13 (2)](https://user-images.githubusercontent.com/1571600/201519839-d818e201-1654-476b-a502-11e74a19a7f2.png)

.

윈도우 고급 방어벽은 이렇게 생긴 것 입니다

```
윈도우키 + R 
wf.msc
```

여기에 등록 됩니다
![2022-11-13 (3)](https://user-images.githubusercontent.com/1571600/201519899-14538a63-e07d-45d5-9c75-74cdb2b1ef47.png)

Blockit 쉬프트 누른 상태에서 클릭 하시면 전체를 지우실수 있습니다. 다른건 지우지 마세요.
