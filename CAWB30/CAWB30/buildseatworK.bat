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
echo %cicslink% directory is not valid for CICS 
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
call csdin handson
if errorlevel 1 goto builderr
rem
rem Generate Sample System Maps
if exist sm000s.bin erase sm000s.bin
if exist sm000s.cob erase sm000s.cob
rem Generate Sample System Maps
if exist sm001s.bin erase sm001s.bin
if exist sm001s.cob erase sm001s.cob
rem Generate Sample System Maps
if exist sm006s.bin erase sm006s.bin
if exist sm006s.cob erase sm006s.cob
rem Generate Sample System Maps
if exist sm002.bin erase sm002.bin
if exist sm002.cob erase sm002.cob
rem Generate Sample System Maps
if exist ua001s.bin erase ua001s.bin
if exist ua001s.cob erase ua001s.cob
rem Generate Sample System Maps
if exist ua002s.bin erase ua002s.bin
if exist ua002s.cob erase ua002s.cob
set _step=3
call bms sm000s
if errorlevel 1 goto builderr
rem Generate Sample System Programs: Translate, Compile, and Link
if exist sm000p.dll erase sm000p.dll
if exist sm000p.obj erase sm000p.obj
call cicstran sm000p /hvw
call bms sm001s
if errorlevel 1 goto builderr
rem Generate Sample System Programs: Translate, Compile, and Link
if exist sm001p.dll erase sm001p.dll
if exist sm001p.obj erase sm001p.obj
call cicstran sm001p /hvw
if errorlevel 1 goto builderr
call bms sm002
if errorlevel 1 goto builderr
rem Generate Sample System Programs: Translate, Compile, and Link
if exist sm02p.dll erase sm02p.dll
if exist sm02p.obj erase sm02p.obj
call cicstran sm02p /hvw
if errorlevel 1 goto builderr
call bms ua001s
if errorlevel 1 goto builderr
rem Generate Sample System Programs: Translate, Compile, and Link
if exist ua001p.dll erase ua001p.dll
if exist ua001p.obj erase ua001p.obj
call cicstran ua001p /hvw
if errorlevel 1 goto builderr
call bms ua002s
if errorlevel 1 goto builderr
rem Generate Sample System Programs: Translate, Compile, and Link
if exist ua002p.dll erase ua002p.dll
if exist ua002p.obj erase ua002p.obj
call cicstran ua002p /hvw
if errorlevel 1 goto builderr
call bms sm006s
if errorlevel 1 goto builderr
rem Generate Sample System Programs: Translate, Compile, and Link
if exist sm006p.dll erase sm006p.dll
if exist sm006p.obj erase sm006p.obj
call cicstran sm006p /hvw
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
