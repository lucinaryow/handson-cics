 IDENTIFICATION DIVISION.
 PROGRAM-ID. SUBEG1.
 AUTHOR.     COMPUTER ASSOCIATES INTERNATIONAL, INC.
 SECURITY.       COPYRIGHT 1989
                 COMPUTER ASSOCIATES INTERNATIONAL INC.
 ENVIRONMENT DIVISION.
 CONFIGURATION SECTION.
 SOURCE-COMPUTER.   IBM-3090.
 OBJECT-COMPUTER.   IBM-3090.
 DATA DIVISION.
 WORKING-STORAGE SECTION.
 01 FILLER-1 PIC X(30) VALUE "Working Storage STARTS HERE".
*
 LINKAGE SECTION.
*
 01 PARM-REC.
    05 PARM-FIRST-NAME PIC X(15).
    05 PARM-LAST-NAME  PIC X(15).
*
 PROCEDURE DIVISION USING PARM-REC.
 SUB-MAIN.
     DISPLAY "START SUBEG1".
     EXIT PROGRAM.


