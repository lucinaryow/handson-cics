: *****************************************************************************
: *
: * CA-Realia II Workbench 3.0 COBOL WbPrep.Bat command file.
: * Copyright (c) 1995 Computer Associates International, Inc.
: *
: * Revision Information
: * ^{File:wbprep.bat}
: * ^{Timestamp:Tue May 06 12:35:30 1997}
: * ^{Revision:3.0}
: *
: * WbPrep.Bat
: * ************
: * Description: The purpose of this batch procedure is to execute all
: * preprocessor steps for the current compile process.
: * A preprocessor step will succeed if the command file associated with
: * the preprocessor step returns
: *   1. "StepOk" and if the _StepOutFile Exists
: *   2. "StepWarnings" and if %CA_PREP_IGNORE_WARNIGNS% == "Y"
: * A preprocessor step Fails if the command file associated with the
: * preprocessor step returns:
: *   1. "StepFailed"
: *   2. "StepWarnings" And if %CA_PREP_IGNORE_WARNINGS^ == "N"
: *   3. _StepOutFile does not Exist
: *
: * Returns:
: * ----------
: *   This batch file returns:
: *     _StepRC="0" - Success Continue with Compile Process
: *      _StepInFN  - Name of Input to Compile
: *      _StepInext - Name of Input to Complie Ext
: *     _StepRC="F" - Failure Stop
: *
: * Preprocessor Command File Requirements:
: * --------------------------------------
: *  1.  Must use _StepWrkDir as Directory where Output of precompiler
: *      is placed.  Eg, "C:\CAWB30\WRKDIR\"
: *  2.  Must use _StepInFN as Input File Name only Eg: "PRIMES"
: *  3.  Must use _StepInExt as Input File Name Ext Eg: "CBL"
: *  4.  Must UPDATE _StepOutExt as Output Extention
: *  5.  Must Update _StepRC with one of the following strings:
: *       5.1  "StepOk"       - OK
: *       5.2  "StepFailed"   - Stop
: *       5.3  "StepWarnings" - Stop if Warnings not allowed!
: *
: *
: * Environement Variables:
: * ----------------------
: *
: * Common Variables:
: * ----------------
: * 1. CA_REAL20DIR    - This is the directory where the Workbench was
: *                     installed.
: * 2. CA_REALIA_INI  - This is the name of the options file that will be
: *                     passed on the the script processor.
: *
: * 3. CA_SHOW_WIN    - Request that Batch window be shown
: * 4. CA_ECHO_WIN    - Request that Batch commands be echoed
: *
: * 5. CA_DOC_FN_FULL   -This is the full file name and path of the target source
: * 6. CA_DOC_FM_AND_EXT -This variable is the file name and extension of
: *                   the source file that is to be preprocessed.
: * 7. CA_DOC_FN        -This is the file name only of the target source.
: * 8. CA_DOC_FN_EXT    -This is the extension only of the target source.
: * 9. CA_DOC_FN_DRIVE  -This is the drive letter of the target source.
: * 10. CA_DOC_FN_DIR    -This is the directory of the target source.  Note: it is
: *                    also the current directory when your batch procedure
: *                    is invoked.  Additionally, if you change directories
: *                    in your batch procedure you should reset to this
: *                    directory before exiting.
: * 11  CA_DOC_FN_PATH   -This is the Path to the target source.
: *
: *
: * Environment variables that will be created are:
: *
: * 1.CA_DOC_FN_FULL         =E:\CAWB30\SAMPLES\COBOL\PRIMES.CBL
: * 2 CA_DOC_FN_AND_EXT      =PRIMES.CBL
: * 3 CA_DOC_FN              =PRIMES
: * 4 CA_DOC_FN_EXT          =CBL
: * 5 CA_DOC_FN_DRIVE        =E
: * 6 CA_DOC_FN_DIR          =E:\CAWB30\SAMPLES\COBOL
: * 7 CA_DOC_FN_PATH         =E:\CAWB30\SAMPLES\COBOL
: *
: *
: * --------------------- Working Directory ----------------
: * CompileDir
: *
: * --------------------- Globals --------------------------
: *
: * PREP_WARN_OK - Default to Y if not defined
: *****************************************************************************
: ********************
: * Initalizations   *
: ********************
: *
if .%PREP_WARN_OK%==. Set PREP_WARN_OK=YES
set _StepRC="0"
set _StepWrkDir=%CompileDir%
set _StepInFN=%CA_DOC_FN%
set _StepInExt=%CA_DOC_FN_EXT%
set _PrepCalled="N"
:step01
: ************************************
: * Execute Step1CmdFile if Found   *
: ************************************
if .%step1CmdFile% == . goto end
set _PrepCalled="Y"
: *
: * Note Step set _StepInDirFN the first time to the source directory.
: * **** subsequent steps will set _StepInDirFN to to the directory location
: * of where the preprocessor batch file placed the preprocessor output.
: *
set _StepInDirFn=%CA_DOC_FN_DIR%\%_StepInFN%
call WbStep %Step1CmdFile% 1 %_StepInFN% %_StepInExt% %_StepInDirFN%
if %_StepRC% == "F" goto Fail
: ************************************
: * Execute Step2CmdFile if Found   *
: ************************************
if .%step2CmdFile% == . goto end
set _StepInDirFn=%_StepWrkDir%%_StepInFN%
call WbStep %Step2CmdFile% 2 %_StepInFN% %_StepInExt% %_StepInDirFN%
if %_StepRC% == "F" goto Fail
: ************************************
: * Execute Step3CmdFile if Found   *
: ************************************
if .%step3CmdFile% == . goto end
set _StepInDirFn=%_StepWrkDir%%_StepInFN%
call WbStep %Step3CmdFile% 3 %_StepInFN% %_StepInExt% %_StepInDirFN%
if %_StepRC% == "F" goto Fail
: ************************************
: * Execute Step4CmdFile if Found   *
: ************************************
if .%step4CmdFile% == . goto end
set _StepInDirFn=%_StepWrkDir%%_StepInFN%
call WbStep %Step4CmdFile% 4 %_StepInFN% %_StepInExt% %_StepInDirFN%
if %_StepRC% == "F" goto Fail
: ************************************
: * Execute Step5CmdFile if Found   *
: ************************************
if .%step5CmdFile% == . goto end
set _StepInDirFn=%_StepWrkDir%%_StepInFN%
call WbStep %Step5CmdFile% 5 %_StepInFN% %_StepInExt% %_StepInDirFN%
if %_StepRC% == "F" goto Fail
: ************************************
: * Execute Step6CmdFile if Found   *
: ************************************
if .%step6CmdFile% == . goto end
set _StepInDirFn=%_StepWrkDir%%_StepInFN%
call WbStep %Step6CmdFile% 6 %_StepInFN% %_StepInExt% %_StepInDirFN%
if %_StepRC% == "F" goto Fail
: ************************************
: * Execute Step7CmdFile if Found   *
: ************************************
if .%step7CmdFile% == . goto end
set _StepInDirFn=%_StepWrkDir%%_StepInFN%
call WbStep %Step7CmdFile% 7 %_StepInFN% %_StepInExt% %_StepInDirFN%
if %_StepRC% == "F" goto Fail
: ************************************
: * Execute Step8CmdFile if Found   *
: ************************************
if .%step8CmdFile% == . goto end
set _StepInDirFn=%_StepWrkDir%%_StepInFN%
call WbStep %Step8CmdFile% 8 %_StepInFN% %_StepInExt% %_StepInDirFN%
if %_StepRC% == "F" goto Fail
: ************************************
: * Execute Step9CmdFile if Found   *
: ************************************
if .%step9CmdFile% == . goto end
set _StepInDirFn=%_StepWrkDir%%_StepInFN%
call WbStep %Step9CmdFile% 9 %_StepInFN% %_StepInExt% %_StepInDirFN%
if %_StepRC% == "F" goto Fail
: ************************************
: * Execute Step10CmdFile if Found   *
: ************************************
if .%step10CmdFile% == . goto end
set _StepInDirFn=%_StepWrkDir%%_StepInFN%
call WbStep %Step10CmdFile% 10 %_StepInFN% %_StepInExt% %_StepInDirFN%
if %_StepRC% == "F" goto Fail
: ************************************
: * Execute Step11CmdFile if Found   *
: ************************************
if .%step11CmdFile% == . goto end
set _StepInDirFn=%_StepWrkDir%%_StepInFN%
call WbStep %Step13CmdFile% 11 %_StepInFN% %_StepInExt% %_StepInDirFN%
if %_StepRC% == "F" goto Fail
: ************************************
: * Execute Step12CmdFile if Found   *
: ************************************
if .%step12CmdFile% == . goto end
set _StepInDirFn=%_StepWrkDir%%_StepInFN%
call WbStep %Step14CmdFile% 12 %_StepInFN% %_StepInExt% %_StepInDirFN%
if %_StepRC% == "F" goto Fail
: ************************************
: * Execute Step13CmdFile if Found   *
: ************************************
if .%step13CmdFile% == . goto end
set _StepInDirFn=%_StepWrkDir%%_StepInFN%
call WbStep %Step13CmdFile% 13 %_StepInFN% %_StepInExt% %_StepInDirFN%
if %_StepRC% == "F" goto Fail
: ************************************
: * Execute Step14CmdFile if Found   *
: ************************************
if .%step14CmdFile% == . goto end
set _StepInDirFn=%_StepWrkDir%%_StepInFN%
call WbStep %Step14CmdFile% 14 %_StepInFN% %_StepInExt% %_StepInDirFN%
if %_StepRC% == "F" goto Fail
: ************************************
: * Execute Step15CmdFile if Found   *
: ************************************
if .%step15CmdFile% == . goto end
set _StepInDirFn=%_StepWrkDir%%_StepInFN%
call WbStep %Step15CmdFile% 15 %_StepInFN% %_StepInExt% %_StepInDirFN%
if %_StepRC% == "F" goto Fail
goto End
:Fail
:OK
:End
