      ******************************************************************
      * Program name: RWRITE.COB                                       *
      *                                                                *
      * Purpose: This program uses the CA-Realia callable file system  *
      *          to create a relative file with 1000 records.         *
      *                                                                *
      *          The file is opened as follows:                        *
      *                                                                *
      *            Record length ................ 50                   *
      *            Code system .................. ASCII                *
      *            Open mode .................... OUTPUT               *
      *            Access mode .................. SEQUENTIAL           *
      *            Lock mode   .................. NONE                 *
      *            Dynamic file specification ... NO                   *
      *            Number of keys ............... 0                    *
      *                                                                *
      ******************************************************************
      *
       COPY CARFSAPI SUPPRESS.
       IDENTIFICATION DIVISION.
       PROGRAM-ID.
           RWRITE.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.
           IBM-PC.
       OBJECT-COMPUTER.
           IBM-PC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      ******************************************************************
      * Standard file close mode                                       *
      ******************************************************************
       77  RFS-CLOSE-MODE PIC S9(4) BINARY VALUE 0.

      ******************************************************************
      * RFSAPI key decriptor block                                     *
      ******************************************************************
       77  RFS-KEY-BLOCK PIC X(18).

      ******************************************************************
      * RFSAPI status                                                  *
      ******************************************************************
       01  RFS-STATUS             PIC S9(4) BINARY.

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
           05 RFS-ORGANIZATION      PIC S9(4) BINARY VALUE  1.
           05 RFS-OPEN-MODE         PIC S9(4) BINARY VALUE  3.
           05 RFS-ACCESS-MODE       PIC S9(4) BINARY VALUE  0.
           05 RFS-LOCK-MODE         PIC S9(4) BINARY VALUE  0.
           05 RFS-DYNAMIC-FILE      PIC S9(4) BINARY VALUE  0.
           05 RFS-NUM-KEYS          PIC S9(4) BINARY VALUE  0.
           05 RFS-RESERVED          PIC S9(4) BINARY VALUE  0.

      ******************************************************************
      * Data file specification                                        *
      ******************************************************************
       01  RFS-FILE-SPEC.
           05 RFS-FILE-NAME      PIC X(7) VALUE 'REL1[R]'.

      ******************************************************************
      * Data file record area                                          *
      ******************************************************************
       01  RFS-RECAREA.
           05 RFS-HEADER          PIC X(7)  VALUE 'RECORD '.
           05 RFS-RECNUM          PIC 9999  VALUE 1.
           05 RFS-RECORD-TRAILER  PIC X(39) VALUE
                          ' XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'.

       PROCEDURE DIVISION.
      ******************************************************************
      * Open the file                                                  *
      ******************************************************************
       OPEN-OUTPUT-FILE.
           DISPLAY 'OPENING FILE FOR OUTPUT'
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
      * Write the records to the file                                  *
      ******************************************************************
       WRITE-OUTPUT-FILE.
           DISPLAY 'WRITING 1000 RECORDS, KEY = 1 -> 1000'.
       WRITE-LOOP.
           CALL 'RealiaFSWrite' USING RFS-HANDLE,
                                      RFS-RECORD-LENGTH
                                      GIVING RFS-STATUS.
           IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'WRITE FAILED, RFS-STATUS = ' RFS-STATUS
              GO TO CLOSE-OUTPUT-FILE.
           IF RFS-RECNUM IS LESS THAN 1000
               ADD 1 TO RFS-RECNUM
               GO TO WRITE-LOOP.

      ******************************************************************
      * Close the file
      ******************************************************************
       CLOSE-OUTPUT-FILE.
           DISPLAY 'CLOSING OUTPUT FILE'.
           CALL 'RealiaFSClose' USING RFS-HANDLE,
                                      RFS-CLOSE-MODE
                                      GIVING RFS-STATUS.
           IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'CLOSE FAILED, RFS-STATUS = ' RFS-STATUS.
           STOP RUN.
