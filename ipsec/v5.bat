@echo off
setlocal enabledelayedexpansion
chcp 65001 > nul
cd /d "%~dp0"

echo == 중국IP주소 차단룰 설정중입니다. 잠시만기다려주세요..... ==
echo == 서비스를 이용해 주셔서 감사합니다. (주)스마일서브 ==
REM	20220612 동우가 수정해봄 기초 뼈대
REM
REM   China_block
REM
REM   (주) 스마일서브 기술지원팀 김성태대리 2007-12-11
REM
REM
REM
REM
REM 로컬룰지정
netsh ipsec static set store location=local

REM 최초 룰정책 생성
netsh ipsec static add policy name=China_IP_block_list activatedefaultrule=yes (주)스마일서브-중국IP리스트-차단정책 assign=yes

REM 필터리스트 추가
REM netsh ipsec static add filterlist name=All
netsh ipsec static add filterlist name=China_block
netsh ipsec static add filterlist name=Local

REM 허용/거부룰 설정
netsh ipsec static add filteraction name=Permit action=Permit
netsh ipsec static add filteraction name=Block action=Block

REM 모든트래픽허용
REM netsh ipsec static add filter filterlist=All srcaddr=ANY dstaddr=me dstmask=255.255.255.0 protocol=ANY mirrored=yes

REM 중국IP차단
netsh ipsec static add filter desc=58.14.0.0 filterlist=China_block srcaddr=58.14.0.0 srcmask=255.255.0.0 dstaddr=ANY protocol=ANY mirrored=yes

REM
REM 255.255.255.0 차단
REM

netsh ipsec static add filter desc=192.83.122.0 filterlist=China_block srcaddr=192.83.122.0 srcmask=255.255.255.0 dstaddr=ANY protocol=ANY mirrored=yes

netsh ipsec static add filter desc=222.240.9.0 filterlist=China_block srcaddr=222.240.9.0 srcmask=255.255.255.0 dstaddr=ANY protocol=ANY mirrored=yes

REM 로컬트래픽허용
netsh ipsec static add filter filterlist=Local srcaddr=me dstaddr=localhost dstmask=255.255.255.0 protocol=ANY mirrored=yes

REM  필터룰 추가
REM netsh ipsec static add rule name=2 policy=China_IP_block_list filter=All filteraction=Permit
netsh ipsec static add rule name=3 policy=China_IP_block_list filter=China_block filteraction=Block
netsh ipsec static add rule name=1 policy=China_IP_block_list filter=Local filteraction=Permit


