#ifndef _INC_CARCOR
#define _INC_CARCOR

/******************************************************************************/
/*                                                                            */
/*   This material is confidential to Computer Associates International, Inc. */
/*   Copyright (c) 1993 Computer Associates International, Inc.               */
/*   All rights reserved.                                                     */
/*                                                                            */
/*   Version 2.0  Carcor.h                                                    */
/*   Feb 8, 1996 (EWB)                                                        */
/*   Version 1.0  Carcor.h                                                    */
/*   Sept 21, 1993 (PKP)                                                      */
/*                                                                            *.
/*   This header provides a uniform set of predefined manifest                *.
/*   constants and macros that provide information about Realia API's         *.
/*   for various operating systems                                            *.
/*                                                                            *.
/*   The compilers supported by this header files are:                        *.
/*                                                                            *.
/*         __IBMC__         IBM Cset++ for 32 Bit OS/2                        *.
/*         _MSC_VER         Microsoft Visual C++ Version >= 900 (2.00 and up) *.
/*                                                                            */
/*   The following constants indicates that the function being declared is    */
/*   exported from one of the Realia DLL's. It is currently defined only when */
/*   the compiler is Microsoft Visual C++.                                    */
/*                                                                            */
/*         CARC_export                                                        */
/*         CARC_import                                                        */
/*                                                                            */
/*   The following constants define the calling convention used by the Realia */
/*   COBOL compiler for routines defined with name beginning with R_, C_, P_, */
/*   and S_.                                                                  */
/*                                                                            */
/*        CARC_call_cobol    standard COBOL calling convention                */
/*        CARC_call_c        standard C calling convention                    */
/*        CARC_call_pascal   standard Pascal calling convention               */
/*        CARC_call_system   standard SYSTEM (operating system API) calling   */
/*                                                                            */
/*   In addition, each of the above symbols is defined with '_ptr' appended   */
/*   to declare a pointer to a function with the associated calling           */
/*   convention.                                                              */
/*                                                                            */
/*   Notes:                                                                   */
/*    1. The standard COBOL calling convention passes an additional parameter */
/*       that indicates the actual number of parameters passed. Hence, a      */
/*       generic prototype for a COBOL program would be                       */
/*                                                                            */
/*          <type> CARC_call_cobol <name> (unsigned long, ...)                */
/*                                                                            */
/*       where <type> is the return type (only long, short, or char; the      */
/*       COBOL compiler does not handle float the same way as the C compiler) */
/*       and <name> is the name of the COBOL proram (lower case characters    */
/*       are converted to the corresponding upper case characters and hyphens */
/*       are converted to dollar signs). The actual parameter count is        */
/*       given in the lower order 16 bits of the first parameter. The high    */
/*       16 bits must be zero (results are undefined if any of the high       */
/*       order bits is not zero).                                             */
/*                                                                            */
/*    2. The standard Pascal calling convention is essentially the __pascal   */
/*       calling convention supported by most MS-DOS C compilers, upgraded to */
/*       32 bits. It is not currently supported in the Microsoft Visual C++   */
/*       compiler. Hence, the CARC_call_pascal symbol is defined to be an     */
/*       illegal token for the Visual C++ compiler so that a symtax error is  */
/*       reported when it is used.                                            */
/*                                                                            */
/******************************************************************************/

#if defined(__IBMC__)

   #define CARC_call_cobol        _System
   #define CARC_call_c            _Optlink
   #define CARC_call_pascal       _Pascal
   #define CARC_call_system       _System

   #define CARC_call_cobol_ptr  * CARC_call_cobol
   #define CARC_call_c_ptr      * CARC_call_c
   #define CARC_call_pascal_ptr * CARC_call_pascal
   #define CARC_call_system_ptr * CARC_call_system

   /* System is defined for ORUSER */
   #define ORUSER  CARC_call_system

   /* Flat pointer to a system routine is defined for ORUSERP */
   #define ORUSERP CARC_call_system_ptr

   /* System is defined for ORAPI */
   #define ORAPI   CARC_call_system

   /* Flat pointer is defined for ORPTR */
   #define ORPTR   *

#elif defined(_MSC_VER) && _MSC_VER >= 900

   #define CARC_export __declspec(dllexport)
   #define CARC_import __declspec(dllimport)

   #define CARC_call_cobol      __cdecl
   #define CARC_call_c          __cdecl
   #define CARC_call_pascal     __illegal
   #define CARC_call_system     __stdcall

   #define CARC_call_cobol_ptr  CARC_call_cobol *
   #define CARC_call_c_ptr      CARC_call_c *
   #define CARC_call_pascal_ptr CARC_call_pascal *
   #define CARC_call_system_ptr CARC_call_system *

   /* Stdcall is defined for ORUSER */
   #define ORUSER  __stdcall

   /* Pointer to a stdcall routine is defined for ORUSERP */
   #define ORUSERP __stdcall  *

   /* Stdcall is defined for ORAPI */
   #define ORAPI   __stdcall

   /* Flat pointer is defined for ORPTR */
   #define ORPTR   *

#endif

#if !defined (CARC_export)
   #define CARC_export
#endif

#if !defined (CARC_import)
   #define CARC_import
#endif

#if !defined (CARC_call_cobol)
   #define CARC_call_cobol
#endif

#if !defined (CARC_call_system)
   #define CARC_call_system
#endif

#if !defined (CARC_call_cobol_ptr)
   #define CARC_call_cobol_ptr *
#endif

#if !defined (CARC_call_system_ptr)
   #define CARC_call_system_ptr *
#endif

#if !defined (ORUSER)
   #define ORUSER
#endif

#if !defined (ORUSERP)
   #define ORUSERP *
#endif

#if !defined (ORAPI)
   #define ORAPI
#endif

#if !defined (ORPTR)
   #define ORPTR *
#endif

#if !defined (CARCARGBLK)
   #define CARCARGBLK unsigned long
   #define CARCGetParmCnt(argblk) ( (CARCARGBLK) (argblk) & 0x0000FFFF )
   #define CARCSetParmCnt(argblk, num) \
      ( (argblk) = ( (CARCARGBLK) (num) & 0x0000FFFF ) )
#endif

/* typedefs for REALIA_FIND... routines */
struct COBOLTIME
   {
   char cYear[4];
   char cMonth[2];
   char cDay[2];
   char cHour[2];
   char cMinute[2];
   char cSecond[2];
   char cHundredths[2];
   };

typedef struct COBOLTIME COBOLTIME;

#pragma pack(push,1)
struct COBOLFileSearch
   {
   unsigned long dwFileAttrs;
   unsigned long nFileSizeLow;
   unsigned long nFileSizeHigh;
   COBOLTIME ctCreationTime;
   COBOLTIME ctLastAccessTime;
   COBOLTIME ctLastWriteTime;
   char cFullFileName[260];
   };
#pragma pack (pop)

typedef struct COBOLFileSearch COBOLFileSearch;

#endif  /* _INC_CARCOR */
