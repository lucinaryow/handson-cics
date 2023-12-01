@echo off
cls
echo CA-Realia CICS build sample application Version 6.0.27
echo Copyright (c) 1993, 1997 Computer Associates International, Inc.
rem
rem BUILDSAM regenerates all of the Sample System Application Files
rem
rem Revision Information
rem ^{File:buildsam.bch}
rem ^{Timestamp:Thu Jun 19 07:39:24 1997}
rem ^{Revision:8.0}
rem
rem test for valid directories
if .%coblink%==. call real2set
if .%cicslink%==. call real2set
if exist %cicslink%\cacx6exe.lib goto ok
echo %cicslink% directory is not valid for CICS
goto error
:ok
set _step=0
set tmp_cobdirec=%cobdirec%
set cobdirec=
set tmp_copydir=%copydir%
set copydir=
set tmp_objdir=%objdir%
set objdir=
set tmp_lstdir=%lstdir%
set lstdir=
set tmp_mapdir=%mapdir%
set mapdir=
set tmp_dlldir=%dlldir%
set dlldir=
rem
rem Merge Sample into System CSD
set _step=2
call csdin seatwork
if errorlevel 1 goto builderr
rem
rem Generate Sample System Maps
if exist UA001S.bin erase UA001S.bin
if exist UA001S.cob erase UA001S.cob
if exist UA002S.bin erase UA002S.bin
if exist UA002S.cob erase UA002S.cob
set _step=3
call bms UA001S
call bms UA002S
if errorlevel 1 goto builderr
rem Generate Sample System Programs: Translate, Compile, and Link
if exist UA001P.dll erase UA001P.dll
if exist UA001P.obj erase UA001P.obj
call cicstran UA001P /hvw
if exist UA002P.dll erase UA002P.dll
if exist UA002P.obj erase UA002P.obj
call cicstran UA002P /hvw
if errorlevel 1 goto builderr
goto end
:builderr
echo Error occured at step %_step%
pause
goto end
:error
echo.
echo Please modify the environment values for CICSLINK and COBLINK
echo and re execute this batch file
goto exit
:end
set cobdirec=%tmp_cobdirec%
set tmp_cobdirec=
set copydir=%tmp_copydir%
set tmp_copydir=
set objdir=%tmp_objdir%
set tmp_objdir=
set lstdir=%tmp_lstdir%
set tmp_lstdir=
set mapdir=%tmp_mapdir%
set tmp_mapdir=
set dlldir=%tmp_dlldir%
set tmp_dlldir=
:exit
