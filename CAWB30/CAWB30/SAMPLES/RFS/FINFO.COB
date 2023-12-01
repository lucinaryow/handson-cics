      ******************************************************************
      * Program name: FINFO.COB                                        *
      *                                                                *
      * Purpose: This program uses the CA-Realia callable file system  *
      *          to get the file and key information from a CA-Realia  *
      *          COBOL indexed file.                                   *
      *                                                                *
      * Note: You must create the data file IXF1 with the program      *
      *       IWRITE.COB before running this program.                  *
      ******************************************************************
      *
       COPY CARFSAPI SUPPRESS.
       IDENTIFICATION DIVISION.
       PROGRAM-ID.
           FINFO.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.
           IBM-PC.
       OBJECT-COMPUTER.
           IBM-PC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

      ******************************************************************
      * RFSAPI status                                                  *
      ******************************************************************
       01  RFS-STATUS             PIC S9(4) BINARY.

      ******************************************************************
      * RFSAPI file type                                               *
      ******************************************************************
       01  RFS-FILE-TYPE          PIC X.

      ******************************************************************
      * RFSAPI parameter block                                         *
      ******************************************************************
       01  RFS-PARM-BLOCK.
           05 RFS-RECORD-LENGTH     PIC S9(9) BINARY VALUE  0.
           05 RFS-MIN-RECORD-LENGTH PIC S9(9) BINARY VALUE  0.
           05 RFS-CODE-SYSTEM       PIC S9(4) BINARY VALUE  0.
           05 RFS-ORGANIZATION      PIC S9(4) BINARY VALUE  0.
           05 RFS-OPEN-MODE         PIC S9(4) BINARY VALUE  0.
           05 RFS-ACCESS-MODE       PIC S9(4) BINARY VALUE  0.
           05 RFS-LOCK-MODE         PIC S9(4) BINARY VALUE  0.
           05 RFS-DYNAMIC-FILE      PIC S9(4) BINARY VALUE  0.
           05 RFS-NUM-KEYS          PIC S9(4) BINARY VALUE  0.
           05 RFS-RESERVED          PIC S9(4) BINARY VALUE  0.

      ******************************************************************
      * RFSAPI key decriptor block                                     *
      ******************************************************************
       01  RFS-KEY-BLOCK.
           05 RFS-KEY-START       PIC S9(9) BINARY VALUE  0.
           05 RFS-KEY-LENGTH      PIC S9(9) BINARY VALUE  0.
           05 RFS-KEY-TYPE        PIC S9(4) BINARY VALUE  0.
           05 RFS-KEY-DUP         PIC S9(4) BINARY VALUE  0.
           05 RFS-KEY-NULL        PIC S9(4) BINARY VALUE  0.
           05 RFS-KEY-RESERVED    PIC S9(4) BINARY VALUE  0.

      ******************************************************************
      * Data file specification                                        *
      ******************************************************************
       01  RFS-FILE-SPEC.
           05 RFS-FILE-NAME      PIC X(4) VALUE 'IXF1'.

       PROCEDURE DIVISION.
      ******************************************************************
      * Get the file information                                       *
      ******************************************************************
       GET-FILE-INFO.
           CALL 'RealiaFSFileInfo' USING RFS-FILE-SPEC,
                                          RFS-PARM-BLOCK,
                                          RFS-FILE-TYPE,
                                          GIVING RFS-STATUS.

           IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'FILE INFO FAILED, RFS-STATUS = ' RFS-STATUS
              STOP RUN.

           CALL 'RealiaFSKeyInfo' USING RFS-FILE-SPEC,
                                        RFS-PARM-BLOCK,
                                        RFS-KEY-BLOCK,
                                        GIVING RFS-STATUS.
           IF RFS-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'KEY INFO FAILED, RFS-STATUS = ' RFS-STATUS
              STOP RUN.

           DISPLAY 'FILE TYPE ............ ' RFS-FILE-TYPE
           DISPLAY 'FILE ORGANIZATION .... ' RFS-ORGANIZATION
           DISPLAY 'FILE RECORD LENGTH ... ' RFS-RECORD-LENGTH
           DISPLAY 'FILE MIN RECORD LENGTH ' RFS-MIN-RECORD-LENGTH
           DISPLAY 'FILE CODE SYSTEM ..... ' RFS-CODE-SYSTEM
           DISPLAY 'NUMBER OF KEYS ....... ' RFS-NUM-KEYS

           DISPLAY ' '
           DISPLAY 'KEY START ............ ' RFS-KEY-START
           DISPLAY 'KEY LENGTH ........... ' RFS-KEY-LENGTH
           DISPLAY 'KEY TYPE ............. ' RFS-KEY-TYPE
           DISPLAY 'DUPLICATES ALLOWED ... ' RFS-KEY-DUP
           DISPLAY 'NULL KEY TYPE ........ ' RFS-KEY-NULL
           STOP RUN.
