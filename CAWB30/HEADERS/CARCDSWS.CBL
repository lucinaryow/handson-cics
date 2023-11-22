*
* Header File for CA-Realia Display routines
*
* This software is the property of
* Computer Associates International, Inc.
* and is protected by International Copyright law.
* Any unauthorized use or reproduction is prohibited.
*
* Copyright (c) 1992, 1996 Computer Associates International, Inc.
* All rights reserved.
*
*
* This COPY book defines the DISPLAY data
* structures.  It may be copied into either the WORKING-STORAGE
* section or the LINKAGE section.
/
*  Revision History
*  ================
*
*  6.000  18 Apr 1997, 15:27 (RJL)
*     Initial version.
*
*-----------------------------------------------------------------
 01  ATTRIBUTE				   PIC X.
*
 01  ATTR-STRING			   PIC X.
*
 01  CHARACTER-STRING			   PIC X.
*
 01  CONSOLE-INFO.
     05  STD-IN-REDIRECT		   PIC X.
	 88  STD-IN-CONSOLE		   VALUE 0.
	 88  STD-IN-FILE-REDIRECT	   VALUE 1.
     05  STD-OUT-REDIRECT		   PIC X.
     05  STD-ERROR-REDIRECT		   PIC X.
*
 01  CURSOR-BLOCK.
     05  CURSOR-ROW			   PIC S9(4) COMP-5.
     05  CURSOR-COLUMN			   PIC S9(4) COMP-5.
*
 01  CURSOR-TYPE.
     10  CUR-START-LINE 		   PIC S9(4) COMP-5.
     10  CUR-END-LINE			   PIC S9(4) COMP-5.
     10  CUR-WIDTH-LINE 		   PIC S9(4) COMP-5.
     10  CUR-ATTR			   PIC S9(4) COMP-5.
	 88  HIDE-CURSOR		   VALUE -1.
*
 01  DISPLAY-PARMS.
     05  DISP-OUTPUT-TYPE-FLAG		   PIC X.
	 88  DISP-OUTPUT-TYPE-NO-CHG	   VALUE LOW-VALUE.
	 88  DISP-OUTPUT-TYPE-DOS	   VALUE 'D'.
	 88  DISP-OUTPUT-TYPE-BIOS	   VALUE 'B'.
	 88  DISP-OUTPUT-TYPE-RAW	   VALUE 'R'.
     05  DISP-AUTOWRAP-FLAG		   PIC X.
	 88  DISP-AUTOWRAP-NO-CHG	   VALUE LOW-VALUE.
	 88  DISP-SET-AUTOWRAP		   VALUE 'Y'.
	 88  DISP-SET-NOAUTOWRAP	   VALUE 'N'.
     05  FILLER 			   PIC X.
     05  DISP-CR-SCROLL-FLAG		   PIC X.
	 88  DISP-CR-SCROLL-NO-CHG	   VALUE LOW-VALUE.
	 88  DISP-SET-CR-SCROLL 	   VALUE 'Y'.
	 88  DISP-SET-NO-CR-SCROLL	   VALUE 'N'.
     05  DISP-LAST-BYTE-SCROLL-FLAG	   PIC X.
	 88  DISP-LAST-BYTE-SCROLL-NO-CHG  VALUE LOW-VALUE.
	 88  DISP-SET-LAST-BYTE-SCROLL	   VALUE 'Y'.
	 88  DISP-SET-NO-LAST-BYTE-SCROLL  VALUE 'N'.
     05  FILLER 			   PIC X(2).
     05  DISP-SCREEN-DEPTH		   PIC S9(4) COMP-5.
	 88  DISP-SCREEN-DEPTH-NO-CHG	   VALUE 0.
	 88  DISP-SCREEN-USE-PHYS-DEPTH    VALUE -1.
     05  FILLER 			   PIC X(7).
*
 01  DISPLAY-RC 			    PIC S9(4) BINARY.
     88  DISPLAY-RC-OK				      VALUE 0.
*
 01  SCROLL-BLOCK.
     05  SCROLL-UPPER-LEFT-CORNER.
	 10  SCROLL-UPPER-LEFT-CORNER-ROW  PIC 9(4) COMP-5.
	 10  SCROLL-UPPER-LEFT-CORNER-COL  PIC 9(4) COMP-5.
     05  SCROLL-LOWER-RIGHT-CORNER.
	 10  SCROLL-LOWER-RIGHT-CORNER-ROW PIC 9(4) COMP-5.
	 10  SCROLL-LOWER-RIGHT-CORNER-COL PIC 9(4) COMP-5.
     05  SCROLL-LINE-COUNT		   PIC 9(4) COMP-5.
*
 01  STRING-LENGTH			   PIC S9(4) COMP-5.
*
 01  VIDEO-STATE.
     05  VIDEO-LENGTH			   PIC S9(4) COMP-5.
     05  FILLER 			   PIC X.
     05  FILLER 			   PIC X.
     05  TEXT-COLUMNS			   PIC S9(4) COMP-5.
     05  TEXT-ROWS			   PIC S9(4) COMP-5.
*
 01  WINDOW-BUFFER			   PIC X.
*
 01  WINDOW-BLOCK.
     05  WINDOW-UPPER-LEFT-CORNER.
	 10  WINDOW-UPPER-LEFT-CORNER-ROW  PIC S9(4) COMP-5.
	 10  WINDOW-UPPER-LEFT-CORNER-COL  PIC S9(4) COMP-5.
     05  WINDOW-UPPER-RIGHT-CORNER.
	 10  WINDOW-UPPER-RIGHT-CORNER-ROW PIC S9(4) COMP-5.
	 10  WINDOW-UPPER-RIGHT-CORNER-COL PIC S9(4) COMP-5.
