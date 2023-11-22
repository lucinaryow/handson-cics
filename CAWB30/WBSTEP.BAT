: *****************************************************************************
: *
: * CA-Realia II Workbench 3.0 COBOL WbStep.Bat command file.
: * Copyright (c) 1997 Computer Associates International, Inc.
: *
: * Revision Information
: * ^{File:wbstep.bat}
: * ^{Timestamp:Fri Apr 25 17:06:06 1997}
: * ^{Revision:3.0}
: *
: * WBStep.Bat - The purpose of this batch procedure is to execute
: * **********   a Single WBStep!
: *
: *Description:  This command procedure invokes _StepCmd file whose
: * task is to precompile _StepInFN with _StepInExt and place the
: * output in working Directory _StepWrkDir.  The Output Name should
: * be the same name as the Input File Name except the extension should
: * be _StepOutExt.  If this command procedure executes successfully,
: * the Next Step will be set up correctly.
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
: *        "O"         - Success Continue
: *        "F"         - Failure Stop
: *   2. _StepInExt    - Next Step Input Ext
: *   3. _StepFailFN   - Failure File Name If Any
: *   4. _StepFailType - Indicates if WB Editor Error Processing Allowed
: *
: * ******************* Sample Batch File ***********************************
: * Line 1-> copy %_StepWrkDir%%_StepInFn%.%_StepInExt%  %_StepWrkDir%%_StepInFN%.BB1
: * Line 2-> set _StepOutExt=BB1
: * Line 3-> cvstatus 0
: * *************************** End Sample ***********************************
: *
: * Errors
: *   1. sCmdFIleMissing
: *      This error occurs if the _StepCmd file could not be found
: *   2. SStepFailed
: *      This error occurs if the _StepCmd file returned a Fatal or
: *      a Warning Error (When Warnings are not to be ignored)
: *
: *****************************************************************************
set _StepCmd=%1
set _StepNum=%2
set _StepInFn=%3
set _StepInExt=%4
set _StepOutExt=C%2%
echo.
echo -----------------------------------------------------
echo   CA-Realia II Workbench Start Preprocessor Task
echo            Step:  %_StepNum%
echo      Source File: %_StepInFN%.%_StepInExt%
echo -----------------------------------------------------
cvstatus 255
call %_StepCmd%
set _StepInExt=%_StepOutExt%
if errorlevel 255 goto sCmdFIleMissing
goto %_StepRC%
goto SBadRC
: **********************************************************
: * Warnings were found in step, If warnings are OK then
: * continue, otherwise, treat warnings as Fatal Error
: **********************************************************
:StepWarnings
if .%PREP_WARN_OK%==.YES goto StepOK
goto SStepFailed
: *
: * The Step Returned a Success RC
: * Test to make sure that Next Step is set up properly.
: *  1. _StepInFN   = FN Only
: *  2. _StepInExt  = Ext Only
: *
: *
:StepOK
if not exist %_StepWrkDir%%_StepInFn%.%_StepOutExt% goto SOutFileNotFound
goto Ok
: *
: *****************************************************************************
: *****************             E R R O R  S T E P S                ***********
: *****************************************************************************
: *
:SBadRC
  set _ErrStep=SBadRC
  goto ProcessErrorsStep
:SOutFileNotFound
  set _ErrStep=SOutFileNotFound
  goto ProcessErrors
:SStepFailed
  set _ErrStep=SStepFailed
  goto ProcessErrorsStep
:SCmdFIleMissing
  set _ErrStep=SCmdFIleMissing
  goto ProcessErrorsStep
: *
: *****************************************************************************
: *****************    P R O C E S S   E R R O R    S T E P         ***********
: *****************************************************************************
: *
:ProcessErrorsStep
call WBERROR
set _StepRC="F"
goto End
: ***************
: * Set OK RC   *
: ***************
:OK
set _StepRC="0"
echo ----------------------------------------------- >> %LOG_FN%
echo ..Success - Step  %_StepNum%                    >> %LOG_FN%
echo .. Step Command File (%_StepCmd%) Run           >> %LOG_FN%
echo .. Return Code =  (%_StepRC%)                   >> %LOG_FN%
echo ----------------------------------------------- >> %LOG_FN%
echo -----------------------------------------------
echo ..Success - Step  %_StepNum%
echo .. Step Command File (%_StepCmd%) Run
echo .. Return Code =  (%_StepRC%)
echo -----------------------------------------------
goto End
:End


