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
           05  WS-CA-PRGNAME           PIC X(06).
           05  FILLER                  PIC X(19).
           05  WS-DFHSTATE             PIC X(15). 
           05  WS-TRANS                PIC X(04).  
           05  WS-LUSER                PIC 9(03).
           05  WS-FUSER                PIC 9(03).
           05  WS-PAGE                 PIC 9(02).
           05  WS-PAGE-END             PIC 9(01).
           05  WS-QITEM                PIC S9(4) COMP.
           05  WS-QITEM-START          PIC S9(4) COMP.
           05  WS-QITEM-END            PIC S9(4) COMP.
           05  WS-QITEM-PAGE           PIC S9(4) COMP.
           05  WS-USERID1                         PIC X(7).
           05  WS-USER-REC.
               10  USERID.
                   15  USERID1                       PIC X(7).
                   15  FILLER                        PIC X.
               10  REQUESTOR                         PIC X.
               10  ADMINISTRATOR                     PIC X. 
               10  APPROVER                          PIC X. 
               10  SERVICE-PROVIDER                  PIC X. 
               10  UPDATED-BY1.
                   15  UPDBY1                        PIC X(7).
                   15  FILLER                        PIC X.
           05  WS-TIX-REC.
               10  TIX-ID                            PIC X(06).
               10  TIX-REQUESTOR                     PIC X(08).
               10  TIX-STATUS                        PIC X(10). 
               10  TIX-TITLE                         PIC X(25).
               10  TIX-DESC                          PIC X(100). 
               10  TIX-DESC-RED REDEFINES TIX-DESC.
                   15  TIX-DESC1                     PIC X(50).
                   15  TIX-DESC2                     PIC X(50).
               10  LAST-UPDATE                       PIC X(20). 
               10  LAST-UPDATE-RED REDEFINES LAST-UPDATE.
                   15  LAST-UPDATE-DATE              PIC X(11).
                   15  LAST-UPDATE-TIME              PIC X(09).
               10  UPDATED-BY2.
                   15  UPDBY2                        PIC X(7).
                   15  FILLER                        PIC X.
               10  LAST-UPDATE-REM                   PIC X(50).
               10  LAST-UPDATE-REMW REDEFINES LAST-UPDATE-REM.
                   15  LAST-UPDATE-REM1              PIC X(25).
                   15  LAST-UPDATE-REM2              PIC X(25).
           05  WS-USER                         PIC X(7).
           05  WS-TICKET-NUM.
               10  WS-TICKET-NUM1                 PIC X(6).
               10  FILLER                         PIC X.
           05  WS-PROG-STATE                      PIC 9(1).  
           05  WS-INIT                            PIC X VALUE 'Y'.   
           05  WS-ID                            PIC X(4).
           05  READ1  PIC X VALUE 'N'.
           05  WS-TNUM  PIC X(06).
           05  WS-TCKID                           PIC X(6).
           05  WS-TCKREQ                          PIC X(8).
           05  WS-TCKSTAT                         PIC X(10).
           05  WS-TCKTTL                          PIC X(25).
           05  WS-TCKDESC                         PIC X(100).
           05  WS-LSTUPD                          PIC X(20).
           05  WS-STUPDBY                         PIC X(8).
           05  WS-LSTUPDRMK                       PIC X(50).
           05  WS-REQUESTOR                       PIC X.
           05  WS-ADMINISTRATOR                   PIC X.
           05  WS-APPROVER                        PIC X.
           05  WS-SERVICE-PROVIDER                PIC X.

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
       01  DFHCOMMAREA                           PIC X(500).
      *
       PROCEDURE DIVISION.
       100-PROCESS.

           EXEC CICS IGNORE CONDITION
                     ERROR 
           END-EXEC
           
           MOVE DFHCOMMAREA TO WS-COMMAREA
           PERFORM 1000-VALIDATION
           IF EIBTRNID = 'SM00' OR 'SM01' OR 'SM03' OR  'SM012'
               IF EIBCALEN NOT = +0
                 
               
                 IF WS-PROG-STATE = '1' 
                   MOVE 'ENTER TICKET NUMBER AND PRESS ENTER' TO ERRMSGO
                   MOVE WS-TICKET-NUM TO TIXNUMO
                   MOVE WS-TCKREQ TO REQBYO
                   MOVE WS-TCKSTAT TO STATO
                   MOVE WS-TCKTTL TO TIXTTLO
                   MOVE WS-TCKDESC(1:50) TO TIXDESC1O
                   MOVE WS-TCKDESC(51:50) TO TIXDESC2O
                   MOVE WS-LSTUPD(1:10) TO DATE1O
                   MOVE WS-LSTUPD(11:10) TO TIME1O
                   MOVE WS-LSTUPDRMK(1:25) TO UPDRMKO
                   MOVE WS-LSTUPDRMK(26:25) TO UPDRMK1O

                   IF WS-TICKET-NUM = '0'
                    MOVE SPACES TO TIXNUMO
                   END-IF

                   MOVE 2 TO WS-PROG-STATE
                   PERFORM 110-NEW-MAP
                 ELSE
                   MOVE WS-TICKET-NUM TO TIXNUMO
                   PERFORM 200-REC-MAP
                 END-IF
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
           IF WS-PROG-STATE = '3'
            PERFORM 700-READ-FILE

            IF TIXTTLI = LOW-VALUES
             MOVE TIX-TITLE TO TIXTTLI
            END-IF
            
            IF REQBYI = LOW-VALUES
             MOVE TIX-REQUESTOR TO REQBYI
            END-IF

            IF TIXDESC1I = LOW-VALUES
             MOVE TIX-DESC1 TO TIXDESC1I 
            END-IF
       
            IF TIXDESC2I = LOW-VALUES
             MOVE TIX-DESC2 TO TIXDESC2I
            END-IF

            IF STATI = LOW-VALUES
             MOVE TIX-STATUS TO STATI
            END-IF

            IF UPDRMKI = LOW-VALUES
             MOVE LAST-UPDATE-REM1 TO UPDRMKI
            END-IF 

            IF UPDRMK1I = LOW-VALUES
             MOVE LAST-UPDATE-REM2 TO UPDRMK1I
            END-IF 
            
             MOVE WS-TICKET-NUM1 TO TIXNUMI
           END-IF
          

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
            IF TIXNUMO = SPACES
             MOVE 'INVALID SPACES IN TIX NO' TO ERRMSGO
            ELSE
              IF WS-PROG-STATE = '2'
              
               MOVE TIXNUMO TO WS-TICKET-NUM1
               PERFORM 300-VALIDATE-TICKET
       
              ELSE IF WS-PROG-STATE = '3'

               PERFORM 600-VALIDATE-ENTRY

              ELSE
               MOVE SPACES TO WS-TICKET-NUM
               MOVE SPACES TO WS-TCKID
               MOVE SPACES TO WS-TCKREQ
               MOVE SPACES TO WS-TCKSTAT
               MOVE SPACES TO WS-TCKTTL
               MOVE SPACES TO WS-TCKDESC
               MOVE SPACES TO WS-LSTUPD
               MOVE SPACES TO WS-STUPDBY
               MOVE SPACES TO WS-LSTUPDRMK
              
               MOVE SPACES TO TIXNUMO
               MOVE SPACES TO REQBYO
               MOVE SPACES TO STATO
               MOVE SPACES TO TIXTTLO
               MOVE SPACES TO TIXDESC1O
               MOVE SPACES TO TIXDESC2O
               MOVE SPACES TO DATE1O
               MOVE SPACES TO TIME1O
               MOVE SPACES TO UPDRMKO
               MOVE SPACES TO UPDRMK1O
               MOVE SPACES TO UPDBYO
               
               MOVE DFHBMUNP TO TIXNUMA
               MOVE DFHBMPRO TO REQBYA
               MOVE DFHBMPRO TO STATA
               MOVE DFHBMPRO TO TIXTTLA
               MOVE DFHBMPRO TO TIXDESC1A
               MOVE DFHBMPRO TO TIXDESC2A
               MOVE DFHBMPRO TO DATE1A
               MOVE DFHBMPRO TO TIME1A
               MOVE DFHBMPRO TO UPDRMKA
               MOVE DFHBMPRO TO UPDRMK1A
               
               MOVE 2 TO WS-PROG-STATE
               MOVE 'ENTER TICKET NUMBER AND PRESS ENTER' TO ERRMSGO

               PERFORM 110-NEW-MAP
               
              END-IF
           
            END-IF
           END-IF
           END-IF

           IF EIBAID = DFHPF2
            IF TIXNUMI = SPACES
             MOVE 'INVALID KEY PRESSED' TO ERRMSGO
            ELSE
             IF WS-PROG-STATE = '3'
              
              PERFORM 700-READ-FILE

              IF STATO = LOW-VALUES
               MOVE WS-TCKSTAT TO STATO
              END-IF

              IF TIXTTLO = LOW-VALUES AND TIXDESC1O = LOW-VALUES 
              AND TIXDESC2O = LOW-VALUES AND UPDRMKO = LOW-VALUES
              AND UPDRMK1O = LOW-VALUES AND STATO = TIX-STATUS

               MOVE 'NO CHANGES' TO ERRMSGO
              MOVE DFHBMUNP TO TIXTTLA
              MOVE DFHBMUNP TO TIXDESC1A
              MOVE DFHBMUNP TO TIXDESC2A
              MOVE DFHBMUNP TO UPDRMKA
              MOVE DFHBMUNP TO UPDRMK1A
              MOVE DFHBMUNP TO STATA
              MOVE WS-TCKTTL TO TIXTTLO
              MOVE WS-TCKDESC(1:50) TO TIXDESC1O
              MOVE WS-TCKDESC(51:50) TO TIXDESC2O
              MOVE WS-LSTUPDRMK(1:25) TO UPDRMKO
              MOVE WS-LSTUPDRMK(26:25) TO UPDRMK1O
              MOVE WS-TCKSTAT TO STATO

              ELSE
               IF STATO NOT = 'APPROVED' 
               AND STATO NOT = 'ONGOING' 
               AND STATO NOT = 'COMPLETED'

               MOVE DFHBMUNP TO TIXTTLA
               MOVE DFHBMUNP TO TIXDESC1A
               MOVE DFHBMUNP TO TIXDESC2A
               MOVE DFHBMUNP TO UPDRMKA
               MOVE DFHBMUNP TO UPDRMK1A
               MOVE DFHBMUNP TO STATA

               MOVE TIXTTLO TO WS-TCKTTL
               MOVE TIXDESC1O TO WS-TCKDESC(1:50)
               MOVE TIXDESC2O TO WS-TCKDESC(51:50)
               MOVE UPDRMKO TO WS-LSTUPDRMK(1:25)
               MOVE UPDRMK1O TO WS-LSTUPDRMK(26:25)
               MOVE STATO TO WS-TCKSTAT

               MOVE WS-TCKTTL TO TIXTTLO
               MOVE WS-TCKDESC(1:50) TO TIXDESC1O
               MOVE WS-TCKDESC(51:50) TO TIXDESC2O
               MOVE WS-LSTUPDRMK(1:25) TO UPDRMKO
               MOVE WS-LSTUPDRMK(26:25) TO UPDRMK1O
               MOVE WS-TCKSTAT TO STATO
               MOVE 'STATUS SHOULD BE ONGOING OR COMPLETED' TO ERRMSGO 
         
            
               ELSE
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

                MOVE WS-HDATE-X TO LAST-UPDATE-DATE
                MOVE WS-HDATE-X TO DATE1O
                MOVE WS-HTIME-X TO LAST-UPDATE-TIME
                MOVE WS-HTIME-X TO TIME1O
                
               PERFORM 800-CREATE-LOG

               EXEC CICS 
                READ FILE('STF00001')
                INTO (WS-TIX-REC)
                RIDFLD (WS-TICKET-NUM1)
                RESP(WS-RES-CODE)
                EQUAL 
                UPDATE
               END-EXEC
                IF TIXTTLI NOT = LOW-VALUES
                 MOVE TIXTTLI TO TIX-TITLE
                END-IF

                IF TIXDESC1I NOT = LOW-VALUES
                 MOVE TIXDESC1I TO TIX-DESC1
                END-IF

                IF TIXDESC2I NOT = LOW-VALUES
                 MOVE TIXDESC2I TO TIX-DESC2
                END-IF

                IF STATO NOT = LOW-VALUES
                 MOVE STATO TO TIX-STATUS
                END-IF

                IF UPDRMKI NOT = LOW-VALUES
                 MOVE UPDRMKI TO LAST-UPDATE-REM1
                END-IF 
             
                IF UPDRMK1I NOT = LOW-VALUES
                 MOVE UPDRMK1I TO LAST-UPDATE-REM2
                END-IF 

                IF DATE1I NOT = LOW-VALUES
                 MOVE DATE1I TO LAST-UPDATE-DATE
                END-IF 

                IF TIME1I NOT = LOW-VALUES
                 MOVE TIME1I TO LAST-UPDATE-TIME
                END-IF 
                  
                PERFORM 900-CREATE-LOG-2

                EXEC CICS 
                REWRITE FILE('STF00001')
                 FROM(WS-TIX-REC)
                 RESP(WS-RES-CODE)
                END-EXEC

                 IF EIBRESP = DFHRESP(NORMAL)
             MOVE 'TICKET UPDATED, PRESS ENTER TO UPDATE ANOTHER TICKET' 
             TO ERRMSGO
                  MOVE 4 TO WS-PROG-STATE
                  
                 ELSE
                  MOVE 'ERROR UPDATE' TO ERRMSGO
                 END-IF
           

             ELSE 
              
              MOVE 'INVALID KEY PRESSED' TO ERRMSGO
              
             END-IF

            END-IF
           END-IF.

       300-VALIDATE-TICKET.
           EXEC CICS 
               READ FILE('STF00001')
               INTO (WS-TIX-REC)
               RIDFLD (WS-TICKET-NUM1)
               RESP(WS-RES-CODE)
               EQUAL 
           END-EXEC
           IF EIBRESP = DFHRESP(NOTFND)
               
               MOVE 'TICKET NUMBER DOES NOT EXIST' TO ERRMSGO
           ELSE 
             IF TIX-STATUS = 'APPROVED' OR TIX-STATUS = 'ONGOING'
              IF WS-REQUESTOR = 'Y' OR WS-SERVICE-PROVIDER = 'Y'
               IF WS-REQUESTOR = 'Y' AND (WS-SERVICE-PROVIDER = 'N' 
               AND WS-APPROVER = 'N' AND WS-ADMINISTRATOR = 'N')
                
                IF WS-USERID1 = WS-TCKREQ 
                 PERFORM 500-TICKET-REC

                ELSE
                 MOVE 'INVALID ACCESS TO THE TICKET' TO ERRMSGO
                END-IF 
               ELSE IF WS-SERVICE-PROVIDER = 'Y'
                 PERFORM 500-TICKET-REC
                 
               END-IF 
              ELSE 

               MOVE 'INVALID ACCESS TO THE TICKET' TO ERRMSGO

              END-IF 
             ELSE
               MOVE 'INVALID TICKET STATUS' TO ERRMSGO
             END-IF  

           END-IF.
       
       400-SEARCH-USER.

           EXEC CICS ASSIGN   
               USERID(WS-USERID1) 
           END-EXEC      
           EXEC CICS 
               READ FILE('UAF00001')
               INTO (WS-USER-REC)
               RIDFLD (WS-USERID1)
               RESP(WS-RES-CODE)
               GTEQ 
           END-EXEC
           IF WS-RES-CODE NOT = +00 OR (REQUESTOR = 'N' 
           AND SERVICE-PROVIDER = 'N' AND APPROVER = 'N' 
           AND ADMINISTRATOR = 'N')
               EXEC CICS SEND TEXT
                   FROM (WS-INVALID)
                   LENGTH (+25)
                   ERASE 
               END-EXEC
               EXEC CICS RETURN END-EXEC
           ELSE
            MOVE 'UPDATED BY THE USER' TO ERRMSGO
            
            MOVE 1 TO WS-PROG-STATE
           END-IF.

       500-TICKET-REC.    
           
           MOVE 3 TO WS-PROG-STATE
           MOVE TIX-REQUESTOR TO WS-TCKREQ
           MOVE TIX-STATUS TO WS-TCKSTAT
           MOVE TIX-TITLE TO WS-TCKTTL
           MOVE TIX-DESC TO WS-TCKDESC
           MOVE LAST-UPDATE TO WS-LSTUPD
           MOVE UPDATED-BY2 TO WS-STUPDBY
           MOVE LAST-UPDATE-REMW TO WS-LSTUPDRMK

           MOVE WS-TICKET-NUM1 TO TIXNUMO
           MOVE WS-TCKREQ TO REQBYO
           MOVE WS-TCKSTAT TO STATO
           MOVE WS-TCKTTL TO TIXTTLO
           MOVE WS-TCKDESC(1:50) TO TIXDESC1O
           MOVE WS-TCKDESC(51:50) TO TIXDESC2O
           MOVE WS-LSTUPD(1:10) TO DATE1O
           MOVE WS-LSTUPD(11:10) TO TIME1O
           MOVE WS-LSTUPDRMK(1:25) TO UPDRMKO
           MOVE WS-LSTUPDRMK(26:25) TO UPDRMK1O
           MOVE WS-STUPDBY TO UPDBYO
           
           MOVE DFHBMPRO TO TIXNUMA
           MOVE DFHBMUNP TO TIXTTLA
           MOVE DFHBMUNP TO TIXDESC1A
           MOVE DFHBMUNP TO TIXDESC2A
           MOVE DFHBMUNP TO STATA
           MOVE DFHBMUNP TO UPDRMKA
           MOVE DFHBMUNP TO UPDRMK1A
           
           MOVE 'ENTER UPDATES' TO ERRMSGO.
       
       600-VALIDATE-ENTRY.

           IF TIXTTLI = SPACES AND TIXDESC1I = SPACES 
           AND TIXDESC2I = SPACES
            MOVE 'REQUIRED FIELDS' TO ERRMSGO
           ELSE

            IF TIXTTLO = LOW-VALUES
             MOVE WS-TCKTTL TO TIXTTLO
            ELSE
             MOVE TIXTTLO TO WS-TCKTTL
            END-IF
            
            IF TIXDESC1O = LOW-VALUES
             MOVE WS-TCKDESC(1:50) TO TIXDESC1O
            ELSE
             MOVE TIXDESC1O TO WS-TCKDESC(1:50) 
            END-IF

            IF TIXDESC2O = LOW-VALUES
             MOVE WS-TCKDESC(51:50) TO TIXDESC2O
            ELSE
             MOVE TIXDESC2O TO WS-TCKDESC(51:50)
            END-IF

            IF STATO = LOW-VALUES
             MOVE WS-TCKSTAT TO STATO
            ELSE
             MOVE STATO TO WS-TCKSTAT
            END-IF

            IF UPDRMKO = LOW-VALUES
             MOVE WS-LSTUPDRMK(1:25) TO UPDRMKO
            ELSE
             MOVE UPDRMKO TO WS-LSTUPDRMK(1:25) 
            END-IF

            IF UPDRMK1O = LOW-VALUES
             MOVE WS-LSTUPDRMK(26:25) TO UPDRMK1O
            ELSE
             MOVE UPDRMK1O To WS-LSTUPDRMK(26:25)
            END-IF


            IF STATO NOT = 'APPROVED' 
            AND STATO NOT = 'ONGOING' 
            AND STATO NOT = 'COMPLETED'

              MOVE DFHBMUNP TO TIXTTLA
              MOVE DFHBMUNP TO TIXDESC1A
              MOVE DFHBMUNP TO TIXDESC2A
              MOVE DFHBMUNP TO UPDRMKA
              MOVE DFHBMUNP TO UPDRMK1A
              MOVE DFHBMUNP TO STATA

              MOVE TIXTTLO TO WS-TCKTTL
              MOVE TIXDESC1O TO WS-TCKDESC(1:50)
              MOVE TIXDESC2O TO WS-TCKDESC(51:50)
              MOVE UPDRMKO TO WS-LSTUPDRMK(1:25)
              MOVE UPDRMK1O TO WS-LSTUPDRMK(26:25)
              MOVE STATO TO WS-TCKSTAT

              MOVE WS-TCKTTL TO TIXTTLO
              MOVE WS-TCKDESC(1:50) TO TIXDESC1O
              MOVE WS-TCKDESC(51:50) TO TIXDESC2O
              MOVE WS-LSTUPDRMK(1:25) TO UPDRMKO
              MOVE WS-LSTUPDRMK(26:25) TO UPDRMK1O
              MOVE WS-TCKSTAT TO STATO
              MOVE 'STATUS SHOULD BE ONGOING OR COMPLETED' TO ERRMSGO 
         
            
            ELSE
               IF (TIXTTLO = SPACES OR TIXTTLO = LOW-VALUES)
               AND (TIXDESC1O = SPACES OR TIXDESC1O = LOW-VALUES)
               AND (TIXDESC2O = SPACES OR TIXDESC2O = LOW-VALUES OR
               UPDRMK1O = SPACES OR UPDRMK1O = LOW-VALUES)

               MOVE 
               'TITLE AND DESCRIPTION ARE REQUIRED' 
               TO ERRMSGO
               MOVE DFHBMUNP TO TIXTTLA
               MOVE DFHBMUNP TO TIXDESC1A
               MOVE DFHBMUNP TO TIXDESC2A
               MOVE DFHBMUNP TO UPDRMKA
               MOVE DFHBMUNP TO UPDRMK1A
               MOVE DFHBMUNP TO STATA

               ELSE IF (TIXTTLO = SPACES OR TIXTTLO = LOW-VALUES)
               AND (TIXDESC1O = SPACES OR TIXDESC1O = LOW-VALUES)

               MOVE 
               'TITLE AND DESCRIPTION ARE REQUIRED' TO ERRMSGO

               MOVE DFHBMUNP TO TIXTTLA
               MOVE DFHBMUNP TO TIXDESC1A
               MOVE DFHBMUNP TO TIXDESC2A
               MOVE DFHBMUNP TO UPDRMKA
               MOVE DFHBMUNP TO UPDRMK1A
               MOVE DFHBMUNP TO STATA

               ELSE IF (TIXTTLO = SPACES OR TIXTTLO = LOW-VALUES)
               AND (UPDRMKO = SPACES OR UPDRMKO = LOW-VALUES)
               AND (TIXDESC2O = SPACES OR TIXDESC2O = LOW-VALUES OR
               UPDRMK1O = SPACES OR UPDRMK1O = LOW-VALUES)

               MOVE 
               'TITLE AND DESCRIPTION 2 OR RMK 2 ARE REQUIRED' 
               TO ERRMSGO

               MOVE DFHBMUNP TO TIXTTLA
               MOVE DFHBMUNP TO TIXDESC1A
               MOVE DFHBMUNP TO TIXDESC2A
               MOVE DFHBMUNP TO UPDRMKA
               MOVE DFHBMUNP TO UPDRMK1A
               MOVE DFHBMUNP TO STATA

               ELSE IF (TIXTTLO = SPACES OR TIXTTLO = LOW-VALUES)
               AND (TIXDESC1O = SPACES OR TIXDESC1O = LOW-VALUES)
               AND (UPDRMKO = SPACES OR UPDRMKO = LOW-VALUES)

               MOVE 
               'TITLE, DESCRIPTION AND REMARKS ARE REQUIRED' 
               TO ERRMSGO

               MOVE DFHBMUNP TO TIXTTLA
               MOVE DFHBMUNP TO TIXDESC1A
               MOVE DFHBMUNP TO TIXDESC2A
               MOVE DFHBMUNP TO UPDRMKA
               MOVE DFHBMUNP TO UPDRMK1A
               MOVE DFHBMUNP TO STATA

               ELSE IF TIXTTLO = SPACES OR TIXTTLO = LOW-VALUES

               MOVE 'TITLE IS REQUIRED' TO ERRMSGO

               MOVE DFHBMUNP TO TIXTTLA
               MOVE DFHBMUNP TO TIXDESC1A
               MOVE DFHBMUNP TO TIXDESC2A
               MOVE DFHBMUNP TO UPDRMKA
               MOVE DFHBMUNP TO UPDRMK1A
               MOVE DFHBMUNP TO STATA

               ELSE IF TIXDESC1O = SPACES OR TIXDESC1O = LOW-VALUES

               MOVE 'DESCRIPTION IS REQUIRED' TO ERRMSGO

               MOVE DFHBMUNP TO TIXTTLA
               MOVE DFHBMUNP TO TIXDESC1A
               MOVE DFHBMUNP TO TIXDESC2A
               MOVE DFHBMUNP TO UPDRMKA
               MOVE DFHBMUNP TO UPDRMK1A
               MOVE DFHBMUNP TO STATA
               
               ELSE IF UPDRMKO = SPACES OR UPDRMKO = LOW-VALUES

               MOVE 'UPDATE REMARK IS REQUIRED' TO ERRMSGO

               MOVE DFHBMUNP TO TIXTTLA
               MOVE DFHBMUNP TO TIXDESC1A
               MOVE DFHBMUNP TO TIXDESC2A
               MOVE DFHBMUNP TO UPDRMKA
               MOVE DFHBMUNP TO UPDRMK1A
               MOVE DFHBMUNP TO STATA
           
             ELSE
              PERFORM 700-READ-FILE
              IF TIXTTLO = TIX-TITLE AND TIXDESC1O = TIX-DESC1 
              AND TIXDESC2O = TIX-DESC2 AND UPDRMKO = LAST-UPDATE-REM1
              AND UPDRMK1O = LAST-UPDATE-REM2 AND STATO = TIX-STATUS

              MOVE 'NO CHANGES' TO ERRMSGO
              MOVE DFHBMUNP TO TIXTTLA
              MOVE DFHBMUNP TO TIXDESC1A
              MOVE DFHBMUNP TO TIXDESC2A
              MOVE DFHBMUNP TO UPDRMKA
              MOVE DFHBMUNP TO UPDRMK1A
              MOVE DFHBMUNP TO STATA
              MOVE WS-TCKTTL TO TIXTTLO
              MOVE WS-TCKDESC(1:50) TO TIXDESC1O
              MOVE WS-TCKDESC(51:50) TO TIXDESC2O
              MOVE WS-LSTUPDRMK(1:25) TO UPDRMKO
              MOVE WS-LSTUPDRMK(26:25) TO UPDRMK1O
              MOVE WS-TCKSTAT TO STATO
              
              
              ELSE
               MOVE 'PRESS PF2 TO UPDATE TICKET' TO ERRMSGO
               MOVE DFHBMUNP TO TIXTTLA
               MOVE DFHBMUNP TO TIXDESC1A
               MOVE DFHBMUNP TO TIXDESC2A
               MOVE DFHBMUNP TO UPDRMKA
               MOVE DFHBMUNP TO UPDRMK1A
               MOVE DFHBMUNP TO STATA

               MOVE 'X' TO WS-INIT
              END-IF
              
             END-IF
            END-IF 
           END-IF.
       
       700-READ-FILE.
           
           EXEC CICS 
               READ FILE('STF00001')
               INTO (WS-TIX-REC)
               RIDFLD (WS-TICKET-NUM1)
               RESP(WS-RES-CODE)
               EQUAL 
           END-EXEC.

       800-CREATE-LOG.
          
           MOVE WS-TICKET-NUM TO LOG-TIX-ID1
           MOVE 1 TO LOG-SEQ-NUM
           MOVE LOG-TIX-ID TO WS-LOG-PH
           EXEC CICS STARTBR FILE('stf00002')
                RIDFLD (LOG-TIX-ID)
                KEYLENGTH(+9)
                RESP(WS-RES-CODE)
                GTEQ
           END-EXEC
           PERFORM UNTIL LOG-TIX-ID1 NOT = WS-LOG-PH(1:6)
               EXEC CICS READPREV
                         FILE('stf00002')
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
           EXEC CICS ENDBR  
                FILE('stF00002')
           END-EXEC
       
           MOVE WS-TICKET-NUM1 TO TIXNUMO
           
           IF TIXTTLO = LOW-VALUES
            MOVE WS-TCKTTL TO TIXTTLO
           END-IF

           IF TIXDESC1O = LOW-VALUES
            MOVE WS-TCKDESC(1:50) TO TIXDESC1O
           END-IF
    
           IF TIXDESC2O = LOW-VALUES
            MOVE WS-TCKDESC(51:50) TO TIXDESC2O
           END-IF
           
           IF (TIXTTLO NOT = TIX-TITLE 
           AND TIXDESC1O NOT = TIX-DESC1)
           OR (TIXTTLO NOT = TIX-TITLE 
           AND TIXDESC2O NOT = TIX-DESC2)
           AND (STATO = 'COMPLETED')

            ADD 1 TO WS-LOG-SEQ  
            MOVE WS-LOG-PH TO LOG-TIX-ID
            MOVE WS-HDATE-X TO LOG-LAST-UPDATE-DATE
            MOVE WS-HTIME-X TO LOG-LAST-UPDATE-TIME
            MOVE WS-USERID1 TO LOG-UPDBY2
            MOVE 'COMPLETED. TITLE/DESCRIPTION UPDATED' 
            TO LOG-LAST-UPDATE-REM    
            
             EXEC CICS 
               WRITE FILE('stf00002')
               FROM(WS-LOG)
               RIDFLD(LOG-TIX-ID)
               RESP(WS-RES-CODE)
            END-EXEC

           ELSE IF (TIXTTLO NOT = TIX-TITLE 
           AND TIXDESC1O NOT = TIX-DESC1)
           OR (TIXTTLO NOT = TIX-TITLE 
           AND TIXDESC2O NOT = TIX-DESC2)
            
            ADD 1 TO WS-LOG-SEQ  
            MOVE WS-LOG-PH TO LOG-TIX-ID
            MOVE WS-HDATE-X TO LOG-LAST-UPDATE-DATE
            MOVE WS-HTIME-X TO LOG-LAST-UPDATE-TIME
            MOVE WS-USERID1 TO LOG-UPDBY2
            MOVE 'TITLE/DESCRIPTION UPDATED' 
            TO LOG-LAST-UPDATE-REM    
            
             EXEC CICS 
               WRITE FILE('stf00002')
               FROM(WS-LOG)
               RIDFLD(LOG-TIX-ID)
               RESP(WS-RES-CODE)
            END-EXEC

           ELSE IF (TIXTTLO NOT = TIX-TITLE 
           AND TIXDESC1O = TIX-DESC1) 
           OR (TIXTTLO NOT = TIX-TITLE 
           AND TIXDESC2O = TIX-DESC2)
           AND (STATO = 'COMPLETED')
            
            ADD 1 TO WS-LOG-SEQ  
            MOVE WS-LOG-PH TO LOG-TIX-ID
            MOVE WS-HDATE-X TO LOG-LAST-UPDATE-DATE
            MOVE WS-HTIME-X TO LOG-LAST-UPDATE-TIME
            MOVE WS-USERID1 TO LOG-UPDBY2
            MOVE 'COMPLETED. TICKET TITLE UPDATED' 
            TO LOG-LAST-UPDATE-REM    
            
             EXEC CICS 
               WRITE FILE('stf00002')
               FROM(WS-LOG)
               RIDFLD(LOG-TIX-ID)
               RESP(WS-RES-CODE)
            END-EXEC
 

           ELSE IF (TIXTTLO NOT = TIX-TITLE 
           AND TIXDESC1O = TIX-DESC1) 
           OR (TIXTTLO NOT = TIX-TITLE 
           AND TIXDESC2O = TIX-DESC2)
            
            ADD 1 TO WS-LOG-SEQ  
            MOVE WS-LOG-PH TO LOG-TIX-ID
            MOVE WS-HDATE-X TO LOG-LAST-UPDATE-DATE
            MOVE WS-HTIME-X TO LOG-LAST-UPDATE-TIME
            MOVE WS-USERID1 TO LOG-UPDBY2
            MOVE 'TICKET TITLE UPDATED'
            TO LOG-LAST-UPDATE-REM 
 
           EXEC CICS 
               WRITE FILE('stf00002')
               FROM(WS-LOG)
               RIDFLD(LOG-TIX-ID)
               RESP(WS-RES-CODE)
           END-EXEC
           
           ELSE IF (TIXTTLO = TIX-TITLE 
           AND TIXDESC1O NOT = TIX-DESC1) 
           OR (TIXTTLO = TIX-TITLE 
           AND TIXDESC2O NOT = TIX-DESC2)
           AND (STATO = 'COMPLETED')

            ADD 1 TO WS-LOG-SEQ  
            MOVE WS-LOG-PH TO LOG-TIX-ID
            MOVE WS-HDATE-X TO LOG-LAST-UPDATE-DATE
            MOVE WS-HTIME-X TO LOG-LAST-UPDATE-TIME
            MOVE WS-USERID1 TO LOG-UPDBY2
            MOVE 'COMPLETED. TICKET DESCRIPTION UPDATED'
            TO LOG-LAST-UPDATE-REM 
             
           EXEC CICS 
               WRITE FILE('stf00002')
               FROM(WS-LOG)
               RIDFLD(LOG-TIX-ID)
               RESP(WS-RES-CODE)
           END-EXEC

           ELSE IF (TIXTTLO = TIX-TITLE 
           AND TIXDESC1O NOT = TIX-DESC1) 
           OR (TIXTTLO = TIX-TITLE 
           AND TIXDESC2O NOT = TIX-DESC2)

            ADD 1 TO WS-LOG-SEQ  
            MOVE WS-LOG-PH TO LOG-TIX-ID
            MOVE WS-HDATE-X TO LOG-LAST-UPDATE-DATE
            MOVE WS-HTIME-X TO LOG-LAST-UPDATE-TIME
            MOVE WS-USERID1 TO LOG-UPDBY2
            MOVE 'TICKET DESCRIPTION UPDATED'
            TO LOG-LAST-UPDATE-REM 

            EXEC CICS 
               WRITE FILE('stf00002')
               FROM(WS-LOG)
               RIDFLD(LOG-TIX-ID)
               RESP(WS-RES-CODE)
           END-EXEC
          
           ELSE IF (TIXTTLO = TIX-TITLE 
           AND TIXDESC1O = TIX-DESC1) 
           OR (TIXTTLO = TIX-TITLE 
           AND TIXDESC2O = TIX-DESC2)
           AND (STATO = 'COMPLETED')
            
            ADD 1 TO WS-LOG-SEQ  
            MOVE WS-LOG-PH TO LOG-TIX-ID
            MOVE WS-HDATE-X TO LOG-LAST-UPDATE-DATE
            MOVE WS-HTIME-X TO LOG-LAST-UPDATE-TIME
            MOVE WS-USERID1 TO LOG-UPDBY2
            MOVE 'COMPLETED. TICKET STATUS UPDATED'
            TO LOG-LAST-UPDATE-REM 

           EXEC CICS 
               WRITE FILE('stf00002')
               FROM(WS-LOG)
               RIDFLD(LOG-TIX-ID)
               RESP(WS-RES-CODE)
           END-EXEC

           END-IF.
       

       900-CREATE-LOG-2.
      
           MOVE WS-TICKET-NUM TO LOG-TIX-ID1
           MOVE 1 TO LOG-SEQ-NUM
           MOVE LOG-TIX-ID TO WS-LOG-PH
           EXEC CICS STARTBR FILE('stf00002')
                RIDFLD (LOG-TIX-ID)
                KEYLENGTH(+9)
                RESP(WS-RES-CODE)
                GTEQ
           END-EXEC
           PERFORM UNTIL LOG-TIX-ID1 NOT = WS-LOG-PH(1:6)
               EXEC CICS READPREV
                         FILE('stf00002')
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
           EXEC CICS ENDBR  
                FILE('stF00002')
           END-EXEC
         

           MOVE WS-TICKET-NUM1 TO TIXNUMO
           
           IF TIXTTLO = LOW-VALUES
            MOVE WS-TCKTTL TO TIXTTLO
           END-IF

           IF TIXDESC1O = LOW-VALUES
            MOVE WS-TCKDESC(1:50) TO TIXDESC1O
           END-IF
    
           IF TIXDESC2O = LOW-VALUES
            MOVE WS-TCKDESC(51:50) TO TIXDESC2O
           END-IF
       
            ADD 1 TO WS-LOG-SEQ  
            MOVE WS-LOG-PH TO LOG-TIX-ID
            MOVE WS-HDATE-X TO LOG-LAST-UPDATE-DATE
            MOVE WS-HTIME-X TO LOG-LAST-UPDATE-TIME
            MOVE WS-USERID1 TO LOG-UPDBY2
            MOVE LAST-UPDATE-REM1 TO LOG-LAST-UPDATE-REM(1:25) 
            MOVE LAST-UPDATE-REM2 TO LOG-LAST-UPDATE-REM(26:25)  

           EXEC CICS 
               WRITE FILE('stf00002')
               FROM(WS-LOG)
               RIDFLD(LOG-TIX-ID)
               RESP(WS-RES-CODE)
           END-EXEC.
       

       1000-VALIDATION.    
           
           IF EIBAID = DFHPF3
           
             EXEC CICS XCTL
              PROGRAM('SM000')
             END-EXEC
       
           END-IF
           
           
           IF EIBAID = DFHPF5 
              PERFORM 700-READ-FILE
              IF WS-INIT = 'X'
              MOVE 'UPDATE ABORTED' TO ERRMSGO
              MOVE DFHBMUNP TO TIXTTLA
              MOVE DFHBMUNP TO TIXDESC1A
              MOVE DFHBMUNP TO TIXDESC2A
              MOVE DFHBMUNP TO UPDRMKA
              MOVE DFHBMUNP TO UPDRMK1A
              MOVE DFHBMUNP TO STATA
              MOVE TIX-TITLE TO TIXTTLO
              MOVE TIX-DESC1 TO TIXDESC1O
              MOVE TIX-DESC2 TO TIXDESC2O
              MOVE LAST-UPDATE-REM1 TO UPDRMKO
              MOVE LAST-UPDATE-REM2 TO UPDRMK1O
              MOVE TIX-STATUS TO STATO
              MOVE TIX-REQUESTOR TO REQBYO
              MOVE UPDATED-BY2 TO UPDBYO
              MOVE LAST-UPDATE-DATE TO DATE1O
              MOVE LAST-UPDATE-TIME TO TIME1O
              MOVE 'Y' TO WS-INIT
              PERFORM 110-NEW-MAP 
              ELSE
             
              MOVE 'UPDATE ABORTED' TO ERRMSGO 
              MOVE SPACES TO WS-TICKET-NUM
              MOVE DFHBMUNP TO TIXNUMA
              MOVE SPACES TO TIXNUMO
              MOVE SPACES TO TIXTTLO
              MOVE SPACES TO TIXDESC1O
              MOVE SPACES TO TIXDESC2O
              MOVE SPACES TO UPDRMKO
              MOVE SPACES TO UPDRMK1O
              MOVE SPACES TO STATO
              MOVE SPACES TO REQBYO
              MOVE SPACES TO UPDBYO
              MOVE SPACES TO DATE1O
              MOVE SPACES TO TIME1O

              MOVE DFHBMPRO TO REQBYA
              MOVE DFHBMPRO TO STATA
              MOVE DFHBMPRO TO TIXTTLA
              MOVE DFHBMPRO TO TIXDESC1A
              MOVE DFHBMPRO TO TIXDESC2A
              MOVE DFHBMPRO TO DATE1A
              MOVE DFHBMPRO TO TIME1A
              MOVE DFHBMPRO TO UPDRMKA
              MOVE DFHBMPRO TO UPDRMK1A
              MOVE 2 TO WS-PROG-STATE
              PERFORM 110-NEW-MAP 
              END-IF
           
       
           END-IF
           
           IF EIBAID = DFHCLEAR OR EIBAID = DFHPF1 
           OR EIBAID = DFHPF4 OR EIBAID = DFHPF6 OR EIBAID = DFHPF7
           OR EIBAID = DFHPF8 OR EIBAID = DFHPF9 OR EIBAID = DFHPF10
           OR EIBAID = DFHPF12
            PERFORM 700-READ-FILE
             IF WS-INIT = 'X'
              MOVE DFHBMUNP TO TIXTTLA
              MOVE DFHBMUNP TO TIXDESC1A
              MOVE DFHBMUNP TO TIXDESC2A
              MOVE DFHBMUNP TO UPDRMKA
              MOVE DFHBMUNP TO UPDRMK1A
              MOVE DFHBMUNP TO STATA
              MOVE DFHBMPRO TO REQBYA

             MOVE WS-TICKET-NUM TO TIXNUMO
             MOVE WS-TCKREQ TO REQBYO
             MOVE WS-TCKTTL TO TIXTTLO
             MOVE WS-TCKDESC(1:50) TO TIXDESC1O
             MOVE WS-TCKDESC(51:50) TO TIXDESC2O
             MOVE WS-TCKSTAT TO STATO
             MOVE WS-LSTUPDRMK(1:25) TO UPDRMKO
             MOVE WS-LSTUPDRMK(26:25) TO UPDRMK1O
             MOVE WS-LSTUPD(1:10) TO DATE1O
             MOVE WS-LSTUPD(11:10) TO TIME1O 
             MOVE WS-STUPDBY TO UPDBYO 
             MOVE 'INVALID PFKEY PRESSED' TO ERRMSGO
             
             PERFORM 110-NEW-MAP
            ELSE
               MOVE DFHBMUNP TO TIXTTLA
              MOVE DFHBMUNP TO TIXDESC1A
              MOVE DFHBMUNP TO TIXDESC2A
              MOVE DFHBMUNP TO UPDRMKA
              MOVE DFHBMUNP TO UPDRMK1A
              MOVE DFHBMUNP TO STATA
              MOVE DFHBMPRO TO REQBYA

             MOVE WS-TICKET-NUM TO TIXNUMO
             MOVE TIX-REQUESTOR TO REQBYO
             MOVE TIX-TITLE TO TIXTTLO
             MOVE TIX-DESC1 TO TIXDESC1O
             MOVE TIX-DESC2 TO TIXDESC2O
             MOVE TIX-STATUS TO STATO
             MOVE LAST-UPDATE-REM1 TO UPDRMKO
             MOVE LAST-UPDATE-REM2 TO UPDRMK1O
             MOVE LAST-UPDATE-DATE TO DATE1O
             MOVE LAST-UPDATE-TIME TO TIME1O 
             MOVE UPDATED-BY2 TO UPDBYO 
             MOVE 'INVALID PFKEY PRESSED WS3' TO ERRMSGO
             PERFORM 110-NEW-MAP
           END-IF.
           