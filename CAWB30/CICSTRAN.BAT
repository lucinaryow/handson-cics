@echo off
echo CA-Realia CICS Translate and compile Version 6.0.27
rem Copyright (c) 1992, 1997 Computer Associates International, Inc.
goto cicstran
rem
rem ****************************************************************
rem Revision Information
rem ^{File:cicstran.bch}
rem ^{Timestamp:Tue Apr 22 17:04:16 1997}
rem ^{Revision:11.0}
rem
rem  CICSTRAN is a batch file to compile and link a CICS application program
rem  CACXPREP will detect the existence of EXEC DLI code
rem  and automatically invoke the RealDLI preprocessor
rem
rem  CACXPREP will detect the existence of EXEC SQL code
rem  and automatically invoke the appropriate Realia SQL preprocessor
rem
rem Optional Environmental Variables
rem
rem  This batch file processes the USERLIB enviornmental
rem  to include user libraries in the link step
rem set USERLIB=
rem
rem The following environmental variables let you place output
rem from this batch.  The setting of these variables is optional.
rem If you choose not to set them, the outputs of the linker
rem remain in the same directory as the source.
rem
rem LSTDIR	- This is the LST target directory.
rem OBJDIR	- This is the OBJ target directory.
rem DLLDIR	- This is the DLL target directory.
rem MAPDIR	- This is the linker (.MAP) target directory.
rem SQLPREP	- This is the name of the SQL preprocessor batchfile.
rem		  It is responsible for setting env SQLLIB
rem
rem Examples:
rem
rem SET OBJDIR=C:\OBJ\
rem SET DLLDIR=C:\CICS\BIN\
rem
rem Note:  These directory names MUST end with a backslash.
rem
rem modify TRANDIREC and COBDIREC if required (see CICS Users' Manual)
rem set TRANDIREC=
rem set COBDIREC=
rem
:cicstran
if exist %1 goto error
if .%coblink%==. call Real2set
if .%cicslink%==. call Real2set
if "%1"== "" goto help
if "%1"== "/?" goto help
if "%1"== "/h" goto help
if "%1"== "/H" goto help
set _extralib=
echo Begin CICS Translation of %1
@echo on
cacxprep %1 %1.CIC %lstdir%%1.LCS /%3
@echo off
if errorlevel 3 goto end
set filext=cic
:testdli
if exist %1.$$1 goto cicsdli
:testsql
if exist %1.$$2 goto cicssql
:testcic
if exist %1.cic goto compile
goto end
:cicsdli
erase %1.$$1
rem dli disabled
echo DLI support not available
pause
goto testsql
echo Begin DLI Translation of %1.CIC
@echo on
caisprep %1.fileext
@echo off
set filext=cdl
set _extralib=%_extralib% cais6dli.lib
goto testsql

:cicssql
erase %1.$$2
if not "%sqlprep%"=="" goto moresql
echo SQL preprocessor not defined
pause
goto end
echo Begin SQL Translation of %1.%filext%
@echo on
call %sqlprep% %1.%fileext% %1.csq
@echo off
set filext=csq
if not "%sqllib%"=="" set _extralib=%_extralib% %sqllib%
goto testcic

:compile
echo compiling generated code of %1.%filext%
@echo on
COBOL /r%2 %1.%filext% %objdir%%1 %lstdir%%1
@echo off
if errorlevel 3 goto end
if not exist %objdir%%1.obj goto end
rem
call linkcobs %1 %_extralib%
goto end
:error
echo A file named %1 exists
echo It cannot be used as a parameter for this batch file
echo retype the command using the program name without the extension
goto end
:help
echo.
echo Usage: 0% program [compileswitches [ Preprocswitches]]
echo.
echo Switches: must be specified as a contiguous group of characters.
echo  See documentation for list of switches.
echo   or execute CACXPREP /? for Preprocessor switches
echo   or execute COBOL /? for Compiler switches
echo.
goto end
:end
if exist %1.$$? erase %1.$$?
set filext=
