       CBL XOPTS(COBOL2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. UA001P.
      
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.    IBM-PC.
       OBJECT-COMPUTER.    IBM-PC.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-CURRENT-MAP              PIC X(7)  VALUE 'UA001M'.
       01  WS-TIME                     PIC 9(15) COMP-3.
       01  WS-USERID                   PIC X(8).
       01  WS-PRGNAME                  PIC X(6).     
       01  WS-LENGTH                   PIC S9(4) COMP.
       01  WS-QNAME                    PIC X(8).
       01  WS-RECB-LENGTH              PIC S9(4) COMP VALUE +20.
       01  WS-KEYB-LENGTH              PIC S9(4) COMP VALUE +8. 
       01  WS-KEYB.                       
           05 WS-KEYB7                   PIC X(07) VALUE LOW-VALUES.
           05 FILLER REDEFINES WS-KEYB7.
              10 FILLER                  PIC X(04).
              10 WS-KEYB3                PIC 9(03). 
           05 WS-KEYB1                   PIC X(01) VALUE HIGH-VALUES.
       01  WS-RECKEY                   VALUE 'ISCB101 '.
           05 WS-USR2                  PIC X(04).
           05 WS-KEY-NUM               PIC 9(03).
           05 FILLER                   PIC X.
       01  WS-SEARCH.
           05  WS-ISCB                 PIC X(4)  VALUE 'ISCB'.
           05  WS-KEY2                 PIC 999.
           05  FILLER                  PIC X     VALUE SPACES.
       01  WS-INDX                     PIC 9(2)  VALUE 1.
       01  WS-REC.
           05  WS-UID.
               10 FILLER               PIC X(04).
               10 WS-UID2              PIC 9(03).
               10 FILLER               PIC X.   
           05  WS-UID-REDEF REDEFINES WS-UID.
               10  WS-USERID7      PIC X(7).
               10  FILLER          PIC X(1).
           05  WS-REQ                  PIC X.
           05  WS-ADMN                 PIC X.
           05  WS-APP                  PIC X.
           05  WS-SP                   PIC X.
           05  WS-UPBY                 PIC X(08).
       01  WS-LASTPAGE                 PIC X(1).
       01  WS-FIRSTPAGE                PIC X(1).
       01  WS-PAGE-CTR                 PIC 9(02).
       01  WS-COMMAREA.
           05  WS-COMMAREA-REC.
               10  WS-CA-UID           PIC X(8).
               10  WS-CA-REC.
                   15  WS-CA-REQ       PIC X.
                   15  WS-CA-ADMN      PIC X.  
                   15  WS-CA-APP       PIC X.
                   15  WS-CA-SP        PIC X.
               10  WS-CA-UPBY          PIC X(8).
           05  WS-CA-PRGNAME           PIC X(06).
           05  FILLER                  PIC X(19).
           05  WS-DFHSTATE             PIC X(15). 
           05  WS-TRANS                PIC X(04).  
           05  WS-LUSER                PIC 9(03).
           05  WS-FUSER                PIC 9(03).
           05  WS-PAGE                 PIC 9(02).
           05  WS-PAGE-END             PIC 9(01).
           05  WS-SWITCH               PIC X.
           05  WS-QITEM                PIC S9(4) COMP.
           05  WS-QITEM-START          PIC S9(4) COMP.
           05  WS-QITEM-END            PIC S9(4) COMP.
           05  WS-QITEM-PAGE           PIC S9(4) COMP.
      *
       COPY UA001S.
       01  WS-UA001 REDEFINES UA001MI.
           05  FILLER                  PIC X(52).
           05  UD  OCCURS 11. 
               10  UDL                 PIC S9(4) COMP.
               10  UDF                 PIC X.
               10  FILLER REDEFINES UDF.
                   15  UDA             PIC X.
               10  UDI                 PIC X(001).
           05  UID     OCCURS 11.
               10  UIDL                PIC S9(4) COMP.
               10  UIDF                PIC X.
               10  FILLER REDEFINES UIDF.
                   15  UIDA            PIC X.
               10  UIDI.
                   15 FILLER           PIC X(04).
                   15 WS-USERNUM       PIC 9(03). 
                   15 FILLER           PIC X. 
           05  REQ     OCCURS 11.
               10  REQL                PIC S9(4) COMP.
               10  REQF                PIC X.
               10  FILLER REDEFINES REQF.
                   15 REQA             PIC X.
               10  REQI                PIC X(001).
           05  ADMN      OCCURS 11.
               10  ADMNL               PIC S9(4) COMP.
               10  ADMNF               PIC X.
               10  FILLER REDEFINES ADMNF.
                   15  ADMNA           PIC X.
               10  ADMNI               PIC X(001).
           05  APP     OCCURS 11.
               10  APPL                PIC S9(4) COMP.
               10  APPF                PIC X.
               10  FILLER REDEFINES APPF.
                   15  APPA            PIC X.
               10  APPI                PIC X(001).
           05  SP          OCCURS 11.
               10  SPL                 PIC S9(4) COMP.
               10  SPF                 PIC X.
               10  FILLER REDEFINES SPF.
                   15  SPA             PIC X.
               10  SPI                 PIC X(001).
    
      *
       COPY DFHAID.
      *
         COPY DFHBMSCA.

       LINKAGE SECTION.
        01  DFHCOMMAREA.
          05  DF-REC.
              10  DF-USERID            PIC X(8).
              10  DF-REC.
                  15  DF-REQ           PIC X.
                  15  DF-ADMIN         PIC X.  
                  15  DF-APP           PIC X.
                  15  DF-SERVICE       PIC X.
              10  DF-UPDATEDBY         PIC X(8).
           05  DF-PRGNAME              PIC  X(6).
           05  FILLER                  PIC X(19).
           05  DFHSTATE                PIC X(15).
           05  DF-TRANS                PIC X(04).  
           05  DF-LUSER                PIC 9(03).
           05  DF-FUSER                PIC 9(03).
           05  DF-PAGE                 PIC 9(02).
           05  DF-PAGE-END             PIC 9(01).
           05  DF-SWITCH               PIC X. 
           05  DF-QITEM                PIC S9(4) COMP.
           05  DF-QITEM-START          PIC S9(4) COMP.
           05  DF-QITEM-END            PIC S9(4) COMP.
           05  DF-QITEM-PAGE           PIC S9(4) COMP.
		   05  DF-SAMPLE               PIC X(08).
		   05  DF-UA02-STATE           PIC X(15).
      *
       PROCEDURE DIVISION.
       100-PROCESS SECTION.
           MOVE DFHCOMMAREA TO WS-COMMAREA
           STRING EIBTRMID DELIMITED BY SIZE
	          EIBTRNID DELIMITED BY SIZE
                  INTO WS-QNAME 
           MOVE LENGTH OF UA001MI TO WS-LENGTH
           EXEC CICS
             IGNORE CONDITION ERROR
           END-EXEC

           IF EIBCALEN = +0 
               MOVE 1 TO WS-PAGE
               MOVE WS-PAGE TO PAGEO
               MOVE 'INITIAL' TO WS-DFHSTATE
               MOVE 'N' TO DF-SWITCH 
               PERFORM 999-MOVE-FILE-TO-Q
               PERFORM 500-MOVE-Q-TO-SCREEN
               PERFORM 100-NEW-MAP

           ELSE
                EXEC CICS
                     RECEIVE MAP ('UA001M')
                     MAPSET ('UA001S')
                     INTO (UA001MI)
                 END-EXEC
                IF  NOT EIBRESP = DFHRESP(MAPFAIL) 
                    EVALUATE EIBAID
					 WHEN DFHPF2
					    PERFORM 210-WHENF2
                     WHEN DFHPF3
                        EXEC CICS 
                            SEND CONTROL 
                            ERASE
                        END-EXEC
                        EXEC CICS DELETEQ TS
                             QUEUE(WS-QNAME)
                        END-EXEC 
                        EXEC CICS RETURN
                        END-EXEC
                     
                    WHEN DFHPF7
                        PERFORM 220-WHENF7
                       
                    WHEN DFHPF8
                        PERFORM 230-WHENF8
                       
                    WHEN OTHER
                        MOVE 'INVALID PFKEY PRESSED' TO ERRMSGO  
                    END-EVALUATE
               ELSE
                   PERFORM 100-NEW-MAP
               END-IF
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
               SEND MAP ('UA001M')
               MAPSET ('UA001S')
               FROM (UA001MO)
               LENGTH(WS-LENGTH)
               ERASE
           END-EXEC
           
           EXEC CICS RETURN
               TRANSID('UA01')
               COMMAREA(WS-COMMAREA)
           END-EXEC.

       210-WHENF2 SECTION.
	       EXEC CICS ASSIGN
               USERID(WS-USERID)
           END-EXEC
	       MOVE 'INITIAL' TO DF-UA02-STATE 
		   EXEC CICS XCTL
			    
                PROGRAM('UA002P')
				COMMAREA(DF-UA02-STATE)
				LENGTH(15)
           END-EXEC.
		   
       220-WHENF7 SECTION.
            
            SUBTRACT 11 FROM WS-QITEM-PAGE
            SUBTRACT 1 FROM WS-PAGE
            IF WS-QITEM-PAGE = WS-QITEM-START OR 
               WS-QITEM-PAGE <  WS-QITEM-START
               MOVE 'THIS IS THE FIRST PAGE' TO ERRMSGO
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
               MOVE 'THIS IS THE LAST PAGE' TO ERRMSGO
            ELSE
               ADD 1 TO WS-PAGE
               MOVE WS-PAGE TO PAGEO
               PERFORM 500-MOVE-Q-TO-SCREEN
            END-IF.   
            PERFORM 100-NEW-MAP.
   
       500-MOVE-Q-TO-SCREEN SECTION.

            MOVE WS-QITEM-PAGE TO WS-QITEM
            EXEC CICS READQ TS
                      QUEUE(WS-QNAME)
                      INTO (WS-REC)
                      LENGTH(WS-RECB-LENGTH)
                      ITEM (WS-QITEM)
             END-EXEC  
          
            MOVE 1 TO WS-INDX

            PERFORM UNTIL WS-INDX > 11
                IF EIBRESP = DFHRESP(NORMAL) AND 
                   WS-QITEM <= WS-QITEM-END  
                   MOVE WS-UID TO UIDI(WS-INDX)
                   MOVE WS-REQ TO REQI(WS-INDX)
                   MOVE WS-ADMN TO ADMNI(WS-INDX)
                   MOVE WS-APP TO APPI(WS-INDX)
                   MOVE WS-SP TO SPI(WS-INDX)
                   ADD 1 TO WS-INDX
                   ADD 1 TO WS-QITEM
                   EXEC CICS READQ TS
                        QUEUE(WS-QNAME)
                        INTO (WS-REC)
                        ITEM (WS-QITEM)
                  END-EXEC  
               ELSE
                  MOVE SPACES TO UDI(WS-INDX)
                  MOVE SPACES TO UIDI(WS-INDX)
                  MOVE SPACES TO REQI(WS-INDX)
                  MOVE SPACES TO ADMNI(WS-INDX)
                  MOVE SPACES TO APPI(WS-INDX)
                  MOVE SPACES TO SPI(WS-INDX)
                  MOVE 'THIS IS THE LAST PAGE'  TO ERRMSGO
                  MOVE '1' TO WS-LASTPAGE 
                  ADD 1 TO WS-INDX
               END-IF
            END-PERFORM

           MOVE WS-USERNUM(1) TO WS-FUSER.

       500-EXIT.
           EXIT.
   
       999-MOVE-FILE-TO-Q SECTION.

            MOVE LOW-VALUES TO WS-KEYB. 
            EXEC CICS 
               STARTBR FILE('uaf00001')
               RIDFLD (WS-KEYB)
               GTEQ
            END-EXEC
                 
            EXEC CICS 
                READNEXT FILE('uaf00001')
                INTO (WS-REC)
                RIDFLD (WS-KEYB)
            END-EXEC


           EXEC CICS WRITEQ TS
                     QUEUE(WS-QNAME)
                     FROM (WS-REC)
                     LENGTH (WS-RECB-LENGTH)
                     ITEM (WS-QITEM)
           END-EXEC
           MOVE WS-QITEM TO WS-QITEM-START
           PERFORM UNTIL EIBRESP NOT = DFHRESP(NORMAL)
               MOVE WS-QITEM TO WS-QITEM-END
               EXEC CICS 
                    READNEXT FILE('uaf00001')
                    INTO (WS-REC)
                    RIDFLD (WS-KEYB)
               END-EXEC
               IF EIBRESP = DFHRESP(NORMAL)
                  EXEC CICS WRITEQ TS
                       QUEUE(WS-QNAME)
                       FROM (WS-REC)
                       LENGTH (WS-RECB-LENGTH)
                       ITEM (WS-QITEM)
                  END-EXEC
                  MOVE WS-USERID7 TO WS-KEYB7
                  MOVE HIGH-VALUES TO WS-KEYB1
               END-IF
           END-PERFORM
           EXEC CICS
                ENDBR FILE('uaf00001')
           END-EXEC
           MOVE WS-QITEM-START TO WS-QITEM-PAGE.
         
       999-EXIT.
           EXIT. 



