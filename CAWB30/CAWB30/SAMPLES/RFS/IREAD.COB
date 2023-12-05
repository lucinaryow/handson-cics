      ******************************************************************
      * Program name: IREAD.COB                                        *
      *                                                                *
      * Purpose: This program reads the CA-Realia COBOL data file      *
      *          that was created by IWRITE.COB.                       *
      *                                                                *
      *          The file is read as follows:                          *
      *                                                                *
      *          1. Sequentially from start to end.                    *
      *          2. By key, record key = 'XX'.                         *
      *          3. Next record.                                       *
      *          4. Prior record.                                      *
      *                                                                *
      *                                                                *
      * Note: The file is opened for input only.                       *
      ******************************************************************
      *
       COPY CARFSAPI SUPPRESS.
       IDENTIFICATION DIVISION.
       PROGRAM-ID.
           IREAD.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.
           IBM-PC.
       OBJECT-COMPUTER.
           IBM-PC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      ******************************************************************
      * Count of records read                                          *
      ******************************************************************
       77  RFS-READ-COUNT PIC S9(4) BINARY VALUE 0.

      ******************************************************************
      * Key number for read by key                                     *
      ******************************************************************
       77  RFS-KEY-NUMBER PIC S9(4) BINARY VALUE 1.

      ******************************************************************
      * Key value for read by key                                      *
      ******************************************************************
       77  RFS-RANDOM-KEY PIC X(2) VALUE 'XX'.

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
           05 RFS-OPEN-MODE         PIC S9(4) BINARY VALUE  0.
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
      * Read the input file sequentially                               *
      ******************************************************************
       READ-INPUT-SEQUENTIAL.
           DISPLAY 'READING 676 RECORDS, KEY = AA -> ZZ'.
       READ-LOOP.
           CALL 'RealiaFSReadNext' USING RFS-HANDLE,
                                         RFS-LOCK-MODE,
                                         RFS-RECLEN
                                         GIVING RFS-STATUS.
           IF RFS-STATUS IS NOT EQUAL TO ZERO THEN
              IF RFS-STATUS IS EQUAL TO 10 AND RFS-READ-COUNT = 676 THEN
                GO TO READ-BY-KEY
              ELSE
                DISPLAY 'READ FAILED, RFS-STATUS = ' RFS-STATUS
              END-IF
              GO TO CLOSE-INPUT-FILE.
           ADD 1 TO RFS-READ-COUNT.
           GO TO READ-LOOP.
      ******************************************************************
      * Read the input file by key, key = 'XX'                         *
      ******************************************************************
       READ-BY-KEY.
           DISPLAY 'TOTAL RECORDS READ = ' RFS-READ-COUNT.
           DISPLAY 'READING BY KEY, KEY = XX'.
           CALL 'RealiaFSReadKey' USING RFS-HANDLE,
                                        RFS-KEY-NUMBER,
                                        RFS-RANDOM-KEY,
                                        RFS-LOCK-MODE,
                                        RFS-RECLEN
                                        GIVING RFS-STATUS.
           IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'READ BY KEY FAILED, RFS-STATUS = ' RFS-STATUS
              GO TO CLOSE-INPUT-FILE.
           DISPLAY RFS-RECAREA.

      ******************************************************************
      * Read the next record                                           *
      ******************************************************************
           DISPLAY 'READING NEXT RECORD'.
           CALL 'RealiaFSReadNext' USING RFS-HANDLE,
                                         RFS-LOCK-MODE,
                                         RFS-RECLEN
                                         GIVING RFS-STATUS.
           IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'READ NEXT FAILED, RFS-STATUS = ' RFS-STATUS
              GO TO CLOSE-INPUT-FILE.
           DISPLAY RFS-RECAREA.

      ******************************************************************
      * Read the prior record                                          *
      ******************************************************************
           DISPLAY 'READING PRIOR RECORD'.
           CALL 'RealiaFSReadPrior' USING RFS-HANDLE,
                                          RFS-LOCK-MODE,
                                          RFS-RECLEN
                                          GIVING RFS-STATUS.
           IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'READ PRIOR FAILED, RFS-STATUS = ' RFS-STATUS
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