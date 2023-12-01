      ******************************************************************
      * Program name: RREAD.COB 				       *
      * 							       *
      * Purpose: This program uses the CA-Realia callable file system  *
      * 	 to read the records created by RWRITE.COB.	       *
      * 							       *
      * 	 The file is read as follows:			       *
      * 							       *
      * 	 1. Sequentially from start to end.		       *
      * 	 2. By key, record key = 500.			       *
      * 							       *
      * Note: the file is opened for input only.		       *
      ******************************************************************
      *
       COPY CARFSAPI SUPPRESS.
       IDENTIFICATION DIVISION.
       PROGRAM-ID.
	   RREAD.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.
	   IBM-PC.
       OBJECT-COMPUTER.
	   IBM-PC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      ******************************************************************
      * Standard file close mode				       *
      ******************************************************************
       77  RFS-CLOSE-MODE PIC S9(4) BINARY VALUE 0.

      ******************************************************************
      * RFSAPI key decriptor block				       *
      ******************************************************************
       77  RFS-KEY-BLOCK PIC X(18).

      ******************************************************************
      * Dummy parameter 					       *
      ******************************************************************
       77  RFS-DUMMY	 PIC S9(4) COMP-5 VALUE 0.

      ******************************************************************
      * Key value for read by key				       *
      ******************************************************************
       77  RFS-RANDOM-KEY PIC S9(9) BINARY VALUE 500.
       77  RFS-RANDOM-KEY-X REDEFINES RFS-RANDOM-KEY	       PIC X(4).

      ******************************************************************
      * Count of records read					       *
      ******************************************************************
       77  RFS-READ-COUNT PIC S9(4) BINARY VALUE 0.

      ******************************************************************
      * RFSAPI status						       *
      ******************************************************************
       01  RFS-STATUS		  PIC S9(4) BINARY.

      ******************************************************************
      * Record length for read					       *
      ******************************************************************
       01  RFS-RECLEN		  PIC S9(9) BINARY.

      ******************************************************************
      * RFSAPI file system handle				       *
      ******************************************************************
       01  RFS-HANDLE		  PIC S9(9) BINARY VALUE  0.

      ******************************************************************
      * RFSAPI parameter block					       *
      ******************************************************************
       01  RFS-PARM-BLOCK.
	   05 RFS-RECORD-LENGTH     PIC S9(9) BINARY VALUE 50.
	   05 RFS-MIN-RECORD-LENGTH PIC S9(9) BINARY VALUE  0.
	   05 RFS-CODE-SYSTEM	    PIC S9(4) BINARY VALUE  0.
	   05 RFS-ORGANIZATION	    PIC S9(4) BINARY VALUE  1.
	   05 RFS-OPEN-MODE	    PIC S9(4) BINARY VALUE  0.
	   05 RFS-ACCESS-MODE	    PIC S9(4) BINARY VALUE  2.
	   05 RFS-LOCK-MODE	    PIC S9(4) BINARY VALUE  0.
	   05 RFS-DYNAMIC-FILE	    PIC S9(4) BINARY VALUE  0.
	   05 RFS-NUM-KEYS	    PIC S9(4) BINARY VALUE  0.
	   05 RFS-RESERVED	    PIC S9(4) BINARY VALUE  0.

      ******************************************************************
      * Data file specification 				       *
      ******************************************************************
       01  RFS-FILE-SPEC.
           05 RFS-FILE-NAME      PIC X(7) VALUE 'REL1[R]'.

      ******************************************************************
      * Data file record area					       *
      ******************************************************************
       01  RFS-RECAREA.
	   05 RFS-HEADER	  PIC X(7)  VALUE SPACES.
	   05 RFS-RECNUM	  PIC 9999  VALUE 0.
	   05 RFS-RECORD-TRAILER  PIC X(39) VALUE SPACES.

       PROCEDURE DIVISION.
      ******************************************************************
      * Open the file						       *
      ******************************************************************
       OPEN-INPUT-FILE.
           DISPLAY 'OPENING FILE FOR INPUT'
           CALL 'RealiaFSOpen' USING RFS-HANDLE,
				     RFS-FILE-SPEC,
				     RFS-PARM-BLOCK,
				     RFS-KEY-BLOCK,
				     RFS-RECAREA
				     GIVING RFS-STATUS.
	   IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'OPEN FAILED, RFS-STATUS = ' RFS-STATUS
	      STOP RUN.

      ******************************************************************
      * Read the input file sequentially			       *
      ******************************************************************
       READ-INPUT-SEQUENTIAL.
           DISPLAY 'READING 1000 RELATIVE RECORDS'.
       READ-LOOP.
           CALL 'RealiaFSReadNext' USING RFS-HANDLE,
					 RFS-LOCK-MODE,
					 RFS-RECLEN
					 GIVING RFS-STATUS.
	   IF RFS-STATUS IS NOT EQUAL TO ZERO THEN
	      IF RFS-STATUS IS EQUAL TO 10 AND
		 RFS-READ-COUNT = 1000 THEN
		GO TO READ-BY-KEY
	      ELSE
                DISPLAY 'READ FAILED, RFS-STATUS = ' RFS-STATUS
	      END-IF
	      GO TO CLOSE-INPUT-FILE.
	   ADD 1 TO RFS-READ-COUNT.
	   GO TO READ-LOOP.

      ******************************************************************
      * Read the input file by key, key = 500			       *
      ******************************************************************
       READ-BY-KEY.
           DISPLAY 'TOTAL RECORDS READ = ' RFS-READ-COUNT.
           DISPLAY 'READING BY KEY, KEY = 500'.
           CALL 'RealiaFSReadKey' USING RFS-HANDLE,
					RFS-DUMMY,
					RFS-RANDOM-KEY-X,
					RFS-LOCK-MODE,
					RFS-RECLEN
					GIVING RFS-STATUS.
	   IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'READ BY KEY FAILED, RFS-STATUS = ' RFS-STATUS
	      GO TO CLOSE-INPUT-FILE.
	   DISPLAY RFS-RECAREA.

      ******************************************************************
      * Close the file
      ******************************************************************
       CLOSE-INPUT-FILE.
           DISPLAY 'CLOSING INPUT FILE'.
           CALL 'RealiaFSClose' USING RFS-HANDLE,
					RFS-CLOSE-MODE
					GIVING RFS-STATUS.
	   IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'CLOSE FAILED, RFS-STATUS = ' RFS-STATUS.
	   STOP RUN.
