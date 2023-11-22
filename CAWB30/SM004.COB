       IDENTIFICATION DIVISION.
       PROGRAM-ID. SM004.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.    IBM-PC.
       OBJECT-COMPUTER.    IBM-PC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-COMMAREA. 
           05 WS-PROG-STATE                    PIC X(20).   
       LINKAGE SECTION.
       01  DFHCOMMAREA                         PIC X(20).
      *
       PROCEDURE DIVISION.
       100-PROC.
           MOVE 'SM004 IS IN CONTROL' TO WS-PROG-STATE
           EXEC CICS XCTL
               PROGRAM('SM000')
               COMMAREA(WS-COMMAREA)
           END-EXEC.
       100-EXIT.
           EXIT.