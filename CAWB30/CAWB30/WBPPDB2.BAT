: *****************************************************************************
: *
: * CA-Realia II Workbench 3.0 COBOL WbPPDB2.Bat command file.
: * Copyright (c) 1997 Computer Associates International, Inc.
: *
: * Revision Information
: * ^{File:wbppdb2.bat}
: * ^{Timestamp:Tue Jan 28 09:52:54 1997}
: * ^{Revision:1.0}
: *
: *
: * WbppDB2.Bat - The purpose of command file is to Preprocess a DB2 COBOL program.
: *
: * Input:
: *   1. _StepCmd    = Step Cmd File Name
: *   2. _StepWrkDir = Working Directory Where Input Found and
: *                    Outputs Should be Placed.
: *   3. _StepInFN   = File Name Only
: *   4. _StepInExt  = Extention Only
: *
: * Output
: *   1. _StepRC
: *   2. _StepOutExt = Extension Only
: *
set _StepOutExt=CDB
Set DB2MSG=%CA_DOC_FN%.R02
set RSP_FN=%CA_DOC_FN%.RSP
echo %_StepWrkDir%%_StepInFn%.%_StepInExt%           > %RSP_FN%
echo /output=%_StepWrkDir%%_StepInFn%.%_StepOutExt% >> %RSP_FN%
echo /list=%_StepWrkDir%%_StepInFn%.LDB             >> %RSP_FN%
realdb2  @%RSP_FN%
if errorlevel 5 goto Error
if errorlevel 1 goto Warning
set _StepRC=StepOK
goto end
: ********************************
: * Error Detected               *
: ********************************
:error
set _StepRC=SStepFailed
goto CleanUp
: ********************************
: * Warning Detected             *
: ********************************
:Warning
set _StepRC=StepWarnings
goto CleanUp
: ********************************
: * Copy Error Files to Log      *
: ********************************
:Cleanup
copy %LOG_FN% + %_StepWrkDir%%_StepInFn%.LDB %LOG_FN%
:End
if exist %CA_DOC_FN%.r02 del %CA_DOC_FN%.r02
if exist %CA_DOC_FN%.rsp del %CA_DOC_FN%.rsp
