       CBL XOPTS(COBOL2)
      *%cicsca
       IDENTIFICATION DIVISION.
      *
      *^{File:cmap.cob}
      *^{Timestamp:Fri May 16 07:31:00 1997}
      *^{Revision:2.0}
      *
      * This software is the property of Computer Associates International, Inc.
      * and is protected by International Copyright law
      * Any unauthorized use or reproduction is prohibited
      *
      * Copyright (c) 1986, 1997 Computer Associates International, Inc.
      * All rights reserved
      *
       PROGRAM-ID. CMAP.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      ******************************************************************
      *DESCRIPTION:This program displays mapsets.		       *
      ******************************************************************
      *
	   COPY CMAPSET.
      *
       01  WS-RESP				 PIC 9999.
       01  WS-LENGTH				 PIC S9(4) COMP.
       01  CMAP-MESSAGE 			 PIC X(46) VALUE
	   ' CMAP complete. Enter new TRANSID to continue.'.
       01  WS-RECORD.
	   05  WS-ACTION			 PIC X.
	       88  WS-GET-MAP			 VALUE 'G'.
	       88  WS-READ-MAP			 VALUE 'R'.
	   05  WS-MAPSET			 PIC X(7).
	   05  WS-MAPNAME			 PIC X(8).
      *
       LINKAGE SECTION.
      *
       01  DFHCOMMAREA				 PIC X(16).
      *
       01  LS-MAP-AREA				 PIC X(4095).
      *
       PROCEDURE DIVISION.
      *
       100-MAINLINE.
	   IF EIBCALEN NOT = 16
	       MOVE LOW-VALUE TO WS-RECORD
	       GO TO 200-SEND-MAP
	   ELSE
	       MOVE DFHCOMMAREA TO WS-RECORD
	       IF WS-GET-MAP
		   GO TO 300-SET-MAP
	       ELSE
		   GO TO 400-READ-MAP
	       END-IF
	   END-IF.
      *
       050-EXIT.
	   EXEC CICS SEND
	       FROM(CMAP-MESSAGE)
	       LENGTH(LENGTH OF CMAP-MESSAGE)
	       ERASE
	   END-EXEC
	   EXEC CICS SEND CONTROL
	       FREEKB
	   END-EXEC
	   EXEC CICS RETURN END-EXEC.
      *
       100-EXIT.
	   EXEC CICS RETURN
	       TRANSID(EIBTRNID)
	       COMMAREA(WS-RECORD)
	       LENGTH(LENGTH OF WS-RECORD)
	   END-EXEC.
      *
       200-SEND-MAP.
	   MOVE WS-MAPSET TO MAPSETO
	   MOVE WS-MAPNAME TO MAPNAMEO
	   EXEC CICS
	       SEND MAP('CMAPSET')
	       ERASE
	       FREEKB
	   END-EXEC
	   SET WS-GET-MAP TO TRUE
	   GO TO 100-EXIT.
      *
       300-SET-MAP.
	   EXEC CICS HANDLE AID
	       ENTER(310-COMMENCE-MAPPING)
	       PF1(050-EXIT)
	       CLEAR(200-SEND-MAP)
	       ANYKEY(310-COMMENCE-MAPPING)
	   END-EXEC
	   EXEC CICS
	       RECEIVE MAP('CMAPSET')
	   END-EXEC.
      *
       310-COMMENCE-MAPPING.
	   EXEC CICS HANDLE ABEND
	       LABEL(320-NOMAPSET)
	   END-EXEC
	   IF MAPNAMEI = SPACE OR LOW-VALUE
	       MOVE MAPSETI TO MAPNAMEI
	   END-IF
	   EXEC CICS LOAD
	       PROGRAM(MAPSETI)
	   END-EXEC
	   EXEC CICS HANDLE ABEND
	       LABEL(330-NOMAP)
	   END-EXEC
	   EXEC CICS
	       SEND MAP(MAPNAMEI)
	       MAPSET(MAPSETI)
	       MAPONLY
	       FREEKB
	       ERASE
	   END-EXEC.
	   MOVE MAPSETI TO WS-MAPSET
	   MOVE MAPNAMEI TO WS-MAPNAME
	   SET WS-READ-MAP TO TRUE
	   GO TO 100-EXIT.
      *
       320-NOMAPSET.
	   EXEC CICS HANDLE ABEND RESET  END-EXEC
	   EXEC CICS HANDLE ABEND CANCEL END-EXEC
	   MOVE 'Invalid MAPSET Name' TO MAPMSGO
	   GO TO 200-SEND-MAP.
      *
       330-NOMAP.
	   MOVE 'Invalid MAP Name' TO MAPMSGO
	   GO TO 200-SEND-MAP.
      *
       400-READ-MAP.
	   EXEC CICS HANDLE AID
	       ENTER(410-CONTINUE-MAPPING)
	       PF1(200-SEND-MAP)
	       CLEAR(200-SEND-MAP)
	       ANYKEY(410-CONTINUE-MAPPING)
	   END-EXEC
	   EXEC CICS HANDLE CONDITION
	       MAPFAIL (410-CONTINUE-MAPPING)
	   END-EXEC
	   EXEC CICS
	       RECEIVE MAP(WS-MAPNAME)
	       MAPSET(WS-MAPSET)
	       SET(ADDRESS OF LS-MAP-AREA)
	   END-EXEC.
      *
       410-CONTINUE-MAPPING.
	   EXEC CICS
	       SEND MAP(WS-MAPNAME)
	       MAPSET(WS-MAPSET)
	       FROM(LS-MAP-AREA)
	       DATAONLY
	       FREEKB
	   END-EXEC
	   GO TO 100-EXIT.
      *
