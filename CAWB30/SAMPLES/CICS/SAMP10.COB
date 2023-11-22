       CBL XOPTS(COBOL2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SAMP10.
      * Revision Information
      * ^{File:samp10.cob  }
      * ^{Timestamp:Tue Apr 29 13:58:00 1997}
      * ^{Revision:5.0}
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
      *DESCRIPTION: This program displays a List		       *
      ******************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. 	 IBM-PC.
       OBJECT-COMPUTER. 	 IBM-PC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *
       01  WS-CURRENT-MAP   VALUE 'SAMM10'       PIC X(7).
       01  WS-TIME				 PIC 9(15) COMP-3.
       01  WS-COUNT				 PIC S9(4) COMP.
       01  WS-RESP				 PIC 9(8) COMP.
       01  WS-LOOP				 PIC 9(4) COMP.
       01  WS-ROWS				 PIC 9(4) COMP.
       01  DISP-RESP				 PIC 999.
	   COPY DFHBMSCA.
	   COPY DFHAID.
	   COPY SAMM10.
       LINKAGE SECTION.
       01  DFHCOMMAREA.  COPY SAMCOMM.
       01  NAMEFILE-REC. COPY NAMEFILE.
       PROCEDURE DIVISION.
       100-PROCESS.
	   EXEC CICS ASSIGN
	       DEFSCRNHT (WS-ROWS)
	   END-EXEC
	   SUBTRACT 7 FROM WS-ROWS
	   DIVIDE 2 INTO WS-ROWS GIVING WS-LOOP
	   IF LS-CURRENT-MAP NOT = WS-CURRENT-MAP
	       PERFORM 130-NEW-MAP
	   ELSE
	       EXEC CICS RECEIVE
		   MAP('SAMM10H')
		   MAPSET('SAMM10')
		   NOHANDLE
	       END-EXEC
	       IF EIBAID = DFHCLEAR
		   PERFORM 130-NEW-MAP
	       ELSE
		   PERFORM 110-EVALUATE
	       END-IF
	   END-IF
	   IF LS-NEXT-PROG = LS-LAST-PROG
	       EXEC CICS SEND
		   MAPSET('SAMM10')
		   MAP('SAMM10T')
		   ACCUM
	       END-EXEC
	       EXEC CICS SEND PAGE END-EXEC
	       EXEC CICS RETURN
		   TRANSID(EIBTRNID)
		   COMMAREA(DFHCOMMAREA)
	       END-EXEC
	   ELSE
	       MOVE LS-NEXT-PROG TO LS-LAST-PROG
	       EXEC CICS XCTL
		   PROGRAM(LS-NEXT-PROG)
		   COMMAREA(DFHCOMMAREA)
	       END-EXEC
	   END-IF
	   .
      *
       110-EVALUATE.
	   EVALUATE TRUE
	   WHEN (SHRTNMI NOT = DFHBMEOF AND SHRTNMI NOT = LOW-VALUE)
	       MOVE SHRTNMI TO LS-RIDFLD
	       SET LS-SHORTNAME TO TRUE
	   WHEN (FCODEI NOT = DFHBMEOF AND FCODEI NOT = LOW-VALUE)
	       EXEC CICS BIF DEEDIT FIELD(FCODEI) END-EXEC
	       MOVE FCODEI TO LS-RIDFLD
	       SET LS-NAMEFILE TO TRUE
	   END-EVALUATE
	   MOVE LOW-VALUE TO SHRTNMO FCODEO
	   EVALUATE EIBAID
	   WHEN DFHPF1
	       IF LS-ACTION = 'MAINT' OR 'FIND'
		   PERFORM 199-INVALID
	       ELSE
		   MOVE 'FIND' TO LS-ACTION
		   PERFORM 200-SETUP-FIND
	       END-IF
	   WHEN DFHPF2
	       IF LS-ACTION = 'FIND'
	       OR LS-ACTION = 'MAINT'
	       OR LS-ACTION = 'EOF'
		   PERFORM 199-INVALID
	       ELSE
		   MOVE SPACE TO LS-ACTION
		   MOVE LS-LAST-RIDFLD TO LS-RIDFLD
		   MOVE LS-LAST-CODE   TO LS-CODE
		   PERFORM 120-NEXT
	       END-IF
	   WHEN DFHPF3
	       IF LS-ACTION = 'FIND'
	       OR LS-ACTION = 'MAINT'
	       OR LS-ACTION = 'BOF'
		   PERFORM 199-INVALID
	       ELSE
		   MOVE 'PREV' TO LS-ACTION
		   MOVE LS-FIRST-RIDFLD TO LS-RIDFLD
		   MOVE LS-FIRST-CODE	TO LS-CODE
		   PERFORM 215-SET-BROWSE
		   PERFORM VARYING WS-COUNT FROM 1 BY 1
		       UNTIL WS-RESP NOT = DFHRESP(NORMAL)
			  OR WS-COUNT > WS-LOOP
		       EXEC CICS READPREV
			   FILE (LS-FILE)
			   SET (ADDRESS OF NAMEFILE-REC)
			   RIDFLD (LS-RIDFLD)
			   RESP (WS-RESP)
		       END-EXEC
		       PERFORM 300-IO-STATUS
		   END-PERFORM
		   IF WS-RESP = DFHRESP(NORMAL)
		   OR WS-RESP = DFHRESP(ENDFILE)
		       EXEC CICS READNEXT
			   FILE (LS-FILE)
			   SET (ADDRESS OF NAMEFILE-REC)
			   RIDFLD (LS-RIDFLD)
			   RESP (WS-RESP)
		       END-EXEC
		       PERFORM 300-IO-STATUS
		   END-IF
		   PERFORM 220-LIST
	       END-IF
	   WHEN DFHPF5
	       IF LS-ACTION = 'FIND'
	       OR LS-ACTION = 'MAINT'
		   PERFORM 199-INVALID
	       ELSE
		   MOVE 'MAINT' TO LS-ACTION
		   PERFORM 200-SETUP-FIND
	       END-IF
	   WHEN DFHPF9
	       IF LS-ACTION = 'FIND'
	       OR LS-ACTION = 'MAINT'
		   PERFORM 199-INVALID
	       ELSE
		   PERFORM 230-PRINT
	       END-IF
	   WHEN DFHPF10
	       IF LS-ACTION = 'FIND'
	       OR LS-ACTION = 'MAINT'
		   PERFORM 199-INVALID
	       ELSE
		   SET LS-MENU-PROG TO TRUE
	       END-IF
	   WHEN DFHPF24
	       IF LS-ACTION = 'FIND'
	       OR LS-ACTION = 'MAINT'
		   MOVE SPACE TO LS-ACTION
	       ELSE
		   PERFORM 199-INVALID
	       END-IF
	   WHEN DFHENTER
	       IF LS-ACTION = 'FIND'
		   PERFORM 210-FIND
	       ELSE
		   IF LS-ACTION = 'MAINT'
		       SET LS-MAINT-PROG TO TRUE
		   ELSE
		       PERFORM 199-INVALID
		   END-IF
	       END-IF
	   WHEN OTHER
	       PERFORM 199-INVALID
	   END-EVALUATE
	   .
      *
       120-NEXT.
	   MOVE SPACE TO LS-ACTION
	   PERFORM 215-SET-BROWSE
	   PERFORM 220-LIST
	   .
      *
       130-NEW-MAP.
	   MOVE LS-FIRST-RIDFLD TO LS-RIDFLD
	   MOVE LS-FIRST-CODE TO LS-CODE
	   PERFORM 120-NEXT
	   .
      *
       199-INVALID.
	   EXEC CICS SEND CONTROL
	       ALARM
	       FREEKB
	   END-EXEC
	   .
      *
       200-SETUP-FIND.
	   MOVE 'ENTER CODE'    TO PROMPTO
	   MOVE DFHUNNUM	TO FCODEA
	   MOVE SPACES		TO FCODEO
	   MOVE DFHREVRS	TO FCODEH
	   MOVE 'OR SHORT NAME' TO PROMPT2O
	   MOVE DFHBMUNP	TO SHRTNMA
	   MOVE SPACES		TO SHRTNMO
	   MOVE DFHREVRS	TO SHRTNMH
	   MOVE
	       'Enter code/short name and press enter - PF24 to Cancel'
		   TO MSGO
	   MOVE -1 TO SHRTNML
	   EXEC CICS SEND
		MAP ('SAMM10H')
		MAPSET ('SAMM10')
		CURSOR
		ACCUM
		ERASE
	   END-EXEC
	   .
      *
       210-FIND.
	   EXEC CICS READ
	       FILE(LS-FILE)
	       SET(ADDRESS OF NAMEFILE-REC)
	       RIDFLD(LS-RIDFLD)
	       GTEQ
	       RESP (WS-RESP)
	   END-EXEC
	   MOVE LS-RIDFLD TO LS-FIRST-RIDFLD LS-LAST-RIDFLD
	   IF WS-RESP = DFHRESP (NORMAL) OR DFHRESP (DUPKEY)
	       MOVE NAME-CODE TO LS-FIRST-CODE LS-CODE LS-LAST-CODE
	   ELSE
	       MOVE LOW-VALUE TO LS-FIRST-CODE LS-CODE LS-LAST-CODE
	   END-IF
	   PERFORM 300-IO-STATUS
	   PERFORM 120-NEXT
	   .
      *
      *    This sets up the file at the first record
      *    and skips forward for dupkey cases
      *
       215-SET-BROWSE.
	   EXEC CICS STARTBR
	       FILE(LS-FILE)
	       RIDFLD(LS-RIDFLD)
	       GTEQ
	       RESP (WS-RESP)
	   END-EXEC
	   PERFORM 300-IO-STATUS
	   IF WS-RESP = DFHRESP(NORMAL)
	       EXEC CICS READNEXT
		   FILE(LS-FILE)
		   RIDFLD(LS-RIDFLD)
		   SET(ADDRESS OF NAMEFILE-REC)
		   RESP(WS-RESP)
	       END-EXEC
	       IF  LS-CODE NOT = SPACE
	       AND LS-CODE NOT = LOW-VALUE
		   PERFORM
		       UNTIL NAME-CODE = LS-CODE
			  OR WS-RESP NOT = DFHRESP(DUPKEY)
		       EXEC CICS READNEXT
			   FILE(LS-FILE)
			   RIDFLD(LS-RIDFLD)
			   SET(ADDRESS OF NAMEFILE-REC)
			   RESP(WS-RESP)
		       END-EXEC
		   END-PERFORM
	       END-IF
	       PERFORM 300-IO-STATUS
	   END-IF
	   .
      *
       220-LIST.
	   MOVE WS-CURRENT-MAP	TO LS-CURRENT-MAP
	   EXEC CICS ASKTIME
	       ABSTIME	(WS-TIME)
	   END-EXEC
	   EXEC CICS FORMATTIME
	       ABSTIME(WS-TIME)
	       DATESEP('-')
	       YYYYMMDD(M10DATEO)
	   END-EXEC
	   EXEC CICS SEND
		MAP ('SAMM10H')
		MAPSET ('SAMM10')
		CURSOR
		ACCUM
		ERASE
	   END-EXEC
	   IF WS-RESP = DFHRESP (NORMAL)
	       MOVE LS-RIDFLD TO LS-FIRST-RIDFLD
	       MOVE NAME-CODE TO LS-FIRST-CODE
	       PERFORM 225-LIST WITH TEST AFTER
		   VARYING WS-COUNT FROM 1 BY 1
		   UNTIL WS-COUNT NOT < WS-LOOP
		      OR WS-RESP NOT = DFHRESP(NORMAL)
	       EXEC CICS ENDBR
		   FILE (LS-FILE)
		   NOHANDLE
	       END-EXEC
	   END-IF
	   .
      *
       225-LIST.
	   MOVE NAME-CODE    TO CCODEO LS-CODE LS-LAST-CODE
	   MOVE LS-RIDFLD TO LS-LAST-RIDFLD
	   MOVE NAME	     TO CNAMEO
	   MOVE CONTACT-NAME TO CONTCTO
	   MOVE PHONE	     TO PPHONEO
	   EXEC CICS SEND
	       MAP ('SAMM10D')
	       MAPSET ('SAMM10')
	       ACCUM
	   END-EXEC
	   EXEC CICS READNEXT
		FILE(LS-FILE)
		RIDFLD(LS-RIDFLD)
		SET(ADDRESS OF NAMEFILE-REC)
		RESP(WS-RESP)
	   END-EXEC
	   PERFORM 300-IO-STATUS
	   .
      *
       230-PRINT.
      ******************************************************************
      *    this routine is called to generate a printed listing of all *
      *    file data						       *
      ******************************************************************
	   SET LS-PRINT-ALL TO TRUE
	   EXEC CICS START
	       TRANSID('SAMP')
	       TERMID('P001')
	       FROM (DFHCOMMAREA)
	       NOHANDLE
	   END-EXEC
	   IF EIBRESP = DFHRESP(NORMAL)
	       MOVE 'Print request STARTed on P001' TO MSGO
	   ELSE
	       MOVE 'Print request could not be STARTed' TO MSGO
	   END-IF
	   .
      *
       300-IO-STATUS.
	   EVALUATE WS-RESP
	   WHEN DFHRESP(NORMAL)
	       CONTINUE
	   WHEN DFHRESP(DUPKEY)
	       MOVE DFHRESP(NORMAL) TO WS-RESP
	   WHEN DFHRESP(NOTFND)
	       MOVE 'No record found' TO MSGO
	   WHEN DFHRESP(ENDFILE)
	       IF  LS-ACTION = 'PREV'
	       OR  LS-ACTION = 'BOF'
		   MOVE 'BOF' TO LS-ACTION
		   MOVE 'Begining of file reached' TO MSGO
	       ELSE
		   MOVE 'EOF' TO LS-ACTION
		   MOVE 'End of file reached' TO MSGO
	       END-IF
	   WHEN OTHER
	       ADD 0 WS-RESP GIVING DISP-RESP
	       STRING 'Unknown IO error on FILE - ' DELIMITED BY SIZE
		      EIBDS			    DELIMITED BY SPACE
		      ' WS-RESP=' DISP-RESP         DELIMITED BY SIZE
		   INTO MSGO
	   END-EVALUATE
	   .
