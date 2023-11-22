      ******************************************************************
      * Program name: ISTART.COB                                       *
      *                                                                *
      * Purpose: This program sets the start position in a CA-Realia   *
      *          COBOL data file that was created by IWRITE.COB.       *
      *                                                                *
      *          The following operations are performed:               *
      *                                                                *
      *          1. A START EQUAL operation is performed on the        *
      *             record with key 'EQ'.                              *
      *          2. The next record is read.                           *
      *          3. A START GREATER THAN operation is performed on     *
      *             the record with key 'GS'.                          *
      *          4. The next record is read.                           *
      *          5. A START GREATER THAN OR EQUAL TO operation is      *
      *             performed on the record with key 'GE'.             *
      *          6. The next record is read.                           *
      *                                                                *
      * Note: The file is opened for input.                            *
      ******************************************************************
      *
       COPY CARFSAPI SUPPRESS.
       IDENTIFICATION DIVISION.
       PROGRAM-ID.
           ISTART.
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
      * Start types for start operations                                *
      ******************************************************************
       77  RFS-START-EQ PIC S9(4) BINARY VALUE 0.
       77  RFS-START-GT PIC S9(4) BINARY VALUE 1.
       77  RFS-START-GE PIC S9(4) BINARY VALUE 2.

      ******************************************************************
      * Key values for start operations                                *
      ******************************************************************
       77  RFS-START-KEY-EQ PIC X(2) VALUE 'EQ'.
       77  RFS-START-KEY-GT PIC X(2) VALUE 'GS'.
       77  RFS-START-KEY-GE PIC X(2) VALUE 'GE'.

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
      * START EQ, key = 'EQ'                                           *
      ******************************************************************
       START-EQ.
           DISPLAY 'START EQUAL, KEY = EQ'.
           CALL 'RealiaFSStart' USING RFS-HANDLE,
                                        RFS-KEY-NUMBER,
                                        RFS-KEY-LENGTH,
                                        RFS-START-KEY-EQ,
                                        RFS-START-EQ,
                                        RFS-LOCK-MODE
                                        GIVING RFS-STATUS.
           IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'START EQ FAILED, RFS-STATUS = ' RFS-STATUS
              GO TO CLOSE-INPUT-FILE.

      ******************************************************************
      * Read the next record                                           *
      ******************************************************************
       READ-NEXT-EQ.
           DISPLAY 'READING NEXT RECORD '.
           CALL 'RealiaFSReadNext' USING RFS-HANDLE,
                                           RFS-LOCK-MODE,
                                           RFS-RECLEN
                                           GIVING RFS-STATUS.
           IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'READ NEXT FAILED, RFS-STATUS = ' RFS-STATUS
              GO TO CLOSE-INPUT-FILE.
           DISPLAY RFS-RECAREA.

      ******************************************************************
      * START GT, key = 'GS'                                           *
      ******************************************************************
       START-GT.
           DISPLAY 'START GREATER THAN, KEY = GS'.
           CALL 'RealiaFSStart' USING RFS-HANDLE,
                                        RFS-KEY-NUMBER,
                                        RFS-KEY-LENGTH,
                                        RFS-START-KEY-GT,
                                        RFS-START-GT,
                                        RFS-LOCK-MODE
                                        GIVING RFS-STATUS.
           IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'START GT FAILED, RFS-STATUS = ' RFS-STATUS
              GO TO CLOSE-INPUT-FILE.

      ******************************************************************
      * Read the next record                                           *
      ******************************************************************
       READ-NEXT-GT.
           DISPLAY 'READING NEXT RECORD '.
           CALL 'RealiaFSReadNext' USING RFS-HANDLE,
                                           RFS-LOCK-MODE,
                                           RFS-RECLEN
                                           GIVING RFS-STATUS.
           IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'READ NEXT FAILED, RFS-STATUS = ' RFS-STATUS
              GO TO CLOSE-INPUT-FILE.
           DISPLAY RFS-RECAREA.

      ******************************************************************
      * START GE, key = 'GE'                                           *
      ******************************************************************
       START-GE.
           DISPLAY 'START GREATER TO OR EQUAL, KEY = GE'.
           CALL 'RealiaFSStart' USING RFS-HANDLE,
                                        RFS-KEY-NUMBER,
                                        RFS-KEY-LENGTH,
                                        RFS-START-KEY-GE,
                                        RFS-START-GE,
                                        RFS-LOCK-MODE
                                        GIVING RFS-STATUS.
           IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'START GE FAILED, RFS-STATUS = ' RFS-STATUS
              GO TO CLOSE-INPUT-FILE.

      ******************************************************************
      * Read the next record                                           *
      ******************************************************************
       READ-NEXT-GE.
           DISPLAY 'READING NEXT RECORD '.
           CALL 'RealiaFSReadNext' USING RFS-HANDLE,
                                           RFS-LOCK-MODE,
                                           RFS-RECLEN
                                           GIVING RFS-STATUS.
           IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'READ NEXT FAILED, RFS-STATUS = ' RFS-STATUS
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