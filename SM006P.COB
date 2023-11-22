         CBL XOPTS(COBOL2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SM006.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.    IBM-PC.
       OBJECT-COMPUTER.    IBM-PC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-TIME			   PIC 9(15) COMP-3.
       01  WS-DATE                               PIC 9(7).
       01  WS-DATE-X REDEFINES WS-DATE           PIC X(7). 
       01  WS-LENGTH                             PIC S9(4) COMP.
       01  WS-INDEX                              PIC 9 VALUE 1.  
       01  WS-TIX-ENTRY-STATE                    PIC X.
       01  WS-USERID.
           05  USERID3                           PIC X(7).
           05  FILLER                            PIC X.
       01  WS-TIXID                              PIC X(6).
       01  WS-RESPONSE-CODE    PIC S9(8) COMP.
       01  WS-LOGID.
           05  LOGID2                            PIC X(6).
           05  FILLER                            PIC X.
       01  WS-USER-REC.
           05  USERID.
               10  USERID1                       PIC X(7).
               10  FILLER                        PIC X.
           05  REQUESTOR                         PIC X.
           05  SERVICE-PROVIDER                  PIC X. 
           05  APPROVER                          PIC X. 
           05  ADMINISTRATOR                     PIC X. 
           05  UPDATED-BY1.
               10  UPDBY1                        PIC X(7).
               10  FILLER                        PIC X.
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
       01  WS-END                                PIC X(15) VALUE
           'END PROCESSING'.
       01  WS-INVKEY                             PIC X(21) VALUE
           'INVALID PFKEY PRESSED'.
       01  WS-INVALID			   PIC X(14) VALUE
           'INVALID ACCESS'.       
       01  WS-INVALID-TICKET			   PIC X(28) VALUE
           'TICKET NUMBER DOES NOT EXIST'.       
       01  WS-INVALID-USER			   PIC X(24) VALUE
           'INVALID ACCESS TO TICKET'.       
       01  WS-COMMAREA. 
           05  WS-USERID1                         PIC X(7).
           05  WS-TICKET-NUM.
               10  WS-TICKET-NUM1                 PIC X(6).
               10  FILLER                         PIC X.
           05  WS-PROG-STATE                      PIC 9(1).  
           05  WS-INIT                            PIC X VALUE 'Y'.

      *
	   COPY SM006S.
      *
	   COPY DFHAID.
      *
       COPY DFHBMSCA.

       LINKAGE SECTION.
       01  DFHCOMMAREA                           PIC X(20).
      *
       PROCEDURE DIVISION.
       000-PROCESS-MENU. 
      *    
           IF EIBTRNID = 'SM00' OR 'SM01' OR 'SM12' OR 'SM06' 
                IF EIBCALEN NOT = +0
                   MOVE DFHCOMMAREA TO WS-COMMAREA
                   IF WS-PROG-STATE = 1 AND WS-INIT = 'N'
                       PERFORM 400-VALIDATE-TICKET
                       MOVE DFHBMASK TO TIXNOA
                       MOVE 2 TO WS-PROG-STATE
                       MOVE 'PRESS F2 TO CANCEL THE TICKET' TO ERRMSGO
                       PERFORM 100-SEND-MAP
                       MOVE 'Y' TO WS-INIT
                   ELSE 
                       PERFORM 200-REC-MAP
                   END-IF
                ELSE
                   MOVE DFHBMDAR TO PF2A
                   MOVE DFHBMDAR TO PF5A
                   MOVE 1 TO WS-PROG-STATE
                   MOVE 'ENTER TICKET NUMBER AND PRESS ENTER' TO ERRMSGO 
                   PERFORM 100-SEND-MAP
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
       000-EXIT.
           EXIT.
           
       100-SEND-MAP.
           MOVE EIBDATE TO WS-DATE
           MOVE WS-DATE-X TO DATE1O
           EXEC CICS ASKTIME
	           ABSTIME	(WS-TIME)
	       END-EXEC
	       EXEC CICS FORMATTIME
	           ABSTIME	(WS-TIME)
	           DATESEP	('-')
	           MMDDYY   (DATE1O)
               TIME     (TIME1O)
               TIMESEP  (':')    
           END-EXEC
           MOVE DFHBMASB TO TIME1A
           MOVE DFHBMASB TO DATE1A
           EXEC CICS
               SEND MAP('SM006M')
               MAPSET('SM006S')
               FROM(SM006MO)
               ERASE
           END-EXEC
           EXEC CICS RETURN
               TRANSID('SM06')
               COMMAREA(WS-COMMAREA)
           END-EXEC.
       100-EXIT.
           EXIT.

       200-REC-MAP.
           EXEC CICS
               RECEIVE MAP('SM006M')
               MAPSET('SM006S')
               INTO (SM006MI)
           END-EXEC
           PERFORM 300-CHECK-AID.
       200-EXIT.
           EXIT.

       300-CHECK-AID.
           EVALUATE TRUE
               WHEN EIBAID = DFHPF3
                   EVALUATE TRUE 
                       WHEN WS-PROG-STATE = 1
                       WHEN WS-PROG-STATE = 2
                           EXEC CICS SEND TEXT
                               FROM (WS-END)
                               LENGTH (15)
                               ERASE
                           END-EXEC 
                           EXEC CICS RETURN END-EXEC         
                       WHEN WS-PROG-STATE = 3
                           MOVE 1 TO WS-PROG-STATE
                           EXEC CICS RETURN END-EXEC
                   END-EVALUATE
               WHEN EIBAID = DFHPF2
                   EVALUATE TRUE   
                       WHEN WS-PROG-STATE = 1
                       WHEN WS-PROG-STATE = 3
                           MOVE WS-TICKET-NUM TO TIXNOO
                           IF TIXNOO NOT = LOW-VALUES
                               MOVE DFHBMASK TO TIXNOA
                           END-IF
                           PERFORM 100-SEND-MAP
                       WHEN WS-PROG-STATE = 2
                           PERFORM 700-CANCEL-TICKET
                           PERFORM 800-CREATE-LOG
                           ADD 1 TO WS-PROG-STATE
                           PERFORM 100-SEND-MAP
                   END-EVALUATE                       
               WHEN EIBAID = DFHPF5
                   EVALUATE TRUE  
                       WHEN WS-PROG-STATE = 1
                       WHEN WS-PROG-STATE = 3
                           MOVE 1 TO WS-PROG-STATE
                           PERFORM 900-CLEAR-VALS
                           MOVE 'ENTER TICKET NUMBER AND PRESS ENTER' TO
                               ERRMSGO
                           PERFORM 100-SEND-MAP
                       WHEN WS-PROG-STATE = 2
                           MOVE 'TICKET CANCEL ABORTED' TO ERRMSGO
                           PERFORM 900-CLEAR-VALS
                           MOVE 1  TO WS-PROG-STATE
                           PERFORM 100-SEND-MAP
                   END-EVALUATE 
               WHEN EIBAID = DFHENTER
                   EVALUATE TRUE  
                       WHEN WS-PROG-STATE = 1
                           IF TIXNOI = SPACES OR TIXNOL = ZERO
                               MOVE 'TICKET NUMBER IS REQUIRED' TO 
                                   ERRMSGO
                               PERFORM 100-SEND-MAP      
                           ELSE
                               MOVE 2 TO WS-PROG-STATE
                               MOVE TIXNOI TO WS-TICKET-NUM
                               PERFORM 400-VALIDATE-TICKET
                               MOVE DFHBMASK TO TIXNOA
                               MOVE 'PRESS F2 TO CANCEL THE TICKET' TO 
                                    ERRMSGO
                               PERFORM 100-SEND-MAP
                           END-IF
                       WHEN WS-PROG-STATE = 2
                           MOVE WS-TICKET-NUM TO TIXNOO
                           MOVE DFHBMASK TO TIXNOA
                           MOVE 2 TO WS-PROG-STATE
                           MOVE 'PRESS F2 TO CANCEL THE TICKET' TO 
                                ERRMSGO
                           PERFORM 100-SEND-MAP
                       WHEN WS-PROG-STATE = 3
                           MOVE 'ENTER TICKET NUMBER AND PRESS ENTER' TO
                               ERRMSGO
                           MOVE 1 TO WS-PROG-STATE
                           MOVE LOW-VALUES TO SM006MO
                           PERFORM 100-SEND-MAP 
                   END-EVALUATE     
               WHEN OTHER
                   EXEC CICS SEND TEXT
                       ERASE
                       FROM (WS-INVKEY)
                       LENGTH (22)
                   END-EXEC            
           END-EVALUATE
           PERFORM 100-SEND-MAP.
       300-EXIT.
           EXIT.

       400-VALIDATE-TICKET.
           EXEC CICS 
               READ FILE('STF00001')
               INTO (WS-TIX-REC)
               RIDFLD (WS-TICKET-NUM)
               RESP(WS-RESPONSE-CODE)
               EQUAL 
           END-EXEC
           IF EIBRESP = DFHRESP(NOTFND)
               MOVE 1 TO WS-PROG-STATE
               MOVE WS-INVALID-TICKET TO ERRMSGO
               PERFORM 100-SEND-MAP
           ELSE   
               PERFORM 500-SEARCH-USER
           END-IF.
       400-EXIT.
           EXIT.

       500-SEARCH-USER.
           EXEC CICS ASSIGN   
               USERID(WS-USERID) 
           END-EXEC      
           EXEC CICS 
               READ FILE('UAF00001')
               INTO (WS-USER-REC)
               RIDFLD (WS-USERID)
               RESP(WS-RESPONSE-CODE)
               EQUAL 
           END-EXEC
           IF TIX-REQUESTOR NOT = USERID
               MOVE 1 TO WS-PROG-STATE
               MOVE WS-INVALID-USER TO ERRMSGO
               PERFORM 100-SEND-MAP
           ELSE   
               MOVE WS-USERID TO WS-USERID1
               PERFORM 600-MOVE-TICKETVAL
           END-IF.
       500-EXIT.
           EXIT.

       600-MOVE-TICKETVAL.
           MOVE TIX-ID TO TIXNOO
           MOVE TIX-REQUESTOR TO REQBYO
           MOVE TIX-TITLE TO TITLEO
           MOVE TIX-DESC1 TO DESC1O
           MOVE TIX-DESC2 TO DESC2O
           MOVE TIX-STATUS TO STATO  
           MOVE TIX-TITLE TO TITLEO
           MOVE UPDATED-BY2 TO UPDBYO
           MOVE LAST-UPDATE-DATE TO DATE2O  
           MOVE LAST-UPDATE-TIME TO TIME2O 
           MOVE LAST-UPDATE-REM1 TO REM1O
           MOVE LAST-UPDATE-REM2 TO REM2O.
       600-EXIT.
           EXIT.


       700-CANCEL-TICKET.
           EXEC CICS 
               READ FILE('STF00001')
               INTO (WS-TIX-REC)
               RIDFLD (WS-TICKET-NUM1)
               RESP(WS-RESPONSE-CODE)
               EQUAL 
               UPDATE
           END-EXEC
           MOVE 'TICKET CANCELED, PRESS ENTER TO CANCEL ANOTHER TICKET'
                  TO ERRMSGO
           
           MOVE 'CANCELED' TO TIX-STATUS
           MOVE 'TICKET CANCELED' TO LAST-UPDATE-REM
           MOVE EIBDATE TO WS-DATE
           MOVE WS-DATE-X TO LAST-UPDATE-DATE
           EXEC CICS ASKTIME
	           ABSTIME	(WS-TIME)
	       END-EXEC
	       EXEC CICS FORMATTIME
	           ABSTIME	(WS-TIME)
	           DATESEP	('/')
	           MMDDYYYY (LAST-UPDATE-DATE)
               TIME     (LAST-UPDATE-TIME)
               TIMESEP  (':')    
           END-EXEC
           MOVE DFHBMASK TO TIXNOA
           MOVE WS-TICKET-NUM1 TO TIXNOO
           MOVE TIX-REQUESTOR TO REQBYO
           MOVE TIX-TITLE TO TITLEO
           MOVE WS-USERID1 TO UPDBYO
           MOVE WS-USERID1 TO UPDATED-BY2
           MOVE LAST-UPDATE-DATE TO DATE2O
           MOVE LAST-UPDATE-TIME TO TIME2O
           MOVE TIX-STATUS TO STATO 
           MOVE LAST-UPDATE-REM1 TO REM1O
           MOVE LAST-UPDATE-REM2 TO REM2O
           MOVE TIX-DESC1 TO DESC1O
           MOVE TIX-DESC2 TO DESC2O 
           EXEC CICS 
               REWRITE FILE('STF00001')
                       FROM(WS-TIX-REC)
                       RESP(WS-RESPONSE-CODE)
           END-EXEC.
       700-EXIT.
           EXIT.

       800-CREATE-LOG.
           MOVE WS-TICKET-NUM TO LOG-TIX-ID1
           MOVE 1 TO LOG-SEQ-NUM
           MOVE LOG-TIX-ID TO WS-LOG-PH
           EXEC CICS STARTBR FILE('STf00002')
                RIDFLD (LOG-TIX-ID)
                KEYLENGTH(+9)
                RESP(WS-RESPONSE-CODE)
                GTEQ
           END-EXEC
           PERFORM UNTIL LOG-TIX-ID1 NOT = WS-LOG-PH(1:6)
               EXEC CICS READPREV
                         FILE('STf00002')
                         INTO (WS-LOG)
                         RIDFLD (LOG-TIX-ID)
                         RESP(WS-RESPONSE-CODE)
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
           ADD 1 TO WS-LOG-SEQ 
           MOVE WS-LOG-PH TO LOG-TIX-ID
           MOVE LAST-UPDATE-TIME TO LOG-LAST-UPDATE-TIME
           MOVE LAST-UPDATE-DATE TO LOG-LAST-UPDATE-DATE
           MOVE UPDBY2 TO LOG-UPDBY2
           MOVE LAST-UPDATE-REM1 TO LOG-LAST-UPDATE-REM(1:25)
           MOVE LAST-UPDATE-REM2 TO LOG-LAST-UPDATE-REM(26:25)
           EXEC CICS 
               WRITE FILE('STF00002')
               FROM(WS-LOG)
               RIDFLD(LOG-TIX-ID)
               RESP(WS-RESPONSE-CODE)
           END-EXEC.
       800-EXIT.
           EXIT.

       900-CLEAR-VALS.
           MOVE SPACE TO TIXNOO
           MOVE SPACE TO REQBYO
           MOVE SPACE TO TITLEO
           MOVE SPACE TO DESC1O
           MOVE SPACE TO DESC2O
           MOVE SPACE TO STATO  
           MOVE SPACE TO DATE2O  
           MOVE SPACE TO TIME2O 
           MOVE SPACE TO REM1O
           MOVE SPACE TO REM2O
           MOVE SPACE TO UPDBYO.
       900-EXIT.
           EXIT.