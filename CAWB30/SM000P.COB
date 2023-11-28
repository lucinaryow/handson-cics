         CBL XOPTS(COBOL2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SM000P.

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
       01  WS-CHOICE                             PIC X(21).
       01  WS-CHOICE-PH.
           05  WS-CHC1                           PIC X(21).  
           05  WS-CHC2                           PIC X(21).  
           05  WS-CHC3                           PIC X(21). 
           05  WS-CHC4                           PIC X(21).          
           05  WS-CHC5                           PIC X(21).                    
           05  WS-CHC6                           PIC X(21).        
           05  WS-CHC7                           PIC X(21).                   
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
               10  LAST-UPDATE-DATE              PIC X(11).
               10  LAST-UPDATE-TIME              PIC X(09).
           05  UPDATED-BY2.
               10  UPDBY2                        PIC X(7).
               10  FILLER                        PIC X.
           05  LAST-UPDATE-REM                   PIC X(50).
           05  LAST-UPDATE-REMW REDEFINES LAST-UPDATE-REM.
               10  LAST-UPDATE-REM1              PIC X(25).
               10  LAST-UPDATE-REM2              PIC X(25).
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
	   COPY SM000S.
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
           IF EIBTRNID = 'SM00' OR 'SM01' OR 'SM02' OR 'SM03' OR 'SM04'
                         OR 'SM05' OR 'SM06' OR 'UA01'  
               MOVE LOW-VALUES TO SW00MO
               PERFORM 400-SEARCH-USER
           ELSE
               EXEC CICS SEND TEXT
                   FROM (WS-INVALID)
                   LENGTH (15)
                   ERASE
               END-EXEC  
           END-IF 
           
           EVALUATE TRUE
               WHEN EIBCALEN = +0
                   MOVE LOW-VALUES TO WS-CHOICE-PH
                   MOVE 'ENTER OPTION AND PRESS ENTER' TO ERRMSGO
                   PERFORM 100-SEND-MAP
               WHEN EIBAID = DFHPF3
                   EXEC CICS SEND TEXT
                       FROM (WS-END)
                       LENGTH (15)
                       ERASE
                   END-EXEC 
               WHEN EIBAID = DFHENTER
                   PERFORM 300-PROCESS-TRAN
               WHEN OTHER
                   EXEC CICS SEND TEXT
                       ERASE
                       FROM (WS-INVKEY)
                       LENGTH (22)
                   END-EXEC            
           END-EVALUATE
           EXEC CICS 
               RETURN 
                   TRANSID('SM00')
                   COMMAREA(WS-COMMAREA)
	       END-EXEC.
       000-EXIT.
           EXIT.


       100-SEND-MAP.
           MOVE EIBDATE TO WS-DATE.
           MOVE WS-DATE-X TO DATEO.
           EXEC CICS ASKTIME
	           ABSTIME	(WS-TIME)
	       END-EXEC
	       EXEC CICS FORMATTIME
	           ABSTIME	(WS-TIME)
	           DATESEP	('-')
	           MMDDYY   (DATEO)
               TIME     (TIMEO)
               TIMESEP  (':')    
           END-EXEC
           MOVE DFHBMASB TO TIMEA
           MOVE DFHBMASB TO DATEA
           MOVE DFHUNIMD TO OPTIONA
           EXEC CICS 
               SEND MAP('SW00M')
                    MAPSET('SW00S')
                    FROM(SW00MO)
                    ERASE
           END-EXEC.
       100-EXIT.
           EXIT.

       300-PROCESS-TRAN.
           EXEC CICS 
              RECEIVE MAP('SW00M')
                      MAPSET('SW00S')
                      INTO (SW00MI)
           END-EXEC
           MOVE 1 TO WS-INDEX
           PERFORM 400-SEARCH-USER
           EVALUATE TRUE
               WHEN OPTIONL = 0 OR OPTIONI = SPACE
                   MOVE 'OPTION IS REQUIRED' TO ERRMSGO
                   MOVE DFHBMBRY TO OPTIONA
               WHEN OPTIONI = 1
                   IF WS-CHC1 = '- USER MAINTENANCE'
                       PERFORM 700-TRANSFER-PROG
                       IF EIBCALEN = +0
                           EXEC CICS XCTL 
                               PROGRAM('UA001P')
                           END-EXEC
                       ELSE
                           EXEC CICS XCTL 
                               PROGRAM('UA001P')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC
                       END-IF
                   END-IF  
                   IF WS-CHC1 = '- SEARCH TICKET'
                       PERFORM 700-TRANSFER-PROG
                       IF EIBCALEN = +0
                           EXEC CICS XCTL 
                               PROGRAM('SM001')
                           END-EXEC
                       ELSE
                           EXEC CICS XCTL 
                               PROGRAM('SM001')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC
                       END-IF
                   END-IF  
               WHEN OPTIONI = 2
                   IF WS-CHC2 = '- ADD TICKET'
                       PERFORM 700-TRANSFER-PROG
                       IF EIBCALEN = +0
                           
                           EXEC CICS XCTL 
                               PROGRAM('SM02P')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC
                       ELSE
                           EXEC CICS XCTL 
                               PROGRAM('SM02P')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC
                       END-IF
                   END-IF  
                   IF WS-CHC2 = '- UPDATE TICKET'
                       PERFORM 700-TRANSFER-PROG
                       IF EIBCALEN = +0
                           EXEC CICS XCTL 
                               PROGRAM('SM03P')
                           END-EXEC
                       ELSE
                           EXEC CICS XCTL 
                               PROGRAM('SM03P')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC
                       END-IF
                   END-IF  
                   IF WS-CHC2 = '- APPROVE TICKET'
                       PERFORM 700-TRANSFER-PROG
                       IF EIBCALEN = +0
                           EXEC CICS XCTL 
                               PROGRAM('SM005')
                           END-EXEC
                       ELSE
                           EXEC CICS XCTL 
                               PROGRAM('SM005')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC
                       END-IF
                   END-IF  
                   IF WS-CHC2 = LOW-VALUES
                       MOVE 'INVALID OPTION' TO ERRMSGO
                       PERFORM 100-SEND-MAP
                   END-IF  
               WHEN OPTIONI = 3
                   IF WS-CHC3 = '- USER MAINTENANCE'
                       PERFORM 700-TRANSFER-PROG
                       IF EIBCALEN = +0
                           EXEC CICS XCTL 
                               PROGRAM('UA001P')
                           END-EXEC
                       ELSE 
                           EXEC CICS XCTL 
                               PROGRAM('UA001P')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC
                       END-IF
                   END-IF  
                   IF WS-CHC3 = '- APPROVE TICKET'
                       PERFORM 700-TRANSFER-PROG
                       IF EIBCALEN = +0
                           EXEC CICS XCTL 
                               PROGRAM('SM005')
                           END-EXEC
                       ELSE 
                           EXEC CICS XCTL 
                               PROGRAM('SM005')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC
                       END-IF
                   END-IF  
                   IF WS-CHC3 = '- UPDATE TICKET'
                       PERFORM 700-TRANSFER-PROG
                       IF EIBCALEN = +0
                           EXEC CICS XCTL 
                               PROGRAM('SM03P')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC
                       ELSE
                           EXEC CICS XCTL 
                               PROGRAM('SM03P')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC
                       END-IF
                   END-IF  
                   IF WS-CHC3 = LOW-VALUES
                       MOVE 'INVALID OPTION' TO ERRMSGO
                       PERFORM 100-SEND-MAP
                   END-IF
               WHEN OPTIONI = 4 
                   IF WS-CHC4 = '- USER MAINTENANCE'
                       PERFORM 700-TRANSFER-PROG
                       IF EIBCALEN = +0
                           EXEC CICS XCTL 
                               PROGRAM('UA001P')
                           END-EXEC
                       ELSE
                           EXEC CICS XCTL 
                               PROGRAM('UA001P')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC
                       END-IF
                   END-IF  
                   IF WS-CHC4 = '- CLOSE TICKET'
                       PERFORM 700-TRANSFER-PROG
                       
                       IF EIBCALEN = +0
                           EXEC CICS XCTL 
                               PROGRAM('SM004')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC
                       ELSE
                           EXEC CICS XCTL 
                               PROGRAM('SM004')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC
                       END-IF
                   END-IF  
                   IF WS-CHC4 = LOW-VALUES
                       MOVE 'INVALID OPTION' TO ERRMSGO
                       PERFORM 100-SEND-MAP
                   END-IF
               WHEN OPTIONI = 5 
                   IF WS-CHC5 = '- CANCEL TICKET'
                       PERFORM 700-TRANSFER-PROG
                       IF EIBCALEN = +0
                           EXEC CICS XCTL 
                               PROGRAM('SM006P')
                           END-EXEC
                       ELSE
                           EXEC CICS XCTL 
                               PROGRAM('SM006P')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC
                       END-IF
                   END-IF  
                   IF WS-CHC5 = LOW-VALUES
                       MOVE 'INVALID OPTION' TO ERRMSGO
                       PERFORM 100-SEND-MAP
                   END-IF
               WHEN OPTIONI = 6 
                   IF WS-CHC6 = '- APPROVE TICKET'
                       PERFORM 700-TRANSFER-PROG
                       IF EIBCALEN = +0
                           EXEC CICS XCTL 
                               PROGRAM('SM005')
                           END-EXEC
                       ELSE
                           EXEC CICS XCTL 
                               PROGRAM('SM005')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC
                       END-IF
                   END-IF  
                   IF WS-CHC6 = '- USER MAINTENANCE'
                       PERFORM 700-TRANSFER-PROG
                       IF EIBCALEN = +0
                           EXEC CICS XCTL 
                               PROGRAM('UA001P')
                           END-EXEC
                       ELSE
                           EXEC CICS XCTL 
                               PROGRAM('UA001P')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC
                       END-IF
                   END-IF  
                   IF WS-CHC6 = LOW-VALUES
                       MOVE 'INVALID OPTION' TO ERRMSGO
                       PERFORM 100-SEND-MAP
                   END-IF
               WHEN OPTIONI = 7 
                   IF WS-CHC7 = '- USER MAINTENANCE'
                       PERFORM 700-TRANSFER-PROG
                       IF EIBCALEN = +0
                           EXEC CICS XCTL 
                               PROGRAM('UA001P')
                           END-EXEC
                       ELSE
                           EXEC CICS XCTL 
                               PROGRAM('UA001P')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC
                       END-IF
                   END-IF  
                   IF WS-CHC7 = LOW-VALUES
                       MOVE 'INVALID OPTION' TO ERRMSGO
                       PERFORM 100-SEND-MAP
                   END-IF
               WHEN OPTIONI NOT = 1 OR 2 OR 3 OR 4 OR 5 OR 6 OR 7
                   IF WS-CHC7 = LOW-VALUES
                       MOVE 'INVALID OPTION' TO ERRMSGO
                       PERFORM 100-SEND-MAP
                   END-IF    
           END-EVALUATE
           PERFORM 100-SEND-MAP.
       300-EXIT.
           EXIT.

       400-SEARCH-USER.
           EXEC CICS ASSIGN   
               USERID(WS-USERID) 
           END-EXEC      
           EXEC CICS 
               READ FILE('UAF00001')
               INTO (WS-USER-REC)
               RIDFLD (WS-USERID)
               RESP(WS-RESPONSE-CODE)
               GTEQ 
           END-EXEC
           IF WS-RESPONSE-CODE NOT = +00 OR (REQUESTOR = 'N' AND 
                                     SERVICE-PROVIDER = 'N' AND APPROVER 
                                         = 'N' AND ADMINISTRATOR = 'N')
               EXEC CICS SEND TEXT
                   FROM (WS-INVALID)
                   LENGTH (+25)
                   ERASE 
               END-EXEC
               EXEC CICS RETURN END-EXEC
           ELSE
            MOVE WS-USERID TO WS-USERID1
            MOVE 1 TO WS-PROG-STATE
           END-IF
           IF REQUESTOR = 'Y' 
               MOVE '- SEARCH TICKET' TO WS-CHOICE
               PERFORM 500-MOVE-CHOICE-VAL
               MOVE '- ADD TICKET' TO WS-CHOICE
               PERFORM 500-MOVE-CHOICE-VAL
               MOVE '- UPDATE TICKET' TO WS-CHOICE
               PERFORM 500-MOVE-CHOICE-VAL
               MOVE '- CLOSE TICKET' TO WS-CHOICE
               PERFORM 500-MOVE-CHOICE-VAL
               MOVE '- CANCEL TICKET' TO WS-CHOICE
               PERFORM 500-MOVE-CHOICE-VAL
           END-IF
           IF SERVICE-PROVIDER = 'Y'
               IF NOT REQUESTOR = 'Y'
                   MOVE '- SEARCH TICKET' TO WS-CHOICE
                   PERFORM 500-MOVE-CHOICE-VAL
                   MOVE '- UPDATE TICKET' TO WS-CHOICE
                   PERFORM 500-MOVE-CHOICE-VAL
               ELSE
                   CONTINUE
               END-IF          
           END-IF
           IF APPROVER = 'Y'
               IF NOT (REQUESTOR = 'Y' OR SERVICE-PROVIDER = 'Y')
                   MOVE '- SEARCH TICKET' TO WS-CHOICE
                   PERFORM 500-MOVE-CHOICE-VAL
               ELSE
                   MOVE '- APPROVE TICKET' TO WS-CHOICE
                   PERFORM 500-MOVE-CHOICE-VAL
               END-IF          
           END-IF
           IF ADMINISTRATOR = 'Y'
               MOVE '- USER MAINTENANCE' TO WS-CHOICE
               PERFORM 500-MOVE-CHOICE-VAL       
           END-IF.
       400-EXIT.
           EXIT.

       500-MOVE-CHOICE-VAL.
           EVALUATE TRUE
               WHEN OPTCHC1O = LOW-VALUES
                   MOVE WS-INDEX TO OPTNO1O
                   MOVE WS-CHOICE TO OPTCHC1O
                   MOVE WS-CHOICE TO WS-CHC1
                   ADD 1 TO WS-INDEX
               WHEN OPTCHC2O = LOW-VALUES
                   MOVE WS-INDEX TO OPTNO2O
                   MOVE WS-CHOICE TO OPTCHC2O
                   MOVE WS-CHOICE TO WS-CHC2
                   ADD 1 TO WS-INDEX
               WHEN OPTCHC3O = LOW-VALUES
                   MOVE WS-INDEX TO OPTNO3O
                   MOVE WS-CHOICE TO OPTCHC3O
                   MOVE WS-CHOICE TO WS-CHC3
                   ADD 1 TO WS-INDEX
               WHEN OPTCHC4O = LOW-VALUES
                   MOVE WS-INDEX TO OPTNO4O
                   MOVE WS-CHOICE TO OPTCHC4O
                   MOVE WS-CHOICE TO WS-CHC4
                   ADD 1 TO WS-INDEX
               WHEN OPTCHC5O = LOW-VALUES
                   MOVE WS-INDEX TO OPTNO5O
                   MOVE WS-CHOICE TO OPTCHC5O
                   MOVE WS-CHOICE TO WS-CHC5
                   ADD 1 TO WS-INDEX
               WHEN OPTCHC6O = LOW-VALUES
                   MOVE WS-INDEX TO OPTNO6O
                   MOVE WS-CHOICE TO OPTCHC6O
                   MOVE WS-CHOICE TO WS-CHC6
                   ADD 1 TO WS-INDEX
               WHEN OPTCHC7O = LOW-VALUES
                   MOVE WS-INDEX TO OPTNO7O
                   MOVE WS-CHOICE TO OPTCHC7O
                   MOVE WS-CHOICE TO WS-CHC7
                   ADD 1 TO WS-INDEX
           END-EVALUATE.
       500-EXIT.
           EXIT.

       600-VALIDATE-TICKET.
           EXEC CICS 
               READ FILE('STF00001')
               INTO (WS-TIX-REC)
               RIDFLD (WS-TICKET-NUM)
               RESP(WS-RESPONSE-CODE)
               GTEQ 
           END-EXEC
           IF EIBRESP = DFHRESP(NOTFND)
               MOVE WS-INVALID-TICKET TO ERRMSGO
               MOVE EIBDATE TO WS-DATE
               MOVE WS-DATE-X TO DATEO
               EXEC CICS ASKTIME
	               ABSTIME	(WS-TIME)
	           END-EXEC
	           EXEC CICS FORMATTIME
	               ABSTIME	(WS-TIME)
	               DATESEP	('-')
	               MMDDYY   (DATEO)
                   TIME     (TIMEO)
                   TIMESEP  (':')    
               END-EXEC
               MOVE DFHBMASB TO TIMEA
               MOVE DFHBMASB TO DATEA
               MOVE DFHUNIMD TO OPTIONA
               EXEC CICS 
                   SEND MAP('SW00M')
                        MAPSET('SW00S')
                        FROM(SW00MO)
                        ERASE
               END-EXEC
               EXEC CICS RETURN 
                   TRANSID('SM00')
                   COMMAREA(WS-COMMAREA)
               END-EXEC
           ELSE 
               MOVE 1 TO WS-PROG-STATE

               IF WS-CHC2 = '- ADD TICKET'
                IF WS-TICKET-NUM = SPACES
                 MOVE '0' TO WS-TICKET-NUM
                END-IF 
               END-IF 
           END-IF.
       600-EXIT.
           EXIT.

       700-TRANSFER-PROG.
           IF TIXNOI = SPACES OR TIXNOL = ZERO 
               MOVE +0 TO EIBCALEN
               MOVE '0' TO WS-TICKET-NUM
           ELSE 
               MOVE 'N' TO WS-INIT
               MOVE TIXNOI TO WS-TICKET-NUM
               PERFORM 600-VALIDATE-TICKET
           END-IF.
       700-EXIT.
           EXIT.