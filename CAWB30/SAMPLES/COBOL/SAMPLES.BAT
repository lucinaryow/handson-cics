@echo off
@echo CA-Realia COBOL Samples Version 6.000 (batch file version)
@echo Copyright (c) 1992, 1996 Computer Associates International, Inc.
if not .%COBLINK%==. goto build
cd ..\..
call real2set.bat
cd samples\cobol
:build
:
: Build and run overall CPU performance sample
:
cobol primes
call linkcob primes
primes
pause
:
: Build and run screen handling sample
:
cobol nameaddr
cobol escaddr
cobol scraddr
call linkcobm nameaddr
call linkcobs escaddr
call linkcobs scraddr
nameaddr
:
: Redisplay version information
:
echo on
cls
@echo CA-Realia COBOL Samples Version 6.000 (batch file version)
@echo Copyright (c) 1992, 1996 Computer Associates International, Inc.
@echo.
@echo off
