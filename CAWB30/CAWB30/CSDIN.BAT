@echo off
echo CA-Realia CICS CSD Import Version 6.0.27
rem Copyright (c) 1993, 1997 Computer Associates International, Inc.
rem ****************************************************************
rem Revision Information
rem ^{File:csdin.bch}
rem ^{Timestamp:Thu May 08 10:02:14 1997}
rem ^{Revision:8.0}
if "%1"=="" goto help
if "%1"== "/?" goto help
if "%1"== "/h" goto help
if "%1"== "/H" goto help
echo on
cacxcsdi.exe %1 %2 %3 %4
@echo off
goto end
:help
echo Import RDT file into named CSD file
echo.
echo Usage: %0 RDTFile[.RDT] [CSD-directory] [/Switches]]
echo.
echo Note: The default CICS Region directory is the value in the CSS file
echo	   named in %windir%\CACX60.INI
echo	   To view all possible switches execute CACXCSDI /?
echo.
goto end
:end
