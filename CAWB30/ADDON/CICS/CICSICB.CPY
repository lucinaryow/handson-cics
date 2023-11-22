      * Revision Information
      * ^{File:cicsicb.cpy }
      * ^{Timestamp:Tue Sep 24 14:11:46 1996}
      * ^{Revision:5.0 }
      *
      * This software is the property of
      *     Computer Associates International, Inc.
      * and is protected by International Copyright law.
      * Any unauthorized use or reproduction is prohibited.
      *
      * Copyright (c) 1984, 1996 Computer Associates International, Inc.
      * All rights reserved.
      *
      *    This is the CA-Realia CICS 6.0
      *    Interface Control Block (ICB).
      *    This COPY file is used by all internal
      *    programs using the CICS runtime interface.
      *
	   05  DFH-ICB-SIZE			 PIC S9(9) binary.
	   05  DFH-MODULE-INFO.
	       10  DFH-VERSION			 PIC S9(4) COMP-4.
		   88  DFH-CURVER		 VALUE 6001.
		   88  DFH-VALIDVER		 VALUE 6001.
	       10  DFH-MODULE-ID		 PIC X(8).
	       10  DFH-CODESET			 PIC X VALUE 'A'.
		   88  DFH-CODESET-INIT 	 VALUE 'A'.
		   88  DFH-ASCII		 VALUE X'41'.
		   88  DFH-EBCDIC		 VALUE X'C1'.
	       10  DFH-CODE-TYPE		 PIC X VALUE 'V'.
		   88  DFH-VSCOBOL		 VALUE 'V' X'E5' X'56'.
		   88  DFH-COBOL2		 VALUE '2' X'F2' X'32'.
		   88  DFH-370ASM		 VALUE 'A' X'C1' X'41'.
      *        run class specified with preprocessor
	       10  DFH-CICSTYPE 		 PIC S9(4) COMP-4.
		   88  DFH-STD-COMPAT		 VALUE 1 0.
		   88  DFH-VR-COMPAT		 VALUE 2.
		   88  DFH-BCH-COMPAT		 VALUE 3.
		   88  DFH-VT-COMPAT		 VALUE 4.
      *        Level number specified with preprocessor
	       10  DFH-LEVEL			 PIC S9(4) COMP-4.
		   88  DFH-1-6-COMPAT		 VALUE 2.
		   88  DFH-2-1-COMPAT		 VALUE 3.
		   88  DFH-3-3-COMPAT		 VALUE 4.
		   88  DFH-4-1-COMPAT		 VALUE 5.
		   88  DFH-SP-COMPAT		 VALUE 10.
		   88  DFH-CA-COMPAT		 VALUE 99.
	   05  DFH-COMMAND			 PIC XX.
	       COPY CMDCONST.
	   05  DFH-DEBUG-DATA.
	       10  DFH-SOURCE-NAME		 PIC X(8).
	       10  DFH-SOURCE-LINE-NUM		 PIC  9(6) COMP-4.
	   05  DFH-RESULT-STATUS		 PIC S9(4) COMP-4.
	       *> positive value is the goto number
	       88  DFH-OK			 VALUE 0.
	       88  DFH-IGNORED			 VALUE 0.
	       88  DFH-DEFAULT			 VALUE -1.
	       88  DFH-GOBACK			 VALUE -2.
	       88  DFH-RETURN			 VALUE -3.
	       88  DFH-XCTL			 VALUE -4.
	       88  DFH-ABEND-LINK		 VALUE -5.
	       88  DFH-ABEND			 VALUE -6 -5.
	       88  DFH-EXIT-MODULE		 VALUE -2 THRU -10.
	       88  DFH-FATAL-ERROR		 VALUE -10.
	   05  DFH-RESERVED			 PIC X(512).
      *        The contents of DFH-RESERVED are CA confidential
      *        and subject to change without notice or support.
      *        DO NOT MODIFY ANY VARIABLES IN DFH-RESERVED.
	   05  REDEFINES DFH-RESERVED.
	       10  DFH-RESP			 PIC S9(8) COMP-4.
	       10  DFH-RESP2			 PIC S9(8) COMP-4.
	       10  DFH-WORK-L			 PIC S9(9) BINARY.
	       10  DFH-WORK-LU			 PIC 9(9) BINARY.
	       10  DFH-WORK-S REDEFINES DFH-WORK-L PIC S9(4) BINARY.
	       10  DFH-WORK-US REDEFINES DFH-WORK-L PIC 9(4) BINARY.
	       10  DFH-PCB			 POINTER.
	       *> see dfhconst COPY file for valid DFH-VAR-NUM values
	       *> DFH-VAR-NUM is an internal work field pointer
	       10  DFH-VAR-NUM			 PIC S9(4) binary.
	       *> modified by BMS processing routines
	       10  DFH-AID-NUMBER		 PIC S9(4) BINARY.
		   COPY AIDNUM.
	       *> This is used for SET FILE command
	       10  DFH-VAR-DSNAME		 PIC X(256).
	       10  REDEFINES DFH-VAR-DSNAME.
	       *> These fields are to support ASSIGN fields larger
	       *> than 8 bytes
		   15  DFH-VAR-INITPARM 	 PIC X(60).
		   15  DFH-VAR-GMTEXT		 PIC X(79).
		   15  DFH-VAR-COMPANY		 PIC X(55).
	       10  REDEFINES DFH-VAR-DSNAME.
	       *> These fields are to support QUERY SECURITY
		   15  DFH-VAR-RESID		 PIC X(12).
		   15  DFH-VAR-RESTYPE		 PIC X(12).
	       10  REDEFINES DFH-VAR-DSNAME.
	       *> These fields are to support FORMAT TIME
		   15  DFH-VAR-YYYYMMDD 	 PIC X(10).
		   15  DFH-VAR-YYYYDDMM 	 PIC X(10).
		   15  DFH-VAR-DDMMYYYY 	 PIC X(10).
		   15  DFH-VAR-MMDDYYYY 	 PIC X(10).
	   05  DFH-VARS-SIZE			 PIC S9(4) COMP-4.
	   05  DFH-VARS-MAX			 PIC S9(4) COMP-4.
	   05  DFH-VARS.
	       10  DFH-VAR			 OCCURS 1 TO 24
						 DEPENDING ON
						 DFH-VARS-MAX.
	       15  DFH-FLAG			 PIC S9(4) COMP-4.
		   COPY FLGCONST.
	       15  DFH-DATA-TYPE		 PIC X.
		   COPY DATATYPE.
	       15  DFH-DATA-CLASS		 PIC X.
		   COPY DATACLAS.
	       15  DFH-DEBUG			 POINTER.
	       15  DFH-ADDR			 POINTER.
	       15  DFH-SIZE			 PIC S9(9) COMP-4.
	       15  DFH-DATA			 PIC X(8).
	       15  DFH-DATA1  REDEFINES DFH-DATA PIC X(1).
	       15  DFH-DATA2  REDEFINES DFH-DATA PIC X(2).
	       15  DFH-DATA4  REDEFINES DFH-DATA PIC X(4).
	       15  DFH-DATA7  REDEFINES DFH-DATA PIC X(7).
	       15  DFH-DATA8  REDEFINES DFH-DATA PIC X(8).
	       15  DFH-DATAF  REDEFINES DFH-DATA PIC S9(9) COMP-4.
	       15  DFH-DATAH  REDEFINES DFH-DATA PIC S9(4) COMP-4.
	       15  DFH-DATAHU REDEFINES DFH-DATA PIC  9(4) COMP-4.
	       15  DFH-LABEL  REDEFINES DFH-DATA PIC S9(4) COMP-4.
	       15  DFH-DATAP  REDEFINES DFH-DATA PIC S9(6) COMP-3.
	       15  DFH-DATAT  REDEFINES DFH-DATA PIC S9(15) COMP-3.
