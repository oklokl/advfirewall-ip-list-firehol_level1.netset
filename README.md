# advfirewall-ip-list-firehol_level1.netset
windows default firewall.. Utilize. Easy registration. > firehol_level1.netset

https://youtu.be/LmL0vJG7qqk
설치 방법 입니다 install
![11](https://user-images.githubusercontent.com/1571600/169641629-b1fe40a7-03bc-4e7f-a19f-5c0f9d8dbfcd.png)




https://cafe.daum.net/candan/AurF/102

https://cafe.daum.net/candan/AurF/105 최종버전 v9.bat 200 버전을 받으시면 됩니다. (파일을 ANSI 인코딩 변경 하였습니다) https://jujun.tistory.com/ 호경이님께서 큰 도움 되셨습니다

나의 개인 홈페이지 입니다. 여기에 주로 업로드 합니다.

```
http://www.johnwillis.com/2015/12/windows-how-to-firewall-block-list-of.html
이 블러그를 보고 만들었습니다

https://stackoverflow.com/questions/72291436/findstr-this-is-a-batch-file-but-it-doesnt-work-very-well

https://kin.naver.com/qna/detail.nhn?d1id=1&dirId=104&docId=393122073

https://kin.naver.com/qna/detail.naver?d1id=1&dirId=104&docId=419918246&scrollTo=answer1
도와주신분들
```

[https://iplists.firehol.org/files/fireho
l_level1.netset](https://iplists.firehol.org/files/firehol_level1.netset)
다운로드 주소

https://iplists.firehol.org https://github.com/firehol/blocklist-ipsets/commits/master/firehol_level1.netset

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

710.bat(아웃,인) 외부 연결, 내부 연결 양쪽다 차단 (in,out) block [a high level]

810.bat(인) 외부에서 들어 오는 연결만 차단 (in) block [recommend]

910.bat(아웃,인) 실행 할때 등록하는 ip 출력 버전 (in,out) block [Meaningless]

12.bat(아웃,인) 등록 할때 삭제 할때 숫자 카운팅이 있는 버전 (in,out) block 전승환님과 모모님께서 만들어,수정 해주심 [experimental]

차단 되는 규칙은 양쪽 모두 막으면 5천개 정도 되고 한쪽만 막으면 2500개 정도 되네요.

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

https://www.henrypp.org/product/simplewall

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
