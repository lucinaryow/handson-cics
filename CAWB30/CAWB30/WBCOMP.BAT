@echo off
: *****************************************************************************
: *
: * CA-Realia II Workbench 3.0 COBOL WbComp.Bat command file.
: * Copyright (c) 1997 Computer Associates International, Inc.
: *
: * Revision Information
: * ^{File:wbcomp.bat}
: * ^{Timestamp:Tue May 20 11:36:02 1997}
: * ^{Revision:15.0}
: *
: * Note: The batch command interpreter for NT resets errorlevel to 0
: * ***** after each and every  SET statement!
: *
: * WbComp.Bat - The purpose of this batch procedure is to Precompile and
: ***********  compile a Cobol Source Program.  Precompile step(s) are handled
: * in WBPrep.Bat. If the WBPrep command file is successful, then this compile
: * batch file will continue. If this routine is succesful then the following
: * files will be created in the Working Directory (CompileDir) or specified
: * output dir.
: *
: *  1 %ObjDir%%CA_DOC_FN%.OBJ
: *  2 %LstDir%%CA_DOC_FN%.Lst
: *  3 %SymDir%%CA_DOC_FN%.Sym                :
: * Additionally, if CA_UseObjLib is specified then the .Obj File
: *  will be inserted into CA_ObjLib
: *
: * o Environment Variables that are Input to this command procedure are:
: *----------------------------------------------------------------------
: * 1. CA_REAL2DIR    - This is the directory where the Workbench was
: *                     installed.
: * 2. CA_REALIA_INI  - This is the name of the options file that will be
: *                     passed on the the script processor
: *
: * 3. CA_SHOW_WIN    - Request that Batch window be shown
: * 4. CA_ECHO_WIN    - Request that Batch commands be echoed
: *
: * 5. REAL2PATH      - This is an env var that points to the path
: *                     to the workbench and other places the user
: *                     wishes.
: * 6. CA_DOC_FN_FULL   -This is the full file name and path of the target source
: * 7. CA_DOC_FM_AND_EXT -This variable is the file name and extension of
: *                   the source file that is to be preprocessed.
: * 8. CA_DOC_FN         -This is the file name only of the target source.
: * 9. CA_DOC_FN_EXT     -This is the extension only of the target source.
: *10. CA_DOC_FN_DRIVE   -This is the drive letter of the target source.
: *11. CA_DOC_FN_DIR     -This is the directory of the target source.  Note: it
: *                    is also the current directory when your batch procedure
: *                    is invoked.  Additionally, if you change directories
: *                    in your batch procedure you should reset to this
: *                    directory before exiting.
: *12  CA_DOC_FN_Path    -This is the Path to the target source.
: *13  CompileDir        - Working Directory - The Script that invokes this
: *                       batch proc is responsible for setting the working
: *                       directory to this User Defined Value.
: *14  CompileTmp        - CobWrk Directory
: *17  ObjDir            - Output Directory for Obj Files
: *18  LstDir            - Output Directory for Listing Files
: *19  SymDir            - Output Directory for Sym Files
: *20  PREP_WARN_OK      - Minimum Compile RC Error Level for the Compile
: *                        step to be considered successful.
: *21  CA_PREP_IGNORE_WARNINGS
: *                      - Indicates if Warnings are acceptable for the
: *                        precompiler.
: *22  COB_ADDOPT        - Additonal Compile Options
: *
: *23  LOG_FN            - Location and File Name of the log file for this pgm
: *
: *Step Description:
: ******************
: * 1 InitStep         - Initialize Env Vars
: *    o Output from previous compile attempts is Deleted
: * 2 PrepStep         - Invoke Preprocessor Step(s)
: *   The WBPrep.Bat command procedure is called to handle any precompile
: *   steps necesary for the current program.  Even if there are no
: *   precompile steps WBPrep.Bat will set _StepInFN and _StepInExt to the
: *   file name and Extension that should be input to the compiler.
: *   _StepRC is set to either "0" (OK) or "F" (FAIL).  Finally,
: *   WbPrep.Bat will test CA_PREP_IGNORE_WARNINGS to determine if
: *   preprocessor Warnings are treated as Fatal or Not!
: * 3 CompileStep      - Compile Program Step
: *   If the PreCompile Fails (_StepRC NE "0") then set _CompRC (RC from
: *   this batch file to an appropriate value) and Exit.
: *   If the PreCompile Succeeds (_StepRC EQ "0") then continue with
: *   compile process.  For example, build response file and invoke compile.
: *   If Compile succeeds then determine if %SymDir% is different than
: *   listing dir.  If it is copy Sym file from listing dir to Sym Dir.
: * 4 ObjLibStep       - Update Already Existing Obj Library
: * 5 LibCreateStep    - Create NEW Obj Library and Add member
: * 6 FileCleanUpStep  - Cleanup Any Temporary Files
: *   Cleanup all temporary files used by compiler
: * 7 End              - End Batch File
: *
: *Error Logic:
: **************
: * 1 ERROR: FailPrep -  Preprocessor Step(s) Failed
: * 2 ERROR: FailComp - Compile Step Failed
: * 3 ERROR: ErrCompilerNotFound - Compiler could not be found
: *
: *
: *Return Codes                                  CVSTATUS
: ***************                               **********
: * 1. _CompRC="0" - Success                         0
: * 2. _CompRC="P" - Failed Preprocessor Step        1
: * 3. _CompRC="W" - Compile Step Warnings/Info      2/3 (3 means don't link)
: * 4. _CompRC="F" - Failed Compile Step             5
: *
: * Note:
: *   When maintaining this batch file please be aware that the
: *   following syntax is used on purpose:
: *     if not Exist %File% go to Label
: *     del %File%
: *     :Label
: *   This logic is used because if the file name in question contains
: *   a very long path AND you placed the Del on the same line eg.
: *     if Exists %File% del %File% then if the entire command line
: *     exceeds DOS 124 char limit then the statement would fail!!!
: *
: * Note
: *   Important! - Dos Command Line may not exceed 127 Characters!!!
: *   -----------
: ****************************************************************************
: *
set _WbErrFmt=N
set _ErrDisaster="N"
if .%CA_ECHO_WIN%==.Y echo on
: *****************************************************************************
: * InitStep - Initialize Env Vars
: *****************************************************************************
:InitStep
if not exist %ObjDir%%CA_DOC_FN%.Obj goto Init2Step
del %ObjDir%%CA_DOC_FN%.Obj
:Init2Step
if not exist %LstDir%%CA_DOC_FN%.Lst goto Init3Step
del %LstDir%%CA_DOC_FN%.Lst
:Init3Step
if not exist %SymDir%%CA_DOC_FN%.Sym goto Init4Step
del %SymDir%%CA_DOC_FN%.Sym
:Init4Step
if not .%CompileTmp%==. set COBWRK=%CompileTmp%
Set COBOLMSG=%CA_DOC_FN%.R01
rem set COBOLMSG=

cawbecho A > %LOG_FN%
cawbecho 7 %CA_DOC_FN_FULL% >> %LOG_FN%
cawbecho B %CA_REALIA_INI% >> %LOG_FN%
cawbecho 8 %CompileDir% >> %LOG_FN%

cawbecho A
cawbecho 7 %CA_DOC_FN_FULL%
cawbecho B %CA_REALIA_INI%
cawbecho 8 %CompileDir%

if NOT .%CA_ECHO_WIN%==.Y goto  PrepStep
echo ===========  Working Directory  =============== >> %LOG_FN%
cd >>   %LOG_FN%
echo ===========  Start List of Environment Area  =============== >> %LOG_FN%
set >> %LOG_FN%
echo ===========  End List of Environment Area  ================= >> %LOG_FN%
: *****************************************************************************
: * PrepStep - Invoke Preprocessor Step(s)
: *****************************************************************************
:PrepStep
CALL %CA_REAL2DIR%\WbPrep
if .%_StepRC% == ."F" goto FailPrep
: *
: * The following logic ensures that if there is no preprocessor step that the
: * input to the compiler is found.
: *
set _CompileSrcIn=%CompileDir%%_StepInFN%.%_StepInExt%
if .%_PrepCalled% == ."Y" goto CompileStep
set _CompileSrcIn=%CA_DOC_FN_FULL%
: *****************************************************************************
: * CompileStep - Compile Program Step
: *****************************************************************************
:CompileStep

if not .%COB_ADDOPT%==. echo  %COB_ADDOPT%>%CA_DOC_FN%.inp
echo  %_CompileSrcIn%>>%CA_DOC_FN%.inp
echo  %ObjDir%%CA_DOC_FN%.OBJ>>%CA_DOC_FN%.inp
echo  %LstDir%%CA_DOC_FN%.LST>>%CA_DOC_FN%.inp
echo =========== Start List of Compile Response File ============ >> %LOG_FN%
copy %LOG_FN% + %CA_DOC_FN%.inp %LOG_FN% > nul
echo =========== End List of Compile Response File ============== >> %LOG_FN%
set CA_MIN_COMPILE_RC=2
: *
: * Default Min Error Level to be 5 or GT i.e., GT 4 (Conditional Errors)
: *
if .%LNK_COMP_WARN_OK%==.YES Set CA_MIN_COMPILE_RC=3
if .%DoNotLinkIfCompileGreaterThan%==. goto SkipOveride
Set CA_MIN_COMPILE_RC=%DoNotLinkIfCompileGreaterThan%
:SkipOveride
cvstatus 255

%CA_REAL2DIR%\COBOL.EXE @%CA_DOC_FN%.inp

if errorlevel 255 goto ErrCompilerNotFound
if errorlevel 3 goto FailComp
if errorlevel 2 goto CompilerWarnings

rem Compile Successful
cawbecho 3 %CA_DOC_FN_FULL%
cawbecho 3 %CA_DOC_FN_FULL% >> %LOG_FN%

set _CompRC="0"

goto ContinueProcessing1

:CompilerWarnings
rem Compile Successful with Warnings
cawbecho 5 %CA_DOC_FN_FULL%
cawbecho 5 %CA_DOC_FN_FULL% >> %LOG_FN%

set _CompRC="W"
goto FileCleanUpStep

:ContinueProcessing1
if .%CA_ECHO_WIN%==.Y goto ObjLibStep

: *****************************************************************************
: * ObjLibStep - Update Already Existing Obj Library
: *****************************************************************************
:ObjLibStep
if NOT .%CA_UseObjLib%==.YES  goto FileCleanUpStep
if .%CA_ObjLib%.==..          goto ObjNextMake
if .%CA_ObjLib%.==. .         goto ObjNextMake
goto ObjNextStep
: *
: * Default Lib to App.Lib
: *
:ObjNextMake
if .%CA_APP_FN%.==..        goto FileCleanUpStep
if .%CA_APP_FN%.==. .       goto FileCleanUpStep
set CA_OBJLIB=%CA_APP_FN%.LIB
:ObjNextStep
if NOT exist %CA_ObjLib%  goto LibCreateStep
: *****************************************************************************
: * Add member to Lib that already exists
: *****************************************************************************
Lib /Out:%CA_ObjLib% %CA_ObjLib% %ObjDir%%CA_DOC_FN%.OBJ
goto FileCleanUpStep
: *****************************************************************************
: * LibCreateStep - Create NEW Obj Library and Add member
: *****************************************************************************
:LibCreateStep
Lib /Out:%CA_ObjLib% %ObjDir%%CA_DOC_FN%.OBJ
goto FileCleanUpStep
: *
: *****************************************************************************
: *****************             E R R O R  S T E P S                ***********
: *****************************************************************************
: *
:FailPrep
  set _ErrStep=FailPrep
  set _CompRC="P"
: * Temp Settings since error level is being wiped out
  CVstatus 6
  goto ProcessErrorsStep
:FailComp
if errorlevel 7 Set _ErrDisaster="Y"
if not exist %LstDir%%CA_DOC_FN%.cvx goto Fail1Comp
del %LstDir%%CA_DOC_FN%.cvx
:Fail1Comp
  set _ErrStep=FailComp
  set _CompRC="F"
: * Temp Settings since error level is being wiped out
  CVstatus 5
  goto ProcessErrorsStep
:ErrCompilerNotFound
  set _ErrStep=ErrCompilerNotFound
  set _CompRC="F"
: * Temp Settings since error level is being wiped out
  CVstatus 16
  goto ProcessErrorsStep
: *
: *****************************************************************************
: *****************    P R O C E S S   E R R O R    S T E P         ***********
: *****************************************************************************
: *
:ProcessErrorsStep
call WBERROR
goto FileCleanUpStep
: *****************************************************************************
: * FileCleanUpStep -  Cleanup Any Temporary Files
: *
: *  1. Append Output Redirection of compiler to .LOG file
: *  2. Delete Output Redirection File - COBOLMSG
: *  3. Delete Input  Redirection File - CA_DOC_FN.Inp
: *****************************************************************************
:FileCleanUpStep
if .%COBOLMSG%==. goto File2CleanUp
if not exist %COBOLMSG% goto File2CleanUp
copy %LOG_FN% + %COBOLMSG% %LOG_FN% > nul
del %COBOLMSG%
:File2CleanUp
if .%CA_DOC_FN%==. goto End
if not exist %CA_DOC_FN%.inp goto End
del %CA_DOC_FN%.inp
goto End
: ********************
: *  End Batch File  *
: ********************

:End
if NOT  .%_CompRC%==."P" goto End1Next
if .%_WbErrFmt%==.Y goto End3Next
CVSTATUS 1
goto TheEnd

:End1Next
if NOT .%_CompRC%==."F" goto End2Next
CVSTATUS 5
goto TheEnd

:End3Next
set _CompRC="F"
CVSTATUS 5
goto TheEnd

:End2Next
if NOT .%_CompRC%==."W" goto TheEnd
cvstatus 2
if .%LNK_COMP_WARN_OK%==.NO cvstatus 3

:TheEnd
if .%_ErrDisaster% == ."Y" CVSTATUS 99
