@echo off
cd /d %~dp0
setlocal enabledelayedexpansion
chcp 65001 > nul
set "DropPath=%1 %2 %3"
BCDEDIT > nul 

type %DropPath% | powershell -Command "$input | ForEach-Object { $_ -replace \"MinimumPasswordAge = 0\",	 \"MinimumPasswordAge = 1\" }" > %temp%\1.txt
IF ERRORLEVEL 1 goto end
type %temp%\1.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"MinimumPasswordLength = 0\",	 \"MinimumPasswordLength = 14\" }" > %temp%\2.txt
IF ERRORLEVEL 1 goto end
type %temp%\2.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"PasswordComplexity = 0\",	 \"PasswordComplexity = 1\" }" > %temp%\3.txt
IF ERRORLEVEL 1 goto end
type %temp%\3.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"AllowAdministratorLockout = 0\",	 \"AllowAdministratorLockout = 1\" }" > %temp%\4.txt
IF ERRORLEVEL 1 goto end
type %temp%\4.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"ForceLogoffWhenHourExpire = 0\",	 \"ForceLogoffWhenHourExpire = 1\" }" > %temp%\5.txt
IF ERRORLEVEL 1 goto end
type %temp%\5.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"ForceUnlockLogon=4,0\",	 \"ForceUnlockLogon=4,1\" }" > %temp%\6.txt
IF ERRORLEVEL 1 goto end
type %temp%\6.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"ConsentPromptBehaviorAdmin=4,5\",	 \"ConsentPromptBehaviorAdmin=4,2\" }" > %temp%\7.txt

IF ERRORLEVEL 1 goto end
type %temp%\7.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"EnableVirtualization=4,1\",	 \"EnableVirtualization=4,1`nMACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\FilterAdministratorToken=4,0\" }" > %temp%\8.txt
IF ERRORLEVEL 1 goto end
type %temp%\8.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"LegalNoticeText=7\",	 \"LegalNoticeText=7`nMACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\MaxDevicePasswordFailedAttempts=4,4\" }" > %temp%\9.txt
IF ERRORLEVEL 1 goto end
type %temp%\9.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"ValidateAdminCodeSignatures=4,0\",	 \"ValidateAdminCodeSignatures=4,1\" }" > %temp%\10.txt
IF ERRORLEVEL 1 goto end
type %temp%\10.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"LimitBlankPasswordUse=4,0\",	 \"LimitBlankPasswordUse=4,1\" }" > %temp%\11.txt
IF ERRORLEVEL 1 goto end
type %temp%\11.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"LmCompatibilityLevel=4,5\",	 \"LmCompatibilityLevel=4\,5`nMACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0\allownullsessionfallback=4,0\" }" > %temp%\12.txt
IF ERRORLEVEL 1 goto end
type %temp%\12.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"NTLMMinClientSec=4,524288\",	 \"NTLMMinClientSec=4\,537395200\" }" > %temp%\13.txt
IF ERRORLEVEL 1 goto end
type %temp%\13.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"NTLMMinServerSec=4,536870912\",	 \"NTLMMinServerSec=4\,537395200`nMACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0\RestrictReceivingNTLMTraffic=4,2\" }" > %temp%\14.txt
IF ERRORLEVEL 1 goto end
type %temp%\14.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"NoLMHash=4,1\",	 \"NoLMHash=4\,1`nMACHINE\System\CurrentControlSet\Control\Lsa\pku2u\AllowOnlineID=4,0\" }" > %temp%\15.txt
IF ERRORLEVEL 1 goto end
type %temp%\15.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"SubmitControl=4,0\",	 \"SubmitControl=4,0`nMACHINE\System\CurrentControlSet\Control\Lsa\UseMachineId=4,1\" }" > %temp%\16.txt
IF ERRORLEVEL 1 goto end
type %temp%\16.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"AddPrinterDrivers=4,0\",	 \"AddPrinterDrivers=4,0`nMACHINE\System\CurrentControlSet\Control\SAM\MinimumPasswordLengthAudit=4,7\" }" > %temp%\17.txt
IF ERRORLEVEL 1 goto end
type %temp%\17.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"EnableSecuritySignature=4,0\",	 \"EnableSecuritySignature=4\,1\" }" > %temp%\18.txt
IF ERRORLEVEL 1 goto end
type %temp%\18.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"RequireSecuritySignature=4,0\",	 \"RequireSecuritySignature=4,1\" }" > %temp%\19.txt
IF ERRORLEVEL 1 goto end
type %temp%\19.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"RequireStrongKey=4,1\",	 \"RequireStrongKey=4,1`nMACHINE\System\CurrentControlSet\Services\Netlogon\Parameters\RestrictNTLMInDomain=4,7\" }" > %temp%\20.txt
IF ERRORLEVEL 1 goto end
type %temp%\20.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"SignSecureChannel=4,1\",	 \"SignSecureChannel=4,1`nMACHINE\System\CurrentControlSet\Services\NTDS\Parameters\LdapEnforceChannelBinding=4,2`nMACHINE\System\CurrentControlSet\Services\NTDS\Parameters\LDAPServerIntegrity=4,2\" }" > %temp%\21.txt
IF ERRORLEVEL 1 goto end
type %temp%\21.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"SeNetworkLogonRight = \*S-1-1-0,\*S-1-5-32-544,\*S-1-5-32-545,\*S-1-5-32-551\",	 \"SeNetworkLogonRight = *S-1-5-32-544,*S-1-5-32-545\" }" > %temp%\22.txt

