      ******************************************************************
      * Program name: IREWRITE.COB                                     *
      *                                                                *
      * Purpose: This program rewrites a record from the CA-Realia     *
      *          COBOL data file that was created by IWRITE.COB.       *
      *                                                                *
      *          The following operations are performed:               *
      *                                                                *
      *          1. The record with key 'UP' is read by key.           *
      *          2. The record trailer is modified.                    *
      *          3. The record area is cleared.                        *
      *          4. The record is re-read to make sure that the        *
      *             rewrite was successful.                            *
      *                                                                *
      * Note: The file is opened for I/O.                              *
      ******************************************************************
      *
       COPY CARFSAPI SUPPRESS.
       IDENTIFICATION DIVISION.
       PROGRAM-ID.
           IREWRITE.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.
           IBM-PC.
       OBJECT-COMPUTER.
           IBM-PC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

      ******************************************************************
      * Key number for read by key                                     *
      ******************************************************************
       77  RFS-KEY-NUMBER PIC S9(4) BINARY VALUE 1.

      ******************************************************************
      * Key value for read by key                                      *
      ******************************************************************
       77  RFS-RANDOM-KEY PIC X(2) VALUE 'UP'.

      ******************************************************************
      * Value for modified trailer                                     *
      ******************************************************************
       77  RFS-MOD-TRAILER PIC X(41) VALUE
                     ' UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU'.

      ******************************************************************
      * Standard file close mode                                       *
      ******************************************************************
       77  RFS-CLOSE-MODE PIC S9(4) BINARY VALUE 0.

      ******************************************************************
      * RFSAPI status                                                  *
      ******************************************************************
       01  RFS-STATUS             PIC S9(4) BINARY.

      ******************************************************************
      * Record length for read                                         *
      ******************************************************************
       01  RFS-RECLEN             PIC S9(9) BINARY.

      ******************************************************************
      * RFSAPI file system handle                                      *
      ******************************************************************
       01  RFS-HANDLE             PIC S9(9) BINARY VALUE  0.

      ******************************************************************
      * RFSAPI parameter block                                         *
      ******************************************************************
       01  RFS-PARM-BLOCK.
           05 RFS-RECORD-LENGTH     PIC S9(9) BINARY VALUE 50.
           05 RFS-MIN-RECORD-LENGTH PIC S9(9) BINARY VALUE  0.
           05 RFS-CODE-SYSTEM       PIC S9(4) BINARY VALUE  0.
           05 RFS-ORGANIZATION      PIC S9(4) BINARY VALUE  2.
           05 RFS-OPEN-MODE         PIC S9(4) BINARY VALUE  5.
           05 RFS-ACCESS-MODE       PIC S9(4) BINARY VALUE  2.
           05 RFS-LOCK-MODE         PIC S9(4) BINARY VALUE  0.
           05 RFS-DYNAMIC-FILE      PIC S9(4) BINARY VALUE  0.
           05 RFS-NUM-KEYS          PIC S9(4) BINARY VALUE  1.
           05 RFS-RESERVED          PIC S9(4) BINARY VALUE  0.

      ******************************************************************
      * RFSAPI key decriptor block                                     *
      ******************************************************************
       01  RFS-KEY-BLOCK.
           05 RFS-KEY-START       PIC S9(9) BINARY VALUE  8.
           05 RFS-KEY-LENGTH      PIC S9(9) BINARY VALUE  2.
           05 RFS-KEY-TYPE        PIC S9(4) BINARY VALUE  0.
           05 RFS-KEY-DUP         PIC S9(4) BINARY VALUE  0.
           05 RFS-KEY-NULL        PIC S9(4) BINARY VALUE  0.
           05 RFS-KEY-RESERVED    PIC S9(4) BINARY VALUE  0.

      ******************************************************************
      * Data file specification                                        *
      ******************************************************************
       01  RFS-FILE-SPEC.
           05 RFS-FILE-NAME      PIC X(4) VALUE 'IXF1'.

      ******************************************************************
      * Data file record area                                          *
      ******************************************************************
       01  RFS-RECAREA.
           05 RFS-HEADER          PIC X(7)  VALUE SPACES.
           05 RFS-KEY-AREA        PIC X(2)  VALUE SPACES.
           05 RFS-RECORD-TRAILER  PIC X(41) VALUE SPACES.

       PROCEDURE DIVISION.
      ******************************************************************
      * Open the file                                                  *
      ******************************************************************
       OPEN-IO-FILE.
           DISPLAY 'OPENING FILE FOR I/O'
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
      * Read the file by key, key = 'UP'                               *
      ******************************************************************
       READ-BY-KEY.
           DISPLAY 'READING BY KEY, KEY = UP'.
           MOVE RFS-RANDOM-KEY TO RFS-KEY-AREA.
           CALL 'RealiaFSReadKey' USING RFS-HANDLE,
                                        RFS-KEY-NUMBER,
                                        RFS-RANDOM-KEY,
                                        RFS-LOCK-MODE,
                                        RFS-RECLEN
                                        GIVING RFS-STATUS.
           IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'READ BY KEY FAILED, RFS-STATUS = ' RFS-STATUS
              GO TO CLOSE-IO-FILE.
           DISPLAY RFS-RECAREA.

      ******************************************************************
      * Modify the record trailer and re-write the record              *
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
      * Clear the record area and re-read the record                   *
      ******************************************************************
       VALIDATE-REWRITE.
           DISPLAY 'READING BY KEY, KEY = UP'.
           MOVE SPACES TO RFS-RECAREA.
           MOVE RFS-RANDOM-KEY TO RFS-KEY-AREA.
           CALL 'RealiaFSReadKey' USING RFS-HANDLE,
                                        RFS-KEY-NUMBER,
                                        RFS-RANDOM-KEY,
                                        RFS-LOCK-MODE,
                                        RFS-RECLEN
                                        GIVING RFS-STATUS.
           IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'READ BY KEY FAILED, RFS-STATUS = ' RFS-STATUS
              GO TO CLOSE-IO-FILE.
           DISPLAY RFS-RECAREA.

      ******************************************************************
      * Close the file
      ******************************************************************
       CLOSE-IO-FILE.
           DISPLAY 'CLOSING I/O FILE'.
           CALL 'RealiaFSClose' USING RFS-HANDLE,
                                      RFS-CLOSE-MODE
                                      GIVING RFS-STATUS.
           IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'CLOSE FAILED, RFS-STATUS = ' RFS-STATUS.
           STOP RUN.
