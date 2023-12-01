*$CALL,APOST,COMP-5
 IDENTIFICATION DIVISION.
 PROGRAM-ID. PRIMES.
*
*  Seive program using standard COBOL. This version uses SEARCH
*  to find non-zero flags.
*
*  Copyright (c) 1992-94 Computer Associates International, Inc.
*
 ENVIRONMENT DIVISION.
 CONFIGURATION SECTION.
 SOURCE-COMPUTER. IBM-PC.
 OBJECT-COMPUTER. IBM-PC.
 DATA DIVISION.
 WORKING-STORAGE SECTION.
 77  TOTAL-PRIME-COUNT           PIC S9(4) COMP.
 77  PRIME                       PIC S9(9) COMP.
 77  PRIME-MULTIPLE              PIC S9(9) COMP.
 01  PRIME-FLAGS-GROUP.
     05  PRIME-FLAG              PIC X OCCURS 8191 TIMES
         INDEXED BY PRIME-INDEX.
 01  FILLER.
     05  TIME-AREA.
         10  HH                  PIC 99.
         10  MM                  PIC 99.
         10  SS                  PIC 99.
         10  HUN                 PIC 99.
     05  TIME-SYNC               PIC X(8).
     05  MILLI-SECONDS           PIC S9(8) COMP.
     05  BGN-MILLI-SECONDS       PIC S9(8) COMP.
     05  DISPLAY-MILLI-SECONDS   PIC Z(8).
/
 PROCEDURE DIVISION.
 PRIME-COUNT-ROUTINE.
*
*  Compute the primes 10 times to increase timing accuracy.
*  Indicate all odd numbers are potential primes
*  Indicate no primes have been found.
*
     PERFORM CALC-MILLI-SECONDS
     MOVE MILLI-SECONDS TO BGN-MILLI-SECONDS.
     PERFORM 10 TIMES
         MOVE ALL '1' TO PRIME-FLAGS-GROUP
         MOVE ZERO TO TOTAL-PRIME-COUNT
         SET PRIME-INDEX TO 1
         PERFORM COUNT-PRIMES
     END-PERFORM
     PERFORM CALC-MILLI-SECONDS.
     SUBTRACT BGN-MILLI-SECONDS FROM MILLI-SECONDS
         GIVING DISPLAY-MILLI-SECONDS.
     DISPLAY 'Found ' TOTAL-PRIME-COUNT ' prime numbers 10 times'
     INSPECT DISPLAY-MILLI-SECONDS TALLYING TALLY FOR ALL SPACES
     ADD 1 TO TALLY
     DISPLAY 'Elapsed time was '
             DISPLAY-MILLI-SECONDS (TALLY:) ' milliseconds'
     STOP RUN.
*
*  For each number which has not been flagged as a multiple
*  of an earlier prime, indicate all of its multiples in
*  the range being evaluated are not primes. Note that
*  PRIME-FLAG(1) represents the integer 3, PRIME-FLAG(n)
*  represents the integer 2n+1.
*
*  Note that PRIME-MULTIPLE technically can only contain
*  values through 9999, but will have values up to 24574.
*  This works since ADD need not truncate like MOVE, and
*  S9(4) COMP fields can be -32768 through 32767.
*
 COUNT-PRIMES.
     SEARCH PRIME-FLAG VARYING PRIME-INDEX
         WHEN PRIME-FLAG (PRIME-INDEX) IS NOT EQUAL TO ZERO
             ADD 1 TO TOTAL-PRIME-COUNT
             SET PRIME-MULTIPLE TO PRIME-INDEX
             ADD PRIME-MULTIPLE PRIME-MULTIPLE 1 GIVING PRIME
             ADD PRIME TO PRIME-MULTIPLE
             SET PRIME-INDEX UP BY 1
             PERFORM UNTIL PRIME-MULTIPLE > 8191
                 MOVE ZERO TO PRIME-FLAG (PRIME-MULTIPLE)
                 ADD PRIME TO PRIME-MULTIPLE
             END-PERFORM
             GO TO COUNT-PRIMES.
*
*  Get time in milliseconds
*
 CALC-MILLI-SECONDS.
     ACCEPT TIME-SYNC FROM TIME.
     PERFORM CALC-MILLI-SECONDS-LOOP.
     MULTIPLY HH BY 60 GIVING MILLI-SECONDS.
     ADD MM TO MILLI-SECONDS.
     MULTIPLY 60 BY MILLI-SECONDS.
     ADD SS TO MILLI-SECONDS.
     MULTIPLY 100 BY MILLI-SECONDS.
     ADD HUN TO MILLI-SECONDS.
     MULTIPLY 10 BY MILLI-SECONDS.
 CALC-MILLI-SECONDS-LOOP.
     ACCEPT TIME-AREA FROM TIME.
     IF TIME-AREA IS EQUAL TO TIME-SYNC
         GO TO CALC-MILLI-SECONDS-LOOP
     END-IF.
