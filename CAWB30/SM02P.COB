         CBL XOPTS(COBOL2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SM02P.

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
      
       01  WS-ENTRCTR                            PIC 9(1).
       01  WS-HDATE                              PIC 9(10).
       01  WS-HDATE-X REDEFINES WS-HDATE         PIC X(10). 
       01  WS-HTIME                             PIC 9(15).
       01  WS-HTIME-X REDEFINES WS-HTIME         PIC X(8). 
       01  WS-RES-CODE                           PIC S9(8) COMP.
       

      *
	   COPY SM002.
      *
	   COPY DFHAID.
      *
       COPY DFHBMSCA.

       LINKAGE SECTION.
       01  DFHCOMMAREA                           PIC X(20).
      *
       PROCEDURE DIVISION.
       100-PROCESS.
           
           MOVE DFHCOMMAREA TO WS-COMMAREA
           IF EIBTRNID = 'SM00' OR 'SM01' OR 'SM02'
               IF EIBCALEN NOT = +0
                
                 IF WS-PROG-STATE = '1' 
                   MOVE 'ENTER TICKET DETAILS AND PRESS PF2' TO ERRMSGO
                   MOVE SPACES TO TIXTTLI
                   MOVE SPACES TO TIXDESC1I
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
            SEND MAP('SM002M')
            MAPSET('SM002')
            FROM(SM002MO)
            
            ERASE
           END-EXEC

           EXEC CICS RETURN
            TRANSID('SM02')
            COMMAREA(WS-COMMAREA)
           END-EXEC.

       200-REC-MAP.
           EXEC CICS 
               RECEIVE MAP('SM002M')
               MAPSET('SM002')
               INTO (SM002MI)
           END-EXEC

           IF EIBAID = DFHENTER
            IF WS-PROG-STATE = '2' 
             
             MOVE SPACES TO TIXTTLI
             MOVE SPACES TO TIXDESC1I
             MOVE SPACES TO TIXDESC2I
             MOVE SPACES TO STATI
             MOVE HIGH-VALUES TO WS-STF01TCKID
             MOVE 3 TO WS-PROG-STATE
            
            PERFORM 300-READ-STF1

            ELSE
            
             IF TIXTTLI NOT = SPACES AND TIXDESC1I NOT = SPACES
             
              MOVE 'PRESS PF2 TO ADD TICKET' TO ERRMSGO
              CONTINUE
             ELSE
              
              IF TIXTTLI = SPACES AND TIXDESC1I = SPACES
               MOVE 'TITLE AND DESCRIPTION IS REQUIRED' TO ERRMSGO
              END-IF

              IF TIXTTLI = SPACES AND TIXDESC1I NOT = SPACES
               MOVE 'TITLE IS REQUIRED' TO ERRMSGO
              END-IF

              IF TIXTTLI NOT = SPACES AND TIXDESC1I = SPACES
               MOVE 'DESCRIPTION IS REQUIRED' TO ERRMSGO
              END-IF

             END-IF

            END-IF

           END-IF 
           
           IF EIBAID = DFHPF2
            IF TIXNUML = ZERO OR TIXTTLI = SPACES OR TIXDESC1I = SPACES
             MOVE 'INVALID SPACES' TO ERRMSGO
             PERFORM 110-NEW-MAP
            ELSE
             MOVE 0 TO WS-ENTRCTR
             MOVE DFHDFHI TO UPDREMA
             MOVE DFHDFHI TO UPDDTA
             MOVE DFHDFHI TO UPDBY1A
             MOVE DFHDFHI TO UPDRMKA
             MOVE DFHDFHI TO UPDRMK1A
             MOVE DFHDFHI TO DATE1A
             MOVE DFHDFHI TO TIME1A
             MOVE DFHDFHI TO UPDBY2A

             MOVE SPACES TO WS-STF01TCKREQ
             MOVE SPACES TO WS-STF01TCKSTAT
             MOVE SPACES TO WS-STF01TCKTTL
             MOVE SPACES TO WS-STF01TCKDESC
             MOVE SPACES TO WS-STF01LSTUPD
             MOVE SPACES TO WS-STF01LSTUPDBY
             MOVE SPACES TO WS-STF01LSTUPDRMK

             MOVE TIXTTLI TO WS-STF01TCKTTL
             MOVE TIXDESC1O TO WS-STF01TCKDESC(1:50)
             MOVE TIXDESC2O TO WS-STF01TCKDESC(51:50)
             MOVE 'CREATED' TO STATI
             MOVE STATI TO WS-STF01TCKSTAT
             MOVE 'TICKET CREATED' TO UPDRMKI
             MOVE UPDRMKI TO WS-STF01LSTUPDRMK(1:25)
             MOVE UPDRMK1I TO WS-STF01LSTUPDRMK(26:25)
             MOVE WS-USERID1 TO UPDBY2I
             MOVE WS-USERID1 TO WS-STF01TCKREQ
             MOVE WS-USERID1 TO WS-STF01LSTUPDBY
             MOVE TIXNUMO TO WS-STF01TCKID
             
             MOVE EIBDATE TO WS-HDATE
             EXEC CICS ASKTIME
              ABSTIME (WS-HTIME)
             END-EXEC

             EXEC CICS FORMATTIME
              ABSTIME (WS-HTIME)
              DATESEP ('/')
              MMDDYYYY (WS-HDATE-X)
              TIME (WS-HTIME)
              TIMESEP (':')
             END-EXEC
             
             MOVE WS-HDATE-X TO WS-STF01LSTUPD(1:10)
             MOVE WS-HDATE-X TO DATE1O
             MOVE WS-HTIME-X TO WS-STF01LSTUPD(11:10)
             MOVE WS-HTIME-X TO TIME1O
             
             EXEC CICS
              WRITE FILE('STf00001')
              FROM (WS-FIELD01)
              RIDFLD (WS-STF01TCKID)
              RESP(WS-RES-CODE)
             END-EXEC
             END-IF

             IF EIBRESP NOT = DFHRESP(NORMAL)
              MOVE 'TICKET NOT CREATED' TO ERRMSGO
             ELSE
              MOVE 'TICKET CREATED, PRESS ENTER TO CREATE NEW TICKET' 
              TO ERRMSGO
              PERFORM 400-CREATE-LOG
              MOVE SPACES TO WS-FIELD01
              MOVE DFHBMPRO TO TIXTTLA
              MOVE DFHBMPRO TO TIXDESC1A
              MOVE DFHBMPRO TO TIXDESC2A
              MOVE DFHBMPRO TO STATA
              MOVE DFHBMPRO TO UPDRMKA
              MOVE DFHBMPRO TO UPDRMK1A
              MOVE DFHBMPRO TO DATE1A
              MOVE DFHBMPRO TO TIME1A
              MOVE DFHBMPRO TO UPDBY2A
              
             END-IF
             
             
           END-IF


           IF EIBAID = DFHPF3
            IF WS-PROG-STATE = '1'
             EXEC CICS SEND TEXT
              FROM (WS-END)
              LENGTH (15)
              ERASE
             END-EXEC 
             EXEC CICS RETURN END-EXEC    
            ELSE
             EXEC CICS XCTL
              PROGRAM('SM000')
             END-EXEC
            END-IF
           END-IF
           
           IF EIBAID = DFHPF5
            MOVE SPACES TO ERRMSGO
            MOVE SPACES TO TIXNUMO
            MOVE SPACES TO TIXTTLO
            MOVE SPACES TO TIXDESC1O
            MOVE SPACES TO TIXDESC2O
            MOVE 2 TO WS-PROG-STATE
            PERFORM 110-NEW-MAP
           END-IF.
       
       300-READ-STF1.

           EXEC CICS STARTBR 
            FILE('STf00001')
            RIDFLD (WS-STF01TCKID)
            RESP(WS-RES-CODE)
            GTEQ
           END-EXEC

           EXEC CICS READNEXT 
            FILE('STf00001')
            INTO (WS-FIELD01)
            RIDFLD (WS-STF01TCKID)
            RESP(WS-RES-CODE)
           END-EXEC

           IF EIBRESP = DFHRESP(NORMAL)
            COMPUTE WS-STF01TCKIDR = WS-STF01TCKIDR + 1
            MOVE WS-STF01TCKIDR TO TIXNUMO
            MOVE WS-STF01TCKID TO WS-TICKET-NUM
            MOVE 1 TO WS-ENTRCTR
           END-IF.
       
       400-CREATE-LOG.
           MOVE WS-TICKET-NUM TO LOG-TIX-ID1
           MOVE 1 TO LOG-SEQ-NUM
           MOVE LOG-TIX-ID TO WS-LOG-PH
           EXEC CICS STARTBR FILE('STf00002')
                RIDFLD (LOG-TIX-ID)
                KEYLENGTH(+9)
                RESP(WS-RES-CODE)
                GTEQ
           END-EXEC
           PERFORM UNTIL EIBRESP = DFHRESP(NOTFND)
               EXEC CICS READPREV
                         FILE('STf00002')
                         INTO (WS-LOG)
                         RIDFLD (LOG-TIX-ID)
                         RESP(WS-RES-CODE)
               END-EXEC
               IF WS-LOG-PH(1:6) NOT = LOG-TIX-ID1
                   CONTINUE
               ELSE 
                   MOVE LOG-TIX-ID TO WS-LOG-PH
               END-IF
               ADD 1 TO LOG-SEQ-NUM
           END-PERFORM

           MOVE WS-LOG-PH TO LOG-TIX-ID
           MOVE WS-HTIME-X TO LOG-LAST-UPDATE-TIME
           MOVE WS-HDATE-X TO LOG-LAST-UPDATE-DATE
           MOVE WS-USERID1 TO LOG-UPDBY2
           MOVE UPDRMKI TO LOG-LAST-UPDATE-REM(1:25)
           MOVE UPDRMK1I TO LOG-LAST-UPDATE-REM(26:25)
           EXEC CICS 
               WRITE FILE('STF00002')
               FROM(WS-LOG)
               RIDFLD(LOG-TIX-ID)
               RESP(WS-RES-CODE)
           END-EXEC.