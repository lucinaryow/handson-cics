@echo off
echo CA-Realia CICS BMS Generation Version 6.0.27
echo Copyright (c) 1993 - 1997 Computer Associates International, Inc.
goto bms
rem Revision Information
rem ^{File:bms.bch}
rem ^{Timestamp:Tue Dec 24 08:06:00 1996}
rem ^{Revision:6.0}
rem
rem Optional Environmental Variables
rem
rem The following environmental variables let you place output
rem from this batch.  The setting of these variables is optional.
rem If you choose not to set them, the outputs of the linker
rem remain in the same directory as the source.
rem
rem LSTDIR  - This is the LST target directory.
rem COPYDIR - This is the CPY target directory.
rem DLLDIR  - This is the BIN target directory.
rem
rem Examples:
rem
rem SET COPYDIR=C:\COPYLIB\
rem SET DLLDIR=C:\CICS\BIN\
rem
rem Note:  These directory names MUST end with a backslash.
rem
:bms
if "%1"== "" goto help
if "%1"== "/?" goto help
if "%1"== "/h" goto help
if "%1"== "/H" goto help
if exist %1 goto process
if exist %1.bms goto process
echo.
echo  Input "%1" to BMS process is not found or incomplete
:help
echo.
echo  Command format:
echo	    %0 filename[.BMS] [/Switches]
echo	    Where filename is your BMS map input
echo	     and  Switches are CA-Realia BMS Switches
echo.
echo Note: To view all possible switches execute CACXBMS /?
echo.
goto end
:process
@echo on
cacxbms  /%2 %1 %copydir% %dlldir% %lstdir%
@echo off
:end
