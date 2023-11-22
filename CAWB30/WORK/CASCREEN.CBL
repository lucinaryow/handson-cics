*$CALL,APOST,UPLOW,ASCII 
 IDENTIFICATION DIVISION.
 PROGRAM-ID. CASCREEN.
*
 ENVIRONMENT DIVISION.
 CONFIGURATION SECTION.
 SOURCE-COMPUTER. IBM-PC.
 OBJECT-COMPUTER. IBM-PC.
 DATA DIVISION.
 WORKING-STORAGE SECTION.
*-----------------------------------------------------------------
*
*    FORMATS.CBL contains data descriptions and sample CALL
*    statements for subroutines documented in the Realia
*    COBOL user manual.  These include subroutines defined in
*
*        a.  Chapter 8           Screen and Keyboard Handling
*        b.  Chapter 12          DOS Interface
*        c.  Chapter 14          Machine-Level Interface
*
*-----------------------------------------------------------------
*-----------------------------------------------------------------
*
*    Screen and Keyboard Handling Subroutines
*
*-----------------------------------------------------------------
*-----------------------------------------------------------------
*
*    Parameter block for ACCEPT_CONTROL and sample calling
*    sequence
*
 01  ESC                                   PIC X  VALUE X'1B'.
 01  ACCEPT-PARMS.
     05  ACCEPT-AUTO-ENTER-FLAG            PIC X.
         88  ACCEPT-AUTO-ENTER-ON          VALUE 'Y'.
         88  ACCEPT-AUTO-ENTER-OFF         VALUE 'N'.
         88  ACCEPT-AUTO-ENTER-NO-CHG      VALUE SPACE.
     05  ACCEPT-TEST-EMPTY-FLAG            PIC X.
         88  ACCEPT-TEST-EMPTY-ON          VALUE 'Y'.
         88  ACCEPT-TEST-EMPTY-OFF         VALUE 'N'.
         88  ACCEPT-TEST-EMPTY-NO-CHG      VALUE SPACE.
     05  ACCEPT-FILL-REQUIRED-FLAG         PIC X.
         88  ACCEPT-FILE-REQUIRED-ON       VALUE 'Y'.
         88  ACCEPT-FILE-REQUIRED-OFF      VALUE 'N'.
         88  ACCEPT-FILE-REQUIRED-NO-CHG   VALUE SPACE.
     05  ACCEPT-CURSOR-TERM-FLAG           PIC X.
         88  ACCEPT-CURSOR-TERM-ON         VALUE 'Y'.
         88  ACCEPT-CURSOR-TERM-OFF        VALUE 'N'.
         88  ACCEPT-CURSOR-TERM-NO-CHG     VALUE SPACE.
     05  ACCEPT-ENTRY-REQUIRED-FLAG        PIC X.
         88  ACCEPT-ENTRY-REQUIRED-ON      VALUE 'Y'.
         88  ACCEPT-ENTRY-REQUIRED-OFF     VALUE 'N'.
         88  ACCEPT-ENTRY-REQUIRED-NO-CHG  VALUE SPACE.
     05  ACCEPT-NO-ENTER-ECHO-FLAG         PIC X.
         88  ACCEPT-NO-ENTER-ECHO-ON       VALUE 'Y'.
         88  ACCEPT-NO-ENTER-ECHO-OFF      VALUE 'N'.
         88  ACCEPT-NO-ENTER-ECHO-NO-CHG   VALUE SPACE.
     05  ACCEPT-MODE                       PIC X.
         88  ACCEPT-MODE-BIOS              VALUE 'Y'.
         88  ACCEPT-MODE-DOS               VALUE 'N'.
         88  ACCEPT-MODE-NO-CHG            VALUE SPACE.
     05  FILLER                            PIC X(7).
