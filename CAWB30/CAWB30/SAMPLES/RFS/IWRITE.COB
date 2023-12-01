      ******************************************************************
      * Program name: IWRITE.COB                                       *
      *                                                                *
      * Purpose: This program uses the CA-Realia callable file system  *
      *          to create an indexed file with 676 records of unique  *
      *          keys starting with values from 'AA' to 'ZZ'.          *
      *                                                                *
      *          The file is opened as follows:                        *
      *                                                                *
      *            Record length ................ 50                   *
      *            Code system .................. ASCII                *
      *            Open mode .................... OUTPUT               *
      *            Access mode .................. DYNAMIC              *
      *            Lock mode   .................. NONE                 *
      *            Dynamic file specification ... NO                   *
      *            Number of keys ............... 1                    *
      *                                                                *
      *          The record key is defined as follows:                 *
      *                                                                *
      *            Key start position ........... 7                    *
      *            Key length ................... 2                    *
      *            Key type ..................... ALPHANUMERIC         *
      *            Duplicate keys ............... NO                   *
      *            Null key character ........... NONE                 *
      *                                                                *
      ******************************************************************
      *
       COPY CARFSAPI SUPPRESS.
       IDENTIFICATION DIVISION.
       PROGRAM-ID.
           IWRITE.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.
           IBM-PC.
       OBJECT-COMPUTER.
           IBM-PC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      ******************************************************************
      * Key indexes for building data record keys                      *
      ******************************************************************
       77  KEY-INDEX-1 PIC S9(4) BINARY VALUE 1.
       77  KEY-INDEX-2 PIC S9(4) BINARY VALUE 1.

      ******************************************************************
      * Standard file close mode                                       *
      ******************************************************************
       77  RFS-CLOSE-MODE PIC S9(4) BINARY VALUE 0.

      ******************************************************************
      * Key table for building data record keys                        *
      ******************************************************************
       01  KEY-TABLE.
           05 KEY-ARRAY PIC X(26) VALUE 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
           05 KEY-CHAR REDEFINES KEY-ARRAY PIC X OCCURS 26 TIMES.

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
           05 RFS-ORGANIZATION      PIC S9(4) BINARY VALUE  2.
           05 RFS-OPEN-MODE         PIC S9(4) BINARY VALUE  3.
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
           05 RFS-HEADER          PIC X(7)  VALUE 'RECORD '.
           05 RFS-KEY-CHAR-1      PIC X     VALUE '?'.
           05 RFS-KEY-CHAR-2      PIC X     VALUE '?'.
           05 RFS-RECORD-TRAILER  PIC X(41) VALUE
                          ' XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'.

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
           DISPLAY 'WRITING 676 RECORDS, KEY = AA -> ZZ'.
       WRITE-LOOP.
           MOVE KEY-CHAR(KEY-INDEX-1) TO RFS-KEY-CHAR-1.
           MOVE KEY-CHAR(KEY-INDEX-2) TO RFS-KEY-CHAR-2.
           CALL 'RealiaFSWrite' USING RFS-HANDLE,
                                      RFS-RECORD-LENGTH
                                      GIVING RFS-STATUS.
           IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'WRITE FAILED, RFS-STATUS = ' RFS-STATUS
              GO TO CLOSE-OUTPUT-FILE.

           IF KEY-INDEX-2 IS EQUAL TO 26 AND KEY-INDEX-1 IS EQUAL
              TO 26 GO TO CLOSE-OUTPUT-FILE.
           IF KEY-INDEX-2 IS EQUAL TO 26 THEN
             MOVE 1 TO KEY-INDEX-2
             ADD 1 TO KEY-INDEX-1
           ELSE
             ADD 1 TO KEY-INDEX-2
           END-IF
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
