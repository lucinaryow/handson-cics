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
       01  WS-ERROR                              PIC X(14) VALUE
           'Invalid Access'.               
       01  WS-COMMAREA.
           05  WS-USERID1                         PIC X(7).
           05  WS-TICKET-NUM                      PIC X(6).
           05  WS-PROG-STATE                      PIC 9(1).
       
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

       01  WS-HV                                 PIC X(20).  
       01  WS-RES-CODE                           PIC S9(8) COMP.
       01  WS-ENTRCTR                            PIC 9(1) VALUE 0.
       01  WS-HDATE                              PIC 9(8).
       01  WS-HDATE-X REDEFINES WS-HDATE         PIC X(8). 
       01  WS-HTIME                             PIC 9(15).
       01  WS-HTIME-X REDEFINES WS-HTIME         PIC X(8). 


      *
	   COPY SM002.
      *
	   COPY DFHAID.
      *
       COPY DFHBMSCA.

       LINKAGE SECTION.
       01  DFHCOMMAREA                           PIC X(14).
      *
       PROCEDURE DIVISION.
       100-PROCESS.

           EXEC CICS IGNORE CONDITION
                     ERROR 
           END-EXEC
           MOVE 0 TO WS-ENTRCTR
            
           IF EIBCALEN NOT = +0
               PERFORM 200-REC-MAP
               MOVE DFHCOMMAREA TO WS-COMMAREA
               
           ELSE
               MOVE DFHCOMMAREA TO WS-COMMAREA

               MOVE 'ENTER TICKET DETAILS AND PRESS PF2' TO ERRMSGO
               MOVE '1' TO WS-COMMAREA
               PERFORM 110-NEW-MAP
               
              
           END-IF.

       100-EXIT.
           EXIT.
       

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
            MOVE 'ENTER PRESSED' TO ERRMSGO
           
            MOVE HIGH-VALUES TO WS-STF01TCKID
            
            PERFORM 300-READ-STF1
           
           END-IF 
           
           IF EIBAID = DFHPF2
            IF TIXTTLI = SPACES OR TIXDESC2I = SPACES
             MOVE 'INVALID SPACES' TO ERRMSGO
            ELSE
             MOVE DFHDFHI TO UPDREMA
             MOVE DFHDFHI TO UPDDTA
             MOVE DFHDFHI TO UPDBY1A
             MOVE DFHDFHI TO UPDRMKA
             MOVE DFHDFHI TO UPDRMK1A
             MOVE DFHDFHI TO DATE1A
             MOVE DFHDFHI TO TIME1A

             MOVE SPACES TO WS-STF01TCKREQ
             MOVE SPACES TO WS-STF01TCKSTAT
             MOVE SPACES TO WS-STF01TCKTTL
             MOVE SPACES TO WS-STF01TCKDESC
             MOVE SPACES TO WS-STF01LSTUPD
             MOVE SPACES TO WS-STF01LSTUPDBY
             MOVE SPACES TO WS-STF01LSTUPDRMK

             MOVE TIXTTLI TO WS-STF01TCKTTL
             MOVE TIXDESC2I TO WS-STF01TCKDESC
             MOVE 'CREATED' TO STATI
             MOVE STATI TO WS-STF01TCKSTAT
             MOVE 'TICKET CREATED' TO UPDRMKI
             MOVE UPDRMKI TO WS-STF01LSTUPDRMK
            
             
             MOVE EIBDATE TO WS-HDATE
             EXEC CICS ASKTIME
              ABSTIME (WS-HTIME)
             END-EXEC

             EXEC CICS FORMATTIME
              ABSTIME (WS-HTIME)
              DATESEP ('-')
              MMDDYY (WS-HDATE-X)
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

             END-IF
             
             
           END-IF

           IF WS-ENTRCTR > 0
            MOVE HIGH-VALUES TO WS-STF01TCKID
            PERFORM 300-READ-STF1
           END-IF

           IF EIBAID = DFHPF3
            EXEC CICS XCTL
                PROGRAM('SM000')
            END-EXEC

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
            ADD 1 TO WS-ENTRCTR
           END-IF.
