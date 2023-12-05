      * CA-Realia CICS 6.0
      ******************************************************************
      *DESCRIPTION:This is the exec interface block		       *
      ******************************************************************
      * Revision Information
      * ^{File:dfheiblk.cob}
      * ^{Timestamp:Wed Sep 18 09:25:56 1996}
      * ^{Revision:3.0}
      *
      *        EIBTIME ............... TIME IN 0HHMMSS FORMAT
      *        EIBDATE ............... DATE IN 0CYYDDD FORMAT
      *        EIBTRNID .............. TRANSACTION IDENTIFIER
      *        EIBTASKN .............. TASK NUMBER
      *        EIBTRMID .............. TERMINAL IDENTIFIER
      *        DFHEIGDI .............. RESERVED
      *        EIBCPOSN .............. CURSOR POSITION
      *        EIBCALEN .............. COMMAREA LENGTH
      *        EIBAID ................ ATTENTION IDENTIFIER
      *        EIBFN ................. FUNCTION CODE
      *        EIBRCODE .............. RESPONSE CODE
      *        EIBDS ................. DATASET NAME
      *        EIBREQID .............. REQUEST IDENTIFIER
      *        EIBRSRCE .............. RESOURCE NAME
      *        EIBSYNC ............... SYNCPOINT REQUIRED
      *        EIBFREE ............... TERMINAL FREE REQUIRED
      *        EIBRECV ............... DATA RECEIVE REQUIRED
      *        EIBSEND ............... RESERVED
      *        EIBATT ................ ATTACH DATA EXISTS
      *        EIBEOC ................ GOTTEN DATA IS COMPLETE
      *        EIBFMH ................ GOTTEN DATA CONTAINS FMH
      *        EIBCOMPL............... RECEIVE COMPLETE FLAG
      *        EIBSIG................. SIGNAL FLAG
      *        EIBCONF................ CONFIRM FLAG
      *        EIBERR................. LU 6.2 ERROR FLAG
      *        EIBERRCD............... LU 6.2 ERROR CODE
      *        EIBSYNRB............... SYNCPOINT ROLLBACK FLAG
      *        EIBNODAT............... NO DATA FLAG
      *        EIBRESP................ ERROR CODE RESPONSE
      *        EIBRESP2............... MORE ERROR CODES
      *        EIBRLDBK............... ROLLED BACK FLAG
      *        EIBCARESERVED.......... RESERVED FOR CA-CICS
      *
       01  EIBLK.
	   05  EIBTIME				 PIC S9(7) COMP-3.
	   05  EIBDATE				 PIC S9(7) COMP-3.
	   05  EIBTRNID 			 PIC X(4).
	   05  EIBTASKN 			 PIC S9(7) COMP-3.
	   05  EIBTRMID 			 PIC X(4).
	   05  DFHEIGDI 			 PIC S9(4) COMP-4.
	   05  EIBCPOSN 			 PIC S9(4) COMP-4.
	   05  EIBCALEN 			 PIC S9(4) COMP-4.
	   05  EIBAID				 PIC X.
	   05  EIBFN				 PIC X(2).
	   05  EIBRCODE 			 PIC X(6).
	   05  EIBDS				 PIC X(8).
	   05  EIBREQID 			 PIC X(8).
	   05  EIBRSRCE 			 PIC X(8).
	   05  EIBSYNC				 PIC X.
	   05  EIBFREE				 PIC X.
	   05  EIBRECV				 PIC X.
	   05  EIBSEND				 PIC X.
	   05  EIBATT				 PIC X.
	   05  EIBEOC				 PIC X.
	   05  EIBFMH				 PIC X.
	   05  EIBCOMPL 			 PIC X.
	   05  EIBSIG				 PIC X.
	   05  EIBCONF				 PIC X.
	   05  EIBERR				 PIC X.
	   05  EIBERRCD 			 PIC X(4).
	   05  EIBSYNRB 			 PIC X.
	   05  EIBNODAT 			 PIC X.
	   05  EIBRESP				 PIC S9(8) COMP-4.
	   05  EIBRESP2 			 PIC S9(8) COMP-4.
	   05  EIBRLDBK 			 PIC X.
      *
      *    do not alter EIBCARESERVED
      *
	   05  EIBCARESERVED			 PIC X(32).
