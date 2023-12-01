#ifndef _INC_CARCRUM
#define _INC_CARCRUM

/****************************************************************************/
/*                                                                          */
/* This material is confidential to Computer Associates International, Inc. */
/* Copyright (c) 1994, 1995 Computer Associates International, Inc.         */
/* All rights reserved.                                                     */
/*                                                                          */
/* CARCRUM.H Version 2.00 (for Windows NT/95)                               */
/* 29 Feb 1996, 11:50 (EWB)                                                 */
/*                                                                          */
/****************************************************************************/

#include "carcor.h"

/****************************************************************************/
/*                                                                          */
/* Defines      This section defines the contents of structures used by the */
/* Structures   run unit management subsystem of OpenRealia applications    */
/* & Types      programming interface (ORAPI).                              */
/*                                                                          */
/****************************************************************************/

#ifdef __OS2__
#define CONST     const
#define DWORD     ULONG
#define FARPROC   PFN
#define HANDLE    LHANDLE
#define LPVOID    PVOID
#define WORD      USHORT

typedef const char *LPCSTR;
#endif

/* The LPFNEEPPROC is an application-defined callback function that recieves*/
/* parameter information for the program entry point specified by the       */
/* RealiaCobolEnumEntryParams function.                                     */

typedef int (ORUSERP LPFNEEPPROC) ( VOID *, WORD, DWORD );

/* The REALIANUMDESC structure describes a fixed-point numeric data-item.   */
/* This structure is passed to the RealiaCobolEnmEntPrmProc function.       */

typedef struct tagREALIANUMDESC { /* rnd */
    unsigned char    rndLinkage;
         /* Specifies the parameter linkage mechanism.                      */
    signed char      rndType;
         /* Specifies the type of the data item.                            */
    unsigned short   rndBase;
         /* Specifies the base index of the linkage cell allocated to the   */
         /* parameter.                                                      */
    unsigned short   rndLength;
         /* Specifies the maximum length of the data item.                  */
    unsigned char    rndPrecision;
         /* Specifies the maximum number of digits maintained in the value  */
         /* of a fixed-point numeric data-item.                             */
    signed char      rndScale;
         /* Specifies the number of digits required to place the implied    */
         /* decimal point of a fixed-point numeric data-item. Assuming an   */
         /* implied decimal-point after the right-most digit of precision,  */
         /* a negative scale specifies the number of digits to the left and */
         /* a positive scale specifies the number of digits to the right    */
         /* required to place the decimal point of a fixed-point numeric    */
         /* data-item.                                                      */
} REALIANUMDESC;

/* The REALIASTDDESC structure describes a standard data-item. This         */
/* structure is passed to the RealiaCobolEnmEntPrmProc function.            */

typedef struct tagREALIASTDDESC { /* rsd */
    unsigned char    rsdLinkage;
         /* Specifies the parameter linkage mechanism.                      */
    signed char      rsdType;
         /* Specifies the type of the data item.                            */
    unsigned short   rsdBase;
         /* Specifies the base index of the linkage cell allocated to the   */
         /* parameter.                                                      */
    unsigned long    rsdLength;
         /* Specifies the maximum length of the data item.                  */
} REALIASTDDESC;

/* Data descriptor formats and parameter linkage mechanisms                 */

#define RDD_FLD         0x00F0    /* Specifies the descriptor format field  */
#define RDD_STD         0x0000    /* Specifies a standard data descriptor   */
                                  /*   represented by the REALIASTDDESC     */
                                  /*   structure.                           */
#define RDD_NUM         0x0010    /* Specifies a numeric data descriptor    */
                                  /*   represented by the REALIANUMDESC     */
                                  /*   structure.                           */


#define RPL_FLD         0x000F    /* Specifies the linkage mechanism field  */
#define RPL_BYREFERENCE 0x0000    /* Specifies a by reference parameter     */
#define RPL_BYVALUE     0x0001    /* Specifies a by value parameter         */
#define RPL_RETURNVALUE 0x0002    /* Specifies a return value parameter     */

/* Data types                                                               */

#define RDT_VOID        0         /* Specifies that the symbol is void of   */
                                  /* type information.                      */
#define RDT_COMP1       1         /* Specifies that the symbol represents a */
                                  /*   4-byte floating-point num data-item. */
#define RDT_COMP2       2         /* Specifies that the symbol represents an*/
                                  /*   8-byte floating-point num data-item. */
#define RDT_COMP3U      3         /* Specifies that the symbol represents an*/
                                  /*   unsigned fixed-point numeric data-   */
                                  /*   item in packed-decimal format.       */
#define RDT_COMP3S     -3         /* Specifies that the symbol represents a */
                                  /*   signed fixed-point num data-item in  */
                                  /*   packed-decimal format.               */
#define RDT_COMP4U      4         /* Specifies that the symbol represents an*/
                                  /*   unsigned fixed-point numeric data-   */
                                  /*   item in big-endian format.           */
#define RDT_COMP4S     -4         /* Specifies that the symbol represents a */
                                  /*   signed fixed-point num data-item in  */
                                  /*   big-endian format.                   */
#define RDT_COMP5U      5         /* Specifies that the symbol represents an*/
                                  /*   unsigned fixed-point numeric data-   */
                                  /*   item in little-endian format.        */
#define RDT_COMP5S     -5         /* Specifies that the symbol represents a */
                                  /*   signed fixed-point num data-item in  */
                                  /*   little-endian format.                */
#define RDT_DLES       -6         /* Specifies that the symbol represents a */
                                  /*   leading embedded-sign, fixed-point   */
                                  /*   numeric data-item in display format. */
#define RDT_DLSS       -7         /* Specifies that the symbol represents a */
                                  /*   leading sign-separate, fixed-point   */
                                  /*   numeric data-item in display format. */
#define RDT_DU          8         /* Specifies that the symbol represents an*/
                                  /*   unsigned fixed-point numeric data-   */
                                  /*   item in display format.              */
#define RDT_DTES       -8         /* Specifies that the symbol represents a */
                                  /*   trailing embedded-sign, fixed-point  */
                                  /*   numeric data-item in display format. */
#define RDT_DTSS       -9         /* Specifies that the symbol represents a */
                                  /*   trailing sign-separate, fixed-point  */
                                  /*   numeric data-item in display format. */
#define RDT_DISPLAY     10        /* Specifies that the symbol represents an*/
                                  /*   elementary level alphanum data-item. */
#define RDT_DISPLAY1   -10        /* Specifies that the symbol represents an*/
                                  /*   elementary DBCS data-item.           */
#define RDT_GROUP       11        /* Specifies that the symbol represents a */
                                  /*   group-level alphanumeric data-item.  */
#define RDT_BINARY      12        /* Specifies that the symbol represents an*/
                                  /*   unsigned fixed-point numeric data-   */
                                  /*   item in native-endian format.        */
#define RDT_BINARYS    -12        /* Specifies that the symbol represents a */
                                  /*   signed fixed-point num data-item in  */
                                  /*   native-endian format.                */
#define RDT_INDEX       20        /* Specifies that the symbol represents a */
                                  /*   4-byte, unassociated index data-item.*/
#define RDT_POINTER     40        /* Specifies that the symbol represents a */
                                  /*   4-byte unassociated pointer data-    */
                                  /*   item.                                */
#define RDT_PROCPOINTER -40       /* Specifies that the symbol represents a */
                                  /*   8-byte, unassociated procedure-      */
                                  /*   pointer data-item.                   */

/* The REALIAENTRYINFO structure specifies the information associated with  */
/* a CA-Realia COBOL program entry-point as found in a CA-Realia COBOL      */
/* executable. This structure can be retrieved by the                       */
/* RealiaCobolGetEntryInfo function.                                                                            */