IF ERRORLEVEL 1 goto end
type %temp%\22.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"SeChangeNotifyPrivilege = \*S-1-1-0,\*S-1-5-19,\*S-1-5-20,\*S-1-5-32-544,\*S-1-5-32-545,\*S-1-5-32-551\",	 \"SeChangeNotifyPrivilege = *S-1-5-19,*S-1-5-20,*S-1-5-32-544,*S-1-5-32-545,*S-1-5-32-551\" }" > %temp%\23.txt

IF ERRORLEVEL 1 goto end
type %temp%\23.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"SeServiceLogonRight = *\S-1-5-80-0\",	 \"SeServiceLogonRight = *S-1-5-20\" }" > %temp%\24.txt
IF ERRORLEVEL 1 goto end
type %temp%\24.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"SeInteractiveLogonRight = Guest,\*S-1-5-32-544,\*S-1-5-32-545,\*S-1-5-32-551\",	 \"SeInteractiveLogonRight = *S-1-5-32-544,*S-1-5-32-545,*S-1-5-32-551\" }" > %temp%\25.txt
IF ERRORLEVEL 1 goto end
type %temp%\25.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"SeDenyNetworkLogonRight = Guest\",	 \"SeDenyNetworkLogonRight = Guest,*S-1-5-32-546,*S-1-0-0,*S-1-5-7,*S-1-5-14,*S-1-5-17,*S-1-5-32-555,*S-1-5-32-568,*S-1-5-32-575,*S-1-5-32-576,*S-1-5-32-577,*S-1-5-9,*S-1-5-113,*S-1-5-80-0,*S-1-5-2\" }" > %temp%\26.txt
IF ERRORLEVEL 1 goto end
type %temp%\26.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"SeDenyInteractiveLogonRight = Guest\",	 \"SeDenyInteractiveLogonRight = Guest,*S-1-5-32-546,*S-1-0-0,*S-1-5-7,*S-1-5-14,*S-1-5-17,*S-1-5-32-555,*S-1-5-32-568,*S-1-5-32-575,*S-1-5-32-576,*S-1-5-32-577,*S-1-5-9,*S-1-5-2`nSeDenyBatchLogonRight = Guest,*S-1-5-32-546,*S-1-0-0,*S-1-5-7,*S-1-5-14,*S-1-5-17,*S-1-5-32-555,*S-1-5-32-568,*S-1-5-32-575,*S-1-5-32-576,*S-1-5-32-577,*S-1-5-9,*S-1-5-2`nSeDenyServiceLogonRight = Guest,*S-1-5-32-546,*S-1-0-0,*S-1-5-7,*S-1-5-14,*S-1-5-17,*S-1-5-32-555,*S-1-5-32-568,*S-1-5-32-575,*S-1-5-32-576,*S-1-5-32-577,*S-1-5-9,*S-1-5-2`nSeDenyRemoteInteractiveLogonRight = Guest,*S-1-5-32-546,*S-1-0-0,*S-1-5-7,*S-1-5-113,*S-1-5-14,*S-1-5-17,*S-1-5-32-555,*S-1-5-32-568,*S-1-5-32-575,*S-1-5-32-576,*S-1-5-32-577,*S-1-5-9,*S-1-5-32-544,*S-1-1-0,*S-1-2-0,*S-1-2-1,*S-1-5-80-0,*S-1-5-2\" }" > %temp%\27.txt
pause
IF ERRORLEVEL 1 goto end
type %temp%\27.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"SeRemoteInteractiveLogonRight = \*S-1-5-32-544,\*S-1-5-32-555\",	 \"Administrator\" }" > %temp%\28.txt
IF ERRORLEVEL 1 goto end

type %temp%\28.txt | powershell -Command "$input | ForEach-Object { $_ -replace \"AAA\",	 \"BBB\" }" > cfgout.ini

:end

echo "다 완성 했네요 수고 하셨습니다"
echo "만약 cfgout.ini 파일이 없다면 %temp% 폴더에 가셔서 28.txt 파일 처럼 숫자로 된 파일을 살펴 보세요.

REM "도와 주신 분들 및 도움 된 블러그"
REM "https://hagsig.tistory.com/28"
REM "https://cafe.daum.net/candan/Lrrl/5"
REM "https://kin.naver.com/qna/detail.naver?d1id=1&dirId=104&docId=433227153"
REM "https://stackoverflow.com/questions/60034/how-can-you-find-and-replace-text-in-a-file-using-the-windows-command-line-envir"
REM "Simon East https://stackoverflow.com/users/195835/simon-east 이분이 특히 도움이 됬어요"
REM "https://cafe.daum.net/candan/ASdB/429 주소 사용 하는 곳"

endlocal
pause
