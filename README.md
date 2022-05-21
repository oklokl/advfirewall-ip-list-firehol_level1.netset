# advfirewall-ip-list-firehol_level1.netset
windows default firewall.. Utilize. Easy registration. > firehol_level1.netset

https://youtu.be/LmL0vJG7qqk
설치 방법 입니다 install

![11](https://user-images.githubusercontent.com/1571600/169641570-c70baeea-21c7-4c45-99bb-3d67e0376743.png)


https://cafe.daum.net/candan/AurF/102
나의 개인 홈페이지 입니다. 여기에 주로 업로드 합니다.

http://www.johnwillis.com/2015/12/windows-how-to-firewall-block-list-of.html
이 블러그를 보고 만들었습니다

https://stackoverflow.com/questions/72291436/findstr-this-is-a-batch-file-but-it-doesnt-work-very-well
https://kin.naver.com/qna/detail.nhn?d1id=1&dirId=104&docId=393122073
도와주신분

[https://iplists.firehol.org/files/fireho
l_level1.netset](https://iplists.firehol.org/files/firehol_level1.netset)
다운로드 주소

https://iplists.firehol.org
제공 싸이트 악성 ip를 리스트로 제공 하는 싸이트 입니다. 하지만 리눅스 기반이기 때문에 윈도우에 맞지 않아서 제가 찾다가 만들게 되었습니다.

배치 파일은 명령 프롬포트를 관리자 권한으로 하셔서 실행 하셔야 합니다 cmd 관리자 권한 실행 확장자는 bat로 되어 있어야 하고 

규칙을 등록 할 경우 리스트에 있는 아이피 모두를 차단 하게 됩니다. 제외 하고 싶다면. 저의 개인 홈페이지에 기제 되어 있으니 참고 하세요.

```
:: type %temp%\out.txt | findstr /blv "# 123.123. 144.144. 122.22." > %temp%\out.txt
```

이부분의 주석 :: 을 제거 하고 자신이 원하는 ip를 등록 하면 됩니다.

인터넷이 안될 경우 방화벽 로그를 활성화 시키고 차단 된 ip를 확인 해서 리스트에서 제외 시키세요. 로그 보는 방법은 카페에 있습니다 구차니즘 ㅎ https://cafe.daum.net/candan/AurF/100

.

.

파일 정보.

710.bat(아웃,인) 외부 연결, 내부 연결 양쪽다 차단 (in,out) block

810.bat(인) 외부에서 들어 오는 연결만 차단 (in) block

910.bat(아웃,인) 실행 할때 등록하는 ip 출력 버전 (in,out) block

차단 되는 규칙은 양쪽 모두 막으면 5천개 정도 되고 한쪽만 막으면 2500개 정도 되네요.

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

https://www.henrypp.org/product/simplewall

이 프로그램 좋아요 가볍고. 이것도 기본 방어벽을 사용 하여 차단 하는 기능을 합니다.

https://youtu.be/h_woyjWTsq4 사용법 영상이에요. 처음에는 무지 어려운대.. 

