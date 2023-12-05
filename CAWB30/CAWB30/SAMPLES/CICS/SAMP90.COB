       CBL XOPTS(COBOL2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SAMP90.
      * Revision Information
      * ^{File:samp90.cob  }
      * ^{Timestamp:Tue Apr 29 13:55:54 1997}
      * ^{Revision:4.0}
      *
      * CA-Realia CICS Version 6.0
      *
      * This software is the property of Computer Associates International, Inc.
      * and is protected by International Copyright law
      * Any unauthorized use or reproduction is prohibited
      *
      * Copyright (c) 1984, 1997 Computer Associates International, Inc.
      *
      * This software is provided by Computer Associates
      * as an example of a CICS application program.
      * It should not be considered complete or correct.					       *
      *
      ******************************************************************
      *DESCRIPITON:Task dispatch program			       *
      ******************************************************************
       DATA DIVISION.
       LINKAGE SECTION.
       01  DFHCOMMAREA.      COPY SAMCOMM.
      *
       PROCEDURE DIVISION.
       000-PROCESS.
	   IF LENGTH OF DFHCOMMAREA NOT = EIBCALEN
      *
      *    If this is first time then setup DFHCOMMAREA
      *
	       EXEC CICS GETMAIN
		   LENGTH (LENGTH OF DFHCOMMAREA)
		   SET (ADDRESS OF DFHCOMMAREA)
	       END-EXEC
	       MOVE LOW-VALUE TO DFHCOMMAREA
	       SET LS-MENU-PROG TO TRUE
	   END-IF
	   MOVE LS-NEXT-PROG TO LS-LAST-PROG
	   IF NOT LS-NAMEFILE
	       SET LS-SHORTNAME TO TRUE
	   END-IF
	   EXEC CICS XCTL
		PROGRAM  (LS-NEXT-PROG)
		COMMAREA (DFHCOMMAREA)
	   END-EXEC.