typedef struct tagREALIAENTRYINFO { /* rei */
    unsigned long    reiFlags;
         /* Specifies the features associated with a program entry-point.   */
    long             reiParams;
         /* Specifies the count of parameters expected by the entry point.  */
    char *           reiObjPgm;
         /* Points to null-terminated string that contains the name of the  */
         /* the COBOL object program contains the entry statement. This     */
         /* member can be used to reference the symbol table generated for  */
         /* the program by the CA-Realia COBOL Compiler.                    */
    char             reiCmpVerN[6];
    char             reiCmpDate[6];
    char             reiCmpTime[6];
    char *           reiRUName;
         /* Points to null-terminated string that contains the name of the  */
         /* the COBOL run unit. This member identifies the CA-Realia        */
         /* COBOL run unit of the module that contains the entry point.     */
    long             reiReserved;
         /* Specifies a long value reserved for future use.                 */
} REALIAENTRYINFO;

/* reiCaller                                                                */
/*   Specifies the calling convention expected by the entry point.          */
/*   This member can be one of the following values                         */
#define REIC_LANGUAGE   0x0007    /* Langage flags in rieCaller             */
#define REIC_REALIA     0x0000    /* Specifies the CA-Realia COBOL convention*/
#define REIC_PASCAL     0x0001    /* Specifies the Pascal convention        */
#define REIC_C          0x0002    /* Specifies the C convention             */
#define REIC_SYSTEM     0x0003    /* Specifies the system convention        */

/* reiFlags                                                                 */
/*   Specifies the features associated with a program entry-point.  This    */
/*   member can be a combination of the following values:                   */

#define REIF_FEATURES    0xFFF8
#define REIF_RETURNVALUE 0x0010   /* Specifies that the entry has a return  */
                                  /*   value associated with it. At run     */
                                  /*   time,  the value is returned in the  */
                                  /*   AL, AX or EAX register depending on  */
                                  /*   size.                                */
#define REIF_ARGCHK      0x0020   /* Specifies that the entry checks the    */
                                  /*   number of arguments passed against   */
                                  /*   the number of parameters expected    */
#define REIF_INITIAL     0x0100   /* Specifies that the program is INITIAL  */
#define REIF_RECURSIVE   0x0200   /* Specifies that the program is          */
                                  /*    RECURSIVE                           */
#define REIF_EBCDIC      0x0400   /* Specifies that the entry is contained  */
                                  /*   in program that use EBCDIC represen- */
                                  /*   tation of characters.                */
#define REIF_IBMFLOAT    0x0800   /* Specifies that the entry is contained  */
                                  /*   in a program that use IBM represen-  */
                                  /*   tations of floatpoint numerics.      */
#define REIF_ANSICANCEL  0x1000   /* Specifies that the entry is contained  */
                                  /*   in program that must be canceled     */
                                  /*   directly.                            */

/* The LPFNUEPROC function is an application-defined callback function that */
/* receives notification of CA-Realia COBOL run-time system events.         */

typedef long (ORUSERP LPFNUEPROC)(
   HANDLE   RUHandle,             /* handle of the run unit                 */
   int      iEvent,               /* identifier of event                    */
   void *   lpvEventInfo,         /* address of event information structure */
   DWORD    lParam);              /* application defined value              */

/* iEvent                                                                   */
/*   Specifies the run-time system event.  This parameter can be one of the */
/*   following values:                                                      */
#define RCUE_ERROR      2        /* Specifies a run-time error event.       */
#define RCUE_TERM       3        /* Specifies a run-unit termination event. */
#define RCUE_LOAD       4        /* Specifies a dynamic module load event.  */
#define RCUE_FREE       5        /* Specifies a dynamic module free event.  */
#define RCUE_SPIE       6        /* Specifies a SPIE event.                 */

/* The REALIAERROR structure contains information that identifies           */
/* a CA-Realia COBOL run-time system error.                                 */

typedef struct tagREALIAERROR { /* re */
    short            reError;
         /* Specifies the CA-Realia COBOL run-time system error-code.       */
    short            reCount;
         /* Specifies the count of bytes contained in the array defined     */
         /* by the reText member.                                           */
    char *           reText;
         /* Points to an array of bytes that contains the text of the       */
         /* run-time system error-message.                                  */
} REALIAERROR;

/* The REALIAMODULE structure contains information used to identify         */
/* COBOL executable modules.  This structure is passed between              */
/* RealiaCobolUsrExtProc functions and the run-time system.                 */

typedef struct tagREALIAMODULE { /* rm */
    char *           rmName;
         /* Points to an array of bytes that contains the name of a module. */
    short            rmCount;
         /* Specifies the count of bytes contained in the array defined by  */
         /* the rmName member.                                              */
    unsigned short   rmReserved;
         /* Specifies a reserved word which must be set to 0.               */
    HANDLE           rmHandle;
         /* Specifies the operating system handle of the COBOL load module. */
} REALIAMODULE;


/* The REALIADCHK structure contains information that provides information  */
/* to a user exit when an Invalid Decimal Data error occurs.  This          */
/* structure is passed to RealiaCobolUsrExtProc function.                   */

typedef struct tagREALIADCHK { /* rdc */
    short         rdcDataType; /* Specifies type of data check              */
    short         rdcDataLen;  /* Length of data field                      */
    char *        rdcData;     /* Data with bad decimal data                */
}  REALIADCHK;

/* The REALIASUBCHK structure contains information that provides            */
/* information to a user exit when an Invalid Subscript error occurs.  This */
/* structure is passed to RealiaCobolUsrExtProc function.                   */

typedef struct tagREALIASUBCHK { /* rsc */
    short         rscDataType;    /* Specifies type of data check (always 1)*/
    short         rscReserved;    /* Reserved for future use                */
    long          rscValue;       /* Subscript value that caused problem    */
    long          rscMinVal;      /* Minimum allowable subscript value      */
    long          rscMaxVal;      /* Maximum allowable subscript value      */
}  REALIASUBCHK;

/* Constants for the rdcDataType and rscDataType fields                     */
#define SPIE_SUB        0x0001    /* Subscript check                        */
#define SPIE_COMP3      0x0002    /* COMP-3 (Packed Decimal)                */
#define SPIE_DLES       0x0003    /* Leading Embedded Sign in ASCII         */
#define SPIE_DLSS       0x0004    /* Leading Seperated Sign in ASCII        */
#define SPIE_DTES       0x0005    /* Tailing Embedded Sign in ASCII         */
#define SPIE_DTSS       0x0006    /* Leading Seperated Sign in ASCII        */
#define SPIE_EDLES      0x0007    /* Leading Embedded Sign in EBCDIC        */
#define SPIE_EDLSS      0x0008    /* Leading Seperated Sign in EBCDIC       */
#define SPIE_EDTES      0x0009    /* Tailing Embedded Sign in EBCDIC        */
#define SPIE_EDTSS      0x000A    /* Leading Seperated Sign in EBCDIC       */
#define SPIE_ADLES      0x000B    /* Leading Embedded Sign in AS:7          */
#define SPIE_ADTES      0x000D    /* Tailing Enbedded Sign in AS:7          */

/* The REALIATERM structure contains information that identifies the cause  */
/* of the termination of a run unit. This structure is passed to the        */
/* RealiaCobolUsrExtProc function.                                          */

typedef struct tagREALIATERM { /* rt */
    char *           rtProgram;
         /* Points to a null-terminated string that contains the name of    */
         /* program that caused termination of the run unit.                */
    long             rtOffset;
         /* Specifies an offset relative to the beginning of the program of */
         /* the statement which caused termination of the run unit.         */
    long             rtStatement;
         /* Specifies the statement in the program (if known) which caused  */
         /* which caused termination of the run unit.                       */
    short            rtCause;
         /* Specifies the cause of run unit termination.                    */
    short            rtReserved;
         /* Reserved for future use.                                        */
    long             rtRC;
         /* Contains the RETURN-CODE special register value.                */
} REALIATERM;

