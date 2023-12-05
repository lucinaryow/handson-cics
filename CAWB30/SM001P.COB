       CBL XOPTS(COBOL2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SM001P.
      
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.    IBM-PC.
       OBJECT-COMPUTER.    IBM-PC.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-TIME                     PIC 9(15) COMP-3.
       01  WS-FILLER                             PIC X(80).
       01  WS-PG-LIT                   PIC 9(2).
       01  WS-PG-RED REDEFINES WS-PG-LIT.
           05   PG-LIT1                PIC 9.
           05   PG-LIT2                PIC 9.
       01  WS-TALLY                    PIC 9(3) VALUE 0.
       01  WS-REM                      PIC 9(3).
       01  WS-COMP                     PIC 9(4).
       01  WS-MAX                      PIC 9(3).
       01  WS-RESPONSE-CODE            PIC S9(8) COMP.
       01  WS-COUNTER                  PIC 9(2) VALUE 0.
       01  WS-COUNTER2                 PIC 9(2) VALUE 0.
       01  WS-CHOICE                   PIC X.
       01  WS-USERID                   PIC X(8).
       01  WS-PRGNAME                  PIC X(6).     
       01  WS-LENGTH                   PIC S9(4) COMP.
       01  WS-RECB-LENGTH              PIC S9(4) COMP VALUE +20.
       01  WS-KEYB-LENGTH              PIC S9(4) COMP VALUE +8. 
       01  WS-INDX                     PIC 9(3)  VALUE 1.
       01  WS-LASTPAGE                 PIC X(1).
       01  WS-FIRSTPAGE                PIC X(1).
       01  WS-PAGE-CTR                 PIC 9(02).
       01  WS-COMMAREA.
           05  WS-CA-PRGNAME           PIC X(06).
           05  FILLER                  PIC X(19).
           05  WS-DFHSTATE             PIC X(15). 
           05  WS-TRANS                PIC X(04).  
           05  WS-LUSER                PIC 9(03).
           05  WS-FUSER                PIC 9(03).
           05  WS-PAGE                 PIC 9(02).
           05  WS-QNAME                PIC X(8).
           05  WS-PAGE-END             PIC 9(01).
           05  WS-QITEM                PIC S9(4) COMP.
           05  WS-QITEM-START          PIC S9(4) COMP.
           05  WS-QITEM-END            PIC S9(4) COMP.
           05  WS-QITEM-PAGE           PIC S9(4) COMP.
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
                   15  LAST-UPDATE-DATE.
				       20 DD PIC X(02).
					   20 FILLER PIC X.
					   20 MM PIC X(02).
					   20 FILLER PIC X.
					   20 YYYY PIC X(02).
					   20 FILLER PIC X.
                   15  LAST-UPDATE-TIME              PIC X(09).
               10  UPDATED-BY2.
                   15  UPDBY2                        PIC X(7).
                   15  FILLER                        PIC X.
               10  LAST-UPDATE-REM                   PIC X(50).
               10  LAST-UPDATE-REMW REDEFINES LAST-UPDATE-REM.
                   15  LAST-UPDATE-REM1              PIC X(25).
                   15  LAST-UPDATE-REM2              PIC X(25).
           05  WS-PROG-STATE                      PIC 9(1).  
           05  WS-INIT                            PIC X VALUE 'Y'.
           05  WS-USERID1                         PIC X(7).
           05  WS-TICKET-NUM.
               10  WS-TICKET-NUM1                 PIC X(6).
               10  FILLER                         PIC X.
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
       01 WS-SWITCH.
           05 DATE-FILTER-SW PIC X.	 
           05 TITLE-FILTER-SW PIC X.
           05 VALID-DATE-FILTER-SW   PIC X.		

      *
       COPY SM001S.
       01  WS-SM001 REDEFINES SM001MI.
           05  FILLER                  PIC X(96). 
           05  UC  OCCURS 11. 
               10  UCL                 PIC S9(4) COMP.
               10  UCF                 PIC X.
               10  FILLER REDEFINES UCF.
                   15  UCA             PIC X.
               10  UCI                 PIC X(001).
           05  TN  OCCURS 11. 
               10  TNL                 PIC S9(4) COMP.
               10  TNF                 PIC X.
               10  FILLER REDEFINES TNF.
                   15  TNA             PIC X.
               10  TNI                 PIC X(006).
           05  TT     OCCURS 11.
               10  TTL                PIC S9(4) COMP.
               10  TTF                PIC X.
               10  FILLER REDEFINES TTF.
                   15  TTA            PIC X.
               10  TTI                PIC X(020). 
           05  ST     OCCURS 11.
               10  STL                PIC S9(4) COMP.
               10  STF                PIC X.
               10  FILLER REDEFINES STF.
                   15 STA             PIC X.
               10  STI                PIC X(010).
           05  UD      OCCURS 11.
               10  UDL               PIC S9(4) COMP.
               10  UDF               PIC X.
               10  FILLER REDEFINES UDF.
                   15  UDA           PIC X.
               10  UDI               PIC X(008).
           05  UB     OCCURS 11.
               10  UBL                PIC S9(4) COMP.
               10  UBF                PIC X.
               10  FILLER REDEFINES UBF.
                   15  UBA            PIC X.
               10  UBI                PIC X(007).
    
      *
       COPY DFHAID.
      *
       COPY DFHBMSCA.

       LINKAGE SECTION.
        01  DFHCOMMAREA                        PIC X(322).
      *
       PROCEDURE DIVISION.
       100-PROCESS SECTION.
           IF EIBTRNID = 'SM00' OR 'SM01' OR 'SM02' OR 'SM03' OR 'SM04'
                          OR 'SM05' OR 'SM06' 
               MOVE DFHCOMMAREA TO WS-COMMAREA
               EXEC CICS
                 IGNORE CONDITION ERROR
               END-EXEC
      
               IF EIBCALEN = +0 
                   STRING EIBTRMID DELIMITED BY SIZE
	                   EIBTRNID DELIMITED BY SIZE
                       INTO WS-QNAME 
                   MOVE LENGTH OF SM001MI TO WS-LENGTH
                   MOVE 1 TO WS-PAGE
                   MOVE WS-PAGE TO PAGEO
                   PERFORM 999-MOVE-FILE-TO-Q
                   PERFORM 500-MOVE-Q-TO-SCREEN
                   PERFORM 100-NEW-MAP
               ELSE
                    EXEC CICS
                         RECEIVE MAP ('SM001M')
                         MAPSET ('SM001S')
                         INTO (SM001MI)
                     END-EXEC
                    IF  NOT EIBRESP = DFHRESP(MAPFAIL) 
                        EVALUATE EIBAID
                         WHEN DFHPF2
                            PERFORM 240-WHENF2
                         WHEN DFHPF3
                            EXEC CICS DELETEQ TS
                                 QUEUE(WS-QNAME)
                            END-EXEC 
                            EXEC CICS SEND TEXT 
                               FROM(WS-FILLER)
                               LENGTH(+500)
                               ERASE
                            END-EXEC 
                            EXEC CICS XCTL 
                               PROGRAM('SM000P')
                            END-EXEC
                        WHEN DFHENTER 
                            PERFORM 250-WHENENTER
                        WHEN DFHPF5
                        WHEN DFHPF7
                            PERFORM 220-WHENF7
                        WHEN DFHPF8
                            PERFORM 230-WHENF8
                        WHEN DFHPF12  
                            PERFORM 270-WHENF12
                        WHEN OTHER
                            MOVE 'INVALID PFKEY PRESSED' TO MSGO  
                        END-EVALUATE
                   ELSE
                       MOVE 'INVALID PFKEY PRESSED' TO MSGO
                       PERFORM 500-MOVE-Q-TO-SCREEN
                       PERFORM 100-NEW-MAP
                   END-IF
               END-IF
           ELSE   
               EXEC CICS SEND TEXT
                       FROM (WS-INVKEY)
                       LENGTH (22)
                       ERASE
               END-EXEC
               EXEC CICS RETURN END-EXEC
           END-IF.
            
    
       100-NEW-MAP SECTION.
           EXEC CICS ASSIGN
               USERID(WS-USERID)
           END-EXEC

           EXEC CICS ASKTIME
               ABSTIME  (WS-TIME)
           END-EXEC
       
           EXEC CICS FORMATTIME
               ABSTIME  (WS-TIME)
               DATESEP  ('/')
               DDMMYYYY   (DATEO)
               TIMESEP    (':')
               TIME       (TIMEO)
           END-EXEC
         
           EXEC CICS
               SEND MAP ('SM001M')
               MAPSET ('SM001S')
               FROM (SM001MO)
               LENGTH(WS-LENGTH)
               ERASE
           END-EXEC
           
           EXEC CICS RETURN
               TRANSID('SM01')
               COMMAREA(WS-COMMAREA)
           END-EXEC.

       220-WHENF7 SECTION.
            
            SUBTRACT 11 FROM WS-QITEM-PAGE
            IF WS-QITEM-PAGE = WS-QITEM-START OR 
               WS-QITEM-PAGE <  WS-QITEM-START
               MOVE 'THIS IS THE FIRST PAGE' TO MSGO
               MOVE 1 TO WS-PAGE
               MOVE WS-QITEM-START TO WS-QITEM-PAGE
            ELSE
              SUBTRACT 1 FROM WS-PAGE 
            END-IF
            MOVE WS-PAGE TO PAGEO
            PERFORM 500-MOVE-Q-TO-SCREEN   
            PERFORM 100-NEW-MAP.

       230-WHENF8 SECTION.

            ADD 11 TO WS-QITEM-PAGE
            IF WS-QITEM-PAGE > WS-QITEM-END 
               SUBTRACT 11 FROM WS-QITEM-PAGE
               MOVE WS-PAGE TO PAGEO
               MOVE 'THIS IS THE LAST PAGE' TO MSGO
            ELSE
               ADD 1 TO WS-PAGE
               MOVE WS-PAGE TO PAGEO
               PERFORM 500-MOVE-Q-TO-SCREEN
            END-IF.   
            PERFORM 100-NEW-MAP.
   
       240-WHENF2 SECTION.
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
           IF NOT WS-RESPONSE-CODE = +00 OR REQUESTOR NOT = 'Y'
               MOVE 'INVALID ACCESS' TO MSGO
               PERFORM 100-NEW-MAP
           ELSE 
               EXEC CICS XCTL  
                   PROGRAM('SM02P')
               END-EXEC
           END-IF.

       250-WHENENTER SECTION.
           IF PAGEI = LOW-VALUES
               MOVE WS-PAGE TO PAGEI
           END-IF
           IF PAGEI NOT = WS-PAGE OR PAGEL = +0
               MOVE PAGEI TO WS-PG-LIT
               IF PG-LIT1 IS NUMERIC AND PG-LIT2 IS NUMERIC
                   IF WS-PG-LIT > WS-PAGE
                       COMPUTE WS-COMP = WS-QITEM +
                                       ((WS-PG-LIT - 1) - WS-PAGE) * 11
                       IF WS-COMP > WS-QITEM-END 
                           PERFORM VARYING WS-INDX FROM WS-QITEM-START 
                                   BY 1 UNTIL 
                                WS-INDX > WS-QITEM-END  
                               ADD 1 TO WS-TALLY
                           END-PERFORM
                           DIVIDE WS-TALLY BY 11 GIVING WS-REM
                           COMPUTE WS-MAX = WS-REM + 1
                           MOVE WS-MAX TO WS-PAGE
                           MOVE WS-PAGE TO PAGEO
                           COMPUTE WS-QITEM-PAGE = (WS-REM * 11) + 
                                                   WS-QITEM-START
                           PERFORM 500-MOVE-Q-TO-SCREEN
                           MOVE 'THIS IS THE LAST PAGE' TO MSGO
                           PERFORM 100-NEW-MAP
                       ELSE     
                           MOVE WS-COMP TO WS-QITEM-PAGE
                           MOVE PAGEI TO WS-PAGE
                           PERFORM 500-MOVE-Q-TO-SCREEN
                           PERFORM 100-NEW-MAP
                       END-IF
                   ELSE 
                       IF WS-PG-LIT = 1
                           MOVE PAGEI TO WS-PAGE
                           MOVE WS-QITEM-START TO WS-QITEM-PAGE 
                           PERFORM 500-MOVE-Q-TO-SCREEN
                           MOVE 'THIS IS THE FIRST PAGE' TO MSGO
                           PERFORM 100-NEW-MAP 
                       ELSE 
                           COMPUTE WS-COMP = WS-QITEM-PAGE - 
                                             (WS-PAGE - WS-PG-LIT) * 11
                           MOVE WS-COMP TO WS-QITEM-PAGE
                           MOVE PAGEI TO WS-PAGE
                           PERFORM 500-MOVE-Q-TO-SCREEN
                           PERFORM 100-NEW-MAP
                       END-IF
                   END-IF
               ELSE 
                   MOVE 'ENTER A NUMERIC PAGE NUMBER' TO MSGO
                   PERFORM 100-NEW-MAP
               END-IF
           ELSE 
               MOVE 1 TO WS-INDX
               PERFORM UNTIL WS-INDX > 11
                   MOVE UCI(WS-INDX) TO WS-CHOICE
                   IF NOT WS-CHOICE = '_'
                       ADD 1 TO WS-COUNTER
                       MOVE WS-INDX TO WS-COUNTER2
                   END-IF
                   ADD 1 TO WS-INDX
               END-PERFORM
               IF WS-COUNTER > 1
                   MOVE 1 TO WS-INDX
                   PERFORM UNTIL WS-INDX > 11
                       MOVE '_' TO UCI(WS-INDX)
                       ADD 1 TO WS-INDX
                   END-PERFORM
                   MOVE 'ENTER 1 SELECTION ONLY' TO MSGO
               ELSE
                   EVALUATE UCI(WS-COUNTER2)
                       WHEN 'U'
                           IF STI(WS-COUNTER2) = 'APPROVED' OR 'ONGOING'
                               PERFORM 600-VALIDATE-USER 
                               EVALUATE TRUE 
                                   WHEN SERVICE-PROVIDER = 'Y' AND 
                                        REQUESTOR = 'Y'
                                       EXEC CICS XCTL  
                                           PROGRAM('SM003P')
                                       END-EXEC
                                   WHEN SERVICE-PROVIDER = 'Y'
                                       EXEC CICS XCTL  
                                           PROGRAM('SM003P')
                                       END-EXEC
                                   WHEN REQUESTOR = 'Y'
                                       EXEC CICS
                                           READ FILE('STF00001')
                                           INTO (WS-TIX-REC)
                                           RIDFLD (TNI(WS-COUNTER2))
                                           RESP(WS-RESPONSE-CODE)
                                           EQUAL 
                                       END-EXEC
                                       IF WS-USERID = TIX-REQUESTOR  
                                           EXEC CICS XCTL  
                                               PROGRAM('SM003P')
                                           END-EXEC
                                       ELSE 
                                           MOVE '_' TO UCI(WS-COUNTER2)
                                           MOVE 'INVALID ACCESS' TO MSGO
                                           PERFORM 100-NEW-MAP
                                       END-IF
                                   WHEN OTHER  
                                       MOVE '_' TO UCI(WS-COUNTER2)
                                       MOVE 'INVALID ACCESS' TO MSGO
                                       PERFORM 100-NEW-MAP
                               END-EVALUATE
                           ELSE 
                               MOVE '_' TO UCI(WS-COUNTER2)
                               MOVE 'STATUS MUST BE APPROVED OR ONGOING'
                                   TO MSGO  
                               PERFORM 100-NEW-MAP
                           END-IF
                       WHEN 'C'
                           IF STI(WS-COUNTER2) = 'COMPLETED'
                               PERFORM 600-VALIDATE-USER 
                               EXEC CICS
                                   READ FILE('STF00001')
                                   INTO (WS-TIX-REC)
                                   RIDFLD (TNI(WS-COUNTER2))
                                   RESP(WS-RESPONSE-CODE)
                                   EQUAL 
                               END-EXEC
                               IF WS-USERID = TIX-REQUESTOR  
                                   EXEC CICS XCTL  
                                       PROGRAM('SM004P')
                                   END-EXEC
                               ELSE 
                                   MOVE '_' TO UCI(WS-COUNTER2)
                                   MOVE 'INVALID ACCESS' TO MSGO
                                   PERFORM 100-NEW-MAP
                               END-IF
                           ELSE 
                               MOVE '_' TO UCI(WS-COUNTER2)
                               MOVE 'STATUS MUST BE COMPLETED' TO 
                                   MSGO  
                               PERFORM 100-NEW-MAP
                           END-IF
                       WHEN 'A'
                               IF STI(WS-COUNTER2) = 'CREATED'
                               PERFORM 600-VALIDATE-USER 
                               EVALUATE TRUE 
                                   WHEN APPROVER = 'Y'
                                       EXEC CICS
                                           READ FILE('STF00001')
                                           INTO (WS-TIX-REC)
                                           RIDFLD (TNI(WS-COUNTER2))
                                           RESP(WS-RESPONSE-CODE)
                                           EQUAL 
                                       END-EXEC
                                       IF WS-USERID = TIX-REQUESTOR  
                                           EXEC CICS XCTL  
                                               PROGRAM('SM005P')
                                           END-EXEC
                                       ELSE 
                                           MOVE '_' TO UCI(WS-COUNTER2)
                                           MOVE 'INVALID ACCESS' TO MSGO
                                           PERFORM 100-NEW-MAP
                                       END-IF
                                   WHEN OTHER  
                                       MOVE '_' TO UCI(WS-COUNTER2)
                                       MOVE 'INVALID ACCESS' TO MSGO
                                       PERFORM 100-NEW-MAP
                               END-EVALUATE
                           ELSE 
                               MOVE '_' TO UCI(WS-COUNTER2)
                               MOVE 'STATUS MUST BE CREATED' TO 
                                   MSGO  
                               PERFORM 100-NEW-MAP
                           END-IF
                       WHEN 'X'
                           EXEC CICS
                               READ FILE('STF00001')
                               INTO (WS-TIX-REC)
                               RIDFLD (TNI(WS-COUNTER2))
                               RESP(WS-RESPONSE-CODE)
                               EQUAL 
                           END-EXEC
                           IF WS-USERID = TIX-REQUESTOR  
                               EXEC CICS XCTL  
                                   PROGRAM('SM006P')
                               END-EXEC
                           ELSE 
                               MOVE '_' TO UCI(WS-COUNTER2)
                               MOVE 'INVALID ACCESS' TO MSGO
                               PERFORM 100-NEW-MAP
                           END-IF
                       WHEN SPACE 
                           MOVE '_' TO UCI(WS-COUNTER2)
                           MOVE 'OPTION IS REQUIRED' TO MSGO
                           PERFORM 100-NEW-MAP
                       WHEN OTHER
                           MOVE '_' TO UCI(WS-COUNTER2)
                           MOVE 'ENTER U, C, A, OR X AND PRESS ENTER' TO
                                 MSGO 
                           PERFORM 100-NEW-MAP
                   END-EVALUATE
               END-IF
           END-IF.

       260-WHENF5 SECTION.
           
       270-WHENF12 SECTION.
           PERFORM UNTIL WS-QITEM-PAGE < WS-QITEM-START OR
                         WS-QITEM-PAGE = WS-QITEM-START
                       SUBTRACT 11 FROM WS-QITEM-PAGE
           END-PERFORM
           MOVE 'THIS IS THE FIRST PAGE' TO MSGO
           MOVE 1 TO WS-PAGE
           MOVE WS-QITEM-START TO WS-QITEM-PAGE
            MOVE WS-PAGE TO PAGEO
            PERFORM 500-MOVE-Q-TO-SCREEN   
            PERFORM 100-NEW-MAP.
   
       500-MOVE-Q-TO-SCREEN SECTION.

            MOVE WS-QITEM-PAGE TO WS-QITEM
            EXEC CICS READQ TS
                      QUEUE(WS-QNAME)
                      INTO (WS-TIX-REC)
                      ITEM (WS-QITEM)
             END-EXEC  
          
            MOVE 1 TO WS-INDX

            PERFORM UNTIL WS-INDX > 11
                IF EIBRESP = DFHRESP(NORMAL) AND 
                   WS-QITEM <= WS-QITEM-END  
                   MOVE TIX-ID TO TNI(WS-INDX)
                   MOVE TIX-TITLE TO TTI(WS-INDX)
                   MOVE TIX-STATUS TO STI(WS-INDX)
                   MOVE LAST-UPDATE TO UDI(WS-INDX)
                   MOVE UPDBY2 TO UBI(WS-INDX)
                   ADD 1 TO WS-INDX
                   ADD 1 TO WS-QITEM
                   EXEC CICS READQ TS
                        QUEUE(WS-QNAME)
                        INTO (WS-TIX-REC)
                        ITEM (WS-QITEM)
                  END-EXEC  
               ELSE
                  MOVE SPACES TO TNI(WS-INDX)
                  MOVE SPACES TO TTI(WS-INDX)
                  MOVE SPACES TO STI(WS-INDX)
                  MOVE SPACES TO UDI(WS-INDX)
                  MOVE SPACES TO UBI(WS-INDX)
                  MOVE 'THIS IS THE LAST PAGE' TO MSGO
                  MOVE '1' TO WS-LASTPAGE 
                  ADD 1 TO WS-INDX
               END-IF
            END-PERFORM.

       500-EXIT.
           EXIT.
	   
       600-VALIDATE-USER.
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
           IF NOT WS-RESPONSE-CODE = +00
               MOVE 'INVALID ACCESS' TO MSGO
               PERFORM 100-NEW-MAP
           END-IF.
   
       999-MOVE-FILE-TO-Q SECTION.

            MOVE LOW-VALUES TO TIX-ID. 
            EXEC CICS 
               STARTBR FILE('stf00001')
               RIDFLD (TIX-ID)
               GTEQ
            END-EXEC

            EXEC CICS 
                READNEXT FILE('stf00001')
                INTO (WS-TIX-REC)
                RIDFLD (TIX-ID)
            END-EXEC

           EXEC CICS WRITEQ TS
                     QUEUE(WS-QNAME)
                     FROM (WS-TIX-REC)
                     ITEM (WS-QITEM)
           END-EXEC
           MOVE WS-QITEM TO WS-QITEM-START
           PERFORM UNTIL EIBRESP NOT = DFHRESP(NORMAL)
               MOVE WS-QITEM TO WS-QITEM-END
               EXEC CICS 
                    READNEXT FILE('stf00001')
                    INTO (WS-TIX-REC)
                    RIDFLD (TIX-ID)
               END-EXEC
	           IF EIBRESP = DFHRESP(NORMAL)
	               EXEC CICS WRITEQ TS
	               	   QUEUE(WS-QNAME)
	               	   FROM (WS-TIX-REC)
	               	   ITEM (WS-QITEM)
	               END-EXEC
               END-IF
           END-PERFORM
           EXEC CICS
                ENDBR FILE('stf00001')
           END-EXEC
           MOVE WS-QITEM-START TO WS-QITEM-PAGE.
         
       999-EXIT.
           EXIT. 