*
*     CALL 'ACCEPT_CONTROL' USING ACCEPT-PARMS
*
*-----------------------------------------------------------------
*
*    Parameter block for DISPLAY_CONTROL and sample calling
*    sequence
*
 01  DISP-PARMS.
     05  DISP-IO-TYPE-FLAG                 PIC X.
         88  DISP-IO-TYPE-NO-CHG           VALUE LOW-VALUE.
         88  DISP-IO-TYPE-DOS              VALUE 'D'.
         88  DISP-IO-TYPE-BIOS             VALUE 'B'.
         88  DISP-IO-TYPE-MAPPED           VALUE 'M'.
     05  DISP-AUTOWRAP-FLAG                PIC X.
         88  DISP-AUTOWRAP-NO-CHG          VALUE LOW-VALUE.
         88  DISP-SET-AUTOWRAP             VALUE 'Y'.
         88  DISP-SET-NOAUTOWRAP           VALUE 'N'.
     05  DISP-VERT-RETRACE-FLAG            PIC X.
         88  DISP-VERT-RETRACE-NO-CHG      VALUE LOW-VALUE.
         88  DISP-SET-WAIT-VERT-RETRACE    VALUE 'Y'.
         88  DISP-SET-NOWAIT-VERT-RETRACE  VALUE 'N'.
     05  DISP-CR-SCROLL-FLAG               PIC X.
         88  DISP-CR-SCROLL-NO-CHG         VALUE LOW-VALUE.
         88  DISP-SET-CR-SCROLL            VALUE 'Y'.
         88  DISP-SET-NO-CR-SCROLL         VALUE 'N'.
     05  DISP-LAST-BYTE-SCROLL-FLAG        PIC X.
         88  DISP-LAST-BYTE-SCROLL-NO-CHG  VALUE LOW-VALUE.
         88  DISP-SET-LAST-BYTE-SCROLL     VALUE 'Y'.
         88  DISP-SET-NO-LAST-BYTE-SCROLL  VALUE 'N'.
     05  DISP-BORDER-COLOR                 PIC 9(2) COMP-5.
         88  DISP-BORDER-COLOR-NO-CHG      VALUE  0.
         88  DISP-BORDER-COLOR-VALID       VALUE  1 THRU 16.
         88  DISP-BORDER-COLOR-BLACK       VALUE  1.
         88  DISP-BORDER-COLOR-BLUE        VALUE  2.
         88  DISP-BORDER-COLOR-GREEN       VALUE  3.
         88  DISP-BORDER-COLOR-CYAN        VALUE  4.
         88  DISP-BORDER-COLOR-RED         VALUE  5.
         88  DISP-BORDER-COLOR-MAGENTA     VALUE  6.
         88  DISP-BORDER-COLOR-BROWN       VALUE  7.
         88  DISP-BORDER-COLOR-WHITE       VALUE  8.
         88  DISP-BORDER-COLOR-GRAY        VALUE  9.
         88  DISP-BORDER-COLOR-HI-BLUE     VALUE 10.
         88  DISP-BORDER-COLOR-HI-GREEN    VALUE 11.
         88  DISP-BORDER-COLOR-HI-CYAN     VALUE 12.
         88  DISP-BORDER-COLOR-HI-RED      VALUE 13.
         88  DISP-BORDER-COLOR-HI-MAGENTA  VALUE 14.
         88  DISP-BORDER-COLOR-YELLOW      VALUE 15.
         88  DISP-BORDER-COLOR-HI-WHITE    VALUE 16.
     05  DISP-SCREEN-DEPTH                 PIC S9(4) COMP-5.
         88  DISP-SCREEN-DEPTH-NO-CHG      VALUE 0.
         88  DISP-SCREEN-USE-PHYS-DEPTH    VALUE -1.
     05  FILLER                            PIC X(7).
*
*    CALL 'DISPLAY_CONTROL' USING DISP-PARMS
*
*-----------------------------------------------------------------
*
*    Parameter block for DISPLAY_GET_CURSOR and
*    DISPLAY_SET_CURSOR and sample calling sequences
*    sequence
*
 01  CUR-BLOCK.
     05  CUR-ROW           PIC 9(4) COMP-5.
     05  CUR-COL           PIC 9(4) COMP-5.
*
*     CALL 'DISPLAY_GET_CURSOR' USING CURSOR-BLOCK
*     CALL 'DISPLAY_SET_CURSOR' USING CURSOR-BLOCK
*
*-----------------------------------------------------------------
*
*    Parameter block for DISPLAY_READ_CHARACTER and sample calling
*    sequence
*
 01  CHARACTER-VALUE             PIC X.
 01  ATTRIBUTE                   PIC X.
*
*    CALL 'DISPLAY_READ_CHARACTER' USING CHARACTER-VALUE ATTRIBUTE
*
*-----------------------------------------------------------------
*
*    Parameter block for DISPLAY_READ_STRING and sample calling
*    sequence
*
 01  ATTRIBUTE-STRING            PIC X(10).
