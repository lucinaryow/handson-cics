      ******************************************************************
      * Program name: BTSAMP.COB                                       *
      *                                                                *
      * Purpose: This program uses the BTRIEVE COBOL language          *
      *          interface to create a BTRIEVE file with 676           *
      *          records  of unique keys starting with values          *
      *          from 'AA' to 'ZZ'.                                    *
      *                                                                *
      *          The file is then read from start to end.              *
      *                                                                *
      *          The file is created as follows:                       *
      *                                                                *
      *            Record length ................ 50                   *
      *            Number of keys ............... 1                    *
      *            Page Size .................... 1024                 *
      *                                                                *
      *          The record key is defined as follows:                 *
      *                                                                *
      *            Key start position ........... 7                    *
      *            Key length ................... 2                    *
      *            Key type ..................... ALPHANUMERIC         *
      *            Duplicate keys ............... NO                   *
      *            Null key keys ................ NO                   *
      *                                                                *
      *                                                                *
      *  Notes:                                                        *
      *                                                                *
      *    The file is opened in accellerated mode for faster          *
      *    file loading.                                               *
      *                                                                *
      *  Linking Instructions:                                         *
      *                                                                *
      *    In order to link this program, you must link with           *
      *    realbtrv.obj and wbtrv32.lib (wbtrv32.lib is supplied       *
      *    with the BTRIEVE software development kit) as shown below:  *
      *                                                                *
      *      1. From the command line:                                 *
      *                                                                *
      *         linkcobm btsamp realbtrv.obj wbtrv32.lib               *
      *                                                                *
      *      2. From the CA-Realia COBOL Workbench:                    *
      *                                                                *
      *         Select the Build menu                                  *
      *         Select the Options menu                                *
      *         Select Program, Application or System Options Notebook *
      *         Click on the Link tab                                  *
      *         Click on the Objects tab                               *
      *         Add realbtrv.obj                                       *
      *         Click on the Libraries tab                             *
      *         Add wbtrv32.lib                                        *
      *                                                                *
      *  REALBTRV copy member:                                         *
      *                                                                *
      *    The copy member REALBTRV.CBL is used to prototype the call  *
      *    to the BTRIEVE interface BTRV. This allows the compiler to  *
      *    verify the number of parameters and parameter types which   *
      *    is a good programming practice. This copy member is not     *
      *    required to do the call. You can call the BTRV interface    *
      *    directly from COBOL without this copy member if you wish.   *
      ******************************************************************
      *
       COPY REALBTRV SUPPRESS.
       IDENTIFICATION DIVISION.
       PROGRAM-ID.
           BTSAMP.
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
      * Count of records read                                          *
      ******************************************************************
       77  BTRV-READ-COUNT       PIC S9(4) BINARY  VALUE 0.

      ******************************************************************
      * Key table for building data record keys                        *
      ******************************************************************
       01  KEY-TABLE.
           05 KEY-ARRAY PIC X(26) VALUE 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
           05 KEY-CHAR REDEFINES KEY-ARRAY PIC X OCCURS 26 TIMES.

      ******************************************************************
      * Data file record area                                          *
      ******************************************************************
       01  BTRV-REC-AREA.
           05 BTRV-HEADER          PIC X(7)  VALUE 'RECORD '.
           05 BTRV-KEY-CHAR-1      PIC X     VALUE '?'.
           05 BTRV-KEY-CHAR-2      PIC X     VALUE '?'.
           05 BTRV-RECORD-TRAILER  PIC X(41) VALUE
                          ' XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'.

      ******************************************************************
      * Parameters for calls to BTRV                                   *
      ******************************************************************
       77  BTRV-OPERATION        PIC S9(4) BINARY VALUE 0.
       77  BTRV-DATA-BUFFER-LEN  PIC S9(4) BINARY VALUE 32.
       77  BTRV-KEY-NUMBER       PIC S9(4) BINARY VALUE 0.

       01  BTRV-DATA-BUFFER.
           02  RECORD-LENGTH     PIC S9(4) BINARY VALUE 50.
           02  PAGE-SIZE         PIC S9(4) BINARY VALUE 1024.
           02  NUMBER-OF-INDEXES PIC S9(4) BINARY VALUE 1.
           02  NOT-USED-1        PIC X(4).
           02  VAR-REC-LEN       PIC S9(4) BINARY VALUE 0.
           02  NOT-USED-1A       PIC X(2).
           02  PRE-ALLOC         PIC S9(4) BINARY VALUE 0.
           02  KEY-SPECS.
               05 KEY-POSITION   PIC S9(4) BINARY VALUE 8.
               05 KEY-LENGTH     PIC S9(4) BINARY VALUE 2.
               05 KEY-FLAG       PIC S9(4) BINARY VALUE 0.
               05 NOT-USED-2     PIC X(4).
               05 KEY-EXTYPE     PIC 9 VALUE 0.
               05 KEY-NULL       PIC 9 VALUE 0.
               05 RESERVED       PIC X(4).

       01  BTRV-POS-BLOCK        PIC X(128) VALUE LOW-VALUES.
       01  BTRV-KEY-BUFFER       PIC X(255) VALUE LOW-VALUES.
       01  BTRV-STATUS           PIC S9(4)  BINARY.
       01  BTRV-FILE-NAME        PIC X(9)   VALUE "TEST.BTR ".

      ******************************************************************
      * Create the BTRIEVE file                                        *
      ******************************************************************
       PROCEDURE DIVISION.
       CREATE-BTRIEVE-FILE.
           DISPLAY 'CREATING FILE TEST.BTR'.
           MOVE 14 TO BTRV-OPERATION.

           CALL 'BTRV' USING BTRV-OPERATION,
                             BTRV-POS-BLOCK,
                             BTRV-DATA-BUFFER,
                             BTRV-DATA-BUFFER-LEN,
                             BTRV-FILE-NAME,
                             BTRV-KEY-NUMBER,
                             GIVING BTRV-STATUS.

           IF BTRV-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'CREATE FAILED, BTRV-STATUS = ' BTRV-STATUS
              STOP RUN.

      ******************************************************************
      * Open the BTRIEVE file                                          *
      ******************************************************************
       OPEN-BTRIEVE-FILE.
           DISPLAY 'OPENING FILE TEST.BTR'.
           MOVE  0 TO BTRV-OPERATION.
           MOVE -1 TO BTRV-KEY-NUMBER.
           MOVE  0 TO BTRV-DATA-BUFFER-LEN.

           CALL 'BTRV' USING BTRV-OPERATION,
                             BTRV-POS-BLOCK,
                             BTRV-DATA-BUFFER,
                             BTRV-DATA-BUFFER-LEN,
                             BTRV-FILE-NAME,
                             BTRV-KEY-NUMBER
                             GIVING BTRV-STATUS.

           IF BTRV-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'OPEN FAILED, BTRV-STATUS = ' BTRV-STATUS
              STOP RUN.

      ******************************************************************
      * Write the records to the file                                  *
      ******************************************************************
       WRITE-BTRIEVE-FILE.
           DISPLAY 'WRITING 676 RECORDS, KEY = AA -> ZZ'.

       WRITE-LOOP.
           MOVE KEY-CHAR(KEY-INDEX-1) TO BTRV-KEY-CHAR-1.
           MOVE KEY-CHAR(KEY-INDEX-2) TO BTRV-KEY-CHAR-2.
           MOVE 2 TO BTRV-OPERATION.
           MOVE 0 TO BTRV-KEY-NUMBER.
           MOVE 50 TO BTRV-DATA-BUFFER-LEN.

           CALL 'BTRV' USING BTRV-OPERATION,
                             BTRV-POS-BLOCK,
                             BTRV-REC-AREA,
                             BTRV-DATA-BUFFER-LEN,
                             BTRV-KEY-BUFFER,
                             BTRV-KEY-NUMBER
                             GIVING BTRV-STATUS.

           IF BTRV-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'WRITE FAILED, BTRV-STATUS = ' BTRV-STATUS
              STOP RUN.
           IF KEY-INDEX-2 IS EQUAL TO 26 AND KEY-INDEX-1 IS EQUAL
              TO 26 GO TO READ-BTRIEVE-FILE.
           IF KEY-INDEX-2 IS EQUAL TO 26 THEN
             MOVE 1 TO KEY-INDEX-2
             ADD 1 TO KEY-INDEX-1
           ELSE
             ADD 1 TO KEY-INDEX-2
           END-IF
           GO TO WRITE-LOOP.

      ******************************************************************
      * Read the records in the file                                   *
      ******************************************************************
       READ-BTRIEVE-FILE.
           DISPLAY 'READING FROM START TO END'.
           MOVE 5 TO BTRV-OPERATION.
           MOVE 'AA' TO BTRV-KEY-BUFFER.

       READ-LOOP.
           CALL 'BTRV' USING BTRV-OPERATION,
                             BTRV-POS-BLOCK,
                             BTRV-REC-AREA,
                             BTRV-DATA-BUFFER-LEN,
                             BTRV-KEY-BUFFER,
                             BTRV-KEY-NUMBER,
                             GIVING BTRV-STATUS.

           IF BTRV-STATUS IS NOT EQUAL TO ZERO THEN
              IF BTRV-STATUS IS EQUAL TO 9 AND BTRV-READ-COUNT = 676
                THEN GO TO CLOSE-BTRIEVE-FILE
              ELSE
                DISPLAY 'READ FAILED, BTRV-STATUS = ' BTRV-STATUS
              END-IF
              GO TO CLOSE-BTRIEVE-FILE.

           DISPLAY BTRV-REC-AREA.
           ADD 1 TO BTRV-READ-COUNT.
           MOVE 6 TO BTRV-OPERATION.
           GO TO READ-LOOP.

      ******************************************************************
      * Close the BTRIEVE file                                         *
      ******************************************************************
       CLOSE-BTRIEVE-FILE.
           DISPLAY 'CLOSING FILE TEST.BTR'.
           MOVE 1 TO BTRV-OPERATION.

           CALL 'BTRV' USING BTRV-OPERATION,
                             BTRV-POS-BLOCK,
                             BTRV-DATA-BUFFER,
                             BTRV-DATA-BUFFER-LEN,
                             BTRV-KEY-BUFFER,
                             BTRV-KEY-NUMBER
                             GIVING BTRV-STATUS.

           IF BTRV-STATUS IS NOT EQUAL TO ZERO
              DISPLAY 'CLOSE FAILED, BTRV-STATUS = ' BTRV-STATUS
              STOP RUN.
           STOP RUN.
