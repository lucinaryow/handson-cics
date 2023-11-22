       CBL XOPTS(COBOL2)
       IDENTIFICATION DIVISION.
       PROGRAM-ID. UA002P.
      
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.    IBM-PC.
       OBJECT-COMPUTER.    IBM-PC.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-CURRENT-MAP              PIC X(7)  VALUE 'UA002M'.
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
       01  WS-FIELDS. 
           05  WS-STD-KEY-LEN    PIC S9(4) COMP VALUE 8.
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
       01  WS-COMMAREA.
		   05 WS-DFHSTATE PIC X(15).
       01  WS-LITERALS.
           05  WS-AFTER-ADD.
	           10 FILLER PIC X(21) VALUE 
			   'USER ID CREATED,PRESS'.
			   10 FILLER PIC X(32) VALUE
			   ' ENTER TO CREATE ANOTHER USER ID'.
		   05  WS-INVALID-ACCESS PIC X(14) VALUE
		       'INVALID ACCESS'.
		   05  WS-DUP-REC PIC X(47) VALUE 
		      'DUPLICATE USER FOUND, PLEASE ENTER ANOTHER USER'.
		   05  WS-INITIAL PIC X(32) VALUE 
              'ENTER USER DETAILS AND PRESS PF2'.		   
       01  WS-SWITCHES.
	       05  WS-EMPTY                PIC X.
		   05  WS-VALIDF               PIC X.
      *
       COPY UA002S.       
    
      *
       COPY DFHAID.
      *
         COPY DFHBMSCA.

       LINKAGE SECTION.
        01  DFHCOMMAREA.
          05 DF-SAMPLE PIC X(15).
      *
       PROCEDURE DIVISION.
       100-PROCESS SECTION.
           MOVE DFHCOMMAREA TO WS-COMMAREA

           STRING EIBTRMID DELIMITED BY SIZE
	          EIBTRNID DELIMITED BY SIZE
                  INTO WS-QNAME 
           MOVE LENGTH OF UA002MI TO WS-LENGTH
           EXEC CICS
             IGNORE CONDITION ERROR
           END-EXEC

           IF DF-SAMPLE = 'INITIAL'
               PERFORM 110-CHECKUSER
               MOVE 'DATA ENTRY' TO WS-DFHSTATE
			   move ' ' to df-sample
               PERFORM 100-NEW-MAP

           ELSE
                EXEC CICS
                     RECEIVE MAP ('UA002M')
                     MAPSET ('UA002S')
                     INTO (UA002MI)
                 END-EXEC
                IF  NOT EIBRESP = DFHRESP(MAPFAIL) 
                    EVALUATE EIBAID
					 
					 WHEN DFHENTER
					    PERFORM 200-WHEN-ENTER
					 WHEN DFHPF2
					    PERFORM 210-WHEN-F2
                     WHEN DFHPF3

                        EXEC CICS RETURN
						   TRANSID('UA01')
					    END-EXEC
                     WHEN DFHPF5
                        PERFORM 220-WHEN-F5					 
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
               SEND MAP ('UA002M')
               MAPSET ('UA002S')
               FROM (UA002MO)
               LENGTH(WS-LENGTH)
               ERASE
           END-EXEC
           
           EXEC CICS RETURN
               TRANSID('UA02')
               COMMAREA(WS-COMMAREA)
           END-EXEC.
		   
       110-CHECKUSER SECTION.
           EXEC CICS ASSIGN
               USERID(WS-USERID)
           END-EXEC
		   EXEC CICS 
                READ FILE('uaf00001')
                INTO (WS-REC)
                RIDFLD (WS-USERID)
                KEYLENGTH (WS-STD-KEY-LEN)
                EQUAL
           END-EXEC
		   
		   IF WS-ADMN = 'N'
		      EXEC CICS SEND TEXT
                    FROM (WS-INVALID-ACCESS)
                    LENGTH (+15)
                    ERASE
               END-EXEC
               EXEC CICS RETURN
               END-EXEC
		   END-IF.
		  		   
       200-WHEN-ENTER SECTION.
           EVALUATE WS-DFHSTATE
		   WHEN 'DATA ENTRY'
			  PERFORM 700-VALIDATE-FIELD
			  MOVE 'PRESS PF2 TO ADD USER'
			  TO ERRMSGO
			  
			  PERFORM 710-PROTECT-FIELDS

		   WHEN 'READY TO ADD'
              PERFORM 710-PROTECT-FIELDS
			  MOVE 'PRESS PF2 TO ADD USER'
			  TO ERRMSGO
			
           WHEN 'AFTER ADD'
              PERFORM 720-RESET-FIELDS
              MOVE WS-INITIAL TO ERRMSGO			  
		      PERFORM 100-NEW-MAP
                			  
		   END-EVALUATE.
		   	   
       210-WHEN-F2 SECTION.
	       EVALUATE WS-DFHSTATE
		   WHEN 'DATA ENTRY'
			  PERFORM 700-VALIDATE-FIELD
			  MOVE 'PRESS PF2 TO CONFIRM ADD'
			  TO ERRMSGO
			  
			  PERFORM 710-PROTECT-FIELDS

		   WHEN 'READY TO ADD'
              
			  PERFORM 800-WRITE-TOFILE
			  
           WHEN 'AFTER ADD'
              PERFORM 710-PROTECT-FIELDS
			  
		   WHEN OTHER
		      MOVE WS-DFHSTATE 	TO ERRMSGO
		   END-EVALUATE.
		   
       220-WHEN-F5 SECTION.
           EVALUATE WS-DFHSTATE
		   WHEN 'AFTER ADD' 
		      EXEC CICS ASSIGN 
				 USERID(WS-USERID)
			  END-EXEC
		   WHEN OTHER
		      PERFORM 720-RESET-FIELDS
			  MOVE WS-INITIAL TO ERRMSGO
 	       END-EVALUATE.
		   
       700-VALIDATE-FIELD SECTION.

	       IF USERI = 'XXXXXXXX' 
		       MOVE DFHBMBRY TO USERA
			   MOVE 'USER IS REQUIRED' TO ERRMSGO
			   PERFORM 100-NEW-MAP
		   END-IF
		   
		   IF REQUESTI = ' ' OR REQUESTI = '_' 
		       MOVE DFHBMBRY TO REQUESTA
			   MOVE 'REQUESTOR IS REQUIRED' TO ERRMSGO
			   PERFORM 100-NEW-MAP
		   END-IF
		   
		   IF REQUESTI NOT = 'N' AND REQUESTI NOT = 'Y'
		       MOVE DFHBMBRY TO REQUESTA
			   MOVE 'REQUESTOR INVALID VALUE' TO ERRMSGO
			   PERFORM 100-NEW-MAP
		   END-IF
		   
		   IF ADMINI = ' ' OR ADMINI = '_' 
		       MOVE DFHBMBRY TO ADMINA
			   MOVE 'ADMIN IS REQUIRED' TO ERRMSGO
			   PERFORM 100-NEW-MAP
		   END-IF
		   
		   IF ADMINI NOT = 'N' AND ADMINI NOT = 'Y' 
		       MOVE DFHBMBRY TO ADMINA
			   MOVE 'ADMIN INVALID VALUE' TO ERRMSGO
			   PERFORM 100-NEW-MAP
		   END-IF
		   
		   IF APPROVEI = ' ' OR APPROVEI = '_' 
		       MOVE DFHBMBRY TO APPROVEA
			   MOVE 'APPROVER IS REQUIRED' TO ERRMSGO
			   PERFORM 100-NEW-MAP
		   END-IF
		   
		   IF APPROVEI NOT = 'N' AND APPROVEI NOT = 'Y' 
		       MOVE DFHBMBRY TO APPROVEA
			   MOVE 'APPROVER INVALID VALUE' TO ERRMSGO
			   PERFORM 100-NEW-MAP
		   END-IF
		   
		   IF SERVICEI = ' ' OR SERVICEI = '_' 
		       MOVE DFHBMBRY TO SERVICEA
			   MOVE 'SERVICE PROVIDER IS REQUIRED' 
			         TO ERRMSGO
			   PERFORM 100-NEW-MAP
		   END-IF
	
	       IF SERVICEI NOT = 'N' AND SERVICEI NOT = 'Y' 
		       MOVE DFHBMBRY TO SERVICEA
			   MOVE 'SERVICE INVALID VALUE' 
			         TO ERRMSGO
			   PERFORM 100-NEW-MAP
		   END-IF
		   	   
		   MOVE 'READY TO ADD' TO WS-DFHSTATE.		
       710-PROTECT-FIELDS SECTION.
           MOVE DFHBMPRF TO USERA
           MOVE DFHBMPRF TO REQUESTA
           MOVE DFHBMPRF TO ADMINA
           MOVE DFHBMPRF TO APPROVEA
           MOVE DFHBMPRF TO SERVICEA.
		   
       720-RESET-FIELDS SECTION.
           MOVE 'XXXXXXXX' TO USERO	   
	       MOVE '_' TO REQUESTO
           MOVE '_' TO ADMINO
           MOVE '_' TO APPROVEO
           MOVE '_' TO SERVICEO
		   
		   MOVE 'DATA ENTRY' TO WS-DFHSTATE.
		   
       800-WRITE-TOFILE SECTION.
	   
* VALIDATE FIRST THEN WRITE INTO FILE 
           		   
		   MOVE USERI TO WS-UID
		   MOVE REQUESTI TO WS-REQ
		   MOVE ADMINI TO WS-ADMN
		   MOVE APPROVEI TO WS-APP
		   MOVE SERVICEI TO WS-SP

	       EXEC CICS ASSIGN
               USERID(WS-UPBY)
           END-EXEC
		   		   
 		   MOVE WS-REC TO ERRMSGO
		   
		   EXEC CICS
               WRITE FILE ('UAF00001')
               FROM (WS-REC)
               RIDFLD (WS-UID)
           END-EXEC
		   IF EIBRESP = DFHRESP(DUPREC)
		      MOVE WS-DUP-REC TO ERRMSGO
			  PERFORM 720-RESET-FIELDS
		   ELSE
		      PERFORM 710-PROTECT-FIELDS
		      MOVE WS-AFTER-ADD	TO ERRMSGO
			  MOVE 'AFTER ADD' TO WS-DFHSTATE 
		   END-IF.
		   
		   
