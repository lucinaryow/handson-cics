@echo off
rem
echo CA-Realia COBOL LinkCobM Version 6.000 (batch file version)
echo Copyright (c) 1992, 1997 Computer Associates International, Inc.
rem
rem  LinkCobM creates a CA-Realia COBOL application executable (.EXE).
rem  The resulting .EXE may be executed in Windows/NT and Windows/95
rem  operating environments.
rem
rem  This command file accepts n .OBJ files as parameters each delimited by a
rem  space. The first parameter will also name the executable file. All other
rem  parameters are additional .OBJ files that are statically linked into the
rem  executable.
rem
if .%1==. goto noOBJ
rem
rem  This command file uses the COBLINK environment variable to locate
rem  library files that are required to create a CA-Realia COBOL executable.
rem
if .%COBLINK%==. goto noDIR
if not exist %COBLINK%\carclw60.lib goto noDIR
rem
rem  Link a main program and subprogram(s) into an application .EXE file.
rem
link /NOD /SUBSYSTEM:CONSOLE /ENTRY:_RealiaCOBOLexeentry %1 %2 %3 %4 %5 %6 %7 %8 %9 %USERLIB% %COBLINK%\carclw60.lib
goto end
:noOBJ
echo.
echo Link an application executable (.EXE) based on the CARCLW60 library.
goto usage
:noDIR
echo.
echo Error: cannot find the CA-Realia COBOL linker library directory.
set COBLINK=
:usage
echo.
echo Usage: LINKCOBM program [program[.OBJ] or library.LIB [...]] [/switches]
echo.
echo Switches:
echo  See LINK documentation or run LINK with no arguments for list of switches
echo.
echo Environment Variables:
echo  COBLINK...Directory containing CA-Realia COBOL linker library files.
echo  USERLIB...Optional object module library (.OBJ and .LIB) file(s)
echo  LIB.......Optional object module library (.OBJ and .LIB) search path.
echo  LINK......Optional linker switches (see LINK documentation).
echo.
:end
