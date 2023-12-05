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
rem Purge existing runtime work files
if exist dfh*.dat  erase dfh*.dat
if exist dfh*.idx  erase dfh*.idx
rem
rem Build Sample data file
set _step=1
echo f >namefile.rsp
echo 0/4 >>namefile.rsp
echo 4/10/d >>namefile.rsp
realcopy namefile.seq namefile.dat[x414] <namefile.rsp
if errorlevel 1 goto builderr
erase namefile.rsp
rem
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
call csdin sample
if errorlevel 1 goto builderr
rem
rem Generate Sample System Maps
if exist samm?0.bin erase samm?0.bin
if exist samm?0.cob erase samm?0.cob
set _step=3
call bms samm00
if errorlevel 1 goto builderr
set _step=4
call bms samm10
if errorlevel 1 goto builderr
set _step=5
call bms samm20
if errorlevel 1 goto builderr
set _step=6
call bms samm30
if errorlevel 1 goto builderr
rem
rem Generate Sample System Programs: Translate, Compile, and Link
if exist samp?0.dll erase samp?0.dll
if exist samp?0.obj erase samp?0.obj
call cicstran samp00 /hvw
set _step=7
call cicstran samp10 /hvw
if errorlevel 1 goto builderr
set _step=8
call cicstran samp20 /hvw
if errorlevel 1 goto builderr
set _step=9
call cicstran samp30 /hvw
if errorlevel 1 goto builderr
set _step=10
call cicstran samp90 /hvw
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
