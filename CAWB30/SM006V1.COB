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
       01  WS-USERID                             PIC X(7).
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
               10  LAST-UPDATE-DATE              PIC X(10).
               10  LAST-UPDATE-TIME              PIC X(10).
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
               10  FILLER                        PIC X.
           05  LOG-SEQ-NUM                       PIC 9(3).
           05  LOG-LAST-UPDATE.
               10  LOG-LAST-UPDATE-DATE          PIC X(10).
               10  LOG-LAST-UPDATE-TIME          PIC X(10).
           05  LOG-UPDATED-BY.
               10  LOG-UPDBY2                    PIC X(7).
               10  FILLER                        PIC X.
           05  LOG-LAST-UPDATE-REM               PIC X(50).
           05  FILLER                            PIC X(02).
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
           05  WS-TICKET-NUM                      PIC X(6).
           05  WS-PROG-STATE                      PIC 9(1).  
      *
	   COPY SM006S.
      *
	   COPY DFHAID.
      *
       COPY DFHBMSCA.

       LINKAGE SECTION.
       01  DFHCOMMAREA                           PIC X(14).
      *
       PROCEDURE DIVISION.
       000-PROCESS-MENU. 
      *   
           IF EIBTRNID = 'SM00' OR 'SM01' OR 'SM12' OR 'SM06'  
               IF EIBCALEN > +0
                   MOVE DFHCOMMAREA TO WS-COMMAREA
                   PERFORM 600-VALIDATE-TICKET
                   MOVE 'PRESS F2 TO CANCEL THE TICKET' TO ERRMSGO
                   MOVE 2 TO WS-PROG-STATE
                   PERFORM 100-SEND-MAP
               ELSE  
                   CONTINUE   
               END-IF
           ELSE
               EXEC CICS SEND TEXT
                   FROM (WS-INVALID)
                   LENGTH (15)
                   ERASE
               END-EXEC  
           END-IF  
           EVALUATE TRUE
               WHEN EIBCALEN = +0
                   MOVE 1 TO WS-PROG-STATE  
                   MOVE 'ENTER TICKET NUMBER AND PRESS ENTER' TO ERRMSGO  
                   PERFORM 100-SEND-MAP
               WHEN EIBAID = DFHPF3
                   EXEC CICS SEND TEXT
                       FROM (WS-END)
                       LENGTH (15)
                       ERASE
                   END-EXEC 
                   EXEC CICS RETURN END-EXEC         
               WHEN EIBAID = DFHPF2
                   EVALUATE TRUE   
                       WHEN WS-PROG-STATE = 1
                       WHEN WS-PROG-STATE = 3
                           CONTINUE
                       WHEN WS-PROG-STATE = 2
                           PERFORM 1000-CANCEL-TICKET
                           PERFORM 1100-CREATE-LOG
                           ADD 1 TO WS-PROG-STATE
                           PERFORM 100-SEND-MAP
                   END-EVALUATE                       
               WHEN EIBAID = DFHPF5
                   EVALUATE TRUE  
                       WHEN WS-PROG-STATE = 1
                       WHEN WS-PROG-STATE = 3
                           CONTINUE
                       WHEN WS-PROG-STATE = 2
                           MOVE 'TICKET CANCEL ABORTED' TO ERRMSGO
                           MOVE SPACE TO TIXNOO
                           MOVE 1  TO WS-PROG-STATE
                           PERFORM 100-SEND-MAP
                   END-EVALUATE 
               WHEN EIBAID = DFHENTER
                   EVALUATE TRUE  
                       WHEN WS-PROG-STATE = 1
                           ADD 1 TO WS-PROG-STATE
                           PERFORM 300-PROCESS-TRAN
                       WHEN WS-PROG-STATE = 2
                           MOVE 'PRESS F2 TO CANCEL THE TICKET' TO 
                                ERRMSGO
                           PERFORM 100-SEND-MAP
                       WHEN WS-PROG-STATE = 3
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
           EXEC CICS RETURN 
               TRANSID('SM06')
               COMMAREA(WS-COMMAREA)
	       END-EXEC.
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
           END-EXEC.
       100-EXIT.
           EXIT.

       300-PROCESS-TRAN.
           EXEC CICS 
              RECEIVE MAP('SM006M')
                      MAPSET('SM006S')
                      INTO (SM006MI)
           END-EXEC
      *    EXEC CICS 
      *        READ FILE('UAF00001')
      *        INTO (WS-USER-REC)
      *        RIDFLD (TIXNOI)
      *        EQUAL 
      *    END-EXEC
      *    IF EIBRESP = DFHRESP(NOTFND)
      *        EXEC CICS SEND TEXT
      *            FROM (WS-INVALID-TICKET)
      *            LENGTH (+28)
      *            ERASE 
      *        END-EXEC
      *        EXEC CICS RETURN END-EXEC
      *    ELSE   
      *        MOVE 'N' TO WS-TIX-ENTRY-STATE
               PERFORM 800-GET-TICKET
      *    END-IF
           PERFORM 100-SEND-MAP.
       300-EXIT.
           EXIT.

       600-VALIDATE-TICKET.
      *    EXEC CICS 
      *        READ FILE('UAF00001')
      *        INTO (WS-TIX-REC)
      *        RIDFLD (WS-TICKET-NUM)
      *        EQUAL 
      *    END-EXEC
      *    IF EIBRESP = DFHRESP(NOTFND)
      *        EXEC CICS SEND TEXT
      *            FROM (WS-INVALID-TICKET)
      *            LENGTH (+28)
      *            ERASE 
      *        END-EXEC
      *        EXEC CICS RETURN END-EXEC
      *    ELSE   
               PERFORM 700-SEARCH-USER.
      *    END-IF.
       600-EXIT.
           EXIT.

       700-SEARCH-USER.
      *    EXEC CICS ASSIGN   
      *        USERID(WS-USERID) 
      *    END-EXEC      
      *    EXEC CICS 
      *        READ FILE('UAF00001')
      *        INTO (WS-USER-REC)
      *        RIDFLD (WS-TICKET-NUM)
      *        EQUAL 
      *    END-EXEC
      *    IF WS-USERID NOT = USERID1
      *        EXEC CICS SEND TEXT
      *            FROM (WS-INVALID-USER)
      *            LENGTH (+24)
      *            ERASE 
      *        END-EXEC
      *        EXEC CICS RETURN END-EXEC
      *    ELSE   
      *        MOVE 'Y' TO WS-TIX-ENTRY-STATE
               PERFORM 800-GET-TICKET.
      *    END-IF.
       700-EXIT.
           EXIT.

       800-GET-TICKET.
      *    IF WS-TIX-ENTRY-STATE = 'Y'
      *        EXEC CICS 
      *            READ FILE('UAF00001')
      *            INTO (WS-TIX-REC)
      *            RIDFLD (TIXNOO)
      *            EQUAL 
      *        END-EXEC
      *    ELSE   
      *        EXEC CICS 
      *            READ FILE('UAF00001')
      *            INTO (WS-TIX-REC)
      *            RIDFLD (TIXNOI)
      *            EQUAL 
      *        END-EXEC
      *    END-IF
           MOVE 1 TO WS-PROG-STATE
           MOVE 123456 TO TIX-ID  
           MOVE 'HELP REQUEST' TO TIXNOO
           MOVE 'SAMPLE ONLY' TO TIX-DESC1  
           MOVE 'PENDING' TO TIX-STATUS  
           MOVE '01-02-2023' TO LAST-UPDATE-DATE 
           MOVE '00:08:53' TO LAST-UPDATE-TIME 
           MOVE 'LAST-UPDATE' TO LAST-UPDATE-REM1
           MOVE TIX-ID TO TIXNOO
           MOVE TIX-TITLE TO TITLEO
           MOVE TIX-DESC1 TO DESC1O
           MOVE TIX-DESC2 TO DESC2O
           MOVE TIX-STATUS TO STATO  
           MOVE LAST-UPDATE-DATE TO DATE2O  
           MOVE LAST-UPDATE-TIME TO TIME2O 
           MOVE LAST-UPDATE-REM1 TO REM1O
           MOVE LAST-UPDATE-REM2 TO REM2O.
       800-EXIT.
           EXIT.

       1000-CANCEL-TICKET.
           MOVE 'TICKET CANCELED, PRESS ENTER TO CANCEL ANOTHER TICKET'
               TO ERRMSGO
           MOVE TIXNOO TO WS-TIXID
           EXEC CICS 
               READ FILE ('UAF00001')
               INTO (WS-TIX-REC)
               RIDFLD (WS-TIXID)
               RESP(WS-RESPONSE-CODE)
               UPDATE
           END-EXEC
           IF WS-RESPONSE-CODE = DFHRESP(NOTFND)
               EXEC CICS SEND TEXT
                   FROM (WS-INVALID-TICKET)
                   LENGTH (+28)
                   ERASE 
               END-EXEC
               EXEC CICS RETURN END-EXEC
           END-IF
           MOVE 'CANCELED' TO TIX-STATUS
           MOVE 'TICKET CANCELED' TO LAST-UPDATE-REM
           MOVE EIBDATE TO WS-DATE
           MOVE WS-DATE-X TO LAST-UPDATE-REM
           EXEC CICS ASKTIME
	           ABSTIME	(WS-TIME)
	       END-EXEC
	       EXEC CICS FORMATTIME
	           ABSTIME	(WS-TIME)
	           DATESEP	('-')
	           MMDDYY   (LAST-UPDATE-DATE)
               TIME     (LAST-UPDATE-TIME)
               TIMESEP  (':')    
           END-EXEC
           EXEC CICS 
               REWRITE FILE ('UAF00001')
               FROM (WS-TIX-REC)
           END-EXEC.
       1000-EXIT.
           EXIT.

       1100-CREATE-LOG.
           MOVE TIX-ID TO LOG-TIX-ID
           MOVE LAST-UPDATE-DATE TO LOG-LAST-UPDATE-DATE
           MOVE LAST-UPDATE-TIME TO LOG-LAST-UPDATE-TIME
           MOVE TIX-ID TO LOG-TIX-ID
           MOVE LAST-UPDATE-REM TO LOG-LAST-UPDATE-REM
           MOVE HIGH-VALUES TO LOGID2
           EXEC CICS STARTBR FILE ('UAF00001')
               RIDFLD (LOG-TIX-ID)
               GTEQ
           END-EXEC
           EXEC CICS READPREV 
               FILE ('UAF00001')
               INTO (WS-LOG)
               RIDFLD (LOGID2)
           END-EXEC
           ADD 1 TO LOG-SEQ-NUM
           EXEC CICS WRITE 
               FILE ('UAF00001')
               FROM (WS-LOG)
               RIDFLD (LOG-TIX-ID)
           END-EXEC.
       1100-EXIT.
           EXIT.