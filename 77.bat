@echo off
setlocal enabledelayedexpansion
chcp 65001 > nul
cd /d "%~dp0"

rem 200 줄씩 가져와서 한 줄로 만들어서 화면에 출력.
set /a CountLine=0
set "str="
for /f "delims=" %%a in ('type "%temp%\out.txt"') do (
set /a CountLine=!CountLine!+1
set "str=!str!,%%a"
if !CountLine! EQU 200 (
set /a CountLine=0
:: echo !str!
netsh advfirewall firewall add rule name="BlockitTT" protocol=any dir=in action=block remoteip=!str!
set "str="
)
)