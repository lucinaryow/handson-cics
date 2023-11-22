@echo off
: *****************************************************************************
: *
: *
if .%CA_ECHO_WIN%==.Y echo on
if .%LNK_EXE_FN%==. set LNK_EXE_FN=%CA_DOC_FN%
set LNK_MODULE_FN=%LNK_EXE_FN%.%LNK_TYPE%
if .%CA_CREATE_NEW_LOG%==.N goto InitStep
cawbecho 9 > %LOG_FN%
cawbecho 9
goto InitStep2
: *****************************************************************************
: * InitStep - Initialize Env Vars
: *****************************************************************************
:InitStep
cawbecho 9 >> %LOG_FN%
cawbecho 9
:InitStep2
cawbecho 6 %LNK_TYPE% >> %LOG_FN%
cawbecho 7 %CA_DOC_FN_FULL% >> %LOG_FN%
cawbecho 8 %CompileDir% >> %LOG_FN%
cawbecho 6 %LNK_TYPE%
cawbecho 7 %CA_DOC_FN_FULL%
cawbecho 8 %CompileDir%
if NOT .%CA_ECHO_WIN%==.Y goto EndInitStep
echo ===========  Working Directory  =============== >> %LOG_FN%
cd >>   %LOG_FN%
echo ===========  Start List of Environment Area  =========== >> %LOG_FN%
set >> %LOG_FN%
echo ===========  End List of Environment Area  ============= >> %LOG_FN%
:EndInitStep
echo ===================== Format of LINK Command  ============= >> %LOG_FN%
echo = LINK,                                                     >> %LOG_FN%
echo =     (1) FN.obj                                            >> %LOG_FN%
echo =  (Obj's may appear on multiple lines!)                    >> %LOG_FN%
echo =     (2) (/OUT:FN.EXE or FN.DLL),                          >> %LOG_FN%
echo =     (3) (/MAP:FN.MAP (If requested)                       >> %LOG_FN%
echo =     (4) (FN.LIB or (,)), - Lib's may appear on Mult Lines)>> %LOG_FN%
: *****************************************************************************
: * BldObjStep  - The purpose of this step is to format the FIRST (1) argument
: * ***********   to LINK - OBJECTS!  The first obj in the list
: * will be CA_DOC_FN.OBJ. Additional objects in list (if any) are passed in
: * the file LNK_FN_OBJ.
: *****************************************************************************
:BldOBJStep
echo ============ (1) Start Format OBJ(s) Inputs ==================  >> %LOG_FN%
if .%LNK_RootObj%==. goto NoRootStep
goto RootDone
:NoRootStep
set LNK_RootObj=%ObjDir%%CA_DOC_FN%.OBJ
:RootDone
if .%LNK_FN_OBJ%==. goto NoObjListStep
if NOT exist %LNK_FN_OBJ% GoTo LBadObjFNErr
echo %LNK_RootObj%       > %CA_DOC_FN%.CL1
echo %LNK_RootObj%       >> %LOG_FN%
copy %CA_DOC_FN%.CL1   +  %LNK_FN_OBJ%     %CA_DOC_FN%.CL1 > nul
copy %LOG_FN%          +  %LNK_FN_OBJ%     %LOG_FN% > nul
goto BldModuleStep
: *****************************************************************************
: * NoObjListStep - No List of Obj Files was passed to this proc. Do not append
: * a <,> to CA_DOC_FN%.OBJ
: *****************************************************************************
:NoObjListStep
echo %LNK_RootObj%        > %CA_DOC_FN%.CL1
echo %LNK_RootObj%        >> %LOG_FN%
goto BldModuleStep
: *****************************************************************************
: *
: * BldModuleStep - The purpose of this step is to format the SECOND (2) argument
: * ************* to LINK. The Exe or DLL module name!  The Exe or Dll name
: * may be explicitly or implicitly set.  If LNK_MODULE_FN is defined then the
: * name AND path is explicitly set.  However, if LNK_MODULE_FN is not set, then
: * the Exe or Dll file name is implicitly set.  If Lnk_Type=EXE then the module
: * name is set by concatenating -> %ExeDIR%%CA_DOC_FN%.EXE together.  If
: * Lnk_Type=DLL then the module name is set by concatenating ->
: * %DLLDIR%%CA_DOC_FN%.DLL.
: *
: *****************************************************************************
:BldModuleStep
echo. >> %LOG_FN%
echo ============ (2) Start Format Output Module Name (EXE or DLL)=  >> %LOG_FN%
if .%LNK_MODULE_FN%==. goto ModNameMissingStep
echo /OUT:%ExeDIR%%LNK_MODULE_FN%                         >> %CA_DOC_FN%.CL1
echo /OUT:%ExeDIR%%LNK_MODULE_FN%                         >> %LOG_FN%
goto BldMapStep
: *****************************************************************************
: * ModNameMissingStep - Mod Name Missing - Determine name Based Link Type
: *****************************************************************************
:ModNameMissingStep
if .%LNK_TYPE%==. set Lnk_Type=EXE
if .%LNK_TYPE%==.EXE goto AddExeModuleStep
: *****************************************************************************
: * AddDllModuleStep = Add Dll to List
: *****************************************************************************
:AddDllModuleStep
set LNK_MODULE_FN=%EXEDIR%%CA_DOC_FN%.DLL
echo /OUT:%EXEDIR%%CA_DOC_FN%.DLL               >> %CA_DOC_FN%.CL1
echo /OUT:%EXEDIR%%CA_DOC_FN%.DLL               >> %LOG_FN%
goto BldMapStep
: *****************************************************************************
: * AddExeModuleStep = Add Exe to List
: *****************************************************************************
:AddExeModuleStep
set LNK_MODULE_FN=%ExeDIR%%CA_DOC_FN%.EXE
echo /OUT:%ExeDIR%%CA_DOC_FN%.EXE               >> %CA_DOC_FN%.CL1
echo /OUT:%ExeDIR%%CA_DOC_FN%.EXE               >> %LOG_FN%
goto BldMapStep
: *****************************************************************************
: * BldMapStep - The purpose of this step is to format the THIRD (3) argument to
: * ************ LINK.  The MAP name.  The environment variable
: * LNK_CREATE_MAP_FILE determines if a Map file is created or not.
: *****************************************************************************
:BldMapStep
if not exist %LNK_MODULE_FN% goto Bld2MapStep
del %LNK_MODULE_FN%
:Bld2MapStep
echo ============ (3) Start Format Map Request ====================  >> %LOG_FN%
if  .%LNK_CREATE_MAP_FILE%==.NO goto BldLibStep
echo /MAP:%MapDir%%CA_DOC_FN%.MAP                      >> %CA_DOC_FN%.CL1
echo /MAP:%MapDir%%CA_DOC_FN%.MAP                      >> %LOG_FN%
goto BldLibStep
: *****************************************************************************
: * BldLibStep - The purpose of this step is to format the FOURTH (4)argument
: * ************** to LINK.  The Library files.  This consists of two
: * sets of data.  First if CA_UseObjLib is set to YES then the CA_ObjLib
: * env var storing a Obj Lib is concatenated onto the beginning of the LIB
: * list.  Remember, CA_ObjLib is used to store Objects associated with a
: * compile.  (Also note it is up to the users discretion to select this
: * option.  If the user does not select this option then the user must
: * explicitly add ALL objects from an application to the Object Dialog.
: *****************************************************************************
:BldLibStep
echo ============ (4) Start Format Lib(s) Inputs ==================  >> %LOG_FN%
if .%CA_UseObjLib%==. goto AddLibNextStep
if .%CA_UseObjLib%==.NO goto AddLibNextStep
if .%CA_UseObjLib%==.no goto AddLibNextStep
if .%CA_ObjLib%.==..         goto LibNextMake
if .%CA_ObjLib%.==. .        goto LibNextMake
goto LibNextStep
:LibNextMake
if .%CA_APP_FN%.==..        goto AddLibNextStep
if .%CA_APP_FN%.==. .       goto AddLibNextStep
set CA_OBJLIB=%CA_APP_FN%.LIB
:LibNextStep
if not Exist %CA_ObjLib% GoTo LObjLibNotFoundErr
if .%LNK_FN_LIB%==. goto Add1Next
echo %CA_ObjLib%                      >> %CA_DOC_FN%.CL1
echo %CA_ObjLib%                      >> %LOG_FN%
goto AddLibNextStep
: *****************************************************************************
: * Add1Next - No additional Libraries so '+' not needed at end of library!
: *****************************************************************************
:Add1Next
echo %CA_ObjLib%                      >> %CA_DOC_FN%.CL1
echo %CA_ObjLib%                      >> %LOG_FN%
: *****************************************************************************
: * AddLibNextStep - Add LNK_FN_LIB files
: *****************************************************************************
:AddLibNextStep
if .%LNK_FN_LIB%==. goto LibAddCommaStep
if NOT exist %LNK_FN_LIB% GoTo LLibFNErr
copy %CA_DOC_FN%.CL1   +  %LNK_FN_LIB%     %CA_DOC_FN%.CL1 > nul
copy %LOG_FN%          +  %LNK_FN_LIB%     %LOG_FN% > nul
goto LinkStep
: *****************************************************************************
:LibAddCommaStep
: *****************               L I N K   S T E P                 ***********
: *
:LinkStep
if .%LNK_DEF_FILE_FN%.==.. goto LinkStp2
set LNK_ADDOPT=%LNK_ADDOPT% /DEF:%LNK_DEF_FILE_FN%
:LinkStp2
echo. >> %LOG_FN%
CVstatus 255
echo ============ Begin Link Step ================  >> %LOG_FN%
if .%LNK_TYPE%==.DLL goto :LinkDLL
echo Link as EXE >> %LOG_FN%
LINK /NODEFAULTLIB /SUBSYSTEM:CONSOLE /ENTRY:_RealiaCOBOLexeentry %LNK_ADDOPT% @%CA_DOC_FN%.CL1 >> %LOG_FN%
goto LinkRC
:LinkDll
echo Link as DLL >> %LOG_FN%
LINK /DLL /NODEFAULTLIB /ENTRY:_RealiaCOBOLdllentry@12 %LNK_ADDOPT% @%CA_DOC_FN%.CL1 >> %LOG_FN%
:LinkRC
if errorlevel 255 GoTo LLinkerNotFoundErr
if errorlevel 1   GoTo LLinkStepErr
set _LinkRC="0"
cawbecho 4 %CA_DOC_FN_FULL% >> %LOG_FN%
cawbecho 4 %CA_DOC_FN_FULL%
goto End
: *
: *****************************************************************************
: *****************             E R R O R  S T E P S                ***********
: *****************************************************************************
: *
:LinkErrors
:LObjFNErr
   set _ErrStep=LObjFNErr
   goto ProcessErrorsStep
:LObjLibNotFoundErr
   set _ErrStep=LObjLibNotFoundErr
   goto ProcessErrorsStep
:LLibFNErr
   set _ErrStep=LLibFNErr
   goto ProcessErrorsStep
:LDefFileErr
   set _ErrStep=LDefFileErr
   goto ProcessErrorsStep
:LLinkerNotFoundErr
   set _ErrStep=LLinkerNotFoundErr
   goto ProcessErrorsStep
:LLinkStepErr
   set _ErrStep=LLinkStepErr
   goto ProcessErrorsStep
:LBinderNotFoundErr
   set _ErrStep=LBinderNotFoundErr
   goto ProcessErrorsStep
:LBindErr
   set _ErrStep=LBindErr
   goto ProcessErrorsStep
: *
: *****************************************************************************
: *****************    P R O C E S S   E R R O R    S T E P         ***********
: *****************************************************************************
: *
:ProcessErrorsStep
call WBERROR
set _LinkRC="F"
goto End
: ****************************
: *****  End Batch File  *****
: ****************************
:End
if not exist %CA_DOC_FN%.cl1 goto End2
del %CA_DOC_FN%.cl1
:End2
if .%LNK_FN_LIB%==. goto End3
if NOT exist %LNK_FN_LIB% GoTo End3
del %LNK_FN_LIB%
:End3
if .%LNK_FN_OBJ%==. goto End4
if NOT exist %LNK_FN_OBJ% GoTo End4
del %LNK_FN_OBJ%
:End4
CVSTATUS 0
if NOT  %_LinkRC%=="F" goto End1Next
CVSTATUS 1
goto TheEnd
:End1Next
:TheEnd
