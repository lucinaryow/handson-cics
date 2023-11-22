       CBL XOPTS(COBOL2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SAMP00.
      * Revision Information
      * ^{File:samp00.cob  }
      * ^{Timestamp:Tue Apr 29 13:57:04 1997}
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
      *DESCRIPTION:Main menu program				       *
      ******************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.    IBM-PC.
       OBJECT-COMPUTER.    IBM-PC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-CURRENT-MAP  VALUE 'SAMM00'        PIC X(7).
       01  WS-TIME				 PIC 9(15) COMP-3.
      *
	   COPY SAMM00.
      *
	   COPY DFHAID.
      *
       LINKAGE SECTION.
       01  DFHCOMMAREA. 			 COPY SAMCOMM.
      *
       PROCEDURE DIVISION.
       100-PROCESS.
	   IF  LS-CURRENT-MAP NOT = WS-CURRENT-MAP
	       PERFORM 100-NEW-MAP
	   ELSE
	       EXEC CICS RECEIVE NOHANDLE END-EXEC
	       IF EIBRESP = DFHRESP(MAPFAIL)
		   PERFORM 100-NEW-MAP
	       ELSE
		   EVALUATE EIBAID
		       WHEN DFHCLEAR
			   PERFORM 100-NEW-MAP
		       WHEN DFHPF1
			   SET LS-LIST-PROG TO TRUE
		       WHEN DFHPF2
			   SET LS-MAINT-PROG TO TRUE
		       WHEN DFHPF3
			   EXEC CICS SEND CONTROL
			       ERASE
			   END-EXEC
			   EXEC CICS RETURN END-EXEC
		       WHEN DFHPF10
			   EXEC CICS RETURN
			       TRANSID('QUIT')
			       IMMEDIATE
			   END-EXEC
		       WHEN OTHER
			   EXEC CICS SEND CONTROL
				 ALARM
				 FREEKB
			   END-EXEC
		   END-EVALUATE
	       END-IF
	   END-IF
      *
      *    transfer control to next transaction
      *
	   MOVE LOW-VALUE TO LS-RIDFLD
	   IF LS-NEXT-PROG NOT = LS-LAST-PROG
	       MOVE LS-NEXT-PROG TO LS-LAST-PROG
	       EXEC CICS XCTL
		   PROGRAM(LS-NEXT-PROG)
		   COMMAREA(DFHCOMMAREA)
	       END-EXEC
	   ELSE
	       EXEC CICS RETURN
		   TRANSID(EIBTRNID)
		   COMMAREA(DFHCOMMAREA)
	       END-EXEC
	   END-IF
	   .
      *
       100-NEW-MAP.
	   MOVE WS-CURRENT-MAP TO LS-CURRENT-MAP
	   EXEC CICS ASKTIME
	       ABSTIME	(WS-TIME)
	   END-EXEC
	   EXEC CICS FORMATTIME
	       ABSTIME	(WS-TIME)
	       DATESEP	('-')
	       YYYYMMDD   (M00DATEO)
	   END-EXEC
	   EXEC CICS SEND MAP ('SAMM00')
		ERASE
	   END-EXEC
	   .
