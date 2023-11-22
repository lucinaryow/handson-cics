         CBL XOPTS(COBOL2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SM03P.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.    IBM-PC.
       OBJECT-COMPUTER.    IBM-PC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-CURRENT-MAP  VALUE 'SM002'         PIC X(7).
       01  WS-TIME				         PIC 9(15) COMP-3.
       01  WS-DATE                               PIC 9(8).
       01  WS-DATE-X REDEFINES WS-DATE           PIC X(8). 
       01  WS-LENGTH                             PIC S9(4) COMP. 
       01  WS-END                                PIC X(14) VALUE
           'END PROCESSING'.
       01  WS-MAPFAIL                            PIC X(20) VALUE
           'MAPFAIL ERROR'.
       01  WS-INVALID			                 PIC X(14) VALUE
           'INVALID ACCESS'.       
       01  WS-COMMAREA. 
           05  WS-USERID1                         PIC X(7).
           05  WS-TICKET-NUM.
               10  WS-TICKET-NUM1                 PIC X(6).
               10  FILLER                         PIC X.
           05  WS-PROG-STATE                      PIC 9(1).  
           05  WS-INIT                            PIC X VALUE 'Y'. 
       
       01  WS-FIELD01.
           05 WS-STF01TCKID                      PIC X(6).
           05 WS-STF01TCKIDR REDEFINES WS-STF01TCKID PIC 9(06).
           05 WS-STF01TCKREQ                     PIC X(8).
           05 WS-STF01TCKSTAT                    PIC X(10).
           05 WS-STF01TCKTTL                     PIC X(25).
           05 WS-STF01TCKDESC                    PIC X(100).
           05 WS-STF01LSTUPD                     PIC X(20).
           05 WS-STF01LSTUPDBY                   PIC X(8).
           05 WS-STF01LSTUPDRMK                  PIC X(50).

       01  WS-TIX-REC.
           05  TIX-ID                            PIC X(06).
           05  TIX-REQUESTOR                     PIC X(08).
           05  TIX-STATUS                        PIC X(10). 
           05  TIX-TITLE                         PIC X(25).
           05  TIX-DESC                          PIC X(100). 
           05  TIX-DESC-RED REDEFINES TIX-DESC.
               10  TIX-DESC1                     PIC X(50).
               10  TIX-DESC2                     PIC X(50).
           05  LAST-UPDATE                       PIC X(20). 
           05  LAST-UPDATE-RED REDEFINES LAST-UPDATE.
               10  LAST-UPDATE-DATE              PIC X(11).
               10  LAST-UPDATE-TIME              PIC X(09).
           05  UPDATED-BY2.
               10  UPDBY2                        PIC X(7).
               10  FILLER                        PIC X.
           05  LAST-UPDATE-REM                   PIC X(50).
           05  LAST-UPDATE-REMW REDEFINES LAST-UPDATE-REM.
               10  LAST-UPDATE-REM1              PIC X(25).
               10  LAST-UPDATE-REM2              PIC X(25).

       01  WS-LOG.
           05  LOG-TIX-ID.
               10  LOG-TIX-ID1                   PIC X(6).
               10  LOG-SEQ-NUM                   PIC 9(3).
           05  LOG-LAST-UPDATE.
               10  LOG-LAST-UPDATE-DATE          PIC X(10).
               10  LOG-LAST-UPDATE-TIME          PIC X(10).
           05  LOG-UPDATED-BY.
               10  LOG-UPDBY2                    PIC X(7).
               10  FILLER                        PIC X.
           05  LOG-LAST-UPDATE-REM               PIC X(50).
           05  FILLER                            PIC X(02).

       01  WS-LOG-PH                             PIC X(9).
       01  WS-LOG-PH2 REDEFINES WS-LOG-PH.
           05  WS-LOG-ID                         PIC 9(6).
           05  WS-LOG-SEQ                        PIC 9(3).

       01  WS-HV                                 PIC X(20).  
       01  WS-RES-CODE                           PIC S9(8) COMP.
       01  WS-ENTRCTR                            PIC 9(1) VALUE 0.
       01  WS-HDATE                              PIC 9(10).
       01  WS-HDATE-X REDEFINES WS-HDATE         PIC X(10). 
       01  WS-HTIME                             PIC 9(15).
       01  WS-HTIME-X REDEFINES WS-HTIME         PIC X(8). 
       

      *
	   COPY SM003.
      *
	   COPY DFHAID.
      *
       COPY DFHBMSCA.

       LINKAGE SECTION.
       01  DFHCOMMAREA                           PIC X(20).
      *
       PROCEDURE DIVISION.
       100-PROCESS.

           EXEC CICS IGNORE CONDITION
                     ERROR 
           END-EXEC
           MOVE 0 TO WS-ENTRCTR
           MOVE DFHCOMMAREA TO WS-COMMAREA
           IF EIBTRNID = 'SM00' OR 'SM01'
               IF EIBCALEN NOT = +0
                
                 IF WS-PROG-STATE = '1' 
                   MOVE 'ENTER TICKET DETAILS AND PRESS PF2' TO ERRMSGO
                   MOVE 2 TO WS-PROG-STATE
                   
                   PERFORM 110-NEW-MAP
                 ELSE
                   PERFORM 200-REC-MAP
                 END-IF
               ELSE
                   MOVE DFHCOMMAREA TO WS-COMMAREA
                   MOVE 'ENTER TICKET DETAILS AND PRESS PF2' TO ERRMSGO
                   MOVE 1 TO WS-PROG-STATE
                   PERFORM 110-NEW-MAP
               
              
               END-IF
           ELSE    
               EXEC CICS SEND TEXT
                    FROM (WS-INVALID)
                    LENGTH (+15)
                    ERASE
               END-EXEC
               EXEC CICS RETURN
               END-EXEC
           END-IF.  

       

       110-NEW-MAP.
           
	       MOVE EIBDATE TO WS-DATE.
           MOVE WS-DATE-X TO DATEO.
           EXEC CICS ASKTIME
            ABSTIME (WS-TIME)
           END-EXEC

           EXEC CICS FORMATTIME
            ABSTIME (WS-TIME)
            DATESEP ('-')
            MMDDYY (DATEO)
            TIME (TIMEO)
            TIMESEP (':')
           END-EXEC
           
           MOVE DFHBMASB TO TIMEA
           MOVE DFHBMASB TO DATEA

           EXEC CICS 
            SEND MAP('SM003M')
            MAPSET('SM003')
            FROM(SM003MO)
            
            ERASE
           END-EXEC

           EXEC CICS RETURN
            TRANSID('SM03')
            COMMAREA(WS-COMMAREA)
           END-EXEC.

       200-REC-MAP.
           EXEC CICS 
               RECEIVE MAP('SM003M')
               MAPSET('SM003')
               INTO (SM003MI)
           END-EXEC

           IF EIBAID = DFHENTER
            MOVE 'ENTER PRESSED' TO ERRMSGO
           END-IF.