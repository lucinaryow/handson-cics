*$PP-DEF HEADER NI EXTERNAL PROGRAM
*$PP-NOLIST HEADER NI
*$PP-RELATIVE-LINE-ADJ +000000003
     copy posix.
 IDENTIFICATION DIVISION.
 PROGRAM-ID. clib EXTERNAL.
*
* Header File for CLIB functions (32 bit version)
*
* This software is the property of
* Computer Associates International, Inc.
* and is protected BY International Copyright law.
* Any unauthorized use or reproduction is prohibited.
*
* Copyright (c) 1992, 1996 Computer Associates International, Inc.
* All rights reserved.
*
* Date:02-16-96 13:00 CWG - moved _utime from posix.cbl
*
 DATA DIVISION.
 LINKAGE SECTION.

 01  access-mode	 PIC S9(9) BINARY.
 01  char-cnt		 PIC S9(9) BINARY.
 01  char-len		 PIC  9(9) BINARY.
 01  char-ptr		 POINTER.
 01  char-str		 PIC X.
 01  drive		 PIC S9(9) BINARY.
 01  filedes		 PIC S9(9) BINARY.
 01  filename-ptr	 POINTER.
 01  filename-str	 PIC X.
 01  iresult		 PIC S9(9) BINARY.
 01  new-drive		 PIC S9(9) BINARY.
 01  new-filedes	 PIC S9(9) BINARY.
 01  old-drive		 PIC S9(9) BINARY.
 01  old-filedes	 PIC S9(9) BINARY.
 01  seekposition	 PIC S9(9) BINARY.
 01  utimebuf.
     05  actime 			   PIC 9(9) BINARY.
     05  modtime			   PIC 9(9) BINARY.

 PROCEDURE DIVISION.

     ENTRY 'C__access' *> MSC function
	 USING BY REFERENCE  filename-str DELIMITED
	       BY VALUE      access-mode
	 RETURNING	     iresult.

     ENTRY 'C__chdir' *> MSC function
	 USING BY REFERENCE  filename-str DELIMITED
	 RETURNING	     iresult.

     ENTRY 'C__chdrive' *> MSC function
	 USING BY VALUE      new-drive
	 RETURNING	     old-drive.

     ENTRY 'C_commit' *> MSC function
	 USING BY VALUE      filedes
	 RETURNING	     iresult.

     ENTRY 'C__commit' *> MSC function
	 USING BY VALUE      filedes
	 RETURNING	     iresult.

     ENTRY 'C__dup' *> MSC function
	 USING BY VALUE      old-filedes
	 RETURNING	     new-filedes.

     ENTRY 'C_eof' *> MSC function
	 USING BY VALUE      filedes
	 RETURNING	     iresult.

     ENTRY 'C__eof' *> MSC function
	 USING BY VALUE      filedes
	 RETURNING	     iresult.

     ENTRY 'C__fullpath' *> MSC function
	 USING BY VALUE      char-ptr
	       BY REFERENCE  filename-str DELIMITED
	       BY VALUE      char-len
	 RETURNING	     filename-ptr.

     ENTRY 'C__getcwd' *> MSC function
	 USING BY VALUE      char-ptr
	       BY VALUE      char-cnt
	 RETURNING	     filename-ptr.

     ENTRY 'C__getdcwd' *> MSC function
	 USING BY VALUE      drive
	       BY VALUE      char-ptr
	       BY VALUE      char-cnt
	 RETURNING	     filename-ptr.

     ENTRY 'C__getdrive' *> MSC function
	 RETURNING	     drive.

     ENTRY 'C__mkdir' *> MSC function
	 USING BY REFERENCE  filename-str DELIMITED
	 RETURNING	     iresult.

     ENTRY 'C_putenv' *> UNIX, X/Open function
	 USING BY REFERENCE  char-str DELIMITED
	 RETURNING	     iresult.

     ENTRY 'C__putenv' *> MSC function
	 USING BY REFERENCE  char-str DELIMITED
	 RETURNING	     iresult.

     ENTRY 'C_tell' *> MSC function
	 USING BY REFERENCE  filedes
	 RETURNING	     seekposition.

     ENTRY 'C__tell' *> MSC function
	 USING BY REFERENCE  filedes
	 RETURNING	     seekposition.

     ENTRY 'c__utime' *> MSC function
	 USING BY REFERENCE  filename-str DELIMITED
	       BY REFERENCE  utimebuf
	 RETURNING	     iresult.

  END PROGRAM CLIB.
*$PP-LIST HEADER