*
*     CALL 'DISPLAY_READ_STRING' USING CHARACTER-STRING
*                                      STRING-LENGTH
*                                      ATTRIBUTE-STRING
*
*-----------------------------------------------------------------
*
*    Parameter block for DISPLAY_READ_WINDOW
*                        DISPLAY_RESTORE_WINDOW
*    and sample calling sequence
*
 01  WINDOW-BUFFER               PIC X(30).
 01  WINDOW-BLOCK.
     05  WINDOW-UPPER-LEFT-CORNER.
         10  WINDOW-UPPER-LEFT-CORNER-ROW  PIC S9(4) COMP-5.
         10  WINDOW-UPPER-LEFT-CORNER-COL  PIC S9(4) COMP-5.
     05  WINDOW-UPPER-RIGHT-CORNER.
         10  WINDOW-UPPER-RIGHT-CORNER-ROW PIC S9(4) COMP-5.
         10  WINDOW-UPPER-RIGHT-CORNER-COL PIC S9(4) COMP-5.
*
*     CALL 'DISPLAY_READ_WINDOW' USING WINDOW-BUFFER
*                                      WINDOW-BLOCK
*
*     CALL 'DISPLAY_RESTORE_WINDOW' USING WINDOW-BUFFER
*                                         WINDOW-BLOCK
*
*-----------------------------------------------------------------
*
*    Parameter block for DISPLAY_SET_ATTRIBUTE and sample calling
*    sequence
*
*
*     CALL 'DISPLAY_SET_ATTRIBUTE' USING ATTRIBUTE
*
*-----------------------------------------------------------------
*
*    Parameter block for DISPLAY_READ_CELL_STRING
*                        DISPLAY_RESTORE_CELL_STRING
*    and sample calling sequence
*
 01  CHARACTER-STRING            PIC X(30).
 01  STRING-LENGTH               PIC S9(4) COMP-5.
*
*     CALL 'DISPLAY_READ_CELL_STRING' USING CHARACTER-STRING
*                                           STRING-LENGTH
*
*     CALL 'DISPLAY_RESTORE_CELL_STRING' USING CHARACTER-STRING
*                                              STRING-LENGTH
*
*-----------------------------------------------------------------
*
*    Parameter block for DISPLAY_SCROLL_UP and
*    DISPLAY_SCROLL-DOWN and sample calling sequences
*    sequence
*
 01  SCROLL-BLOCK.
     05  SCROLL-UPPER-LEFT-CORNER.
         10  SCROLL-UPPER-LEFT-CORNER-ROW        PIC 9(4) COMP-5.
         10  SCROLL-UPPER-LEFT-CORNER-COL        PIC 9(4) COMP-5.
     05  SCROLL-LOWER-RIGHT-CORNER.
         10  SCROLL-LOWER-RIGHT-CORNER-ROW       PIC 9(4) COMP-5.
         10  SCROLL-LOWER-RIGHT-CORNER-COL       PIC 9(4) COMP-5.
     05  SCROLL-LINE-COUNT                       PIC 9(4) COMP-5.
*
*    CALL 'DISPLAY_SCROLL_UP' USING SCROLL-BLOCK
*    CALL 'DISPLAY_SCROLL_DOWN' USING SCROLL-BLOCK
*
*-----------------------------------------------------------------
*
*    Sample call to DISPLAY_SWAP_SCREENS
*
*    CALL 'DISPLAY_SWAP_SCREENS'
*
*-----------------------------------------------------------------
*    Sample call to DISPLAY_GET_MODE
*                   DISPLAY_GET_MODE
*    and sample calling sequence
*
 01  VIDEO-STATE.
     05  VIDEO-LENGTH                      PIC S9(4) COMP-5.
     05  VIDEO-TYPE                        PIC X.
         88 MONO-TEXT           VALUE X'00'.
         88 COLOR-TEXT          VALUE X'00'.
         88 MONO-GRAPH          VALUE X'00'.
         88 COLOR-GRAPH         VALUE X'00'.
     05  TEXT-COLUMNS                      PIC S9(4) COMP-5.
     05  TEXT-ROWS                         PIC S9(4) COMP-5.