/* rtCause                                                                  */
/*   Specifies the cause of run unit termination.  This member can be one   */
/*   of the following values:                                               */

#define RTC_KILL        0x0000    /* Specifies termination of the process.  */
#define RTC_STOPRUN     0x0001    /* Specifies execution of a STOP RUN verb.*/
#define RTC_ERROR       0x0002    /* Specifies a run-time error.            */
#define RTC_RCT         0x0003    /* Specifies execution of RealiaCobolTerm */
#define RTC_DEBUGGER    0x0004    /* Specifies termination by debugger      */


/* Program instance values                                                  */

#define RPI_MRI   (HANDLE)0       /* Specifies the most recent instance     */
#define RPI_NEW   (HANDLE)(-1)    /* Specifies a new instance               */
#define RPI_ALL   (HANDLE)(-1)    /* Specifies all instances                */

/* Program attribute values                                                 */

#define RPA_INITIAL     0x2000    /* Specifies a INITIAL program            */
#define RPA_MAIN        0x8000    /* Specifies a MAIN program               */
#define RPA_RECURSIVE   0x4000    /* Specifies a RECURSIVE program          */

/* Result values                                                            */

#define RCL0002   2 /* File status %1 on %2                                 */
#define RCL0003   3 /* Wrong length record for %1                           */
#define RCL0004   4 /* COMMIT failure on file %1                            */
#define RCL0005   5 /* Indexed file error - offset %1 on file %2            */
#define RCL0008   8 /* Close of a file not on the CFB chain                 */
#define RCL0010  10 /* Insufficient memory                                  */
#define RCL0012  12 /* Incorrect number of arguments in call                */
#define RCL0014  14 /* Out of memory in ACCEPT                              */
#define RCL0015  15 /* Field overlap                                        */
#define RCL0016  16 /* Field is out of screen boundary                      */
#define RCL0017  17 /* Divide by zero                                       */
#define RCL0018  18 /* Stack exhausted                                      */
#define RCL0019  19 /* CALL to active program                               */
#define RCL0020  20 /* CANCEL of active program                             */
#define RCL0025  25 /* Bad SUPPRESS call before OPEN                        */
#define RCL0028  28 /* .EXE file is not a Realia COBOL program              */
#define RCL0030  30 /* SPIE routine invalid data                            */
#define RCL0031  31 /* Subscript out of range                               */
#define RCL0038  38 /* The function is unavailable for use with DISPDOS     */
#define RCL0039  39 /* Error writing SORT/MERGE file                        */
#define RCL0040  40 /* Error status %1 creating SORT/MERGE file             */
#define RCL0041  41 /* SORT/MERGE capacity exceeded                         */
#define RCL0042  42 /* RELEASE executed with no SORT active                 */
#define RCL0043  43 /* RETURN executed with no SORT active                  */
#define RCL0044  44 /* Out of memory in SORT/MERGE                          */
#define RCL0050  50 /* Invalid decimal data                                 */
#define RCL0052  52 /* Perform stack was empty at end of perform range      */
#define RCL0060  60 /* Realia COBOL environment already initialized         */
#define RCL0062  62 /* General Protection Fault                             */
#define RCL0063  63 /* Error addressing huge data in LINKAGE SECTION        */
#define RCL0064  64 /* Active run unit entered on the wrong stack           */
#define RCL0065  65 /* Program instance allocation failed                   */
#define RCL0066  66 /* Dynamically called program %1 load error %2          */
#define RCL0067  67 /* Dynamically called program %1 entrypoint not found   */
#define RCL0068  68 /* Invalid dynamic call program name                    */
#define RCL0069  69 /* Dynamically called program %1 export proc not found  */
#define RCL0070  70 /* Invalid or unsupported parameter descriptor          */
#define RCL0071  71 /* Invalid or unsupported module register parameter     */
#define RCL0072  72 /* COMMIT DosBufReset error %1                          */
#define RCL0073  73 /* Run Unit Block allocation failed                     */
#define RCL0074  74 /* Unable to initialize DLW display system              */
#define RCL0099  99 /* Run unit termination                                 */
#define RCL0100 100 /* Sort file procedure called with no sort active       */
#define RCL0101 101 /* Attempted to statically cancel a program that is not */
                    /* COBOL.                                               */
#define RCL0102 102 /* Thread Resource Data allocation failed               */
#define RCL0103 103 /* Dynamically called program %1 initialization failed  */
#define RCL0104 104 /* Internal logic error: Module table corrupted         */
#define RCL0105 105 /* Realia File System load error %1                     */
#define RCL0106 106 /* Internal logic error: Realia File System corrupted   */
#define RCL0107 107 /* Realia Runtime Library initialization error %1       */
#define RCL0108 108 /* No valid console for screen section operation        */
#define RCL0109 109 /* Invalid run unit handle                              */
#define RCL0110 110 /* Invalid entry handle                                 */
#define RCL0111 111 /* Invalid instance handle                              */
#define RCL0112 112 /* Module not found                                     */
#define RCL0113 113 /* Entry not in module                                  */
#define RCL0114 114 /* Perform stack full upon PERFORM with CALL directive  */
#define RCL0115 115 /* An error was encoundered in interpretive execution   */
#define RCL0116 116 /* The Realia File System was explicitly unloaded       */
#define RCL0117 117 /* The requested run unit was not found                 */
#define RCL0118 118 /* SORT executed when sort is already active            */
#define RCL0122 122 /* Run unit name mismatch                               */


/****************************************************************************/
/*                            FUNCTIONS                                     */
/*                                                                          */
/*                                                                          */
/* Functions    This section defines the run-unit management functions of   */
/*              the OpenRealia application-program interface                */
/*                                                                          */
/****************************************************************************/


