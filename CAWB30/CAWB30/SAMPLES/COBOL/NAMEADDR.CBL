 IDENTIFICATION DIVISION.
 PROGRAM-ID. NAMEADDR.
*
*  This program demonstrates CA-Realia COBOL CALL and CANCEL
*   and screen handle capabilities.
*
*  Copyright (c) 1992 Computer Associates International, Inc.
*
 ENVIRONMENT DIVISION.
 CONFIGURATION SECTION.
 SOURCE-COMPUTER. IBM-PC.
 OBJECT-COMPUTER. IBM-PC.
 SPECIAL-NAMES.
 INPUT-OUTPUT SECTION.
 FILE-CONTROL.
 DATA DIVISION.
 FILE SECTION.
 WORKING-STORAGE SECTION.
*
 01  USER-CHOICE			   PIC X.
     88  CALL-ESC                          VALUE '1'.
     88  CALL-SCR                          VALUE '2'.
     88  CALL-SIO                          VALUE '3'.
     88  USER-TRM                          VALUE '4'.
 01  ESCADDR-PGM  VALUE 'ESCADDR'          PIC X(7).
 01  SCRADDR-PGM  VALUE 'SCRADDR'          PIC X(7).
 01  SIOADDR-PGM  VALUE 'SIOADDR'          PIC X(7).
*
 PROCEDURE DIVISION.
*
 MAINLINE.
*
     PERFORM UNTIL USER-TRM

         DISPLAY ' '
         DISPLAY 'Press 1 to call NAMEADDR using ESC sequences.  '
         DISPLAY 'Press 2 to call NAMEADDR using SCREEN SECTION. '
         DISPLAY 'Press 3 to call NAMEADDR using SCREENIO.       '
         DISPLAY 'Press 4 to exit.                               '
         DISPLAY 'Enter choice and then press Enter '
	     WITH NO ADVANCING

	 MOVE SPACE TO USER-CHOICE
	 ACCEPT USER-CHOICE

	 PERFORM IF CALL-ESC
	     CALL ESCADDR-PGM
		 ON EXCEPTION
                     DISPLAY ESCADDR-PGM ' not found.'
		 NOT ON EXCEPTION
		     CANCEL ESCADDR-PGM
	     END-CALL
	 ELSE IF CALL-SCR
	     CALL SCRADDR-PGM
		 ON EXCEPTION
                     DISPLAY SCRADDR-PGM ' not found.'
		 NOT ON EXCEPTION
		     CANCEL SCRADDR-PGM
	     END-CALL
	 ELSE IF CALL-SIO
	     CALL SIOADDR-PGM
		 ON EXCEPTION
                     DISPLAY SIOADDR-PGM ' not found.'
		 NOT ON EXCEPTION
		     CANCEL SIOADDR-PGM
	     END-CALL
	 END-PERFORM
     END-PERFORM.
*
 TERMINATE-PROGRAM.
     STOP RUN.
