@echo off
echo CA-Realia CICS Build CICSTERM.DLL Version 6.0.27
echo Copyright (c) 1993, 1997 Computer Associates International, Inc.
goto buildtrm
rem  CICSTERM permits customization of keyboard mapping and colors
rem ****************************************************************
rem Revision Information
rem ^{File:buildtrm.bch}
rem ^{Timestamp:Wed May 21 09:50:30 1997}
rem ^{Revision:6.0}
rem ****************************************************************
:buildtrm
set _cicsterm=%1
if %1.==. set _cicsterm=cicsterm
@echo on
COBOL /n %_cicsterm% %objdir%%_cicsterm%	%lstdir%%_cicsterm%
@echo off
if errorlevel 3 goto end
if not exist %objdir%%_cicsterm%.obj goto end
call linkcobs %_cicsterm%
:end
set _cicsterm=
