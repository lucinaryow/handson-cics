      *$ascii,dialect-realia
      *%cicsca
      * Revision Information
      * ^{File:cint.cob    }
      * ^{Timestamp:Wed May 21 14:38:22 1997}
      * ^{Revision:8.0 }
      *
      * This software is the property of Computer Associates International, Inc.
      * and is protected by International Copyright law
      * Any unauthorized use or reproduction is prohibited
      *
      * Copyright (c) 1993, 1997 Computer Associates International, Inc.
      * All rights reserved
      *
      *    Description: CA-Realia CICS Rel 6.0
      *    This program MUST be compiled with the *$ASCII directive
      *
      *    This is the intialization routine
      *    It is invoked at the end of CICS Initialization
      *    It displays the greeting message and
      *    then begins the STARTID Transaction
      *
      *    This program may be modified by Licensed CA-Realia CICS users
      *    to control startup activity
      *
      *    This program is pseudo-conversational
      *
      *    It begins by sending out the startup screen
      *    If there is SIGNON required It is then verified
      *    If there is a START-ID ,then it RETURNS to that TRANSACTION
      *    If there is no START-ID then it clears the screen
      *
       IDENTIFICATION DIVISION.
       PROGRAM-ID. CINT.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *   mapset copy member
      *    CINTCOL and CINTBW are expected to be IDENTICAL except for
      *    color attributes so CINTCOLI/O are used for data areas labels
	   COPY CINTSET.
      *
	   COPY DFHBMSCA.
	   COPY DFHAID.
      *
      *     SIGNON error message text
      *
       01  MESSAGE-1 PIC X(35) VALUE 'Terminal is already signed on'.
       01  MESSAGE-2 PIC X(33) VALUE 'INVREQ attempting to SIGNON'.
       01  MESSAGE-3 PIC X(26) VALUE 'Password is required'.
       01  MESSAGE-4 PIC X(22) VALUE 'Invalid Password'.
       01  MESSAGE-5 PIC X(34) VALUE 'NOTAUTH attempting to SIGNON'.
       01  MESSAGE-6 PIC X(36) VALUE 'USERIDERR attempting to SIGNON'.
       01  MESSAGE-7 PIC X(28) VALUE 'ENTER TRANSID to begin'.
      *
      *    Error return codes
      *
       01  USAGE IS COMP.
	   05  WS-RESP				 PIC 9(8).
	   05  WS-RESP2 			 PIC 9(8).
      *
       01  WS-INITPARMLEN			 PIC S9(4) COMP.
       01  WS-START-PTR 			 PIC S9(4) COMP.
       01  WS-LOW-VALUE 			 PIC X VALUE LOW-VALUE.
      *
       01  INITPARM-AREA.
	   05  INITPARM-CHAR			 PIC X
						 OCCURS 0 TO 60
						 DEPENDING ON
						 WS-INITPARMLEN.
      *
       LINKAGE SECTION.
       01  DFHCOMMAREA.
	   05  SECURITY-SW			 PIC X.
	       88  SECURITY-NO			 VALUE LOW-VALUE.
	       88  SECURITY-YES 		 VALUE HIGH-VALUE.
	   05  USERID				 PIC X(8).
	   05  START-TRANID			 PIC X(4).
	   05  NONSTOP-WORD			 PIC X(7).
	       88  NON-STOP			 VALUE 'NONSTOP'.
	       88  MUST-WAIT			 VALUE SPACE.
	   05  VERSION-NO			 PIC X(10).
	   05  GMTEXT				 PIC X(79).
	   05  COLOR-SW 			 PIC X.
	       88  COLOR-YES			 VALUE HIGH-VALUE.
	       88  COLOR-NO			 VALUE LOW-VALUE.
	   05  CINTMAP				 PIC X(7).
      *
       PROCEDURE DIVISION.
      *
      *    check for valid DFHCOMMAREA size
      *
	   EVALUATE TRUE
	   WHEN (EIBCALEN NOT = LENGTH OF DFHCOMMAREA)
	       EXEC CICS GETMAIN
		   SET (ADDRESS OF DFHCOMMAREA)
		   INITIMG (WS-LOW-VALUE)
	       END-EXEC
	       GO TO SETUP-GOODMORNING
	   WHEN (EIBAID = DFHCLEAR)
	       GO TO SETUP-GOODMORNING
	   WHEN (SECURITY-YES AND USERID NOT = LOW-VALUE)
		 OR (SECURITY-NO)
	       GO TO INIT-START-TASK
	   WHEN OTHER
	       GO TO CHECK-SECURITY
	   END-EVALUATE
	   .
      *
       SETUP-GOODMORNING.
      *
      *    retrieve INITPARM to determine if there is START=transid
      *
	   EXEC CICS ASSIGN
      *    Note: These items are CA-CICS extensions to ASSIGN
	       VERSION (VERSION-NO)
	       GMTEXT (GMTEXT)
	       SECURITY (SECURITY-SW)
      *    Note: The above items are CA-CICS extensions to ASSIGN
	       INITPARMLEN (WS-INITPARMLEN)
	       INITPARM (INITPARM-AREA)
	       USERID(USERID)
	       COLOR (COLOR-SW)
	       NOHANDLE
	   END-EXEC
	   MOVE 1 TO WS-START-PTR
	   MOVE SPACE TO START-TRANID
	   IF WS-INITPARMLEN > 0
	       UNSTRING INITPARM-AREA
		   DELIMITED BY '=' OR ',' OR ALL SPACE
		   INTO START-TRANID
		   POINTER WS-START-PTR
	       IF WS-START-PTR < WS-INITPARMLEN
		   UNSTRING INITPARM-AREA
		       DELIMITED BY ',' OR ALL SPACE
		       INTO NONSTOP-WORD
		       POINTER WS-START-PTR
      *     convert to upper case
		   MOVE FUNCTION UPPER-CASE (NONSTOP-WORD)
		     TO NONSTOP-WORD
	       END-IF
	   END-IF
	   IF COLOR-NO
	       MOVE 'CINTBW' TO CINTMAP
	   ELSE
	       MOVE 'CINTCOL' TO CINTMAP
	   END-IF
	   IF (SECURITY-YES AND (USERID NOT = LOW-VALUE))
	   OR (SECURITY-NO)
	       MOVE DFHBMS-ASK-DARK TO SECLIT1A OF CINTCOLI
				       SECLIT2A OF CINTCOLI
				       USERIDA	OF CINTCOLI
				       PASSWRDA OF CINTCOLI
	       MOVE -1 TO SETCURL
	   ELSE
	       MOVE DFHBMS-ASK-DARK TO SECNOA OF CINTCOLI
	       MOVE -1 TO USERIDL
	       MOVE SPACE TO USERIDO PASSWRDO
	   END-IF
      *
      * 	Set up screen header
      *
	   MOVE VERSION-NO TO VERSIONO OF CINTCOLO
	   MOVE GMTEXT TO GMTEXTO OF CINTCOLO
      *
      *        don't send map if non-stop
      *
	   IF ((SECURITY-YES AND (USERID NOT = LOW-VALUE))
	       OR (SECURITY-NO))
	   AND (NONSTOP-WORD = 'NONSTOP')
      *
      *    don't show initial screen if not neccessary
      *
	       GO TO INIT-START-TASK
	   ELSE
	       EXEC CICS SEND MAP(CINTMAP)
		   MAPSET('CINTSET')
		   FROM (CINTCOLO)
		   FREEKB
		   FRSET
		   ERASE
		   CURSOR
	       END-EXEC
	       GO TO RESTART-TRANSACTION
	   END-IF
	   .
      *
       INIT-START-TASK.
	   IF START-TRANID NOT = SPACE
      *
      *        setup START transaction as needed
      *
      *        if the initparm included 'NONSTOP' then task
      *        is executed immediately
      *
	       EXEC CICS SEND CONTROL
		   ERASE
		   CURSOR (0)
		   FREEKB
	       END-EXEC
	       EXEC CICS RETURN
		   TRANSID (START-TRANID)
		   IMMEDIATE
	       END-EXEC
	   ELSE
	       GO TO CLEAR-SCREEN
	   END-IF
	   .
      *
       CLEAR-SCREEN.
      *
      *    Clears screen when all processing is done and there is no START-ID
      *
	   EXEC CICS SEND CONTROL
	       ERASE
	       CURSOR (0)
	       FREEKB
	   END-EXEC
	   EXEC CICS SEND
	       FROM (MESSAGE-7)
	   END-EXEC
	   EXEC CICS RETURN END-EXEC
	   .
      *
       CHECK-SECURITY.
	   EXEC CICS RECEIVE
	       MAP(CINTMAP)
	       MAPSET ('CINTSET')
	       RESP (WS-RESP)
	       INTO (CINTCOLI)
	   END-EXEC
	   IF WS-RESP = DFHRESP(MAPFAIL)
	       GO TO SETUP-GOODMORNING
	   END-IF
	   MOVE FUNCTION UPPER-CASE (PASSWRDI OF CINTCOLI)
	     TO PASSWRDI OF CINTCOLI
	   EXEC CICS SIGNON
	       USERID (USERIDI OF CINTCOLI)
	       PASSWORD (PASSWRDI OF CINTCOLI)
	       RESP (WS-RESP)
	       RESP2 (WS-RESP2)
	   END-EXEC
	   IF WS-RESP = DFHRESP(NORMAL)
	       MOVE LOW-VALUE TO ERRMSGO OF CINTCOLO
	       MOVE USERIDI OF CINTCOLI TO USERID
	       GO TO INIT-START-TASK
	   ELSE
	       MOVE LOW-VALUE TO USERID
	       MOVE SPACE TO USERIDO PASSWRDO
	       EVALUATE WS-RESP
	       WHEN DFHRESP(INVREQ)
		   IF WS-RESP2 = 9
		       MOVE MESSAGE-1 TO ERRMSGO OF CINTCOLO
		   ELSE
		       MOVE MESSAGE-2 TO ERRMSGO OF CINTCOLO
		   END-IF
	       WHEN DFHRESP(NOTAUTH)
		   EVALUATE WS-RESP2
		   WHEN 1
		       MOVE MESSAGE-3 TO ERRMSGO OF CINTCOLO
		   WHEN 2
		       MOVE MESSAGE-4 TO ERRMSGO OF CINTCOLO
		   WHEN OTHER
		       MOVE MESSAGE-5 TO ERRMSGO OF CINTCOLO
		   END-EVALUATE
	       WHEN OTHER
		   MOVE MESSAGE-6 TO ERRMSGO OF CINTCOLO
	       END-EVALUATE
	   END-IF
	   MOVE -1 TO ERRMSGL
	   EXEC CICS SEND MAP (CINTMAP)
	       MAPSET ('CINTSET')
	       FROM (CINTCOLO)
	       DATAONLY
	       FREEKB
	       FRSET
	       CURSOR
	   END-EXEC
	   GO TO RESTART-TRANSACTION
	   .
      *
       RESTART-TRANSACTION.
	   EXEC CICS RETURN
	       TRANSID	(EIBTRNID)
	       COMMAREA (DFHCOMMAREA)
	   END-EXEC
	   .
      *
