/****************************************************************************/
/*                                                                          */
/* This material is confidential to Computer Associates International, Inc. */
/* Copyright (c) 1996 Computer Associates International, Inc.               */
/* All rights reserved.                                                     */
/*                                                                          */
/* CARCRUNN.C Version 1.00 (for Windows NT/95)                              */
/* 17 Jul 1996,  8:30 (RCR)                                                 */
/*                                                                          */
/* This source file defines the run unit name assigned to a COBOL           */
/* executable or dynamic load library.  The CA-Realia COBOL system ships    */
/* with a default run unit name of "CARC.RUP".  To specify a different run  */
/* unit name, do the following:                                             */
/*                                                                          */
/* 1.  Make a copy of this source file.                                     */
/* 2.  Edit the last line to change "CARC.RUP" to a different name.  The    */
/*     name must consist of 8 or fewer characters.                          */
/* 3.  Compile this source, generating an object file.                      */
/* 4.  Include the generated object file with the link step for any COBOL   */
/*     executable or library for which the run unit name is desired.        */
/*                                                                          */
/* You may use different run unit names to force programs to be partitioned */
/* into multiple run units.  See the chapter "Mixed-language Programming"   */
/* in the COBOL User Guide for more details.                                */
/*                                                                          */
/****************************************************************************/


/*                                                                          */
/* A run unit name is a 12 byte structure, aligned on a 4 byte boundary.    */
/* The first 8 bytes specify the run unit name, which is can be from 1 to   */
/* 8 characters.  If the run unit name is less than 8 characters, the       */
/* remaining characters must be '\0'  The last 4 bytes of the structure     */
/* must always be zero.                                                     */
/*                                                                          */
typedef union RunUnitName {
   char           chaExternalName[9];
   unsigned long  ulaInternalRep[3];
   } RR_RUN;


const RR_RUN CARC__RunUnitName = { "CARC.RUP"};