*    CALL 'DISPLAY_GET_MODE' USING VIDEO-STATE.
*    CALL 'DISPLAY_SET_MODE' USING VIDEO-STATE.
*

 
 01  K-ATTRIBUTE-WHITE-ON-BLACK  PIC S9(04) COMP VALUE ZERO.
 01  K-ATTRIBUTE-HIGH-INTENSITY  PIC S9(04) COMP VALUE +1.
 01  K-ATTRIBUTE-UNDERSCORE      PIC S9(04) COMP VALUE +4.
 01  K-ATTRIBUTE-BLINK           PIC S9(04) COMP VALUE +5.
 01  K-ATTRIBUTE-REVERSE-VIDEO   PIC S9(04) COMP VALUE +7.
 01  K-ATTRIBUTE-INVISIBLE       PIC S9(04) COMP VALUE +8.
 01  K-ATTRIBUTE-BLACK-TEXT      PIC S9(04) COMP VALUE +30.
 01  K-ATTRIBUTE-RED-TEXT        PIC S9(04) COMP VALUE +31.
 01  K-ATTRIBUTE-GREEN-TEXT      PIC S9(04) COMP VALUE +32.
 01  K-ATTRIBUTE-YELLOW-TEXT     PIC S9(04) COMP VALUE +33.
 01  K-ATTRIBUTE-BLUE-TEXT       PIC S9(04) COMP VALUE +34.
 01  K-ATTRIBUTE-MAGENTA-TEXT    PIC S9(04) COMP VALUE +35.
 01  K-ATTRIBUTE-CYAN-TEXT       PIC S9(04) COMP VALUE +36.
 01  K-ATTRIBUTE-WHITE-TEXT      PIC S9(04) COMP VALUE +37.
 01  K-ATTRIBUTE-BLACK-BCKG      PIC S9(04) COMP VALUE +40.
 01  K-ATTRIBUTE-RED-BCKG        PIC S9(04) COMP VALUE +41.
 01  K-ATTRIBUTE-GREEN-BCKG      PIC S9(04) COMP VALUE +42.
 01  K-ATTRIBUTE-YELLOW-BCKG     PIC S9(04) COMP VALUE +43.
 01  K-ATTRIBUTE-BLUE-BCKG       PIC S9(04) COMP VALUE +44.
 01  K-ATTRIBUTE-MAGENTA-BCKG    PIC S9(04) COMP VALUE +45.
 01  K-ATTRIBUTE-CYAN-BCKG       PIC S9(04) COMP VALUE +46.
 01  K-ATTRIBUTE-WHITE-BCKG      PIC S9(04) COMP VALUE +47.
 LINKAGE SECTION.
******************
 01  PARM-REC.
     05  PARM-NUM                 PIC S9(04) COMP.
          05  PARM-ATTRIBUTE     PIC S9(04) COMP.

 PROCEDURE DIVISION USING PARM-REC.
 PRIME-COUNT-ROUTINE.
*
     IF  (PARM-NUM = 1)
        PERFORM CLEAR-SCREEN
          ELSE
             PERFORM SET-MODE.

          EXIT PROGRAM.
*    Clear Screen!
 CLEAR-SCREEN.
     DISPLAY ESC '[2J' WITH NO ADVANCING.  
*
 SET-MODE.

     IF  (PARM-ATTRIBUTE = 0)
              DISPLAY ESC '[0m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 1)
              DISPLAY ESC '[1m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 4)
              DISPLAY ESC '[4m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 5)
              DISPLAY ESC '[5m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 7)
              DISPLAY ESC '[7m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 8)
              DISPLAY ESC '[8m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 30)
              DISPLAY ESC '[30m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 31)
              DISPLAY ESC '[31m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 32)
              DISPLAY ESC '[32m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 33)
              DISPLAY ESC '[33m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 34)
              DISPLAY ESC '[34m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 35)
              DISPLAY ESC '[35m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 36)
              DISPLAY ESC '[36m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 37)
              DISPLAY ESC '[37m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 40)
              DISPLAY ESC '[40m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 41)
              DISPLAY ESC '[41m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 42)
              DISPLAY ESC '[42m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 43)
              DISPLAY ESC '[43m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 44)
              DISPLAY ESC '[44m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 45)
              DISPLAY ESC '[45m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 46)
              DISPLAY ESC '[46m' WITH NO ADVANCING
          ELSE IF (PARM-ATTRIBUTE = 47)
              DISPLAY ESC '[47m' WITH NO ADVANCING.

 END-PROGRAM-PREVENT-FALLTHRU.
