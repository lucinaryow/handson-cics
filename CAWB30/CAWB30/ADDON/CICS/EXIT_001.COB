      *$dialect-realia
      *$nodcall
      *$uplow
      *$nomovelink
      *$epdcall
      *** !! do not change these compiler directives !!
      * CA-Realia PAN/LCM keyword standards
      * ^{File:exit_001.cob}
      * ^{Timestamp:Fri May 16 07:33:28 1997}
      * ^{Revision:4.0}
      *
      *   CA-Realia CICS Rel 6.0 CICS Runtime Exit routine
      *
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'EXIT_001'.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
	   ALPHABET EBCDIC-DATA IS EBCDIC
	   ALPHABET ASCII-DATA IS STANDARD-1.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  DATA-STREAM-SIZE			 PIC 9(4) binary.
       LINKAGE SECTION.
       01  EXIT-AREA.
	   COPY EXITPARM.
      *
      *    define cics areas picture to meet specifics of exit
      *
       01  DATA-STREAM-AREA.
	   05  DATA-STREAM-CHAR 		 PIC X
						 OCCURS 1 TO 1920
						 DEPENDING ON
						 DATA-STREAM-SIZE.
       PROCEDURE DIVISION USING EXIT-AREA.
	   PERFORM
	   IF EXIT-INIT
	       PERFORM INIT-ROUTINE
	   ELSE
	   IF EXIT-SHUTDOWN
	       PERFORM SHUTDOWN-ROUTINE
	   ELSE
	       SET EXIT-OK TO TRUE
	       PERFORM SET-ADDRESS
	       PERFORM USER-EXIT
	   END-PERFORM
	   GOBACK.
      *
       INIT-ROUTINE. *> initialize exit parameters
	   MOVE 1 TO EXIT-AREA-SIZE
	   SET EXIT-TASK TO TRUE
	   SET EXIT-MODULE-AREA TO NULL
	   .
      *
       SHUTDOWN-ROUTINE.
      *
      *    add exit specific code
      *
       SET-ADDRESS.
	   SET ADDRESS OF DATA-STREAM-AREA TO EXIT-ADDRESS (1)
	   ADD 0 EXIT-SIZE (1) GIVING DATA-STREAM-SIZE
	   .

       USER-EXIT.
      *
      *    add exit specific code
      *
	   EXIT.
