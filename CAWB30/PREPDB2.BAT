@echo off
echo CA-Realia DB2 Translate Version 6.0.1
rem Copyright (c) 1992, 1997 Computer Associates International, Inc.
goto Prepdb2
rem
rem ****************************************************************
rem Revision Information
rem ^{File:prepdb2.bch }
rem ^{Timestamp:Tue Feb 25 15:38:24 1997}
rem ^{Revision:2.0}
rem
rem  PREPDB2 is a batch file to translate a DB2 application program
rem	     and can work in conjunction with CICSTRAN
rem
:Prepdb2
if "%1"== "" goto help
if "%1"== "/?" goto help
if "%1"== "/h" goto help
if "%1"== "/H" goto help
rem Set up default dbname
set _dbname=%DB2NAME%
if "%DB2name%"=="" set _dbname=sample
rem set default sqllib
set sqllib=%db2lib%
if "%DB2lib%"=="" set sqllib=%DB2Path%\lib\db2api.lib
echo Begin DB2 Translation of %1
@echo on
realdb2 %1 %_dbname% %2
@echo off
goto end
:help
echo.
realdb2
goto end
:end
