# advfirewall-ip-list-firehol_level1.netset
windows default firewall.. Utilize. Easy registration. > firehol_level1.netset

https://cafe.daum.net/candan/AurF/102
나의 개인 홈페이지 입니다. 여기에 주로 업로드 합니다.

http://www.johnwillis.com/2015/12/windows-how-to-firewall-block-list-of.html
이 블러그를 보고 만들었습니다

https://stackoverflow.com/questions/72291436/findstr-this-is-a-batch-file-but-it-doesnt-work-very-well
https://kin.naver.com/qna/detail.nhn?d1id=1&dirId=104&docId=393122073
도와주신분

https://iplists.firehol.org/files/firehol_level1.netset
다운로드 주소

https://iplists.firehol.org
제공 싸이트 악성 ip를 리스트로 제공 하는 싸이트 입니다. 하지만 리눅스 기반이기 때문에 윈도우에 맞지 않아서 제가 찾다가 만들게 되었습니다.

배치 파일은 명령 프롬포트를 관리자 권한으로 하셔서 실행 하셔야 합니다 cmd 관리자 권한 실행 확장자는 bat로 되어 있어야 하고 

규칙을 등록 할 경우 리스트에 있는 아이피 모두를 차단 하게 됩니다. 제외 하고 싶다면. 저의 개인 홈페이지에 기제 되어 있으니 참고 하세요.

```
:: type %temp%\out.txt | findstr /blv "# 123.123. 144.144. 122.22." > %temp%\out.txt
```

이부분의 주석 :: 을 제거 하고 자신이 원하는 ip를 등록 하면 됩니다.

인터넷이 안될 경우 방화벽 로그를 활성화 시키고 차단 된 ip를 확인 해서 리스트에서 제외 시키세요. 로그 보는 방법은 카페에 있습니다 구차니즘 ㅎ

.

.

파일 정보.

710.bat(아웃,인) 외부 연결, 내부 연결 양쪽다 차단 (in,out) block

810.bat(인) 외부에서 들어 오는 연결만 차단 (in) block

910.bat(아웃,인) 실행 할때 등록하는 ip 출력 버전 (in,out) block

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
netsh advfirewall export "%temp%\advfirewall_file.wfw"
```
백업


```
netsh advfirewall import "%temp%\advfirewall_file.wfw"
```
복구

