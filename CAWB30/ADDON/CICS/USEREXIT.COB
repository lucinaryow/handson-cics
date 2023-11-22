      *$ascii
      *$dialect-realia
      *$nodcall
      *$uplow
      *$nomovelink
      *$epdcall
      *** !! do not change these compiler directives !!
      * CA-Realia PAN/LCM keyword standards
      * ^{File:userexit.cob}
      * ^{Timestamp:Fri May 16 07:34:28 1997}
      * ^{Revision:3.0}
      *
      *   CA-Realia CICS Rel 6.0 CICS Runtime Exit routine
      *   ALL exits use this interface
      *
       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'USEREXIT'. *> Change this to unique name
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
	   ALPHABET EBCDIC-DATA IS EBCDIC
	   ALPHABET ASCII-DATA IS STANDARD-1.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       LINKAGE SECTION.
       01  CICSICB. COPY CICSICB.

	   COPY DFHEIBLK.

       01  EXIT-AREA.
	   COPY EXITPARM.
      *
      *    define cics areas picture to meet specifics of exit
      *
       01  EXIT-AREA-01 			 PIC X(1024).
       *> etc....

       PROCEDURE DIVISION USING EXIT-AREA.
	   PERFORM SET-ADDRESS
	   EVALUATE TRUE
	   WHEN EXIT-INIT
	       PERFORM INIT
	   WHEN EXIT-START-TASK
	       PERFORM START-TASK
	   WHEN EXIT-END-TASK
	       PERFORM END-TASK
	   WHEN EXIT-SYNCPOINT
	       PERFORM SYNCPOINT
	   WHEN EXIT-SYNCPOINT-ROLLBACK
	       PERFORM SYNCPOINT-ROLLBACK
	   WHEN EXIT-AT-ERROR
	       PERFORM AT-ERROR
	   WHEN EXIT-SHUTDOWN
	       PERFORM SHUTDOWN
	   END-EVALUATE
	   GOBACK.
      *
       INIT.
      *
      *    Add exit specific code
      *    Set the exit level that is needed
	   SET EXIT-ERROR-PROCESSING TO TRUE
	   SET EXIT-MODULE-AREA TO NULL
	   .
      *
       START-TASK.
      *    add exit specific code
      *
       END-TASK.
      *    add exit specific code
      *
       SYNCPOINT.
      *    add exit specific code
      *
       SYNCPOINT-ROLLBACK.
      *    add exit specific code
      *
       AT-ERROR.
      *    add exit specific code
      *
       SHUTDOWN.
      *    add exit specific code
      *    Perform all shut routines
      *    Ensure that all files are closed
      *    Ensure that all dynamic memory is freed
      *
       SET-ADDRESS.
	   IF EXIT-IN-TASK
	       SET ADDRESS OF CICSICB TO EXIT-ICB
	       SET ADDRESS OF EIBLK TO EXIT-EIBLK
	   END-IF
	   .
