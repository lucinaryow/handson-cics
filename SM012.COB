       CBL XOPTS(COBOL2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SM012.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.    IBM-PC.
       OBJECT-COMPUTER.    IBM-PC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-TIME            PIC 9(15) COMP-3.
       01  WS-DATE            PIC 9(7).
       01  WS-DATE-X REDEFINES WS-DATE PIC X(7).       
       01  WS-INVALID         PIC X(15) VALUE 'INVALID ACCESS'.
       01  WS-ABORT           PIC X(22) VALUE 'TICKET CLOSURE ABORTED'.
       01  WS-RESPONSE-CODE   PIC 9(02).
       01  WS-RESPONSE-CODE1   PIC 9(02).
       01  WS-BLANK-MESG      PIC X(55) VALUE 
           'TICKET APPROVED, PRESS ENTER TO APPROVE ANOTHER TICKET'.
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
       01  WS-PROG-ID    PIC X(06).
       01  WS-LENGTH          PIC S9(4) COMP.
           COPY SW12.
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
           MOVE DFHCOMMAREA TO WS-COMMAREA
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
               SEND MAP('MAP05')
               MAPSET('SW12')
               FROM(MAP05O)
               ERASE
           END-EXEC
            EXEC CICS 
                RECEIVE MAP('MAP05')
                MAPSET('SW12')
                INTO (MAP05I)
            END-EXEC
                 EVALUATE TRUE
                   WHEN EIBAID = DFHPF3
                       EVALUATE TRUE
                        WHEN WS-ID = 'SM00' 
                            MOVE 'SM000P' TO WS-PROG-ID
                        WHEN WS-ID = 'SM01' 
                              MOVE 'SM001' TO WS-PROG-ID
                        WHEN WS-ID = 'SM05' 
                              MOVE 'SM005' TO WS-PROG-ID
                        WHEN WS-ID = 'SM04' 
                              MOVE 'SM004' TO WS-PROG-ID      
                        END-EVALUATE 
                           MOVE 'SM12'TO WS-ID
                         EXEC CICS XCTL 
                               PROGRAM(WS-PROG-ID)
                               COMMAREA(WS-COMMAREA)
                         END-EXEC  
                   WHEN EIBAID = DFHPF5  
                         MOVE 'SM01' TO WS-ID
                         MOVE  1 TO WS-PROG-STATE
                           EXEC CICS XCTL 
                               PROGRAM('SM004')
                               COMMAREA(WS-COMMAREA)
                           END-EXEC       
                  END-EVALUATE.   
      
       100-EXIT.
           EXIT.   
