       CBL XOPTS(COBOL2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SM004.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.    IBM-PC.
       OBJECT-COMPUTER.    IBM-PC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01  WS-TIME            PIC 9(15) COMP-3.
       01  WS-TIME1            PIC 9(15) COMP-3.
       01  WS-DATE            PIC 9(7).
       01  WS-DATE-X REDEFINES WS-DATE PIC X(7).       
       01  WS-CURRENT-MAP     VALUE 'SW004'         PIC X(7).
       01  WS-INVALID         PIC X(15) VALUE 'INVALID ACCESS'.
       01  WS-ABORT           PIC X(22) VALUE 'TICKET CLOSURE ABORTED'.
       01  WS-RESPONSE-CODE   PIC 9(02).
       01  WS-RESPONSE-CODE1   PIC 9(02).
       01  WS-COMMAREA1.
           10 PROG-ID              PIC X(04) VALUE 'SM04'.
       01  WS-BLANK-MESG      PIC X(50) VALUE 
           'TICKET CLOSED, PRESS ENTER TO CLOSE ANOTHER TICKET'.
       01  WS-SERVICE-REC.
           05 WS-REC-KEY                 PIC X(06).
           05 WS-REC-KEY-NUM REDEFINES WS-REC-KEY PIC 9(06).
           05 WS-REC-Requestor           PIC X(8).
           05 WS-REC-Status              PIC X(10).
           05 WS-REC-Title               PIC X(25).
           05 WS-REC-Description.
              10 WS-DESC1   PIC X(50).
              10 WS-DESC2   PIC X(50).
           05 WS-REC-Last-Update.
              10   WS-REC-DATE              PIC X(10).
            10   FILLER                    PIC X VALUE SPACES.            
            10   WS-REC-TIME              PIC X(09).    
           05 WS-REC-Last-Update-by      PIC X(8). 
           05 WS-REC-Update-Remarks      PIC X(50).
       01  WS-LOG-REC.
           05 WS-REC3-Ticket-ID.
              10 WS-REC3-2                  PIC X(6).
              10 WS-REC3-Seq-Number         PIC 9(03).
           05 WS-REC3-Last-Update.
            10   WS-REC3-DATE              PIC X(10).
            10   FILLER                    PIC X VALUE SPACES.
            10   WS-REC3-TIME              PIC X(09).  
           05 WS-REC3-Last-Update-by     PIC X(8). 
           05 WS-REC3-Update-Remarks     PIC X(50).
           05 FILLER                     PIC X(2). 
       01 WS-REC3     PIC 9(06).
       01 WS-INITIAL-STATE                             PIC X VALUE 'N'. 
       01   WS-EXIST           PIC X VALUE 'N'.
       01   WS-STD-KEY-LEN    PIC S9(4) COMP VALUE 6.
       01  WS-REC3-LENGTH                PIC S9(4) COMP VALUE +89. 
       01  WS-COMMAREA. 
           05  WS-USER                         PIC X(7).
           05  WS-TICKET-NUM.
               10  WS-TICKET-NUM1                 PIC X(6).
               10  FILLER                         PIC X.
           05  WS-PROG-STATE                      PIC 9(1).  
           05  WS-INIT                            PIC X VALUE 'Y'.   
           05  WS-ID                            PIC X(4).
           05  READ1  PIC X VALUE 'N'.
           05  WS-TNUM  PIC X(06).
       01  WS-PROG-ID PIC X(6).   
       01  WS-PROG PIC X(4).
       01  WS-T PIC X(8).
       01  WS-LENGTH          PIC S9(4) COMP.
           COPY SW004.
           COPY DFHAID.
           COPY DFHBMSCA.
       LINKAGE SECTION.
       01  DFHCOMMAREA                           PIC X(27).
      *       
       PROCEDURE DIVISION.
       100-PROCESS.  
           EXEC CICS IGNORE CONDITION
                     ERROR
           END-EXEC      
                    IF EIBTRNID = 'SM00' OR 'SM01' OR 'SM12' OR 'SM04'
                IF EIBCALEN NOT = +0
                   MOVE DFHCOMMAREA TO WS-COMMAREA

                   IF WS-PROG-STATE = 1 AND WS-INIT = 'N'
                       MOVE WS-TICKET-NUM1 TO WS-REC-KEY
                       PERFORM 230-VALIDATE-TICKET-NUM
                       PERFORM 101-DISPLAY-MAP
                       MOVE 'Y' TO WS-INIT
                   ELSE 
                     IF  NOT EIBRESP = DFHRESP(MAPFAIL) 
                       PERFORM 201-RECEIVE-MAP
                    ELSE
                    PERFORM 101-DISPLAY-MAP
                    END-IF
                   END-IF
                ELSE
                     IF WS-PROG  = '€€€€' 
                         CONTINUE
                     ELSE
                      IF WS-ID NOT = SPACES
                          MOVE WS-ID TO WS-PROG
                       ELSE
                          CONTINUE
                       END-IF
                       END-IF
                   MOVE 1 TO WS-PROG-STATE
                   MOVE 'ENTER TICKET NUMBER AND PRESS ENTER' TO ERRMSGO 
                   MOVE DFHPROTN  TO PF2A
                   MOVE DFHPROTN TO PF5A
                   PERFORM 101-DISPLAY-MAP
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
       100-EXIT.
           EXIT.   
        101-DISPLAY-MAP.
           MOVE EIBDATE TO WS-DATE
           MOVE WS-DATE-X TO DATEO
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
           EXEC CICS
               SEND MAP('MAP04')
               MAPSET('SW004')
               FROM(MAP04O)
               ERASE
           END-EXEC
           EXEC CICS RETURN
               TRANSID('SM04')
               COMMAREA(WS-COMMAREA)
           END-EXEC  
       101-EXIT.
           EXIT.         
       201-RECEIVE-MAP.
            EXEC CICS 
                RECEIVE MAP('MAP04')
                MAPSET('SW004')
                INTO (MAP04I)
            END-EXEC
            IF WS-PROG-STATE = 1 
              PERFORM 210-CHECK-AID-BLANK
            ELSE
               IF WS-PROG-STATE = 2
            PERFORM 220-CHECK-AID-VALUE
             ELSE 
               IF WS-PROG-STATE = 3
                  IF WS-ID = 'SM12'
                        EVALUATE TRUE
                        WHEN READ1 =  'N'
                        MOVE DFHBMASK TO TNUMA
                        MOVE WS-TICKET-NUM1 TO WS-REC-KEY
                        MOVE WS-BLANK-MESG  TO ERRMSGO
                        PERFORM 500-DISPLAY-UPDATE
                        MOVE 'Y' TO READ1
                        PERFORM 101-DISPLAY-MAP
                        WHEN OTHER
                        PERFORM 230-CHECK-AID-VALUE3
                       END-EVALUATE
                       ELSE
                 PERFORM 230-CHECK-AID-VALUE3
                END-IF     
            END-IF
            END-IF.
       201-EXIT.
           EXIT.    
       210-CHECK-AID-BLANK.
                   EVALUATE TRUE
                   WHEN EIBAID = DFHENTER
                     IF  TNUML = +0 OR TNUMI = SPACES
                        MOVE SPACES TO WS-TNUM
                        MOVE DFHUNIMD TO TNUMA
                        MOVE 'TICKET NUMBER IS REQUIRED' TO 
                        ERRMSGO
                        PERFORM 101-DISPLAY-MAP
                    ELSE
                        MOVE 2 TO WS-PROG-STATE
                        MOVE TNUMI TO WS-REC-KEY
                        PERFORM 230-VALIDATE-TICKET-NUM
                        PERFORM 101-DISPLAY-MAP
                    END-IF    
                   WHEN EIBAID = DFHPF3 OR DFHPF12
                        EXEC CICS XCTL 
                               PROGRAM('SM000P')
                           END-EXEC 
                   WHEN EIBAID = DFHPF15 
                        IF WS-TNUM = SPACES OR ZERO
                        MOVE DFHUNIMD TO TNUMA 
                         MOVE WS-TNUM TO TNUMO                          
                        MOVE 'INVALID PFKEY PRESSED' TO ERRMSGO
                        PERFORM 101-DISPLAY-MAP
                        ELSE
                        MOVE WS-TNUM TO TNUMO
                        MOVE DFHUNIMD TO TNUMA                            
                        MOVE 'INVALID PFKEY PRESSED' TO ERRMSGO
                        PERFORM 101-DISPLAY-MAP
                        END-IF
                   WHEN OTHER
                        IF TNUML = +0 OR TNUMI = SPACES
                        MOVE DFHUNIMD TO TNUMA                            
                        MOVE 'INVALID PFKEY PRESSED' TO ERRMSGO
                        PERFORM 101-DISPLAY-MAP
                        ELSE
                        MOVE WS-TNUM TO TNUMO
                        MOVE DFHUNIMD TO TNUMA                            
                        MOVE 'INVALID PFKEY PRESSED' TO ERRMSGO
                        PERFORM 101-DISPLAY-MAP
                        END-IF
                   END-EVALUATE.
                       
       210-EXIT.
           EXIT.
       220-CHECK-AID-VALUE.
            EVALUATE TRUE
              WHEN EIBAID = DFHENTER
                   MOVE DFHBMASK TO TNUMA
                   MOVE WS-TICKET-NUM TO TNUMO
                   MOVE 2 TO WS-PROG-STATE
                   MOVE 'PRESS PF2 TO CLOSE THE TICKET' TO ERRMSGO
                   PERFORM 101-DISPLAY-MAP
              WHEN EIBAID = DFHPF2 
                   MOVE WS-TICKET-NUM TO WS-REC-KEY
                  PERFORM 221-REWRITE-FILE
                  PERFORM 222-WRITE-LOGS
                  MOVE WS-BLANK-MESG  TO ERRMSGO
                  ADD 1 TO WS-PROG-STATE
                  MOVE DFHBMASK TO TNUMA
                   MOVE 'Y' TO READ1
                  PERFORM 500-DISPLAY-UPDATE
                  PERFORM 101-DISPLAY-MAP
              WHEN EIBAID = DFHPF3 
                        EXEC CICS XCTL 
                               PROGRAM('SM000P')
                           END-EXEC 
              WHEN EIBAID = DFHPF5
                        MOVE 'TICKET CLOSURE ABORTED' TO ERRMSGO
                        PERFORM 400-CLEAR-VALS
                        MOVE SPACE TO WS-TNUM
                        MOVE SPACE TO TNUMI
                        MOVE 'N' TO READ1
                        MOVE +0 TO TNUML
                        MOVE SPACE TO WS-TICKET-NUM1
                        MOVE 1 TO WS-PROG-STATE
                         MOVE 'Y' TO WS-INIT
                        PERFORM 101-DISPLAY-MAP
              WHEN EIBAID = DFHPF15
                        MOVE 'SM04' TO WS-ID
                        MOVE 1 TO WS-PROG-STATE
                        MOVE 'N' TO WS-INIT    
                         EXEC CICS XCTL 
                               PROGRAM('SM012')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC     
                         PERFORM 100-PROCESS   
                WHEN OTHER
                 EVALUATE TRUE
                 WHEN READ1 =  'Y'
                        MOVE DFHBMASK TO TNUMA
                        MOVE WS-TICKET-NUM1 TO WS-REC-KEY
                        PERFORM 230-VALIDATE-TICKET-NUM         
                        MOVE 'INVALID PFKEY PRESSED' TO ERRMSGO
                        PERFORM 101-DISPLAY-MAP
                WHEN OTHER
                   MOVE DFHUNIMD TO TNUMA    
                   MOVE WS-TNUM TO TNUMO                        
                        MOVE 'INVALID PFKEY PRESSED' TO ERRMSGO
                        PERFORM 101-DISPLAY-MAP
             END-EVALUATE
             END-EVALUATE.  
        220-EXIT.
           EXIT.
        230-CHECK-AID-VALUE3.
             EVALUATE TRUE
                   WHEN EIBAID = DFHENTER
                   PERFORM 400-CLEAR-VALS
                   MOVE SPACE TO WS-TNUM 
                   MOVE SPACES TO  WS-TICKET-NUM1                  
                   MOVE 1 TO WS-PROG-STATE
                   MOVE 'ENTER TICKET NUMBER AND PRESS ENTER' TO ERRMSGO 
                   MOVE DFHPROTN  TO PF2A
                   MOVE DFHPROTN TO PF5A
                   WHEN EIBAID = DFHPF5
                        MOVE 'TICKET CLOSURE ABORTED' TO ERRMSGO
                        PERFORM 400-CLEAR-VALS
                        MOVE SPACE TO WS-TNUM
                        MOVE SPACE TO TNUMI
                        MOVE 'N' TO READ1
                        MOVE +0 TO TNUML
                        MOVE SPACE TO WS-TICKET-NUM1
                        MOVE 1 TO WS-PROG-STATE
                         MOVE 'Y' TO WS-INIT
                        PERFORM 101-DISPLAY-MAP
                   WHEN EIBAID = DFHPF3 OR DFHPF12
                        EXEC CICS XCTL 
                               PROGRAM('SM000P')
                           END-EXEC 
                   WHEN EIBAID = DFHPF15
                        MOVE 'SM04' TO WS-ID
                        MOVE 3 TO WS-PROG-STATE
                        MOVE 'N' TO READ1    
                         EXEC CICS XCTL 
                               PROGRAM('SM012')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC     
                         PERFORM 100-PROCESS   
                   WHEN OTHER
                       EVALUATE TRUE
                    WHEN READ1 =  'N'
                        MOVE DFHBMASK TO TNUMA
                        MOVE WS-TICKET-NUM1 TO WS-REC-KEY
                        PERFORM 500-DISPLAY-UPDATE
                        MOVE 'INVALID PFKEY PRESSED' TO ERRMSGO
                        PERFORM 101-DISPLAY-MAP
                     WHEN READ1 =  'Y'
                        MOVE DFHBMASK TO TNUMA
                        MOVE WS-TICKET-NUM1 TO WS-REC-KEY
                        PERFORM 500-DISPLAY-UPDATE
                        MOVE 'INVALID PFKEY PRESSED' TO ERRMSGO
                        PERFORM 101-DISPLAY-MAP
                     WHEN OTHER
                     MOVE DFHUNIMD TO TNUMA    
                     MOVE WS-TNUM TO TNUMO                        
                        MOVE 'INVALID PFKEY PRESSED' TO ERRMSGO
                        PERFORM 101-DISPLAY-MAP
                   END-EVALUATE
                   END-EVALUATE.
                
        230-EXIT.
            EXIT.   
        221-REWRITE-FILE.
               EXEC CICS
               WRITE FILE ('STf00001')
               FROM (WS-SERVICE-REC)
               RIDFLD (WS-REC-KEY)
               END-EXEC.
               IF EIBRESP = DFHRESP(DUPREC)
               EXEC CICS 
                    READ FILE('STf00001')
                    INTO (WS-SERVICE-REC)
                    RIDFLD (WS-REC-KEY)
                    KEYLENGTH (WS-STD-KEY-LEN)
                    EQUAL
                    UPDATE
               END-EXEC
                MOVE 'CLOSED' TO  WS-REC-Status 
           MOVE EIBDATE TO WS-DATE
           MOVE WS-DATE-X TO WS-REC-DATE
           EXEC CICS ASKTIME
	           ABSTIME	(WS-TIME)
	       END-EXEC
	       EXEC CICS FORMATTIME
	           ABSTIME	(WS-TIME)
	           DATESEP	('/')
	           MMDDYYYY (WS-REC-DATE)
               TIME     (WS-T)
               TIMESEP  (':')    
           END-EXEC
                MOVE WS-T TO WS-REC-TIME
                MOVE WS-USER TO WS-REC-Last-Update-by
                MOVE 'TICKET CLOSED' TO  WS-REC-Update-Remarks
           EXEC CICS
               REWRITE FILE ('STf00001')
               FROM (WS-SERVICE-REC)
           END-EXEC.
        221-EXIT.
            EXIT.
        222-WRITE-LOGS.
            MOVE WS-REC-KEY TO WS-REC3-2
            MOVE 1 TO WS-REC3-Seq-Number

           EXEC CICS STARTBR FILE('STf00002')
                RIDFLD (WS-REC3-Ticket-ID)
                RESP(WS-RESPONSE-CODE)
                EQUAL
           END-EXEC.
           PERFORM UNTIL WS-EXIST = 'Y'
               EXEC CICS READNEXT FILE('STf00002')
                    INTO (WS-LOG-REC) 
                    RIDFLD (WS-REC3-Ticket-ID)
                    RESP(WS-RESPONSE-CODE1)                    
               END-EXEC
                EVALUATE WS-RESPONSE-CODE1
                WHEN 00
                     ADD 1 TO WS-REC3-Seq-Number 
                     MOVE WS-RESPONSE-CODE1 TO WS-RESPONSE-CODE
                WHEN OTHER
                     SUBTRACT 1 FROM WS-REC3-Seq-Number 
                     MOVE 'Y' TO WS-EXIST
                END-EVALUATE
                END-PERFORM
                       ADD 1 TO WS-REC3-Seq-Number
                       MOVE WS-REC-Last-Update-by TO 
                              WS-REC3-Last-Update-by
                        MOVE  WS-REC-Last-Update TO 
                              WS-REC3-Last-Update
                        MOVE  WS-REC-Update-Remarks TO 
                              WS-REC3-Update-Remarks
                        EXEC CICS WRITE FILE('STf00002')
                              FROM (WS-LOG-REC)
                              RIDFLD (WS-REC3-Ticket-ID)
                              LENGTH (WS-REC3-LENGTH)    
                        END-EXEC.      
        222-EXIT.
            EXIT.    
       230-VALIDATE-TICKET-NUM.
           EXEC CICS
                READ FILE('STf00001')
                INTO (WS-SERVICE-REC) 
                RIDFLD (WS-REC-KEY)
                RESP(WS-RESPONSE-CODE)
               EQUAL 
           END-EXEC
           EVALUATE EIBRESP
           WHEN DFHRESP(NOTFND)
                   MOVE TNUMI TO WS-TNUM
                   MOVE WS-REC-KEY TO TNUMO
                   MOVE DFHUNIMD TO TNUMA
                   MOVE 1 TO WS-PROG-STATE
                   MOVE 'Y' TO WS-INIT
               MOVE 'TICKET NUMBER DOES NOT EXIST' TO ERRMSGO
               PERFORM 101-DISPLAY-MAP
           WHEN DFHRESP(NORMAL)
           MOVE 'Y' TO READ1
           MOVE TNUMI TO WS-TNUM
                      EXEC CICS ASSIGN   
                       USERID(WS-USER) 
                      END-EXEC  
                  IF WS-USER = WS-REC-Requestor
                     IF WS-REC-Status = 'COMPLETED'
                     PERFORM 300-MOVE-TICKETVAL
                     MOVE WS-REC-KEY TO WS-TICKET-NUM
                     MOVE DFHBMASK TO TNUMA
                      MOVE 2 TO WS-PROG-STATE
                     MOVE 'PRESS PF2 TO CLOSE THE TICKET' TO ERRMSGO    
                  ELSE
                   MOVE 1 TO WS-PROG-STATE
                   MOVE 'Y' TO WS-INIT
                   MOVE DFHUNIMD TO TNUMA
                   MOVE WS-REC-KEY TO TNUMO
                   MOVE 'INVALID TICKET STATUS' TO ERRMSGO  
                   PERFORM 101-DISPLAY-MAP                    
                   END-IF   
                   ELSE
                   MOVE WS-REC-KEY TO TNUMO
                   MOVE 1 TO WS-PROG-STATE
                   MOVE 'Y' TO WS-INIT
                   MOVE DFHUNIMD TO TNUMA
                   MOVE 'INVALID ACCESS TO THE TICKET' TO ERRMSGO
                   PERFORM 101-DISPLAY-MAP 
                   END-IF       
               END-EVALUATE.
        230-EXIT.
           EXIT.       
        300-MOVE-TICKETVAL.
           MOVE WS-REC-KEY TO TNUMO
           MOVE WS-REC-Requestor TO REQBYO
           MOVE WS-DESC1 TO DESCL1O
           MOVE WS-DESC2 TO DESCL2O
           MOVE WS-REC-Status TO STATSO  
           MOVE WS-REC-Title TO TITLEO
           MOVE WS-REC-Last-Update-by TO UPDBYO
           MOVE WS-REC-DATE TO DATE1O  
           MOVE WS-REC-TIME TO TIME1O 
           MOVE WS-REC-Update-Remarks TO UPDREM1O.
        300-EXIT.
           EXIT.  
        400-CLEAR-VALS.
                   MOVE SPACE TO TNUMO
                   MOVE SPACE TO REQBYO
                   MOVE SPACE TO TITLEO
                   MOVE SPACE TO DESCL1O
                   MOVE SPACE TO DESCL2O
                   MOVE SPACE TO STATSO
                   MOVE SPACE TO UPDBYO
                   MOVE SPACE TO UPDREM1O
                   MOVE SPACE TO UPDREM2O
                   MOVE SPACE TO DATE1O
                   MOVE SPACE TO TIME1O.
        400-EXIT.
           EXIT.        
        500-DISPLAY-UPDATE.
        PERFORM 400-CLEAR-VALS
           EXEC CICS
                READ FILE('STf00001')
                INTO (WS-SERVICE-REC) 
                RIDFLD (WS-REC-KEY)
                RESP(WS-RESPONSE-CODE)
               EQUAL 
           END-EXEC
           EVALUATE EIBRESP
           WHEN DFHRESP(NORMAL)
            PERFORM 300-MOVE-TICKETVAL
           END-EVALUATE.
        500-EXIT.                






