@echo off
rem
rem  CA-Realia COBOL LinkCob Version 6.000 (batch file version)
rem  Copyright (c) 1992, 1997 Computer Associates International, Inc.
rem
rem  LinkCob creates a CA-Realia COBOL application executable (.EXE).
rem  The resulting .EXE may be executed in Windows/NT and Windows/95
rem  operating environments.
rem
rem  This command file accepts n .OBJ files as parameters each delimited by a
rem  space. The first parameter will also name the executable file. All other
rem  parameters are additional .OBJ files that are statically linked into the
rem  executable.
rem
LinkCobM %1 %2 %3 %4 %5 %6 %7 %8 %9
