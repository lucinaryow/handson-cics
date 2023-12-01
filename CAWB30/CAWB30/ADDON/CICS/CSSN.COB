       CBL XOPTS(COBOL2)
      *$ASCII,dialect-realia
      *%cicsca
       IDENTIFICATION DIVISION.
      *
      * ^{File:cssn.cob}
      * ^{Timestamp:Fri May 16 07:31:10 1997}
      * ^{Revision:2.0}
      *
      * This software is the property of Computer Associates International, Inc.
      * and is protected by International Copyright law
      * Any unauthorized use or reproduction is prohibited
      *
      * Copyright (c) 1986, 1997 Computer Associates International, Inc.
      * All rights reserved
      *
      ******************************************************************
      *DESCRIPTION:CSSN/CSSF signon/signoff    transaction.	       *
      ******************************************************************
       PROGRAM-ID. CSSN.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *
       01  WS-SUB				 PIC S9(4) COMP.
       01  WS-SUB1				 PIC S9(4) COMP.
       01  WS-SIZE				 PIC S9(4) COMP.
      *
       01  WS-TEXT.
	   05  WS-CHAR				 PIC X OCCURS 0 TO 255
						 DEPENDING ON WS-SIZE.
      *
       01  MESS.
	   05  MESS-TEXT			 PIC X(50).
      *
	   COPY DFHBMSCA.
      *
	   COPY CSSNSET.
      *
       01  SECURITY-DATA.
      *
      *    This is a copy of entry from SNT table
      *    The data values are in ASCII operating value
      *
	   05  OPNAME				 PIC X(20).
	   05  PASSWRD				 PIC X(8).
	   05  USERID				 PIC X(8).
      *
       LINKAGE SECTION.
      *
       01  DFHCOMMAREA				 PIC X(255).
      *
       01  RECVSET.
	   05  RECV-CHAR			 PIC X
						 OCCURS 0 TO 2000
						 DEPENDING ON WS-SIZE.
      *
       PROCEDURE DIVISION.
      *
       000-MAINLINE.
      *
	   IF  EIBCALEN > ZERO
	       MOVE EIBCALEN TO WS-SIZE
	       MOVE DFHCOMMAREA TO WS-TEXT
	   ELSE
	       MOVE 0 TO WS-SIZE
	       EXEC CICS RECEIVE
		   SET(ADDRESS OF RECVSET)
		   LENGTH(WS-SIZE)
	       END-EXEC
	       IF WS-SIZE > 0
		   MOVE 0 TO WS-SUB
		   PERFORM VARYING WS-SUB1 FROM 1 BY 1
		       UNTIL WS-SUB > 100
			   OR WS-SUB1 > WS-SIZE
		       IF RECV-CHAR (WS-SUB1) = DFHSBA
			   ADD 2 TO WS-SUB1
		       ELSE
			   ADD 1 TO WS-SUB
			   MOVE RECV-CHAR (WS-SUB1) TO WS-CHAR (WS-SUB)
		       END-IF
		   END-PERFORM
		   MOVE WS-SUB TO WS-SIZE
	       END-IF
	   END-IF
      *
	   IF WS-SIZE > 0
	       MOVE FUNCTION UPPER-CASE (WS-TEXT) TO WS-TEXT
	   END-IF
      *
	   IF EIBTRNID = 'CSSF'
	       GO TO 100-CSSF
	   ELSE
	       GO TO 200-CSSN
	   END-IF.
      *
       100-CSSF.
      ***********************
      *    SIGN-OFF PROCESSES
      ************************
	   STRING 'CA-Realia CICS User is signed-off'
	       DELIMITED BY SIZE INTO MESS-TEXT
	   PERFORM 300-SEND
	   IF WS-SIZE > 0
	       MOVE 0 TO WS-SUB
	       INSPECT WS-TEXT TALLYING
		    WS-SUB FOR ALL 'GOODNITE'
		    WS-SUB FOR ALL 'GOODNIGHT'
		    WS-SUB FOR ALL 'BON SOIR'
	       IF WS-SUB > 0
		   EXEC CICS RETURN
		       TRANSID(HIGH-VALUE)
		   END-EXEC
	       END-IF
	   END-IF
      *
      *    This will logout user from system
      *
	   exec cics signoff end-exec
	   EXEC CICS RETURN END-EXEC.
      *
       200-CSSN.
      ***************************
      *    CSSN PROCESSING
      ***************************
	   IF  WS-SIZE > ZERO
	       MOVE 0 TO WS-SUB
	       INSPECT WS-TEXT TALLYING WS-SUB
		   FOR CHARACTERS BEFORE INITIAL 'PS '
	       IF WS-SUB < WS-SIZE
		   ADD 3 TO WS-SUB
	       ELSE
		   MOVE 0 TO WS-SUB
		   INSPECT WS-TEXT TALLYING WS-SUB
		       FOR CHARACTERS BEFORE INITIAL 'PS='
		   IF WS-SUB < WS-SIZE
		       ADD 3 TO WS-SUB
		   ELSE
		       MOVE 0 TO WS-SUB
		       INSPECT WS-TEXT TALLYING WS-SUB
			   FOR CHARACTERS BEFORE INITIAL 'PASSWORD='
		       IF WS-SUB < WS-SIZE
			   ADD 10 TO WS-SUB
		       END-IF
		   END-IF
	       END-IF
	       IF WS-SUB < WS-SIZE
		   UNSTRING WS-TEXT
		       DELIMITED BY SPACE OR 'NAME ' OR 'NAME='
			   OR ',' OR ';'
		      INTO PASSWRD WITH POINTER WS-SUB
	       END-IF
	       MOVE 0 TO WS-SUB
	       INSPECT WS-TEXT TALLYING
		   WS-SUB FOR CHARACTERS BEFORE INITIAL 'NAME '
	       IF WS-SUB < WS-SIZE
		   ADD 6 TO WS-SUB
	       ELSE
		   MOVE 0 TO WS-SUB
		   INSPECT WS-TEXT TALLYING
		       WS-SUB FOR CHARACTERS BEFORE INITIAL 'NAME='
		   IF WS-SUB < WS-SIZE
		       ADD 6 TO WS-SUB
		   END-IF
	       END-IF
	       IF WS-SUB < WS-SIZE
		   UNSTRING WS-TEXT
		       DELIMITED BY ',' OR ';' OR 'PS ' OR 'PS='
			   OR 'PASSWORD='
		      INTO OPNAME WITH POINTER WS-SUB
	       END-IF
	   END-IF
	   exec cics signon
	       userid(userid)
	       password(passwrd)
	       nohandle
	   end-exec
	   IF eibresp = dfhresp(normal)
	       STRING 'CA-Realia CICS User is signed on'
		  DELIMITED BY SIZE
		  INTO MESS-TEXT
	       PERFORM 300-SEND
	       EXEC CICS RETURN END-EXEC
	   ELSE
	       MOVE EIBTRNID TO TRNIDO
	       EXEC CICS SEND MAP('CSSNSET')
		   ERASE
		   FREEKB
	       END-EXEC
	       EXEC CICS RETURN TRANSID (EIBTRNID) END-EXEC
	   END-IF.
      *
       300-SEND.
	   MOVE 0 TO WS-SIZE
	   INSPECT MESS-TEXT
	       TALLYING WS-SIZE
	       FOR CHARACTERS BEFORE INITIAL LOW-VALUE
	   IF WS-SIZE > 0
	       EXEC CICS SEND
		   FROM   (MESS)
		   LENGTH (WS-SIZE)
		   ERASE
	      END-EXEC
	   END-IF
	   MOVE LOW-VALUE TO MESS-TEXT.
      *
