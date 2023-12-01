@echo off
rem
echo CA-Realia Real2SET Version 6.000 (batch file version)
echo Copyright (c) 1992, 1996 Computer Associates International, Inc.
rem
rem  Real2SET invokes RealCFG to build a batch file
rem  This batch file will set all environmentals to support
rem  the Realia installation as defined in the registration file
rem
rem  use REAL2SET /C to force a full replacement of LIB, OBJ and SYSLIB
rem
if exist real2env.bat erase real2env.bat
realcfg /q real2env.bat %1
if exist real2env.bat call real2env.bat
