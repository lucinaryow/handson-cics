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
       01  WS-DATE            PIC 9(7).
       01  WS-DATE-X REDEFINES WS-DATE PIC X(7).       
       01  WS-CURRENT-MAP     VALUE 'SM004'         PIC X(7).
       01  WS-INVALID         PIC X(15) VALUE 'INVALID ACCESS'.
       01  WS-ABORT           PIC X(22) VALUE 'TICKET CLOSURE ABORTED'.
       01  WS-RESPONSE-CODE   PIC 9(02).
       01  WS-RESPONSE-CODE1   PIC 9(02).
       01  WS-BLANK-MESG      PIC X(50) VALUE 
           'TICKET CLOSED, PRESS ENTER TO CLOSE ANOTHER TICKET'.
       01  WS-SERVICE-REC.
           05 WS-REC-KEY                 PIC X(06).
           05 WS-REC-KEY-NUM REDEFINES WS-REC-KEY PIC 9(06).
           05 WS-REC-Requestor           PIC X(8).
           05 WS-REC-Status              PIC X(10).
           05 WS-REC-Title               PIC X(25).
           05 WS-REC-Description         PIC X(100).
           05 WS-REC-Last-Update.
            10   WS-REC-DATE              PIC X(10).
            10   WS-REC-TIME              PIC X(10).    
           05 WS-REC-Last-Update-by      PIC X(8). 
           05 WS-REC-Update-Remarks      PIC X(50).
       01  WS-LOG-REC.
           05 WS-REC3-Ticket-ID.
              10 WS-REC3-2                  PIC X(6).
              10 WS-REC3-Seq-Number         PIC 9(03).
           05 WS-REC3-Last-Update.
            10   WS-REC3-DATE              PIC X(10).
            10   WS-REC3-TIME              PIC X(10).  
           05 WS-REC3-Last-Update-by     PIC X(8). 
           05 WS-REC3-Update-Remarks     PIC X(50).
           05 FILLER                     PIC X(2). 
       01 WS-REC3     PIC 9(06).
       01  K                             PIC 9(03). 
       01   WS-EXIST           PIC X VALUE 'N'.
       01   WS-STD-KEY-LEN    PIC S9(4) COMP VALUE 6.
       01  WS-REC3-LENGTH                PIC S9(4) COMP VALUE +89. 
       01  WS-COMMAREA. 
           05  WS-USERID1                         PIC X(7).
           05  WS-TICKET-NUM.
               10  WS-TICKET-NUM1                 PIC X(6).
               10  FILLER                         PIC X.
           05  WS-PROG-STATE                      PIC 9(1).  
           05  WS-INIT                            PIC X VALUE 'Y'. 
       01   WS-COMMAREA1.
              05  WS-PROG1             PIC X(6) VALUE 'SM0004'.      
    
       01  WS-LENGTH          PIC S9(4) COMP.
           COPY SM004s.
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
           
            MOVE DFHCOMMAREA TO   WS-COMMAREA
           IF EIBTRNID = 'SM00' OR 'SM01' OR 'SM02'
                PERFORM 102-CHECK-TNUM-VALUE        
                
           ELSE
             EXEC CICS SEND TEXT
                    FROM (WS-INVALID)
                    LENGTH (+15)
                    ERASE
               END-EXEC
               EXEC CICS RETURN
               END-EXEC.
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
           MOVE DFHBMASK TO REQBYA
           MOVE DFHBMASK TO TITLEA
           MOVE DFHBMASK TO DESCL1A
           MOVE DFHBMASK TO DESCL2A
           MOVE DFHBMASK TO STATSA
           MOVE DFHBMASK TO UPDBYA
           MOVE DFHBMASK TO UPDREM1A
           MOVE DFHBMASK TO UPDREM2A
           MOVE DFHBMASK TO DATE1A
           MOVE DFHBMASK TO TIME1A
           EXEC CICS
               SEND MAP('MAP04')
               MAPSET(SM004)
               FROM(MAP04O)
               LENGTH(+383)
               ERASE
           END-EXEC
           EXEC CICS RETURN 
                   TRANSID('SM04')
                   COMMAREA(WS-COMMAREA)
           END-EXEC.
       101-EXIT.
           EXIT.
       102-CHECK-TNUM-VALUE.
               IF WS-TICKET-NUM1 = '0'
                   MOVE 'ENTER TICKET NUMBER AND PRESS ENTER' TO ERRMSGO 
                   PERFORM 101-DISPLAY-MAP
                   PERFORM 201-RECEIVE-MAP
                   PERFORM 210-CHECK-AID-BLANK
                
               ELSE
                   MOVE WS-TICKET-NUM1 TO WS-REC-KEY
                   PERFORM 230-VALIDATE-TICKET-NUM
                   PERFORM 201-RECEIVE-MAP
                   PERFORM 220-CHECK-AID-VALUE
               END-IF.        
       102-EXIT.
           EXIT.    
       201-RECEIVE-MAP.
            EXEC CICS 
                RECEIVE MAP('MAP04')
                MAPSET('SM004')
                INTO (MAP04I)
            END-EXEC.
       201-EXIT.
           EXIT.    
       210-CHECK-AID-BLANK.
                   EVALUATE TRUE
                   WHEN EIBAID = DFHENTER
                     MOVE TNUMI TO WS-REC-KEY
                     PERFORM 230-VALIDATE-TICKET-NUM
                   WHEN EIBAID = DFHPF2 OR DFHPF5
                        CONTINUE
                   WHEN EIBAID = DFHPF3 OR DFHPF12
                        EXEC CICS RETURN
                                  TRANSID('SM00')
                        END-EXEC
                   WHEN EIBAID = DFHPF11 
                           EXEC CICS XCTL 
                               PROGRAM('SM012')
                               COMMAREA(WS-COMMAREA1)
                           END-EXEC
                   WHEN OTHER
                     MOVE 'INVALID PFKEY PRESSED' TO ERRMSGO
                   END-EVALUATE.  
        210-EXIT.
           EXIT.
       220-CHECK-AID-VALUE.
                   EVALUATE TRUE
                   WHEN EIBAID = DFHENTER
                    MOVE 'PRESS PF2 TO CLOSE THE TICKET' TO ERRMSGO
                   WHEN EIBAID = DFHPF2 
                  PERFORM 222-WRITE-LOGS
                  MOVE WS-BLANK-MESG  TO ERRMSGO
                  PERFORM 101-DISPLAY-MAP
                  PERFORM 210-CHECK-AID-BLANK
                   WHEN EIBAID = DFHPF3 
                        EXEC CICS RETURN
                                  TRANSID('SM00')
                        END-EXEC
                   WHEN EIBAID = DFHPF5
                        MOVE 'TICKET CLOSURE ABORTED' TO ERRMSGO
                        EXEC CICS RETURN
                                  TRANSID('SM04')
                        END-EXEC
                   WHEN EIBAID = DFHPF11 
                           EXEC CICS XCTL 
                               PROGRAM('SM012')
                               COMMAREA(WS-COMMAREA1)
                           END-EXEC
                   WHEN OTHER
                     MOVE 'INVALID PFKEY PRESSED' TO ERRMSGO 
                   END-EVALUATE.  
        220-EXIT.
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
                EXEC CICS FORMATTIME
                ABSTIME (WS-TIME)
                DATESEP ('-')
                MMDDYY (WS-REC-DATE)
                TIME (WS-REC-TIME)
                TIMESEP (':')
                END-EXEC   
                MOVE WS-USERID1 TO WS-REC-Last-Update-by
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
                        MOVE  WS-REC-DATE TO 
                               WS-REC3-DATE
                        MOVE  WS-REC-TIME TO 
                               WS-REC3-TIME
                        MOVE  'GAGS' TO 
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
                STARTBR FILE('STf00001')
                RIDFLD (WS-REC-KEY)
                EQUAL 
           END-EXEC
           EXEC CICS
                READ FILE('STf00001')
                INTO (WS-SERVICE-REC) 
                RIDFLD (WS-REC-KEY)
           END-EXEC
           EVALUATE EIBRESP
           WHEN DFHRESP(NOTFND)
               MOVE 'TICKET NUMBER DOES NOT EXIST' TO ERRMSGO
               MOVE SPACES TO TNUMO
               MOVE SPACES TO TNUMI
               PERFORM 102-CHECK-TNUM-VALUE
           WHEN DFHRESP(NORMAL)
                  IF WS-USERID1 = WS-REC-Requestor
                     IF WS-REC-Status = 'COMPLETED'
                   MOVE WS-REC-KEY-NUM TO TNUMO
                   MOVE WS-REC-Requestor TO REQBYO
                   MOVE WS-REC-Status TO STATSO
                   MOVE WS-REC-Title TO TITLEO
                   MOVE WS-REC-Description TO DESCL1O
                   MOVE WS-REC-DATE   TO  DATE1O
                   MOVE WS-REC-TIME   TO  TIME1O
                   MOVE WS-REC-Last-Update-by TO UPDBYO
                   MOVE WS-REC-Update-Remarks TO UPDREM1O
                   MOVE DFHBMASK TO TNUMA
                   MOVE DFHBMASK TO REQBYA
                   MOVE DFHBMASK TO TITLEA
                   MOVE DFHBMASK TO DESCL1A
                   MOVE DFHBMASK TO DESCL2A
                   MOVE DFHBMASK TO STATSA
                   MOVE DFHBMASK TO UPDBYA
                   MOVE DFHBMASK TO UPDREM1A
                   MOVE DFHBMASK TO UPDREM2A
                   MOVE DFHBMASK TO DATE1A
                   MOVE DFHBMASK TO TIME1A
                   MOVE 'PRESS PF2 TO CLOSE THE TICKET' TO ERRMSGO    
                  ELSE
                  MOVE 'INVALID TICKET STATUS' TO ERRMSGO                      
                   END-IF   
                   ELSE
                   MOVE 'INVALID ACCESS TO THE TICKET' TO ERRMSGO
                   END-IF       
               END-EVALUATE
                EXEC CICS
               SEND MAP('MAP04')
               MAPSET(SM004)
               FROM(MAP04O)
               ERASE
               END-EXEC .
        230-EXIT.
           EXIT.           






