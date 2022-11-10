@echo off
chcp 65001 > nul
REM "https://kin.naver.com/qna/detail.naver?d1id=1&dirId=104&docId=432385293&scrollTo=answer1"
REM "중간 부분에 #이 박혀 있는 문서를 뒷 부분을 제외 시키는 배치 배치 파일 입니다 파워쉘 명령어 전병철 님께서 만들어 주셨습니다 ㅎㅎ"
PowerShell -Command "& {$FILE = Get-Content """"C:\Users\jsh89\Desktop\threat-100.txt"""";$SaveFileDir = """"C:\Users\jsh89\Desktop\out2.txt"""";foreach ($LINE in $FILE) {foreach($Line in $LINE.Split('#')) {Write-Output $Line >> $SaveFileDir;break;}}}"
pause
