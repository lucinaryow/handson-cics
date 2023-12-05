#ifndef _INC_REALIA
#define _INC_REALIA 1

/*
 *****************************************************************************
 *
 *   This material is confidential to Computer Associates International, Inc.
 *   Copyright (c) 1993, 1996 Computer Associates International, Inc.
 *   All rights reserved.
 *
 * NAME
 *    realia.h -- define Realia procedurs
 *
 * DESCRIPTION
 *
 *    This header provides a uniform set of predefined manifest
 *    constants and macros that provide information about Realia API's
 *    for various operating systems
 *
 *    The compilers supported by this header files are:
 *
 *         __IBMC__         IBM Cset++ for 32 Bit OS/2
 *         _MSC_VER         Microsoft Visual C++ Version >= 900 (2.00 and up)
 *
 *        NOTE: The COBOL calling convention requires that the first
 *              parmameter MUST be
 *
 *                  CARCARGBLK ArgBlkValue
 *
 *              This variable contains information about the call for use
 *              by Realia modules. It must contain the number of remaining
 *              parameters in the call.
 *
 *              To set parmameter count before calling a Realia module from c
 *              use the defined macro:
 *
 *              int CARCSetParmCnt (CARCARGBLK, int)
 *
 *              To get the number of parameters passed from a COBOL program
 *              to a called c program use the defined macro:
 *
 *              int CARCGetParmCnt (CARCARGBLK)
 */

#include "carcor.h"

#if defined (__IBMC__)
   #include <os2.h>
#elif defined (_MSC_VER) && _MSC_VER >= 900
   #include <windows.h>
#endif

#ifdef  __cplusplus
extern "C" {
#endif

CARC_import long CARC_call_cobol REALIA_GETMAIN
    ( CARCARGBLK ArgBlk,
          void  **buffer,
          long  *buffsize);

CARC_import long CARC_call_cobol REALIA_FREEMAIN
    ( CARCARGBLK ArgBlk,
          void  **buffer,
          long  *buffsize);

CARC_import long CARC_call_cobol REALIA_QUERY_MEMSIZE
    ( CARCARGBLK ArgBlk,
          void  **buffer,
          long  *buffsize);

CARC_import long CARC_call_cobol REALIA_QUERY_MEMBASE
    ( CARCARGBLK ArgBlk,
          void  **buffer,
          void  **base,
          long  *basesize);

CARC_import long CARC_call_cobol REALIA_GET_COMMAND_TAIL
    ( CARCARGBLK ArgBlk,
          char  *ParmLine,
          long  *PARMMaxSize );

CARC_import void CARC_call_cobol REALIA_GET_PARM_COUNT
    ( CARCARGBLK ArgBlk,
          long  *ParmCount );

CARC_import long CARC_call_cobol REALIA_GET_COMMAND_NAME
    ( CARCARGBLK ArgBlk,
          char  *PARMLine,
          long  *PARMMaxSize);

CARC_import long CARC_call_cobol REALIA_GET_ENV_STRING
    ( CARCARGBLK ArgBlk,
          char  *SearchString,
          char  *SearchResult,
          long  *SearchMaxLength );

CARC_import long CARC_call_cobol REALIA_PUT_ENV_STRING
    ( CARCARGBLK ArgBlk,
          char  *EnvStrName,
          char  *EnvStrValue);

CARC_import long CARC_call_cobol REALIA_GET_MACHINE_NAME
    ( CARCARGBLK ArgBlk,
          char  *MachineName,
          long  *MachineNameLen );

CARC_import void CARC_call_cobol REALIA_GET_OS_MODE
    ( CARCARGBLK ArgBlk,
  unsigned long *OSMode );

CARC_import long CARC_call_cobol REALIA_CREATE_UNIQUE_FILE
    ( CARCARGBLK  ArgBlk,
           char  *FileName,
     const char  *Directory,
           long  *FileMMaxSize);

CARC_import void CARC_call_cobol REALIA_GET_CTRLBRK_HANDLING
    ( CARCARGBLK  ArgBlk,
          long   *pSwitch);

CARC_import void CARC_call_cobol REALIA_SET_CTRLBRK_HANDLING
    ( CARCARGBLK  ArgBlk,
          long   *pSwitch);

CARC_import void CARC_call_cobol REALIA_TEST_CTRLBRK
    ( CARCARGBLK  ArgBlk,
          long   *pResult);

CARC_import long CARC_call_cobol REALIA_FINDFIRST
    ( CARCARGBLK  ArgBlk,
          HANDLE *SearchFileHandle,  /* pointer to the search handle */
            char *SearchFileName,
 COBOLFileSearch *SearchStruct);

CARC_import long CARC_call_cobol REALIA_FINDNEXT
    ( CARCARGBLK  ArgBlk,
          HANDLE *SearchFileHandle,
 COBOLFileSearch *SearchStruct);

CARC_import void CARC_call_cobol REALIA_FINDCLOSE
    ( CARCARGBLK  ArgBlk,
          HANDLE *SearchFileHandle);

CARC_import void CARC_call_cobol REALIA_GET_CURRENT_DIRECTORY
    ( CARCARGBLK  ArgBlk,
            char *DirectoryName,
            long *DirectoryNameLength);

CARC_import void CARC_call_cobol REALIA_SET_CURRENT_DIRECTORY
    ( CARCARGBLK  ArgBlk,
            char *DirectoryName);

CARC_import long CARC_call_cobol REALIA_PATHSRCH_FIRST(
    CARCARGBLK ArgBlk,
    char *SearchFileName,
    COBOLFileSearch *cobsearch,
    char *envname,
    char *exename,
    HANDLE *SearchFileHandle,
    unsigned char *flag
    );
#define pathsrch_normal         0x00
#define pathsrch_exact_search   0x01
#define pathsrch_dll_search     0x02

#define Filefound                  0
#define SpecError                  1
#define NoFile                     2
#define NoMoreFiles               18

CARC_import long CARC_call_cobol REALIA_PATHSRCH_NEXT(
    CARCARGBLK ArgBlk,
    COBOLFileSearch *cobsearch,
    HANDLE *SearchFileHandle
    );

CARC_import void CARC_call_cobol REALIA_PATHSRCH_CLOSE(
    CARCARGBLK ArgBlk,
    HANDLE *SearchFileHandle
    );

CARC_import long CARC_call_cobol REALIA_IS_MAIN(
    CARCARGBLK ArgBlk
    );

CARC_import long CARC_call_cobol REALIA_EXEC_PROGRAM
    ( CARCARGBLK  ArgBlk,
            long *phProcess,
            ...  );

CARC_import long CARC_call_cobol REALIA_EXEC_COMMAND
    ( CARCARGBLK  ArgBlk,
            long *phProcess,
             ... );

CARC_import long CARC_call_cobol REALIA_EXEC_WAIT
    ( CARCARGBLK  ArgBlk,
            long *phProcess,
            long *pExitCodeProcess);

CARC_import long CARC_call_cobol REALIA_EXEC_DETACH
    ( CARCARGBLK  ArgBlk,
            long *phProcess);


#ifdef  __cplusplus
}
#endif  /* __cplusplus */

#endif /* ?_INC_REALIA */
