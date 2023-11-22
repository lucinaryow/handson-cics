: *****************************************************************************
: *
: * CA-Realia II Workbench 3.0 COBOL WbError.Bat command file.
: * Copyright (c) 1997 Computer Associates International, Inc.Revision Information
: * ^{File:wberror.bat}
: * ^{Timestamp:Fri Apr 25 17:02:24 1997}
: * ^{Revision:2.0}
: *
: *****************************************************************************
: *
: * WbError.Bat - The purpose of this batch procedure is to process all
: * ***********   Preprocess, Compile and Link error messages:  %1
: * contains the name of the error Label to process.
: *
: * Note: This batch file is called from WBStep.Bat, WbComp.Bat and
: *       WbLink.Bat.  There are three categories of errors:
: *
: *       1. Preprocessor Step Errors - Labels prefixed by S - These errors
: *          occur if an individual step fails
: *
: *       2. Compile Errors - No Prefix - These errors
: *          occur if the compile fails
: *
: *       3. Link Errors - Labels prefixed by L- These errors
: *          occur if the Link fails
: *
: ****************************************************************************
: *
goto %_ErrStep%
: *
: *****************************************************************************
: ********************** P R E P   S T E P    E R R O R S  ********************
: *****************************************************************************
: *
: *****************************************************************************
: * ERROR: SBadRC -  Step Returned Invalid RC
: * *****
: * Description: This error message occurs if a particular step fails in
: * ************ WBStep.Bat
: *****************************************************************************
:SBadRC
echo ----------------------------------------------- >> %LOG_FN%
echo ..Error in Step  %_StepNum%                     >> %LOG_FN%
echo .. Step Command File (%_StepCmd%)               >> %LOG_FN%
echo .. did not return a proper RC                   >> %LOG_FN%
echo ----------------------------------------------- >> %LOG_FN%
goto ErrEnd
: *****************************************************************************
: * ERROR: SOutFileNotFound -  Step did not set output file name
: * *****
: * Description: This error message occurs if WbStep.Bat calls preprocessor
: * ************ .Cmd file for this step and it does not set output file name
: *****************************************************************************
:SOutFileNotFound
echo ----------------------------------------------- >> %LOG_FN%
echo ..Error in Step  %_StepNum%                     >> %LOG_FN%
echo .. Step Command File (%_StepCmd%)               >> %LOG_FN%
echo .. output file %_StepWrkDir%%_StepInFn%.%_StepOutExt% Not Found! >> %LOG_FN%
echo ----------------------------------------------- >> %LOG_FN%
goto ErrEnd
: *****************************************************************************
: * ERROR: SStepFailed-  The Preprocessor bat file had errors/
: * *****
: * Description: This error message occurs if WbStep.Bat calls preprocessor
: * ************ .Cmd file for this step and it FAILS
: *****************************************************************************
:SStepFailed
echo ----------------------------------------------- >> %LOG_FN%
echo ..Error in Step  %_StepNum%                     >> %LOG_FN%
echo .. Step Command File (%_StepCmd%) Failed!       >> %LOG_FN%
echo ----------------------------------------------- >> %LOG_FN%
goto ErrEnd
: *****************************************************************************
: * ERROR: -  SCmdFIleMissing - WBStep.Bat attempts to execute Prep Cmd file
: * *****     but it could not be found
: * Description: This error message occurs if WbStep.Bat calls preprocessor
: * ************ .Cmd file BUT it COULD not be found!
: *****************************************************************************
:SCmdFIleMissing
echo ----------------------------------------------- >> %LOG_FN%
echo ..Error in Step  %_StepNum%                     >> %LOG_FN%
echo .. Step Command File (%_StepCmd%) Not Found!    >> %LOG_FN%
echo ----------------------------------------------- >> %LOG_FN%
goto ErrEnd
: *
: *****************************************************************************
: **********************  C O M P I L E    E R R O R S  ***********************
: *****************************************************************************
: *
: *****************************************************************************
: * ERROR: FailPrep -  Preprocessor Step(s) Failed
: * *****
: * Description: This error message occurs if ANY of the steps in WBPREP.BAT
: * ************ failed.
: *****************************************************************************
:FailPrep
echo ------------------------------------------------------- >> %LOG_FN%
echo ..Preprocessor Error WBP001 - Errors Detected in        >> %LOG_FN%
echo ..       Preprocessor Steps!                            >> %LOG_FN%
echo ------------------------------------------------------- >> %LOG_FN%
GoTo ErrEnd
: *****************************************************************************
: * ERROR: FailComp - Compile Step Failed
: * Description: This error message occurs if the compile failed.
: * ************
: *****************************************************************************
:FailComp
echo -------------------------------------------------- >> %LOG_FN%
echo ..Compile Error WBC001 - Compile Errors Detected!  >> %LOG_FN%
if errorlevel 7 goto DErrLvl
if errorlevel 6 goto EErrLvl
if errorlevel 5 goto FErrLvl
if errorlevel 4 goto CErrLvl
if errorlevel 2 goto WErrLvl
echo -------------------------------------------------- >> %LOG_FN%
GoTo ErrEnd
:DErrLvl
echo ..Disastrous D level errors were detected. >> %LOG_FN%
echo ..Examples of Disastrous errors are: >> %LOG_FN%
echo .. 1) Not enough disk space for compile work files.          >> %LOG_FN%
echo .. 2) Not enough disk space for listing, obj or sym file.    >> %LOG_FN%
echo .. 3) Sym, Obj or Listing file could not be written.         >> %LOG_FN%
echo .. 4) Incorrect MLI_ call detected.                          >> %LOG_FN%
echo .. 5) Fatal Error Compile Error                              >> %LOG_FN%
echo .. Please continue to examine this file for more information. >> %LOG_FN%
GoTo CompErrDone
:EErrLvl
echo ..Erroneous E level errors and below were found.  >> %LOG_FN%
GoTo CompErrDone
:FErrLvl
echo ..Flagging F level violations and below were found.  >> %LOG_FN%
GoTo CompErrDone
:CErrLvl
echo ..Conditional C level errors and below were found.  >> %LOG_FN%
GoTo CompErrDone
:CErrLvl
echo ..Warning W level(2) errors were found.  >> %LOG_FN%
GoTo CompErrDone
: ****************
:CompErrDone
echo -------------------------------------------------- >> %LOG_FN%
GoTo ErrEnd
: *****************************************************************************
: * ERROR: ErrCompilerNotFound - Compiler could not be found
: * Description: This error should never happen, it indicates that the
: * ************ compiler (COBOL.EXE) could not be found!
: *****************************************************************************
:ErrCompilerNotFound
echo ----------------------------------------------- >> %LOG_FN%
echo ..Compile Error WBC002 - COBOL.EXE Not Found!   >> %LOG_FN%
echo ..Please check to see if CAWB30 dir is in path!  >> %LOG_FN%
echo ----------------------------------------------- >> %LOG_FN%
GoTo ErrEnd
: *
: *****************************************************************************
: ***********************   L I N K   E R R O R S  ****************************
: *****************************************************************************
: *
: *****************************************************************************
: * ERROR: LObjFNErr
: * *****
: * Description; This error should NEVER occur.  For this error to occur
: * the WB would have to pass a file name in LNK_FN_OBJ that does not exist.
: * Note: Remember LNK_FN_OBJ contains the name of the temporary file that
: * has stored in it a list of objects to be linked
: *****************************************************************************
:LObjFNErr
echo -------------------------------------------------------- >> %LOG_FN%
echo ..Link Error WBL001- The File that contains list of      >> %LOG_FN%
echo ..objs could not be found (%LNK_FN_OBJ%)                 >> %LOG_FN%
echo -------------------------------------------------------- >> %LOG_FN%
GoTo ErrEnd
: *****************************************************************************
: * ERROR: LObjLibNotFoundErr -
: * *****
: * Description: This error should never occur.  For this error to occur it
: * ************ means that the user requested that the current application be
: * linked using the %CA_ObjLib%.  However, the %CA_ObjLib% could not be found!
: *****************************************************************************
:LObjLibNotFoundErr
echo -------------------======------------------------------- >> %LOG_FN%
echo ..Link Error WBL002- The Application object library      >> %LOG_FN%
echo ..could not be found (%CA_ObjLib%)                       >> %LOG_FN%
echo -----------------------------===------------------------ >> %LOG_FN%
GoTo ErrEnd
: *****************************************************************************
: * ERROR: LLibFNErr -
: * *****
: * Description: This error should never occur.  For this error to occur it
: * ************ means that the WB would have passed a file name in %LNK_FN_LIB%
: * that DOES not exist.  Remember that %LNK_FN_LIB% should contain the list
: * of .LIB files necessary to link a file.
: *****************************************************************************
:LLibFNErr
echo -------------------------------------------------------- >> %LOG_FN%
echo ..Link Error WBL003- The File that contains list of objs >> %LOG_FN%
echo ..could not be found (%LNK_FN_OBJ%)                      >> %LOG_FN%
echo -------------------------------------------------------- >> %LOG_FN%
GoTo ErrEnd
: *****************************************************************************
: * ERROR: LDefFileErr-
: * *****
: * Description: This error will occur if the Def file specified in the
: * ************ notebook linker options could not be found.
: *****************************************************************************
:LDefFileErr
echo -------------------------------------------------------- >> %LOG_FN%
echo ..Link Error WBL004- The module definitions file (.DEF)  >> %LOG_FN%
echo ..(%LNK_DEF_FILE_FN%) could not be found!                >> %LOG_FN%
echo -------------------------------------------------------- >> %LOG_FN%
GoTo ErrEnd
: *****************************************************************************
: * ERROR: LLinkerNotFoundErr-
: * *****
: * Description: This error should not occur.  This error will occur if the
: * ************ linker, OPTLINK.EXE, cannot be located.
: *****************************************************************************
:LLinkerNotFoundErr
echo -------------------------------------------------------- >> %LOG_FN%
echo ..Link Error WBL005- The linker, OPTLINK.EXE, could not  >> %LOG_FN%
echo ..be found.                                              >> %LOG_FN%
echo -------------------------------------------------------- >> %LOG_FN%
GoTo ErrEnd
: *****************************************************************************
: * ERROR: LLinkStepErr  -
: * *****
: * Description: This error indicates that a user linker error has occurred!
: * ************
: *****************************************************************************
:LLinkStepErr
echo -------------------------------------------------------- >> %LOG_FN%
echo ..Link Error WBL006- Link Step Failed.  Please examine   >> %LOG_FN%
echo ..the linker output (above) for details                  >> %LOG_FN%
echo -------------------------------------------------------- >> %LOG_FN%
GoTo ErrEnd
: *****************************************************************************
: * ERROR: LBinderNotFoundErr-
: * *****
: * Description: This error should not occur.  This error will occur if the
: * ************ linker, REALBIND.EXE, cannot be located.
: *****************************************************************************
:LBinderNotFoundErr
echo -------------------------------------------------------- >> %LOG_FN%
echo ..Link Error WBL007- The binder, REALBIND.EXE, could not >> %LOG_FN%
echo ..be found.                                              >> %LOG_FN%
echo -------------------------------------------------------- >> %LOG_FN%
GoTo ErrEnd
: *****************************************************************************
: * ERROR: LBindErr
: * *****
: * Description: This error should not occur.  This error indicates an error
: * ************ occurred attempting to bind the Exe or DLL
: *****************************************************************************
:LBindErr
echo -------------------------------------------------------- >> %LOG_FN%
echo ..Link Error WBL008- Link Bind Step Failed.  Please      >> %LOG_FN%
echo ..examine binder output, that follows, for details       >> %LOG_FN%
echo -------------------------------------------------------- >> %LOG_FN%
GoTo ErrEnd
: ****************************
: *****  End Batch File  *****
: ****************************
:ErrEnd

