       CBL XOPTS(COBOL2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SAMP30.
      * Revision Information
      * ^{File:samp30.cob  }
      * ^{Timestamp:Tue Apr 29 13:56:10 1997}
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
      *DESCRIPTION: This program process print requests 	       *
      ******************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. 	 IBM-PC.
       OBJECT-COMPUTER. 	 IBM-PC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-CURRENT-MAP  VALUE 'SAMM30'        PIC X(7).
       01  WS-TIME				 PIC 9(15) COMP-3.
       01  WS-NAME				 PIC X(10).
       01  WS-COUNT				 PIC S9(4) COMP.
	   COPY SAMM30.
       01  NAMEFILE-REC. COPY NAMEFILE.
       01  SAMCOMM.	 COPY SAMCOMM.
       PROCEDURE DIVISION.
       000-PROCESS.
	   EXEC CICS HANDLE CONDITION
		ENDDATA(9999-RETURN)
		NOTFND(100-RETRIEVE)
		ENDFILE(240-SEND-PAGE)
		OVERFLOW(210-OVERFLOW)
	   END-EXEC
	   EXEC CICS IGNORE CONDITION
	       DUPKEY
	   END-EXEC
	   IF NOT LS-NAMEFILE
	       SET LS-SHORTNAME TO TRUE
	   END-IF
	   GO TO 100-RETRIEVE
	   .
      *
       100-RETRIEVE.
	   EXEC CICS RETRIEVE
	       INTO (SAMCOMM)
	   END-EXEC
	   EVALUATE TRUE
	   WHEN LS-PRINT-ALL
	       GO TO 200-PRINT-ALL
	   WHEN LS-PRINT-ONE
	       GO TO 300-PRINT-ONE
	   WHEN OTHER
	       GO TO 100-RETRIEVE
	   END-EVALUATE
	   .
      *
       200-PRINT-ALL.
	   MOVE LOW-VALUE TO LS-RIDFLD
	   EXEC CICS ASKTIME
	       ABSTIME	(WS-TIME)
	   END-EXEC
	   EXEC CICS FORMATTIME
	       ABSTIME(WS-TIME)
	       DATESEP('-')
	       YYYYMMDD(M30DATHO)
	   END-EXEC
	   EXEC CICS STARTBR
		FILE(LS-FILE)
		RIDFLD(LS-RIDFLD)
		GTEQ
	   END-EXEC
	   PERFORM 230-GET-NEXT
	   GO TO 210-OVERFLOW
	   .
      *
       210-OVERFLOW.
	   EXEC CICS SEND MAP ('SAMM30H')
	       MAPSET ('SAMM30')
	       ACCUM
	       ERASE
	   END-EXEC
	   GO TO 220-PRINT
	   .
      *
       220-PRINT.
	   MOVE NAME-CODE    TO CCODEO
	   MOVE NAME	     TO CNAMEO
	   MOVE CONTACT-NAME TO CONTCTO
	   MOVE PHONE	     TO PPHONEO
	   EXEC CICS SEND MAP ('SAMM30D')
	       MAPSET ('SAMM30')
	       ACCUM
	   END-EXEC
	   PERFORM 230-GET-NEXT
	   GO TO 220-PRINT
	   .
      *
       230-GET-NEXT.
	   EXEC CICS READNEXT
		FILE (LS-FILE)
		INTO (NAMEFILE-REC)
		RIDFLD(LS-RIDFLD)
	   END-EXEC
	   .
      *
       240-SEND-PAGE.
	   EXEC CICS ENDBR
	       FILE (LS-FILE)
	       NOHANDLE
	   END-EXEC
	   EXEC CICS SEND PAGE END-EXEC
	   GO TO 100-RETRIEVE
	   .
      *
       300-PRINT-ONE.
	   EXEC CICS READ
		FILE ('NAMEFILE')
		INTO (NAMEFILE-REC)
		RIDFLD(LS-CODE)
		EQUAL
	   END-EXEC
	   MOVE LOW-VALUE TO SAMM30AO
	   EXEC CICS ASKTIME
	       ABSTIME	(WS-TIME)
	   END-EXEC
	   EXEC CICS FORMATTIME
	       ABSTIME(WS-TIME)
	       DATESEP('-')
	       YYYYMMDD(M30DATAO)
	   END-EXEC
	   MOVE NAME-CODE    TO CCODEAO
	   MOVE SHORT-NAME   TO SHRTNMO
	   MOVE NAME	     TO CNAMEAO
	   MOVE CONTACT-NAME TO PCONTCTO
	   MOVE PHONE	     TO PPHONEAO
	   MOVE FAX	     TO PFAXO
	   MOVE ADDRESS1     TO ADDR1O
	   MOVE ADDRESS2     TO ADDR2O
	   MOVE ADDRESS3     TO ADDR3O
	   MOVE ADDRESS4     TO ADDR4O
	   MOVE POSTAL-CODE  TO POSTO
	   MOVE COMMENT      TO CCMNTO
	   EXEC CICS SEND MAP ('SAMM30A')
	       MAPSET('SAMM30')
	       ERASE
	   END-EXEC
	   GO TO 100-RETRIEVE
	   .
      *
       9999-RETURN.
	   EXEC CICS RETURN END-EXEC
	   .
