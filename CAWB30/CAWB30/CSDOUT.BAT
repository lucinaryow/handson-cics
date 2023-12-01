@echo off
echo CA-Realia CICS CSD Export Version 6.0.27
rem Copyright (c) 1993, 1997 Computer Associates International, Inc.
rem ****************************************************************
rem Revision Information
rem ^{File:csdout.bch}
rem ^{Timestamp:Tue Dec 24 08:06:50 1996}
rem ^{Revision:4.0}
if "%1"=="" goto help
if "%1"== "/?" goto help
if "%1"== "/h" goto help
if "%1"== "/H" goto help
echo on
cacxcsdx.exe %1 %2
@echo off
goto end
:help
echo Export CSD file to named RDT Source file
echo.
echo Usage: %0 RDTFile[.RDT] [CSDFile[.CSD]]
echo.
echo Note: The default CSDFile is REALCICS.CSD
echo.
goto end
:end
