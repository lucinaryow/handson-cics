: *****************************************************************************
: *
: * CA-Realia II Workbench 3.0 COBOL WbPPCA.Bat command file.
: * Copyright (c) 1995 Computer Associates International, Inc.
: *
: * Revision Information
: * ^{File:wbppca.bat  }
: * ^{Timestamp:Tue May 06 12:40:02 1997}
: * ^{Revision:3.0}
: *
: *
: * WbppCA.Bat -   The purpose of command file is to Run the carcprep
: * ************   preprocessor.
: *
: * Input: 
: *   1. _StepCmd    = Step Cmd File Name
: *   2. _StepWrkDir = Working Directory Where Input Found and
: *                    Outputs Should be Placed.
: *   3. _StepInFN   = File Name Only 
: *   4. _StepInExt  = Extention Only 
: *   5  _StepOutExt = Suggested Ouput Extention!
: *   6. _StepInDirFn = Dir and File name no Ext
: * Output
: *   1. _StepRC          
: *   2. _StepInExt  = Extention Only 
: *
: * ******************* Sample Batch File ***********************************
: * Line 1-> copy %_StepInDirFn%.%_StepInExt%  %_StepWrkDir%%_StepInFN%.BB1
: * Line 2-> set _StepOutExt=BB1
: * Line 3-> cvstatus 0
: * *************************** End Sample ***********************************
: *
: ***************
set RSP_FN=%CA_DOC_FN%.RSP
echo %_StepInDirFn%.%_StepInExt%              > %RSP_FN%
echo %_StepWrkDir%%_StepInFn%.%_StepOutExt%   >> %RSP_FN%
echo NUL                                      >> %RSP_FN%
echo %_StepWrkDir%%_StepInFn%.LS1             >> %RSP_FN%
echo %_StepWrkDir%%_StepInFn%.Err             >> %RSP_FN%
carcprep  @%RSP_FN%
if errorlevel 1 goto Error
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
copy %LOG_FN% +   %_StepWrkDir%%_StepInFn%.LS1   %LOG_FN%
:End
