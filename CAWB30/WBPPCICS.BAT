: *****************************************************************************
: *
: * CA-Realia II Workbench 3.0 COBOL WbPPCics.Bat command file.
: * Copyright (c) 1995 Computer Associates International, Inc.
: *
: * Revision Information
: * ^{File:wbppcics.bat}
: * ^{Timestamp:Fri May 16 10:17:26 1997}
: * ^{Revision:4.0}
: *
: *
: * WbppCICS.Bat - The purpose of command file is to Preprocess a CICS
: * ************   COBOL program.
: *
: * Input:
: *   1. _StepCmd    = Step Cmd File Name
: *   2. _StepWrkDir = Working Directory Where Input Found and
: *                    Outputs Should be Placed.
: *   3. _StepInFN   = File Name Only
: *   4. _StepInExt  = Extention Only
: *   5  _StepOutExt = Suggested Ouput Extention!
: *   6. _StepInDirFn = Dir and File name no Ext
: * 
: * Output
: *   1. _StepRC
: *   2. _StepInExt  = Extension Only
: *
: * ******************* Sample Batch File ***********************************
: * Line 1-> copy %_StepInDirFn%.%_StepInExt%  %_StepWrkDir%%_StepInFN%.BB1
: * Line 2-> set _StepOutExt=BB1
: * Line 3-> cvstatus 0
: * *************************** End Sample ***********************************
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
: ***************
set _StepOutExt=CIC
Set CICSMSG=%CA_DOC_FN%.R02
set RSP_FN=%CA_DOC_FN%.RSP
echo %_StepInDirFn%.%_StepInExt%              > %RSP_FN%
echo %_StepWrkDir%%_StepInFn%.%_StepOutExt%   >> %RSP_FN%
echo %_StepWrkDir%%_StepInFn%.LCS             >> %RSP_FN%
cacxprep  @%RSP_FN%
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
copy %LOG_FN% +   %_StepWrkDir%%_StepInFn%.LCS   %LOG_FN% > nul
:End
if not exist %CA_DOC_FN%.r02 goto End1
del %CA_DOC_FN%.r02
:End1
if not exist %CA_DOC_FN%.rsp go to End2
del %CA_DOC_FN%.rsp
:End2
