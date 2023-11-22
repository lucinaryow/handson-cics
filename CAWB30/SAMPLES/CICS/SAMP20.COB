       CBL XOPTS(COBOL2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SAMP20.
      * Revision Information
      * ^{File:samp20.cob  }
      * ^{Timestamp:Thu May 08 09:18:04 1997}
      * ^{Revision:6.0}
      *
      * CA-Realia CICS Version 6.0
      *
      * This software is the property of Computer Associates International, Inc.
      * and is protected by International Copyright law
      * Any unauthorized use or reproduction is prohibited
      *
      * Copyright (c) 1984, 1997 Computer Associates International, Inc.
      *
      * This program is provided by Computer Associates
      * as an example of a CICS application program.
      * It should not be considered complete or correct.					       *
      *
      ******************************************************************
      *DESCRIPTION:name maintenance				       *
      ******************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. 	 IBM-PC.
       OBJECT-COMPUTER. 	 IBM-PC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-CURRENT-MAP  VALUE 'SAMM20'        PIC X(7).
       01  WS-TIME				 PIC 9(15) COMP-3.
       01  NAMEFILE-REC. COPY NAMEFILE.
	   COPY SAMM20.
	   COPY DFHBMSCA.
	   COPY DFHAID.
      *
       LINKAGE SECTION.
       01  DFHCOMMAREA. 			 COPY SAMCOMM.
       PROCEDURE DIVISION.
       000-PROCESS.
	   MOVE SPACE TO MSGO
	   EXEC CICS HANDLE CONDITION
		DUPREC(9040-DUPREC)
		ENDFILE(9050-ENDFILE)
		NOTFND(9060-NOTFND)
		DUPKEY(9082-DUPKEY)
	   END-EXEC
	   EXEC CICS IGNORE CONDITION
	       MAPFAIL
	   END-EXEC
	   IF  LS-CURRENT-MAP NOT = WS-CURRENT-MAP
	       GO TO 9030-NEW-MAP
	   ELSE
	       GO TO 050-RECEIVE
	   END-IF
	   .
      *
       050-RECEIVE.
	   EXEC CICS HANDLE AID
	       ANYKEY(9000-INVALID-ACTION)
	   END-EXEC
	   EVALUATE LS-ACTION
	   WHEN 'ADD'
	       EXEC CICS HANDLE AID
		   ENTER(2000-FILE-ADD)
		   CLEAR(1024-CANCEL)
		   PF24(1024-CANCEL)
	       END-EXEC
	   WHEN 'CHANGE'
	       EXEC CICS HANDLE AID
		   ENTER(2010-FILE-CHANGE)
		   CLEAR(1024-CANCEL)
		   PF24(1024-CANCEL)
	       END-EXEC
	   WHEN 'DELETE'
	       EXEC CICS HANDLE AID
		   ENTER(2020-FILE-DELETE)
		   CLEAR(1024-CANCEL)
		   PF24(1024-CANCEL)
	       END-EXEC
	   WHEN 'FIND'
	       EXEC CICS HANDLE AID
		   ENTER(2030-FILE-FIND)
		   CLEAR(9030-NEW-MAP)
		   PF24(9030-NEW-MAP)
	       END-EXEC
	   WHEN OTHER
	       EXEC CICS HANDLE AID
		   ANYKEY(9000-INVALID-ACTION)
		   CLEAR(9030-NEW-MAP)
		   PF1(1001-FIND)
		   PF2(1002-NEXT)
		   PF3(1003-PREV)
		   PF4(1004-CHANGE)
		   PF5(1005-ADD)
		   PF6(1006-DELETE)
		   PF9(1009-PRINT-NAME)
		   PF10(1010-RETURN-TO-MENU)
	       END-EXEC
	       EVALUATE LS-ACTION
	       WHEN 'BOF'
		   EXEC CICS HANDLE AID
		       PF3(9000-INVALID-ACTION)
		   END-EXEC
	       WHEN 'EOF'
		   EXEC CICS HANDLE AID
		       PF2(9000-INVALID-ACTION)
		   END-EXEC
	       END-EVALUATE
	   END-EVALUATE
	   EXEC CICS RECEIVE
	       MAP('SAMM20')
	       MAPSET ('SAMM20')
	   END-EXEC
	   GO TO 9000-INVALID-ACTION
	   .
      *
       1001-FIND.
	   MOVE 'FIND'   TO LS-ACTION
	   MOVE DFHUNNUM TO CCODEA
	   MOVE DFHBMFSE TO SHRTNMA
	   MOVE SPACES	 TO CCODEO SHRTNMO
	   MOVE DFHREVRS TO CCODEH SHRTNMH
	   MOVE 'Enter code or short name and press ENTER key'
	     TO MSGO
	   MOVE -1 TO SHRTNML
	   GO TO 9120-SEND-DATA-ONLY
	   .
      *
       1002-NEXT.
	   EXEC CICS IGNORE CONDITION
	       DUPKEY
	   END-EXEC
	   PERFORM 9080-STARTBR THRU 9080-EXIT
      * display second record
	   EXEC CICS READNEXT
	       FILE (LS-FILE)
	       INTO(NAMEFILE-REC)
	       RIDFLD (LS-RIDFLD)
	   END-EXEC
	   GO TO 9090-SHOW-RECORD
	   .
      *
       1003-PREV.
	   EXEC CICS IGNORE CONDITION
	       DUPKEY
	   END-EXEC
	   PERFORM 9080-STARTBR THRU 9080-EXIT
	   PERFORM 2 TIMES
	       EXEC CICS READPREV
		   FILE (LS-FILE)
		   INTO(NAMEFILE-REC)
		   RIDFLD (LS-RIDFLD)
	       END-EXEC
	       MOVE NAME-CODE TO LS-CODE
	   END-PERFORM
	   GO TO 9090-SHOW-RECORD
	   .
      *
       1004-CHANGE.
	   MOVE 'CHANGE' TO LS-ACTION
	   PERFORM 9100-UNPROTECT
	   MOVE 'Change data and press enter - PF24 to cancel'
	     TO MSGO
	   MOVE -1 TO SHRTNML
	   GO TO 9120-SEND-DATA-ONLY
	   .
      *
       1005-ADD.
	   MOVE 'ADD' TO LS-ACTION
	   PERFORM 9100-UNPROTECT
	   MOVE DFHUNNUM TO CCODEA
	   MOVE DFHREVRS TO CCODEH
	   MOVE SPACE TO CCODEO
			 SHRTNMO
			 CNAMEO
			 PCONTCTO
			 PPHONEO
			 PFAXO
			 ADDR1O
			 ADDR2O
			 ADDR3O
			 ADDR4O
			 POSTO
			 CCMNTO
	   MOVE 'Enter data and press ENTER - PF24 to cancel'
	     TO MSGO
	   MOVE -1 TO CCODEL
	   GO TO 9120-SEND-DATA-ONLY
	   .
      *
       1006-DELETE.
	   MOVE 'DELETE' TO LS-ACTION
	   MOVE 'Press ENTER key to delete - PF24 to cancel'
	     TO MSGO
	   GO TO 9120-SEND-DATA-ONLY
	   .
      *
       1009-PRINT-NAME.
	   SET LS-PRINT-ONE  TO TRUE
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
	   GO TO 9120-SEND-DATA-ONLY
	   .
      *
       1010-RETURN-TO-MENU.
	   SET LS-MENU-PROG TO TRUE
	   MOVE SPACE TO WS-CURRENT-MAP
	   GO TO 9998-RETURN
	   .
      *
       1024-CANCEL.
	   MOVE 'Request has been cancelled' TO MSGO
	   EXEC CICS READ
	       FILE(LS-FILE)
	       INTO(NAMEFILE-REC)
	       RIDFLD(LS-RIDFLD)
	       GTEQ
	   END-EXEC
	   MOVE SPACE TO LS-ACTION
	   PERFORM 9110-RESTORE-ATTRIBUTES
	   PERFORM 9130-MOVE-FILE-TO-SCREEN
	   GO TO 9120-SEND-DATA-ONLY
	   .
      *
       2000-FILE-ADD.
	   MOVE SPACES TO NAMEFILE-REC
	   PERFORM 2015-EDIT
	   IF LS-ACTION = SPACE
	       EXEC CICS WRITE
		   FILE('NAMEFILE')
		   FROM(NAMEFILE-REC)
		   RIDFLD(NAME-CODE)
	       END-EXEC
	       MOVE 'Record has been added' TO MSGO
	   END-IF
	   GO TO 9120-SEND-DATA-ONLY
	   .
      *
       2010-FILE-CHANGE.
	   EXEC CICS READ
	       FILE('NAMEFILE')
	       INTO(NAMEFILE-REC)
	       RIDFLD(LS-CODE)
	       EQUAL
	       UPDATE
	   END-EXEC
	   PERFORM 2015-EDIT
	   IF LS-ACTION = SPACE
	       EXEC CICS REWRITE
		   FILE('NAMEFILE')
		   FROM(NAMEFILE-REC)
	       END-EXEC
	       MOVE 'Record has been changed' TO MSGO
	   END-IF
	   GO TO 9120-SEND-DATA-ONLY
	   .
      *
       2015-EDIT.
	   PERFORM 9140-MOVE-SCREEN-TO-FILE
	   EVALUATE TRUE
	   WHEN (NAME-CODE = LOW-VALUE OR NAME-CODE = SPACE)
	       MOVE 'Code cannot be blank' TO MSGO
	       MOVE -1 TO CCODEL
	   WHEN (NAME = LOW-VALUES OR NAME = SPACES)
	       MOVE 'Name cannot be blank' TO MSGO
	       MOVE -1 TO CNAMEL
	   WHEN OTHER
	       MOVE SPACE TO MSGO LS-ACTION
	       PERFORM 9110-RESTORE-ATTRIBUTES
	   END-EVALUATE
	   IF SHORT-NAME = LOW-VALUES
	   OR SHORT-NAME = SPACES
	       MOVE NAME TO SHORT-NAME
	   END-IF
	   IF LS-SHORTNAME
	       MOVE SHORT-NAME TO LS-RIDFLD
	   END-IF
	   .
      *
       2020-FILE-DELETE.
	   EXEC CICS PUSH HANDLE
	   END-EXEC
	   EXEC CICS IGNORE CONDITION
	       NOTFND
	   END-EXEC
	   EXEC CICS DELETE
		FILE(LS-FILE)
		RIDFLD(LS-RIDFLD)
	   END-EXEC
	   EXEC CICS POP HANDLE
	   END-EXEC
	   MOVE 'Record has been deleted' TO MSGO
	   MOVE SPACE TO LS-ACTION
	   PERFORM 9080-STARTBR THRU 9080-EXIT
	   GO TO 9090-SHOW-RECORD
	   .
      *
       2030-FILE-FIND.
	   IF (CCODEI NOT = DFHBMEOF AND CCODEI NOT = LOW-VALUE)
	       EXEC CICS BIF DEEDIT FIELD(CCODEI) END-EXEC
	       MOVE CCODEI TO LS-RIDFLD
	       SET LS-NAMEFILE TO TRUE
	   ELSE
	       MOVE SHRTNMI TO LS-RIDFLD
	       SET LS-SHORTNAME TO TRUE
	   END-IF
	   EXEC CICS IGNORE CONDITION
	       DUPKEY
	   END-EXEC
	   EXEC CICS READ
	       FILE(LS-FILE)
	       INTO(NAMEFILE-REC)
	       RIDFLD(LS-RIDFLD)
	       GTEQ
	   END-EXEC
	   MOVE 'Record has been found' TO MSGO
	   MOVE SPACE TO LS-ACTION
	   PERFORM 9110-RESTORE-ATTRIBUTES
	   PERFORM 9130-MOVE-FILE-TO-SCREEN
	   GO TO 9120-SEND-DATA-ONLY
	   .
      *
       9000-INVALID-ACTION.
	   EXEC CICS SEND CONTROL
	       ALARM
	       FREEKB
	   END-EXEC
	   GO TO 9998-RETURN
	   .
      *
       9030-NEW-MAP.
	   PERFORM 9080-STARTBR THRU 9080-EXIT
	   MOVE SPACE TO LS-ACTION
	   PERFORM 9130-MOVE-FILE-TO-SCREEN
	   GO TO 9070-SEND-MAP
	   .
      *
       9040-DUPREC.
	   MOVE -1 TO CCODEL
	   MOVE 'Error - duplicate record - correct or PF24 to cancel'
	     TO MSGO
	   GO TO 9120-SEND-DATA-ONLY
	   .
      *
       9050-ENDFILE.
	   MOVE SPACE TO LS-ACTION
	   IF EIBAID = DFHPF3
	       MOVE 'BOF' TO LS-ACTION
	       MOVE 'Beginning of file encountered' TO MSGO
	   ELSE
	       MOVE 'EOF' TO LS-ACTION
	       MOVE 'End of file encountered' TO MSGO
	   END-IF
	   PERFORM 9110-RESTORE-ATTRIBUTES
	   IF  LS-CURRENT-MAP = WS-CURRENT-MAP
	       GO TO 9120-SEND-DATA-ONLY
	   ELSE
	       GO TO 9070-SEND-MAP
	   END-IF
	   .
      *
       9060-NOTFND.
	   MOVE 'No record found' TO MSGO
	   EXEC CICS HANDLE CONDITION
	       NOTFND(9050-ENDFILE)
	   END-EXEC
	   MOVE SPACE TO LS-ACTION
	   PERFORM 9080-STARTBR THRU 9080-EXIT
	   GO TO 9090-SHOW-RECORD
	   .
      *
       9070-SEND-MAP.
	   EXEC CICS ASKTIME
	       ABSTIME (WS-TIME)
	   END-EXEC
	   EXEC CICS FORMATTIME
	       ABSTIME (WS-TIME)
	       DATESEP ('-')
	       YYYYMMDD (M20DATEO)
	   END-EXEC
	   EXEC CICS SEND MAP ('SAMM20')
		FREEKB
		ERASE
	   END-EXEC
	   GO TO 9998-RETURN
	   .
      *
       9080-STARTBR.
	   EXEC CICS STARTBR
	       FILE(LS-FILE)
	       RIDFLD(LS-RIDFLD)
	       GTEQ
	   END-EXEC
	   GO TO 9081-NEXT
	   .
      *
       9080-EXIT. EXIT.
      *
       9081-NEXT.
	   EXEC CICS READNEXT
	       FILE(LS-FILE)
	       INTO(NAMEFILE-REC)
	       RIDFLD(LS-RIDFLD)
	   END-EXEC
	   MOVE NAME-CODE TO LS-CODE
	   GO TO 9080-EXIT
	   .
      *
       9082-DUPKEY.
	   IF LS-CODE = NAME-CODE
	   OR LS-CODE = LOW-VALUE
	   OR LS-CODE = SPACE
	       GO TO 9080-EXIT
	   ELSE
	       GO TO 9081-NEXT
	   END-IF
	   .
      *
       9090-SHOW-RECORD.
	   PERFORM 9130-MOVE-FILE-TO-SCREEN
	   GO TO 9120-SEND-DATA-ONLY
	   .
      *
       9100-UNPROTECT.
	   MOVE DFHBMFSE TO SHRTNMA
			    CNAMEA
			    PCONTCTA
			    PPHONEA
			    PFAXA
			    ADDR1A
			    ADDR2A
			    ADDR3A
			    ADDR4A
			    POSTA
			    CCMNTA
	   MOVE DFHREVRS TO SHRTNMH
			    CNAMEH
			    PCONTCTH
			    PPHONEH
			    PFAXH
			    ADDR1H
			    ADDR2H
			    ADDR3H
			    ADDR4H
			    POSTH
			    CCMNTH
	   .
      *
       9110-RESTORE-ATTRIBUTES.
	   MOVE DFHBMASB TO CCODEA
			    SHRTNMA
			    CNAMEA
			    PCONTCTA
			    PPHONEA
			    PFAXA
			    ADDR1A
			    ADDR2A
			    ADDR3A
			    ADDR4A
			    POSTA
			    CCMNTA
	   MOVE DFHDFHI TO CCODEH
			   SHRTNMH
			   CNAMEH
			   PCONTCTH
			   PPHONEH
			   PFAXH
			   ADDR1H
			   ADDR2H
			   ADDR3H
			   ADDR4H
			   POSTH
			   CCMNTH
	   .
      *
       9120-SEND-DATA-ONLY.
	   EXEC CICS
		SEND MAP('SAMM20')
		CURSOR
		FREEKB
		DATAONLY
	   END-EXEC
	   GO TO 9998-RETURN.
      *
      *
       9130-MOVE-FILE-TO-SCREEN.
	   MOVE NAME-CODE    TO LS-CODE
	   MOVE NAME-CODE    TO CCODEO
	   MOVE SHORT-NAME   TO SHRTNMO
	   MOVE NAME	     TO CNAMEO
	   MOVE CONTACT-NAME TO PCONTCTO
	   MOVE PHONE	     TO PPHONEO
	   MOVE FAX	     TO PFAXO
	   MOVE ADDRESS1     TO ADDR1O
	   MOVE ADDRESS2     TO ADDR2O
	   MOVE ADDRESS3     TO ADDR3O
	   MOVE ADDRESS4     TO ADDR4O
	   MOVE POSTAL-CODE  TO POSTO
	   MOVE COMMENT      TO CCMNTO
	   .
      *
       9140-MOVE-SCREEN-TO-FILE.
	   IF CCODEL > ZERO
	       EXEC CICS BIF DEEDIT FIELD(CCODEI) END-EXEC
	       MOVE CCODEI TO NAME-CODE
	   END-IF
	   IF SHRTNML > ZERO
	       MOVE SHRTNMI TO SHORT-NAME
	   END-IF
	   IF CNAMEL > ZERO
	       MOVE CNAMEI TO NAME
	   END-IF
	   IF PCONTCTL > ZERO
	       MOVE PCONTCTI TO CONTACT-NAME
	   END-IF
	   IF PPHONEL > ZERO
	       MOVE PPHONEI TO PHONE
	   END-IF
	   IF PFAXL > ZERO
	       MOVE PFAXI TO FAX
	   END-IF
	   IF ADDR1L > ZERO
	       MOVE ADDR1I TO ADDRESS1
	   END-IF
	   IF ADDR2L > ZERO
	       MOVE ADDR2I TO ADDRESS2
	   END-IF
	   IF ADDR3L > ZERO
	       MOVE ADDR3I TO ADDRESS3
	   END-IF
	   IF ADDR4L > ZERO
	       MOVE ADDR4I TO ADDRESS4
	   END-IF
	   IF POSTL > ZERO
	       MOVE POSTI TO POSTAL-CODE
	   END-IF
	   IF CCMNTL > ZERO
	       MOVE CCMNTI TO COMMENT
	   END-IF
      *
	   IF CCODEF = DFHBMEOF
	       MOVE SPACE TO NAME-CODE
	   END-IF
	   IF SHRTNMF = DFHBMEOF
	       MOVE SPACE TO SHORT-NAME
	   END-IF
	   IF CNAMEF = DFHBMEOF
	       MOVE SPACE TO NAME
	   END-IF
	   IF PCONTCTF = DFHBMEOF
	       MOVE SPACE TO CONTACT-NAME
	   END-IF
	   IF PPHONEF = DFHBMEOF
	       MOVE SPACE TO PHONE
	   END-IF
	   IF PFAXF = DFHBMEOF
	       MOVE SPACE TO FAX
	   END-IF
	   IF ADDR1F = DFHBMEOF
	       MOVE SPACE TO ADDRESS1
	   END-IF
	   IF ADDR2F = DFHBMEOF
	       MOVE SPACE TO ADDRESS2
	   END-IF
	   IF ADDR3F = DFHBMEOF
	       MOVE SPACE TO ADDRESS3
	   END-IF
	   IF ADDR4F = DFHBMEOF
	       MOVE SPACE TO ADDRESS4
	   END-IF
	   IF POSTF = DFHBMEOF
	       MOVE SPACE TO POSTAL-CODE
	   END-IF
	   IF CCMNTF = DFHBMEOF
	       MOVE SPACE TO COMMENT
	   END-IF
	   .
      *
       9998-RETURN.
	   MOVE WS-CURRENT-MAP TO LS-CURRENT-MAP
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
