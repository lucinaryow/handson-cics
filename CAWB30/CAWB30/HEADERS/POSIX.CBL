*$PP-DEF HEADER NI EXTERNAL PROGRAM
*$PP-NOLIST HEADER NI
*$PP-RELATIVE-LINE-ADJ +000000003
*
* This software is the property of Computer Associates International, Inc.
* and is protected by International Copyright law
* Any unauthorized use or reproduction is prohibited
*
* Copyright (c) 1995, 1996 Computer Associates International, Inc.
* All rights reserved
*
*    Description: CA-Realia COBOL 6.0 Selected POSIX.1 API Routines
*
*^{Mods:*** }
*
* Date:06-14-96  CWG - Added mem functions
*
* Date:02-16-96 13:00 CWG - moved _utime from posix.cbl
*
* Changes by GODCH01 Date:12-04-95 14:17
* 1)  All COMP-5 changed to BINARY
* 2)  Preprocessor directive upgraded to current standard
* 3)  Stream changed from PIC S9(9) BINARY to POINTER
* 4)  tmpname changed to tmpnam
* 5)  tmpnam call changed to:
*	 USING BY REFERENCE char-str DELIMITED
* 6)  many references to BY VALUE   *-ptr changed to
*			 BY REFERENCE *-str DELIMITED
* 7)  Added several missing entry points
*
 IDENTIFICATION DIVISION.
 PROGRAM-ID.	 POSIX EXTERNAL.

 DATA DIVISION.
 LINKAGE SECTION.

 01  char-as-int	 PIC S9(9) BINARY.
 01  char-cnt		 PIC S9(9) BINARY.
 01  char-len		 PIC  9(9) BINARY.
 01  char-ptr		 POINTER.
 01  char-str		 PIC X.
 01  char-str2		 PIC X.
 01  clock-ticks	 PIC S9(9) BINARY.
 01  dirname-str	 PIC X.
 01  element-cnt	 PIC  9(9) BINARY.
 01  element-len	 PIC  9(9) BINARY.
 01  filedes		 PIC S9(9) BINARY.
 01  filemode-str	 PIC X.
 01  filename-ptr	 POINTER.
 01  filename-str	 PIC X.
 01  filepos		 PIC S9(9) BINARY.
 01  format-str 	 PIC X.
 01  iresult		 PIC S9(9) BINARY.
 01  new-filename-str	 PIC X.
 01  new-filename-ptr	 POINTER.
 01  new-mode		 PIC S9(9) BINARY.
 01  new-mode-mask	 PIC S9(9) BINARY.
 01  new-stream 	 POINTER.
 01  new-filedes	 PIC S9(9) BINARY.
 01  old-char-ptr	 POINTER.
 01  old-filename-str	 PIC X.
 01  old-mode		 PIC S9(9) BINARY.
 01  old-mode-mask	 PIC S9(9) BINARY.
 01  old-stream 	 POINTER.
 01  old-filedes	 PIC S9(9) BINARY.
 01  open-flags 	 PIC  9(9) BINARY.
 01  seekmode		 PIC S9(9) BINARY.
     88  seek-from-front     VALUE 0.
     88  seek-from-current   VALUE 1.
     88  seed-from-end	     VALUE 2.
 01  seekoffset 	 PIC S9(9) BINARY.
 01  seekposition	 PIC S9(9) BINARY.