#ifdef  __cplusplus
extern "C" {
#endif


/* The RealiaCobolCreateRunUnit function creates a run unit handle for      */
/* managing cobol programs.                                                 */
/*                                                                          */
long ORAPI RealiaCobolCreateRunUnit (
   HANDLE *       lpRunUnitHandle,
   LPCSTR         lpRunUnitName,
   LPVOID         lpReserved01,
   LPVOID         lpReserved02
   );
/*                                                                          */
/* Parameters                                                               */
/*    lpRunUnitHandle                                                       */
/*       A pointer to a field which will be updated with the handle for the */
/*       created run unit.                                                  */
/*                                                                          */
/*    lpRunUnitName                                                         */
/*       A pointer to a null terminated string or NULL. If this parameter   */
/*       is set to NULL, the default run unit name will be givin to the run */
/*       unit. If a string is passed, the run unit will be given the        */
/*       specified name (only the first 8 characters are used). This name   */
/*       must match the run unit name specified in any module called within */
/*       the run unit.                                                      */
/*                                                                          */
/*    lpReserved01                                                          */
/*       Reserved for future use. Must be set to INVALID_HANDLE_VALUE.      */
/*                                                                          */
/*    lpReserved02                                                          */
/*       Reserved for future use. Must be set to INVALID_HANDLE_VALUE.      */
/*                                                                          */
/* Result Value                                                             */
/*    The result value is an integer value of zero if this function is      */
/*    successful. Otherwise, it is one of the error numbers listed above.   */
/*                                                                          */
/* Remarks                                                                  */
/*    This function creates a handle based run unit which can be used by    */
/*    the other run unit management functions.  A handle based run unit is  */
/*    established as the active run unit only when a program is called via  */
/*    the RealiaCobolCallProgram function specifying the handle returned by */
/*    this function.  Use the RealiaCobolInitiateRunUnit to initialize a    */
/*    run unit used as the default for all cobol programs.                  */
/*                                                                          */
/* See Also                                                                 */
/*    RealiaCobolDeleteRunUnit, ReliaCobolInitiateRunUnit                   */


/* The RealiaCobolInitiateRunUnit function initiates a "default" or name    */
/* based run unit.                                                          */
/*                                                                          */
long ORAPI RealiaCobolInitiateRunUnit (
   LPCSTR         lpRunUnitName,
   LPVOID         lpReserved01,
   LPVOID         lpReserved02
   );
/*                                                                          */
/* Parameters                                                               */
/*    lpRunUnitName                                                         */
/*       A pointer to a null terminated string or NULL. If this parameter   */
/*       is set to NULL, the default run unit name will be givin to the run */
/*       unit. If a string is passed, the run unit will be given the        */
/*       specified name (only the first 8 characters are used). This name   */
/*       must match the run unit name specified in any module called within */
/*       the run unit.                                                      */
/*                                                                          */
/*    lpReserved01                                                          */
/*       Reserved for future use. Must be set to INVALID_HANDLE_VALUE.      */
/*                                                                          */
/*    lpReserved02                                                          */
/*       Reserved for future use. Must be set to INVALID_HANDLE_VALUE.      */
/*                                                                          */
/* Result Value                                                             */
/*    The result value is an integer value of zero if this function is      */
/*    successful. Otherwise, it is one of the error numbers listed above.   */
/*                                                                          */
/* Remarks                                                                  */
/*    This function initializes a default or name based run unit which is   */
/*    used as the run unit for all programs with a matching run unit name.  */
/*    A handle for a default or name based run unit can be obtained by      */
/*    calling the RealiaCobolGetRunUnit function.                           */
/*                                                                          */
/* See Also                                                                 */
/*    RealiaCobolTerminateRunUnit, ReliaCobolCreateRunUnit                  */


/* The RealiaCobolDeleteRunUnit function terminates a run unit handle and   */
/* deletes any storage associated with the run unit.                        */
/*                                                                          */
long ORAPI RealiaCobolDeleteRunUnit (
   HANDLE         RunUnitHandle
   );
/*                                                                          */
/* Parameters                                                               */
/*    RunUnitHandle                                                         */
/*       A run unit handle returned by RealiaCobolCreateRunUnit.            */
/*                                                                          */
/* Result Value                                                             */
/*    The result value is an integer value of zero if this function is      */
/*    successful. Otherwise, it is one of the error numbers listed above.   */
/*                                                                          */
/* Remarks                                                                  */
/*    This function is intented to terminate handle based run units created */
/*    by RealiaCobolCreateRunUnit.  Default or name based run units should  */
/*    be terminated by calling RealiaCobolTerminateRunUnit.                 */
/*                                                                          */
/*    If the run unit contains active instances, then this function will    */
/*    not return to its caller.  Instead, control will be returned to the   */
/*    caller of the first active cobol routine in the run unit.  If the     */
/*    call to the first cobol routine was via the RealiaCobolCallProgram    */
/*    function, then control will return to the caller of RealiaCobolCall-  */
/*    Program.  If the the cobol program was called directly from C or      */
/*    another language, an exception will be raised which can be handled    */
/*    directly by the calling routine (see the Mixed-language Programming   */
/*    section in the COBOL user Guide for a description of the exception).  */
/*                                                                          */
/*    If the run unit contains no active instances, control will return to  */
/*    the caller of this function.                                          */
/*                                                                          */
/* See Also                                                                 */
/*    RealiaCobolTerminateRunUnit, RealiaCreateRunUnit,                     */
/*    RealiaCobolCallProgram                                                */


/* The RealiaCobolTerminateRunUnit function terminates a default run unit   */
/* releasing any storage associated with the run unit.                      */
/*                                                                          */
long ORAPI RealiaCobolTerminateRunUnit (
   LPCSTR         lpRunUnitName
   );
/*                                                                          */
/* Parameters                                                               */
/*    lpRunUnitName                                                         */
/*       A pointer to a null terminated string or NULL. If this parameter   */
/*       is set to NULL, the run unit with the default name will be         */
/*       terminated.  Otherwise, the run unit matching the specified name   */
/*       will be terminated.                                                */
/*                                                                          */
/* Result Value                                                             */
/*    The result value is an integer value of zero if this function is      */
/*    successful. Otherwise, it is one of the error numbers listed above.   */
/*                                                                          */
/* Remarks                                                                  */
/*    This function is intented to terminate a default or name based run    */
/*    unit.  The run unit with a matching name is terminated and all        */
/*    storage associated with that run unit is deleted.  Only run units     */
/*    initialized by RealiaCobolInitiateRunUnit or by execution of COBOL    */
/*    are terminated by this routine.  Handle based run units must be       */
/*    terminated by RealiaCobolDeleteRunUnit.                               */
/*                                                                          */
/*    If the run unit contains active instances, then this function will    */
/*    not return to its caller.  Instead, control will be returned to the   */
/*    caller of the first active cobol routine in the run unit.  If the     */
/*    call to the first cobol routine was via the RealiaCobolCallProgram    */
/*    function, then control will return to the caller of RealiaCobolCall-  */
/*    Program.  If the the cobol program was called directly from C or      */
/*    another language, an exception will be raised which can be handled    */
/*    directly by the calling routine (see the Mixed-language Programming   */
/*    section in the COBOL user Guide for a description of the exception).  */
/*                                                                          */
/*    If the run unit contains no active instances, control will return to  */
/*    the caller of this function.                                          */
/*                                                                          */
/* See Also                                                                 */
/*    RealiaCobolInitiateRunUnit, RealiaCobolCallProgram                    */



/* The RealiaCobolGetDefaultRunUnit function returns a run unit handle for  */
/* the default run unit matching the specified name.                        */
/*                                                                          */
long ORAPI RealiaCobolGetDefaultRunUnit (
   HANDLE *       lpRunUnitHandle,
   LPCSTR         lpRunUnitName
   );
/*                                                                          */
/* Parameters                                                               */
/*    lpRunUnitHandle                                                       */
/*       A pointer to a field which will be updated with the handle for the */
/*       active run unit.                                                   */
/*                                                                          */
/*    lpRunUnitName                                                         */
/*       A pointer to a null terminated string or NULL. If this parameter   */
/*       is set to NULL, the default run unit name will be givin to the run */
/*       unit. If a string is passed, the run unit will be given the        */
/*       specified name (only the first 8 characters are used). This name   */
/*       must match the run unit name specified in any module called within */
/*       the run unit.                                                      */
/*                                                                          */
/* Result Value                                                             */
/*    The result value is an integer value of zero if this function is      */
/*    successful. Otherwise, it is one of the error numbers listed above.   */
/*                                                                          */
/* Remarks                                                                  */
/*    The RealiaCobolGetDefaultRunUnit returns a handle for the run unit    */
/*    matching the given run unit name.  It may be used to obtain a handle  */
/*    for a run unit which was created by direct use of COBOL code.  If no  */
/*    run unit is found with the matching name, an error is returned.       */
/*                                                                          */
/* See Also                                                                 */
/*    RealiaCobolInitiateRunUnit, RealiaCobolCreateRunUnit                  */


/* The RealiaCobolAddressOf function returns the address of its argument.   */
unsigned long ORAPI RealiaCobolAddressOf (
   VOID *         lpArgument
   );
/*                                                                          */
/* Parameters                                                               */
/*    lpArgument                                                            */
/*       A pointer to the argument.                                         */
/*                                                                          */
/* Result Value                                                             */
/*    The return value from this function is `lpArgument' cast as an        */
/*    unsigned long.                                                        */
/*                                                                          */
/* Remarks                                                                  */
/*                                                                          */
/*    This function is intended for use by programs written in a language   */
/*    that does not have an AddressOf function. It provides a means by      */
/*    which these programs can build the array required for the             */
/*    `lpArguments' argument of the RealiaCobolCallProgram function.        */


/* The RealiaCobolCallProgram function performs a COBOL CALL to CA-Realia   */
/* COBOL program entry point.                                               */
/*                                                                          */
long ORAPI RealiaCobolCallProgram (
   HANDLE         RunUnitHandle,
   HANDLE         EntryHandle,
   HANDLE *       lpInstanceHandle,
   DWORD          ProgramAttributes,
   LONG *         lpReturnCode,
   DWORD          cArguments,
   VOID * CONST * lpArguments,
   VOID *         lpGiving
   );
/*                                                                          */
/* Parameters                                                               */
/*    RunUnitHandle                                                         */
/*       Specifies the run unit in which the program is to be executed.     */
/*       This argument consists of a handle returned by the RealiaCobol-    */
/*       CreateRunUnit or RealiaCobolGetDefaultRunUnit functions.           */
/*                                                                          */
/*    EntryHandle                                                           */
/*       A handle to the entry point to be called.  This argument consists  */
/*       of a handle returned by the RealiaCobolAddressToEntry or Realia-   */
/*       CobolGetEntryHandle functions.                                     */
/*                                                                          */
/*    lpInstanceHandle                                                      */
/*       A pointer to a field that contains a handle for the program        */
/*       instance to call. This field must be initialized to one of the     */
/*       following values:                                                  */
/*                                                                          */
/*          RPI_MRI     Specifies that the most recent instance of the      */
/*                      program is invoked by the call. A new instance of   */
/*                      the program may be invoked by the call if an        */
/*                      instance of the program does not already exist or   */
/*                      the most recent instance of the program is active   */
/*                      and the program is RECURSIVE.                       */
/*                                                                          */
/*          RPI_NEW     Specifies that a new instance of the program is     */
/*                      invoked by the call.                                */
/*                                                                          */
/*          other       Specifies the handle of an existing program         */
/*                      instance returned by a prior call to this function. */
/*                                                                          */
/*       If the program does not have the INITIAL attribute, this function  */
/*       overwrites the current value of this parameter with the handle of  */
/*       the actual instance invoked by this call. If the program has the   */
/*       INITIAL attribute, this function overwrites the current value of   */
/*       this parameter with the RPI_MRI value.                             */
/*                                                                          */
/*    ProgramAttributes                                                     */
/*       The argument specifies attributes to be assigned to the program    */
/*       instance. The parameter can be set to zero or a combination of the */
/*       following values:                                                  */
/*                                                                          */
/*          RPA_INITIAL    Specifies that the called program instance is to */
/*                         be assigned the initial program attribute.       */
/*                         Programs with the initial attribute assigned are */
/*                         canceled during the execution of the EXIT        */
/*                         PROGRAM or GOBACK statement which returns to the */
/*                         caller.                                          */
/*                                                                          */
/*          RPA_MAIN       Specifies that the called program instance is to */
/*                         be assigned the main program attribute. Programs */
/*                         with the main program attribute assigned skip    */
/*                         the execution of EXIT PROGRAM statements. Such   */
/*                         programs will only return to caller by execution */
/*                         of a STOP RUN or GOBACK statement. During the    */
/*                         execution of a GOBACK statement, the run unit    */
/*                         will be terminated.                              */
/*                                                                          */
/*          RPA_RECURSIVE  Specifies that the called program instance is to */
/*                         be assigned the recursive program attribute.     */
/*                         Programs with the recursive attribute assigned   */
/*                         may be re-entered while still active, in which   */
/*                         case, a new instance of the program is created.  */
/*                         Note that an initial instance of the program is  */
/*                         not directly created by the use of this          */
/*                         attribute; only when the called instance is      */
/*                         re-entered is an initial instance created.       */
/*                         Programs assigned the recursive attribute are    */
/*                         also assigned the initial attribute and are      */
/*                         therefore canceled on exit.                      */
/*                                                                          */
/*    lpReturnCode                                                          */
/*       Points to an unsigned long field that receives the contents of the */
/*       RETURN-CODE special register from the CA-Realia COBOL program      */
/*       entry-point specified by the EntryHandle argument.                 */
/*                                                                          */
/*    cArguments                                                            */
/*       The number of arguments that are to be passed to the entry point.  */
/*                                                                          */
/*    lpArguments                                                           */
/*       A pointer to an array. Each element of the array contains the      */
/*       address of one of the arguments to the entry point.                */
/*                                                                          */
/*    lpGiving                                                              */
/*       A pointer to the field that receives the GIVING value.             */
/*                                                                          */
/* Result Value                                                             */
/*    The result value is zero or one of the error message listed above     */
/*    A result value of zero indicates the program successfully executed    */
/*    control returned via an EXIT PROGRAM.  A result value of RCL0099      */
/*    indicates the run unit of the program was terminated either due to an */
/*    error or a termination request (STOP RUN or RealiaCobolTerminateRun-  */
/*    Unit) while this program was active.                                  */
/*                                                                          */
/* Remarks                                                                  */
/*                                                                          */
/*    The RealiaCobolCallProgram function handles calls to CA-Realia COBOL  */
/*    programs the same way as a COBOL CALL statement with the ON OVERFLOW  */
/*    phrase specified.  Therefore, when a COBOL CALL statement receives    */
/*    control after a failed attempt to enter a CA-Realia COBOL program, so */
/*    does the RealiaCobolCallProgram function.                             */
/*                                                                          */
/*    When the call fails, the result value of the RealiaCobolCallPrgram    */
/*    function is the error number that would have been stored in the       */
/*    RETURN-CODE special-register and the value of the integer referenced  */
/*    by the lpReturnCode argument is undefined.                            */
/*                                                                          */
/*    The run unit specified by RunUnitHandle becomes the active run unit   */
/*    for the duration of the call.  Thus any other Cobol programs called   */
/*    directly or indirectly by the Cobol program specified by EntryHandle  */
/*    will execute in the run unit specified by RunUnitHandle, providing    */
/*    the run unit name of the program matches the run unit name specified  */
/*    on the run unit.  The run unit may be either a handle based run unit  */
/*    created by RealiaCobolCreateRunUnit, or a default run unit returned   */
/*    by RealiaCobolGetDefaultRunUnit.                                      */
/*                                                                          */
/*    The run unit name of the program being called must match the run unit */
/*    name of the run unit.                                                 */
/*                                                                          */
/*    If the field pointed to by the lpInstanceHandle field contains the    */
/*    handle of an existing program instance, then that program instance    */
/*    must not be active.  The field pointed to by lpInstanceHandle is      */
/*    updated before the entry point is called. Hence this handle is        */
/*    available to any routine called during the execution of the           */
/*    designated entry point.                                               */
/*                                                                          */
/*    If the lpGiving parameter is NULL the GIVING value is not saved. In   */
/*    addition, the field pointed to by this parameter is not updated if    */
/*    entry point does not have a GIVING field.                             */
/*                                                                          */
/*    If the lpReturnCode parameter is NULL the RETURN_CODE special         */
/*    register is not saved.                                                */
/*                                                                          */
/* See Also                                                                 */
/*    RealiaCobolCancelModule, RealiaCobolCancelProgram,                    */
/*    RealiaCobolGetEntryAddress, RealiaCobolGetEntryHandle,                */
/*    RealiaCobolAddressToEntry, RealiaCobolTerminateRunUnit.               */


/* The RealiaCobolCancelModule function performs a COBOL cancel on the CA-  */
/* Realia COBOL program instances created by a module.                      */
/*                                                                          */
long ORAPI RealiaCobolCancelModule (
   HANDLE         RunUnitHandle,
   HANDLE         EntryHandle
   );
/*                                                                          */
/* Parameters                                                               */
/*    RunUnitHandle                                                         */
/*       A handle for the run unit which contains the instances to be       */
/*       canceled.  This argument consists of a handle returned by the      */
/*       RealiaCobolCreateRunUnit or RealiaCobolGetDefaultRunUnit           */
/*       functions.                                                         */
/*                                                                          */
/*    EntryHandle                                                           */
/*       A handle to an entry point in the modulde to be canceled.  This    */
/*       argument consists of a handle returned by the RealiaCobolAddress-  */
/*       ToEntry or RealiaCobolGetEntryHandle functions.                    */
/*                                                                          */
/* Result Value                                                             */
/*    The result value is zero, -1 or one of the error message listed above.*/
/*    A result value of zero or -1 indicates that the module was success-   */
/*    fully canceled.  A -1 result value further indicates that the module  */
/*    was removed from the run-unit module database, thus invalidating any  */
/*    handles for the module.                                               */
/*                                                                          */
/* Remarks                                                                  */
/*    The EntryHandle is used to specify the module to cancel.  All         */
/*    program instances not designated as entry-point call/cancel created   */
/*    by the module containing the program entry-point specified by the     */
/*    EntryHandle are canceled.  The specified entry point is always        */
/*    canceled.                                                             */
/*                                                                          */
/*    The module is removed from the COBOL run-time module database if all  */
/*    program instances created by the module are canceled. It is also      */
/*    freed from the operating system module database if the module was     */
/*    loaded the CA-Realia COBOL run-time system.  It is the responsiblity  */
/*    of the caller of RealiaCobolCancelModule to ensure this function is   */
/*    called from a safe module in cases where the canceled module can be   */
/*    freed.                                                                */
/*                                                                          */
/* See Also                                                                 */
/*    RealiaCobolCancelProgram, RealiaCobolTerminateRunUnit                 */


/* The RealiaCobolCancelProgram function performs a COBOL cancel on the     */
/* specified program.                                                       */
long ORAPI RealiaCobolCancelProgram (
   HANDLE         RunUnitHandle,
   HANDLE         EntryHandle,
   HANDLE         InstanceHandle
   );
/*                                                                          */
/* Parameters                                                               */
/*    RunUnitHandle                                                         */
/*       A handle for the run unit which contains the instances to be       */
/*       canceled.  This argument consists of a handle returned by the      */
/*       RealiaCobolCreateRunUnit or RealiaCobolGetDefaultRunUnit           */
/*       functions.                                                         */
/*                                                                          */
/*    EntryHandle                                                           */
/*       A handle to the entry point to be canceled.  This argument consists*/
/*       of a handle returned by the RealiaCobolAddressToEntry or Realia-   */
/*       CobolGetEntryHandle functions.                                     */
/*                                                                          */
/*    lpInstanceHandle                                                      */
/*       A pointer to a field that contains a handle for the program        */
/*       instance to be canceled. This field must be set to one of the      */
/*       following values:                                                  */
/*                                                                          */
/*          RPI_MRI     Specifies that the most recent instance of the      */
/*                      program is to be canceled.                          */
/*                                                                          */
/*          RPI_ALL     Specifies that all instances of the program are to  */
/*                      be canceled.                                        */
/*                                                                          */
/*          other       Specifies the handle of a specific program instance */
/*                      to cancel.                                          */
/*                                                                          */
/* Result Value                                                             */
/*    The result value is zero, -1 or one of the error message listed above.*/
/*    A result value of zero or -1 indicates that the program was success-  */
/*    fully canceled.  A -1 result value further indicates that the module  */
/*    containing the program was removed from the run-time module database, */
/*    thus invalidating any handles for the module.                         */
/*                                                                          */
/* Remarks                                                                  */
/*    An specific instance can be canceled by passing the instance handle   */
/*    returned by the RealiaCobolCallProgram function.                      */
/*                                                                          */
/*    The module containing the program is removed from the COBOL run-time  */
/*    module database if all program instances created by the module are    */
/*    canceled.  It is also freed from the operating system module          */
/*    database if the module was loaded the CA-Realia COBOL run-time system.*/
/*    It is the responsiblity of the caller of RealiaCobolCancelProgram to  */
/*    ensure the caller of this function is located in a safe module in     */
/*    cases where the canceled module can be freed.                         */
/*                                                                          */
/* See Also                                                                 */
/*    RealiaCobolCancelModule, RealiaCobolTerminateRunUnit                  */


/* The RealiaCobolAddressToEntry function returns the EntryHandle for a     */
/* specified program entry address.                                         */
/*                                                                          */
long ORAPI RealiaCobolAddressToEntry (
   HANDLE         RunUnitHandle,
   FARPROC        EntryAddress,
   HANDLE *       lpEntryHandle
   );
/*                                                                          */
/* Parameters                                                               */
/*    RunUnitHandle                                                         */
/*       A handle for a run unit.  The handle can be for any run unit.      */
/*                                                                          */
/*    EntryAddress                                                          */
/*       The address of the entry point.                                    */
/*                                                                          */
/*    lpEntryHandle                                                         */
/*       A pointer to a field which will be updated to contain the entry    */
/*       handle for this entry point.                                       */
/*                                                                          */
/* Result Value                                                             */
/*    The result value is an integer value of zero if this function is      */
/*    successful. Otherwise, it is one of the error numbers listed above.   */
/*                                                                          */
/* Remarks                                                                  */
/*    The EntryAddress must be the address of a COBOL entry point.   This   */
/*    function can be used to convert direct reference to a cobol entry     */
/*    point to an EntryHandle suitable for passing to the RealiaCobol-      */
/*    CallProgram function.                                                 */
/*                                                                          */
/* See Also                                                                 */
/*    RealiaCobolGetEntryAddress, RealiaCobolGetEntryHandle,                */
/*    RealiaCobolCancelModule, RealiaCobolCancelProgram,                    */
/*    RealiaCobolCallProgram                                                */


/* The RealiaCobolGetEntryHandle function searches the entrypoint tables    */
/* generated by the CA-Realia COBOL Compiler for the entry point specified  */
/* by the lpstrEntry parameter and returns a handle to the specified entry  */
/* point.                                                                   */
/*                                                                          */
long ORAPI RealiaCobolGetEntryHandle (
   HANDLE         RunUnitHandle,
   LPCSTR         lpEntryName,
   LPCSTR         lpModuleFileName,
   HANDLE         ModuleHandle,
   HANDLE *       lpEntryHandle
   );
/*                                                                          */
/* Parameters                                                               */
/*    RunUnitHandle                                                         */
/*       A handle for a run unit in which the lookup is to occur.  The      */
/*       handle can be for any run unit.                                    */
/*                                                                          */
/*    lpEntryName                                                           */
/*       Points to a null terminated string containing the entry point name */
/*       of a CA-Realia COBOL program entry-point.                          */
/*                                                                          */
/*    lpModuleFileName                                                      */
/*       Can be used to qualify the search for the program entry-point      */
/*       specified by lpEntryName to a specific module.  This argument can  */
/*       contain a null terminated string that names the module or NULL.    */
/*       The name specified is the filename of the module.                  */
/*                                                                          */
/*    ModuleHandle                                                          */
/*       Can be used to qualify the search for the program entry-point      */
/*       specified by lpEntryName to a specific module.  This argument can  */
/*       contains the handle of a previously loaded module or INVALID_-     */
/*       HANDLE_VALUE.  This handle is the operating specific handle. (e.g. */
/*       returned by LoadLibrary in WIN32).                                 */
/*                                                                          */
/*    lpEntryHandle                                                         */
/*       Points to a field in which this function stores a handle for the   */
/*       specified entry point if the specified entry point can be located  */
/*       in the entry-point table generated by the compiler.                */
/*                                                                          */
/* Result Value                                                             */
/*    The result value is an integer value of zero if this function is      */
/*    successful. Otherwise, it is one of the error numbers listed above.   */
/*                                                                          */
/* Remarks                                                                  */
/*    This function searches for the specified entry point name by using    */
/*    one of three methods.                                                 */
/*       1.  If ModuleHandle is not INVALID_MODULE_HANDLE, then the search  */
/*           is made for the entry point in the module specified by Module- */
/*           Handle.                                                        */
/*       2.  If lpModuleFileName is not NULL, then the search is made for   */
/*           the entry point in the module whose path name is given by      */
/*           lpModuleFileName.                                              */
/*       3.  If ModuleHandle is INVALID_MODULE_HANDLE and lpModuleFileName  */
/*           is NULL, the search is performed using the rules for a         */
/*           dynamic call.                                                  */
/*    If the ModuleHandle parameter is not INVALID_HANDLE_VALUE and the     */
/*    lpModuleFileName parameter is not NULL, only the ModuleHandle         */
/*    parameter is used. The lpModuleFileName parameter is ignored.         */
/*                                                                          */
/*    The search for the entry name in the entry-point tables is case       */
/*    insensitive.                                                          */
/*                                                                          */
/*    If the ModuleHandle parameter is not INVALID_HANDLE_VALUE, then the   */
/*    specified module is located. The entry-point table generated by the   */
/*    CA-Realia COBOL Compiler and stored in the module is searched for the */
/*    specified entry name. If it is found, then this function returns a    */
/*    handle to that entry point. If the entry name is not found in the     */
/*    entry-point table, or if the module cannot be located, this function  */
/*    returns an error.                                                     */
/*                                                                          */
/*    If the lpModuleFileName parameter is not NULL, then the specified     */
/*    module is located. If it is not already mapped to the current         */
/*    address space, it is mapped. The entry-point table generated by the   */
/*    CA-Realia COBOL Compiler and stored in the module is searched for the */
/*    specified entry name. If it is found, then this function returns a    */
/*    handle to that entry point. If the entry name is not found in the     */
/*    entry-point table, or if the module cannot be located, this function  */
/*    returns an error.                                                     */
/*                                                                          */
/*    If the lpModuleFileName string specifies a path but the file does not */
/*    exist in the specified path, the function fails.  If a path is not    */
/*    specified and the filename extension is omitted the default library   */
/*    extension is appended (e.g. ".DLL").  However, the filename string    */
/*    can include a trailing point character (.) to indicate that the       */
/*    module name has no extension.  When no path is specified, the         */
/*    function searches for the file in a system dependent manner.          */
/*                                                                          */
/*    If ModuleHandle is INVALID_HANDLE_VALUE and lpModuleFileName is NULL, */
/*    the search is performed according to the rules of the COBOL CALL      */
/*    statement. That is, the entry-point tables of all previously loaded   */
/*    modules are searched in the reverse order in which they were loaded.  */
/*    If a match is found in any entry-point table, this function returns a */
/*    handle to the matching entry point. If a match is not found, this     */
/*    function constructs a module file name from the entry name. (If the   */
/*    file system of the operating system is case sensitive, the constructed*/
/*    file name is converted to all lower case.) This function then proceeds*/
/*    as if the original call had specified the constructed file name as the*/
/*    lpModuleFileName parameter.                                           */
/*                                                                          */
/*    The RunUnitHandle can be that of any run unit, and does not have to   */
/*    be the run unit in which the program will be called.   If the search  */
/*    for an Entry Handle causes a dynamic library to be loaed, the user    */
/*    exit for this run unit will be notified of the load event.            */
/*                                                                          */
/* See Also                                                                 */
/*    RealiaCobolCallProgram, RealiaCobolCancelModule,                      */
/*    RealiaCobolCancelProgram, RealiaCobolGetEntryAddress,                 */
/*    RealiaCobolGetEntryInfo, RealiaCobolAddressToEntry                    */


/* The RealiaCobolGetEntryAddress function returns the address of the entry */
/* point to a CA-Realia COBOL program.                                      */
/*                                                                          */
long ORAPI RealiaCobolGetEntryAddress (
   HANDLE         RunUnitHandle,
   HANDLE         EntryHandle,
   FARPROC *      lpEntryAddress
   );
/*                                                                          */
/* Parameters                                                               */
/*    RunUnitHandle                                                         */
/*       A handle for a run unit.  The handle can be for any run unit.      */
/*                                                                          */
/*    EntryHandle                                                           */
/*       A handle to the entry point whose entry address is desired.        */
/*                                                                          */
/*    lpEntryAddress                                                        */
/*       Points to a field that receives the entry point address.           */
/*                                                                          */
/* Result Value                                                             */
/*    The result value is an integer value of zero if this function is      */
/*    successful. Otherwise, it is one of the error numbers listed above.   */
/*                                                                          */
/* Remarks                                                                  */
/*    The RealiaCobolGetEntryAddress function converts the program          */
/*    entry-point argument to address form and stores it in the field       */
/*    pointed to by lpEntryAddress.  This address can be used to call the   */
/*    function directly without going through the RealiaCobolCallProgram    */
/*    program.                                                              */
/*                                                                          */
/* See Also                                                                 */
/*    RealiaCobolGetEntryHandle, RealiaCobolAddressToEntry                  */


/* The RealiaCobolEnumEntryParams function enumerates the parameters of the */
/* of the specified CA-Realia COBOL program entry-point.                    */
long ORAPI RealiaCobolEnumEntryParams (
   HANDLE         RunUnitHandle,
   HANDLE         EntryHandle,
   LPFNEEPPROC    EnumEntPrmProc,
   DWORD          EnumEntPrmProcParm
   );
/*                                                                          */
/* Parameters                                                               */
/*    RunUnitHandle                                                         */
/*       A handle for a run unit.  The handle can be for any run unit.      */
/*                                                                          */
/*    EntryHandle                                                           */
/*       A handle to the entry point whose parameters are to be enumerated. */
/*       This argument consists of a handle returned by the RealiaCobol-    */
/*       AddressToEntry or RealiaCobolGetEntryHandle functions.             */
/*                                                                          */
/*    EnumEntPrmProc                                                        */
/*       Points to the callback function that receives parameter            */
/*       information for the specified CA-Realia COBOL program              */
/*       entry-point.                                                       */
/*                                                                          */
/*    EnumEntPrmProc                                                        */
/*       Specifies a 32-bit application-defined value to pass to the        */
/*       callback function.                                                 */
/*                                                                          */
/* Result Value                                                             */
/*    The result value is an integer value of zero if this function is      */
/*    successful. Otherwise, it is one of the error numbers listed above.   */
/*                                                                          */


/* The RealiaCobolGetEntryInfo function retrieves information about a       */
/* Realia COBOL program entry-point.                                        */
long ORAPI RealiaCobolGetEntryInfo (
   HANDLE            RunUnitHandle,
   HANDLE            EntryHandle,
   REALIAENTRYINFO * lpEntryInfo
   );
/*                                                                          */
/* Parameters                                                               */
/*    RunUnitHandle                                                         */
/*       A handle for a run unit.  The handle can be for any run unit.      */
/*                                                                          */
/*    EntryHandle                                                           */
/*       A handle to the entry point whose parameters are to be enumerated. */
/*       This argument consists of a handle returned by the RealiaCobol-    */
/*       AddressToEntry or RealiaCobolGetEntryHandle functions.             */
/*                                                                          */
/*    lpEntryInfo                                                           */
/*       Points to a REALIAENTRYINFO structure that receives the entry      */
/*       information.                                                       */
/*                                                                          */
/* Result Value                                                             */
/*    The result value is an integer value of zero if this function is      */
/*    successful. Otherwise, it is one of the error numbers listed above.   */
/*                                                                          */
/* See Also                                                                 */
/*    RealiaCobolGetEntryHandle, RealiaCobolAddressToEntry,                 */
/*    RealiaCobolEnumEntryParams                                            */


/* The RealiaCobolRegUserExit function registers a RealiaCobolUsrExitProc   */
/* callback function which will receive notification CA-Realia COBOL run-   */
/* time system events.                                                      */
long ORAPI RealiaCobolRegUserExit (
   HANDLE         RunUnitHandle,
   LPFNUEPROC     lpfnUserExitProc,
   DWORD          lParm
   );
/*                                                                          */
/* Parameters                                                               */
/*    RunUnitHandle                                                         */
/*       A handle for the run unit for which the user exit is to be         */
/*       registered.  This argument consists of a handle returned by the    */
/*       RealiaCobolCreateRunUnit or RealiaCobolGetDefaultRunUnit           */
/*       functions.                                                         */
/*                                                                          */
/*    lpfnUserExitProc                                                      */
/*       Points to the RealiaCobolUsrExtProc callback function that         */
/*       received notification of runtime system events.                    */
/*                                                                          */
/*    lParm                                                                 */
/*       Specifies a 32-bit application defined value to pass to the        */
/*       lpfnUserExitProc function.                                         */
/*                                                                          */
/* Result Value                                                             */
/*    The result value is an integer value of zero if this function is      */
/*    successful. Otherwise, it is one of the error numbers listed above.   */
/*                                                                          */
/* Remarks                                                                  */
/*    This function registers the specified exit function to be called for  */
/*    notification of runtime system events.  The exit functions are called */
/*    in first-registered, last-notified order.                             */
/*                                                                          */
/*    Each registered function will be notified of the following events     */
/*                                                                          */
/*       RCUE_ERROR     Specifieds a run-time error event.                  */
/*                                                                          */
/*         The lpvEvent parameter points to a REALIAERROR structure. (see   */
/*         definition of the REALIAERROR structure above).                  */
/*                                                                          */
/*         A nonzero return value specifies that the error message should   */
/*         be displayed by the run-time system.  A return value of zero     */
/*         specifies that the error message should not be displayed by the  */
/*         run-time system.                                                 */
/*                                                                          */
/*         A RCUE_TERM event will eventually follow this event.             */
/*                                                                          */
/*       RCUE_FREE      Specifies a dynamic module free event.              */
/*                                                                          */
/*         The lpiEvent parameter points to a REALIAMODULE structure. (see  */
/*              definition of the REALIAMODULE structure above).                 */
/*                                                                          */
/*         A nonzero return value specifies that the run-time is to         */
/*         continue polling the user-exit chain. A return value of zero     */
/*         specifies that the run-time is to stop polling the user-exit     */
/*         chain.                                                           */
/*                                                                          */
/*         The rmHandle member of the REALIAMODULE structure contains the   */
/*         operating system handle of the module to be freed, or NULL       */
/*         if the module has already been freed.  The user-exit procedure   */
/*         must inspect the rmHandle member to to determine if the module   */
/*         has been freed by a prior exit function.                         */
/*                                                                          */
/*         The run-time system always evaluates the contents of the         */
/*         rmHandle member to determine whether or not to issue a free on   */
/*         the module, regardless of the return value.  Therefore, if the   */
/*         module is freed by the user-exit procedure, the procedure should */
/*         set rmHandle to NULL and return zero as the return value.        */
/*                                                                          */
/*      RCUE_LOAD       Specifies a dynamic module load event.              */
/*                                                                          */
/*         The lpiEvent parameter points to a REALIAMODULE structure. (see  */
/*              definition of the REALIAMODULE structure above).                 */
/*                                                                          */
/*         A nonzero return value specifies that the run-time is to         */
/*         continue polling the user-exit chain. A return value of zero     */
/*         specifies that the run-time is to stop polling the user-exit     */
/*         chain.                                                           */
/*                                                                          */
/*         The rmHandle member of the REALIAMODULE structure contains NULL  */
/*         or operating system handle of the loaded module. The user-exit   */
/*         procedure must inspect the rmHandle member to determine if the   */
/*          module has been loaded by a prior exit function.                */
/*                                                                          */
/*         The run-time system always evaluates the contents of the         */
/*         REALIAMODULE structure to determine whether or not to attempt    */
/*         a load on the module, regardless of the return value.  This if   */
/*         the user exit loads the module, it should set rmHandle to the    */
/*         operating system handle of the load module.                      */
/*                                                                          */
/*    RCUE_SPIE         Specifies an invalid decimal or subscript.          */
/*                                                                          */
/*         The lpiEvent parameter points to either a REALIADCHK or          */
/*         REALIASUBCHK structure.   The firest field of both structures is */
/*         a field which indicates the type of error.  If this value is     */
/*         equal to SPIE_SUB, lpiEvent points to a REALIASUBCHK structure   */
/*         otherwise it points to a REALIADCHK structure.                   */
/*                                                                          */
/*         A return value of zero specifies that the data has been fixed    */
/*         and it is rechecked by the run-time system to see if the new     */
/*         value is acceptable.                                             */
/*                                                                          */
/*         A nonzero return value specifies that the run-time is to         */
/*         continue polling the user-exit chain.  If this is the last user  */
/*         exit routine on the chain, the run-time system displays the      */
/*         appropriate error message.                                       */
/*                                                                          */
/*    RCUE_TERM         Specifies a run-unit termination event.             */
/*                                                                          */
/*         The lpiEvent parameter points to a REALIATERM structure. (see    */
/*              definition of the REALIATERM structure above).                   */
/*                                                                          */
/*         A nonzero return value specifies that the run-time is to         */
/*         continue polling the user-exit chain and that control be         */
/*         eventually returned to the caller of COBOL.  A return value of   */
/*         zero specifies that control of execution is return to the        */
/*         operating system.                                                */
/*                                                                          */
/* See Also                                                                 */
/*    RealiaCobolUnRegUserExit                                              */


/* The RealiaCobolUnregUserExit function removes a RealiaCobolUsrExitProc   */
/* from the user exit chain.                                                */
long ORAPI RealiaCobolUnregUserExit (
   HANDLE         RunUnitHandle,
   LPFNUEPROC     lpfnUserExitProc
   );
/*                                                                          */
/* Parameters                                                               */
/*    RunUnitHandle                                                         */
/*       A handle for the run unit for which the user exit is to be         */
/*       deregistered.  This argument consists of a handle returned by the */
/*       RealiaCobolCreateRunUnit or RealiaCobolGetDefaultRunUnit           */
/*       functions.                                                         */
/*                                                                          */
/*                                                                          */
/*    lpfnUserExitProc                                                      */
/*       Points to a RealiaCobolUsrExtProc callback which was previously    */
/*       added by calling RealiaCobolRegUserExit.                           */
/*                                                                          */
/* Result Value                                                             */
/*    The result value is an integer value of zero if this function is      */
/*    successful. Otherwise, it is one of the error numbers listed above.   */
/*                                                                          */
/* Remarks                                                                  */
/*    User Exits are automatically deregistered when a run unit is          */
/*    terminated, thus the user should not call the deregister function in  */
/*    response to a termination notification.                               */
/*                                                                          */
/* See Also                                                                 */
/*    RealiaCobolRegUserExit                                                */

#ifdef  __cplusplus
}
#endif  /* __cplusplus */

#endif  /* _INC_CARCRUM */
