@echo off
rem CA-Realia CICS System Table Print Version 6.0.27
rem Copyright (c) 1993, 1997 Computer Associates International, Inc.
rem ****************************************************************
rem Revision Information
rem ^{File:cicsdoc.bch}
rem ^{Timestamp:Tue Dec 24 08:07:10 1996}
rem ^{Revision:4.0}
set _commandlist=%1
if .==.%1 set _commandlist=syntax.prn
echo on
cacxdoc %_commandlist%
@echo off
echo List of current syntax is in file %_commandlist%
set _commandlist=
