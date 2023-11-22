*$PP-DEF HEADER NI EXTERNAL PROGRAM
*$PP-NOLIST HEADER NI
*$PP-RELATIVE-LINE-ADJ +000000003
 IDENTIFICATION DIVISION.
 PROGRAM-ID. BTRV EXTERNAL.
*
* Header File for CA-Realia calls to the BTRIEVE C language interface
* provided in BTRAPI.H
*
* This software is the property of
* Computer Associates International, Inc.
* and is protected by International Copyright law.
* Any unauthorized use or reproduction is prohibited.
*
* Copyright (c) 1992, 1997 Computer Associates International, Inc.
* All rights reserved.
*
 DATA DIVISION.
 LINKAGE SECTION.
 01  BTRV-OPERATION			   PIC S9(4) BINARY.
 01  BTRV-POS-BLOCK			   PIC X.
 01  BTRV-DATA-BUFFER			   PIC X.
 01  BTRV-DATA-BUFFER-LEN		   PIC S9(4) BINARY.
 01  BTRV-KEY-BUFFER			   PIC X.
 01  BTRV-KEY-NUMBER			   PIC S9(4) BINARY.
 01  BTRV-STATUS			   PIC S9(4) BINARY.
*
 PROCEDURE DIVISION.
     ENTRY 'S_BTRV' USING BY VALUE BTRV-OPERATION
			  BY REFERENCE BTRV-POS-BLOCK
			  BY REFERENCE BTRV-DATA-BUFFER
			  BY REFERENCE BTRV-DATA-BUFFER-LEN
			  BY REFERENCE BTRV-KEY-BUFFER
			  BY VALUE BTRV-KEY-NUMBER
			  RETURNING BTRV-STATUS.

 END PROGRAM BTRV.
*$PP-LIST HEADER
