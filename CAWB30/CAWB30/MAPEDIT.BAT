@echo off
echo CA-Realia CICS Map Edit Version 6.0.27
rem Copyright (c) 1993, 1997 Computer Associates International, Inc.
rem ****************************************************************
rem Revision Information
rem ^{File:mapedit.bch}
rem ^{Timestamp:Thu Jun 19 07:56:40 1997}
rem ^{Revision:5.0}
rem
rem use /l as extra parameter to use 43 line edit mode
rem use /w as extra parameter to use 132 column edit mode
rem use /d as extra parameter to permit duplicate field names in different maps
rem
cacxmap %1 %2 %3 %4
