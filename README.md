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

규칙을 등록 할 경우 리스트에 있는 아이피 모두를 차단 하게 됩니다. 제외 하고 싶다면. 저의 개인 홈페이지에 기제 되어 있으니 참고 하세요.

```
:: type %temp%\out.txt | findstr /blv "# 123.123. 144.144. 122.22." > %temp%\out.txt
```

이부분의 주석 :: 을 제거 하고 자신이 원하는 ip를 등록 하면 됩니다.

.

.

파일 정보.

710.bat(아웃,인) 외부 연결, 내부 연결 양쪽다 차단 (in,out) block

810.bat(인) 외부에서 들어 오는 연결만 차단 (in) block

910.bat(아웃,인) 실행 할때 등록하는 ip 출력 버전 (in,out) block