* NOTE: the statrec given below is a `generic' version used only
*	for this external program definition - the definiton of
*	the record returned by the `stat' and `fstat' functions
*	is in the `statrec.cbl' copy book and is operating
*	system dependent
 01  statrec.
     05  st-dev 	 PIC S9(4) BINARY.
     05  st-ino 	 PIC  9(4) BINARY.
     05  st-mode	 PIC  9(4) BINARY.
     05  st-nlink	 PIC S9(4) BINARY.
     05  st-uid 	 PIC S9(4) BINARY.
     05  st-gid 	 PIC S9(4) BINARY.
     05  st-rdev	 PIC S9(4) BINARY.
     05  st-size	 PIC S9(9) BINARY.
     05  st-atime	 PIC S9(9) BINARY.
     05  st-mtime	 PIC S9(9) BINARY.
     05  st-ctime	 PIC S9(9) BINARY.
 01  stream		 POINTER.
 01  time-diff		 USAGE COMP-2.
 01  timer		 PIC 9(9) BINARY.
 01  timer-1		 PIC 9(9) BINARY.
 01  timer-2		 PIC 9(9) BINARY.
 01  timer-ptr		 POINTER. *> pointer to timer
 01  timerec.
     05  tm-sec 	 PIC S9(9) BINARY.
     05  tm-min 	 PIC S9(9) BINARY.
     05  tm-hour	 PIC S9(9) BINARY.
     05  tm-mday	 PIC S9(9) BINARY.
     05  tm-mon 	 PIC S9(9) BINARY.
     05  tm-year	 PIC S9(9) BINARY.
     05  tm-wday	 PIC S9(9) BINARY.
     05  tm-yday	 PIC S9(9) BINARY.
     05  tm-isdst	 PIC S9(9) BINARY.
 01  timerec-ptr	 POINTER.
 01  uresult		 PIC  9(9) BINARY.
 01  vbuf-mode		 PIC S9(9) BINARY.
     88  vbuf-full-buffer    VALUE 0.
     88  vbuf-line-buffer    VALUE 64.
     88  vbuf-no-buffer      VALUE 4.

 PROCEDURE DIVISION.

*    stdio.h

     ENTRY 'C_clearerr'
	 USING BY VALUE      stream.

     ENTRY 'C_fclose'
	 USING BY VALUE      stream
	 RETURNING	     iresult.

     ENTRY 'C_fdopen'
	 USING BY VALUE      filedes
	       BY REFERENCE  filemode-str DELIMITED
	 RETURNING	     new-stream.

     ENTRY 'C_feof'
	 USING BY VALUE      stream
	 RETURNING	     iresult.

     ENTRY 'C_ferror'
	 USING BY VALUE      stream
	 RETURNING	     iresult.

     ENTRY 'C_fflush'
	 USING BY VALUE      stream
	 RETURNING	     iresult.

     ENTRY 'C_fgetc'
	 USING BY VALUE      stream
	 RETURNING	     char-as-int.

     ENTRY 'C_fgetpos'
	 USING BY VALUE      stream
	       BY REFERENCE  filepos
	 RETURNING	     iresult.

     ENTRY 'C_fgets'
	 USING BY REFERENCE  char-str
	       BY VALUE      char-len
	       BY VALUE      stream
	 RETURNING	     char-ptr.

     ENTRY 'C_fileno'
	 USING BY VALUE      stream
	 RETURNING	     filedes.

     ENTRY 'C_fopen'
	 USING BY REFERENCE  filename-str DELIMITED
	       BY REFERENCE  filemode-str DELIMITED
	 RETURNING	     new-stream.

*    ENTRY 'C_fprintf'
*	 USING BY VALUE      stream
*	       BY REFERENCE  format-str DELIMITED
*	       ...
*	 RETURNING	     iresult.

     ENTRY 'C_fputc'
	 USING BY VALUE      char-as-int
	       BY VALUE      stream
	 RETURNING	     iresult.

     ENTRY 'C_fputs'
	 USING BY REFERENCE  char-str DELIMITED
	       BY VALUE      stream
	 RETURNING	     iresult.

     ENTRY 'C_fread'
	 USING BY REFERENCE  char-str
	       BY VALUE      element-len
	       BY VALUE      element-cnt
	       BY VALUE      stream
	 RETURNING	     iresult.

     ENTRY 'C_freopen'
	 USING BY REFERENCE  filename-str DELIMITED
	       BY REFERENCE  filemode-str DELIMITED
	       BY VALUE      old-stream
	 RETURNING	     new-stream.

*    ENTRY 'C_fscanf'
*	 USING BY VALUE      stream
*	       BY REFERENCE  format-str DELIMITED
*	       ...
*	 RETURNING	     iresult.

     ENTRY 'C_fseek'
	 USING BY VALUE      stream
	       BY VALUE      seekoffset
	       BY VALUE      seekmode
	 RETURNING	     iresult.

     ENTRY 'C_fsetpos'
	 USING BY VALUE      stream
	       BY REFERENCE  filepos
	 RETURNING	     iresult.

     ENTRY 'C_ftell'
	 USING BY VALUE      stream
	 RETURNING	     seekposition.

     ENTRY 'C_fwrite'
	 USING BY REFERENCE  char-str
	       BY VALUE      element-len
	       BY VALUE      element-cnt
	       BY VALUE      stream
	 RETURNING	     uresult.

     ENTRY 'C_getc'
	 USING BY VALUE      stream
	 RETURNING	     char-as-int.

     ENTRY 'C_getchar'
	 RETURNING	     char-as-int.

     ENTRY 'C_gets'
	 USING BY REFERENCE  char-str
	 RETURNING	     char-ptr.

     ENTRY 'C_perror'
	 USING BY REFERENCE  char-str DELIMITED.

*    ENTRY 'C_printf'
*	 USING BY REFERENCE  format-str DELIMITED
*	       ...
*	 RETURNING	     iresult.

     ENTRY 'C_putc'
	 USING BY VALUE      char-as-int
	       BY VALUE      stream
	 RETURNING	     iresult.

     ENTRY 'C_putchar'
	 USING BY VALUE      char-as-int
	 RETURNING	     iresult.

     ENTRY 'C_puts'
	 USING BY REFERENCE  char-str DELIMITED
	 RETURNING	     iresult.

     ENTRY 'C_remove'
	 USING BY REFERENCE  filename-str DELIMITED
	 RETURNING	     iresult.

     ENTRY 'C_rename'
	 USING BY REFERENCE  old-filename-str DELIMITED
	       BY REFERENCE  new-filename-str DELIMITED
	 RETURNING	     iresult.

     ENTRY 'C_rewind'
	 USING BY VALUE      stream.

*    ENTRY 'C_scanf'
*	 USING BY REFERENCE  format-str DELIMITED
*	       ...
*	 RETURNING	     iresult.

     ENTRY 'C_setbuf'
	 USING BY VALUE      stream
	       BY VALUE      char-ptr.

     ENTRY 'C_setvbuf'
	 USING BY VALUE      stream
	       BY VALUE      char-ptr
	       BY VALUE      vbuf-mode
	       BY VALUE      char-len
	 RETURNING	     iresult.

*    ENTRY 'C_sprintf'
*	 USING BY REFERENCE  char-str
*	       BY REFERENCE  format-str DELIMITED
*	       ...
*	 RETURNING	     char-cnt.

     ENTRY 'C_tmpfile'
	 RETURNING	     new-stream.

     ENTRY 'C_tmpnam'
	 USING BY VALUE      filename-ptr
	 RETURNING	     new-filename-ptr

     ENTRY 'C_ungetc'
	 USING BY VALUE      char-as-int
	       BY VALUE      stream
	 RETURNING	     iresult.

*    The 'v...' functions cannot be used from COBOL because there
*    is no way to implement the 'stdarg.h' macros.

*    stdlib.h

     ENTRY 'C_free'
	 USING BY VALUE      char-ptr.

     ENTRY 'C_getenv'
	 USING BY REFERENCE char-str DELIMITED
	 RETURNING	    char-ptr.

     ENTRY 'C_malloc'
	 USING BY VALUE      char-len
	 RETURNING	     char-ptr.

     ENTRY 'C_realloc'
	 USING BY VALUE      old-char-ptr
	       BY VALUE      char-len
	 RETURNING	     char-ptr.

*    string.h

     ENTRY 'C_memchr'
	 USING BY REFERENCE char-str
	       BY VALUE     char-as-int
	       BY VALUE     char-len
	 GIVING char-ptr.

     ENTRY 'C_memcmp'
	 USING BY REFERENCE char-str
	       BY REFERENCE char-str2
	       BY VALUE     char-len
	 GIVING iresult.

     ENTRY 'C_memcpy'
	 USING BY REFERENCE char-str
	       BY REFERENCE char-str2
	       BY VALUE     char-len
	 GIVING char-ptr.

     ENTRY 'C_memmove'
	 USING BY REFERENCE char-str
	       BY REFERENCE char-str2
	       BY VALUE     char-len
	 GIVING char-ptr.


     ENTRY 'C_memset'
	 USING BY REFERENCE char-str
	       BY VALUE     char-as-int
	       BY VALUE     char-len
	 GIVING char-ptr.

*    sys/stat.h

*	 type struct stat used as follows:
*
*	     01  statrec.
*		 copy statrec.

     ENTRY 'C_chmod'
	 USING BY REFERENCE  filename-str DELIMITED
	       BY VALUE      new-mode
	 RETURNING	     iresult.

     ENTRY 'C_fstat'
	 USING BY VALUE      filedes
	       BY REFERENCE  statrec
	 RETURNING	     iresult.

     ENTRY 'C_mkdir'
	 USING BY REFERENCE  filename-str DELIMITED
	       BY VALUE      new-mode
	 RETURNING	     iresult.

     ENTRY 'C_mkfifo'
	 USING BY REFERENCE  filename-str DELIMITED
	       BY VALUE      new-mode
	 RETURNING	     iresult.

     ENTRY 'C_stat'
	 USING BY REFERENCE  filename-str DELIMITED
	       BY REFERENCE  statrec
	 RETURNING	     iresult.

     ENTRY 'C_umask'
	 USING BY VALUE      new-mode-mask
	 RETURNING	     old-mode-mask.

*    time.h

*	 type struct tm used as follows:
*
*	     01  timerec.
*		 copy timerec.

     ENTRY 'C_asctime'
	 USING BY VALUE      timerec-ptr
	 RETURNING	     char-ptr.

     ENTRY 'C_clock'
	 RETURNING	     clock-ticks.

     ENTRY 'C_ctime'
	 USING BY REFERENCE  timer
	 RETURNING	     char-ptr.

     ENTRY 'C_difftime'
	 USING BY REFERENCE  timer-1
		  REFERENCE  timer-2
	 RETURNING	     time-diff.

     ENTRY 'C_gmtime'
	 USING BY REFERENCE  timer
	 RETURNING	     timerec-ptr.


     ENTRY 'C_localtime'
	 USING BY REFERENCE  timer
	 RETURNING	     timerec-ptr.

     ENTRY 'C_mktime'
	 USING BY REFERENCE  timerec
	 RETURNING	     timer.

     ENTRY 'C_strftime'
	 USING BY REFERENCE  char-str
	       BY VALUE      char-len
	       BY REFERENCE  format-str DELIMITED
	       BY REFERENCE  timerec
	 RETURNING	     char-cnt.

     ENTRY 'C_time'
	 USING BY VALUE      timer-ptr
	 RETURNING	     timer.

     ENTRY 'C_tzset'.

*    unistd.h

     ENTRY 'C_chdir'
	 USING BY REFERENCE  dirname-str DELIMITED
	 RETURNING	     iresult.

     ENTRY 'C_close'
	 USING BY VALUE      filedes
	 RETURNING	     iresult.

     ENTRY 'C_creat'
	 USING BY REFERENCE  filename-str DELIMITED
	       BY VALUE      new-mode
	 RETURNING	     filedes.

     ENTRY 'C_dup'
	 USING BY VALUE      old-filedes
	 RETURNING	     new-filedes.

     ENTRY 'C_dup2'
	 USING BY VALUE      old-filedes
	       BY VALUE      new-filedes
	 RETURNING	     iresult.

     ENTRY 'C_lseek'
	 USING BY VALUE      filedes
	       BY VALUE      seekoffset
	       BY VALUE      seekmode
	 RETURNING	     seekposition.

     ENTRY 'C_open'
	 USING BY REFERENCE  filename-str DELIMITED
	       BY VALUE      open-flags
	       BY VALUE      new-mode
	 RETURNING	     filedes.

     ENTRY 'C_read'
	 USING BY VALUE      filedes
	       BY REFERENCE  char-str
	       BY VALUE      char-len
	 RETURNING	     iresult.

     ENTRY 'C_write'
	 USING BY VALUE      filedes
	       BY REFERENCE  char-str
	       BY VALUE      char-len
	 RETURNING	     iresult.

 END PROGRAM POSIX.
*$PP-LIST HEADER
