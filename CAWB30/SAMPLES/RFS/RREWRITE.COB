      ******************************************************************
      * Program name: RREWRITE.COB				       *
      * 							       *
      * Purpose: This program rewrites a record from the CA-Realia     *
      * 	 COBOL data file that was created by IWRITE.COB.       *
      * 							       *
      * 	 The following operations are performed:	       *
      * 							       *
      * 	 1. The record with key 750 is read.		       *
      * 	 2. The record trailer is modified.		       *
      * 	 3. The record area is cleared. 		       *
      * 	 4. The record is re-read to make sure that the        *
      * 	    rewrite was successful.			       *
      * 							       *
      * Note: The file is opened for I/O.			       *
      ******************************************************************
      *
       COPY CARFSAPI SUPPRESS.
       IDENTIFICATION DIVISION.
       PROGRAM-ID.
	   RREWRITE.
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
      * RFSAPI status						       *
      ******************************************************************
       01  RFS-STATUS		  PIC S9(4) BINARY.

      ******************************************************************
      * Value for modified trailer				       *
      ******************************************************************
       77  RFS-MOD-TRAILER PIC X(39) VALUE
                     ' UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU'.

      ******************************************************************
      * RFSAPI key decriptor block				       *
      ******************************************************************
       77  RFS-KEY-BLOCK PIC X(18).

      ******************************************************************
      * Dummy parameters					       *
      ******************************************************************
       77  RFS-DUMMY	 PIC S9(4) BINARY VALUE 0.
       77  RFS-DUMMY-LEN PIC S9(9) BINARY VALUE 0.

      ******************************************************************
      * Start type for start operation				       *
      ******************************************************************
       77  RFS-START-EQ PIC S9(4) BINARY VALUE 0.

      ******************************************************************
      * Key value for start operation				       *
      ******************************************************************
       77  RFS-START-KEY-EQ PIC S9(9) BINARY VALUE 750.
       77  RFS-START-KEY-EQ-X REDEFINES RFS-START-KEY-EQ       PIC X(4).

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
	   05 RFS-OPEN-MODE	    PIC S9(4) BINARY VALUE  5.
	   05 RFS-ACCESS-MODE	    PIC S9(4) BINARY VALUE  0.
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
      * START EQ, key = 750					      *
      ******************************************************************
       START-EQ.
           DISPLAY 'START EQUAL, KEY = 750'
           CALL 'RealiaFSStart' USING RFS-HANDLE,
				      RFS-DUMMY,
				      RFS-DUMMY-LEN,
				      RFS-START-KEY-EQ-X,
				      RFS-START-EQ,
				      RFS-LOCK-MODE
				      GIVING RFS-STATUS.
	   IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'START EQ FAILED, RFS-STATUS = ' RFS-STATUS
	      GO TO CLOSE-IO-FILE.

      ******************************************************************
      * Read the next record					       *
      ******************************************************************
       READ-NEXT.
           DISPLAY 'READING NEXT RECORD '.
           CALL 'RealiaFSReadNext' USING RFS-HANDLE,
					 RFS-LOCK-MODE,
					 RFS-RECLEN
					 GIVING RFS-STATUS.
	   IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'READ NEXT FAILED, RFS-STATUS = ' RFS-STATUS
	      GO TO CLOSE-IO-FILE.
	   DISPLAY RFS-RECAREA.

      ******************************************************************
      * Modify the record trailer and re-write the record	       *
      ******************************************************************
       REWRITE-RECORD.
           DISPLAY 'RE-WRITING THE RECORD'.
	   MOVE RFS-MOD-TRAILER TO RFS-RECORD-TRAILER.
           CALL 'RealiaFSReWrite' USING RFS-HANDLE,
					RFS-RECORD-LENGTH
					GIVING RFS-STATUS.
	   IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'REWRITE FAILED, RFS-STATUS = ' RFS-STATUS
	      GO TO CLOSE-IO-FILE.
	   DISPLAY RFS-RECAREA.

      ******************************************************************
      * Clear the record area and re-read the record		       *
      ******************************************************************
       VALIDATE-REWRITE.
           DISPLAY 'READING RECORD, KEY = 750'
           CALL 'RealiaFSStart' USING RFS-HANDLE,
				      RFS-DUMMY,
				      RFS-DUMMY-LEN,
				      RFS-START-KEY-EQ-X,
				      RFS-START-EQ,
				      RFS-LOCK-MODE
				      GIVING RFS-STATUS.
	   IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'START EQ FAILED, RFS-STATUS = ' RFS-STATUS
	      GO TO CLOSE-IO-FILE.

           CALL 'RealiaFSReadNext' USING RFS-HANDLE,
					 RFS-LOCK-MODE,
					 RFS-RECLEN
					 GIVING RFS-STATUS.
	   IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'READ NEXT FAILED, RFS-STATUS = ' RFS-STATUS
	      GO TO CLOSE-IO-FILE.
	   DISPLAY RFS-RECAREA.

      ******************************************************************
      * Close the file
      ******************************************************************
       CLOSE-IO-FILE.
           DISPLAY 'CLOSING INPUT FILE'.
           CALL 'RealiaFSClose' USING RFS-HANDLE,
				      RFS-CLOSE-MODE
				      GIVING RFS-STATUS.
	   IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'CLOSE FAILED, RFS-STATUS = ' RFS-STATUS.
	   STOP RUN.
