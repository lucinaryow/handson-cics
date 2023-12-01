       01  DFHBMSCA.
      *
      * CA-Realia CICS 6.0 Computer Associates International, Inc.
      *
      * Revision Information
      * ^{File:dfhbmsca.cob}
      * ^{Timestamp:Tue Oct 08 15:34:54 1996}
      * ^{Revision:2.0}
      *
      *  Note:This FILE is provided with most values as quoted literals
      *       so that the file can be used for both ASCII and EBCDIC
      *       programs
      *
      *       The only exceptions are some 3270 Data Stream Orders
      *       They use different Hexadecimal values for ASCII and
      *       EBCDIC and they cannot be expressed as quoted literals
      *       as the values are <Line Feed>, <Tab>, <End of File> etc.
      *       characters in ASCII
      *
      *       They have their values set up to default to the EBCDIC
      *       values.
      *
      *       3270 orders are only needed for EXEC CICS SEND and RECEIVE
      *       and SEND TEXT with imbedded format orders.
      *       If you use these values in ASCII programs the values
      *       must be changed.
      *
      *       An alternative is to use REPLACING to change the values.
      *
      *    i.e. COPY DFHBMSCA replacing
      * 		     ==005== BY ==009==  *> DFHPT
      * 		     ==021== BY ==010==  *> DFHNL
      * 		     ==040== BY ==021==  *> DFHSA
      * 		     ==041== BY ==031==  *> DFHSFE
      * 		     ==044== BY ==023==  *> DFHMF
      * 		     ==060== BY ==020==  *> DFHRA
      * 		     ==063== BY ==026==. *> DFHSUB
      *
      ******************************************************************
      *BMS and Terminal Control - Order & Attributes constants	       *
      ******************************************************************
      *
      *    Field Attributes
      *
	   05  DFHBMASB 			 PIC X VALUE '8'.
	   05  DFHBMASF 			 PIC X VALUE '1'.
	   05  DFHBMASK 			 PIC X VALUE '0'.
	   05  DFHBMBRY 			 PIC X VALUE 'H'.
	   05  DFHBMDAR 			 PIC X VALUE '<'.
	   05  DFHBMFSE 			 PIC X VALUE 'A'.
	   05  DFHBMPRF 			 PIC X VALUE '/'.
	   05  DFHBMPRO 			 PIC X VALUE '-'.
	   05  DFHBMUNN 			 PIC X VALUE '&'.
	   05  DFHBMUNP 			 PIC X VALUE ' '.
	   05  DFHUNNUM 			 PIC X VALUE 'J'.
      *
      *    partially supported
      *
	   05  DFHUNNOD 			 PIC X VALUE '('.
	   05  DFHUNIMD 			 PIC X VALUE 'I'.
	   05  DFHUNINT 			 PIC X VALUE 'R'.
	   05  DFHUNNON 			 PIC X VALUE '('.
	   05  DFHPROTI 			 PIC X VALUE 'Y'.
	   05  DFHPROTN 			 PIC X VALUE '%'.
      *
      *    These values are additions to mainframe constants
      *
	   05  DFHBMS-ASK-DARK			 PIC X VALUE '@'.
	   05  DFHBMS-ASK-BRY-FSET		 PIC X VALUE '9'.
	   05  DFHBMS-ASK-DAR-FSET		 PIC X VALUE ''''.
      * 					       VALUE APOST
	   05  DFHBMS-PRO-BRY-FSET		 PIC X VALUE 'Z'.
	   05  DFHBMS-PRO-DAR-FSET		 PIC X VALUE '_'.
	   05  DFHBMS-NUM-BRY			 PIC X VALUE 'Q'.
	   05  DFHBMS-NUM-DAR			 PIC X VALUE '*'.
	   05  DFHBMS-NUM-DAR-FSET		 PIC X VALUE ')'.
      *
      *    Field Flag values
	   05  DFHBMEOF-VAL VALUE 128		 PIC S9(4) COMP-4.
	   05  FILLER REDEFINES DFHBMEOF-VAL.
	       10  FILLER			 PIC X.
	       10  DFHBMEOF			 PIC X.
      * 					 x'80'.
	   05  DFHBMCUR-VAL VALUE 002		 PIC S9(4) COMP-4.
	   05  FILLER REDEFINES DFHBMCUR-VAL.
	       10  FILLER			 PIC X.
	       10  DFHBMCUR			 PIC X.
      * 					 x'02'.
	   05  DFHBMMEC-VAL VALUE 130		 PIC S9(4) COMP-4.
	   05  FILLER REDEFINES DFHBMMEC-VAL.
	       10  FILLER			 PIC X.
	       10  DFHBMMEC			 PIC X.
      * 					 x'82'.
      * 					 x'02'.
	   05  DFHBMFLG-VAL  VALUE 0		 PIC S9(4) COMP-4.
	       88  DFHERASE			 VALUES 128 130.
      * 					 x'80' X'82'
	       88  DFHCURSR			 VALUES 002 130.
      * 					 x'02' X'82'
	   05  FILLER REDEFINES DFHBMFLG-VAL.
	       10  FILLER			 PIC X.
	       10  DFHBMFLG			 PIC X.

	   05  DFHBMDUP-VAL VALUE 028		 PIC S9(4) COMP-4.
	   05  FILLER REDEFINES DFHBMDUP-VAL.
	       10  FILLER			 PIC X.
	       10  DFHBMDUP			 PIC X.
      * 					     x'1C'
      *
      ******************************************************************
      *    supported 327X Extended Attributes
      *
      *    Extended COLOR Attributes
      *
	   05  DFHDFCOL 			 PIC X VALUE '0'.
	   05  DFHBLUE				 PIC X VALUE '1'.
	   05  DFHRED				 PIC X VALUE '2'.
	   05  DFHPINK				 PIC X VALUE '3'.
	   05  DFHGREEN 			 PIC X VALUE '4'.
	   05  DFHTURQ				 PIC X VALUE '5'.
	   05  DFHYELLO 			 PIC X VALUE '6'.
	   05  DFHNEUTR 			 PIC X VALUE '7'.
      *
      *    Extended HILIGHT Attributes
      *
	   05  DFHDFHI				 PIC X VALUE '0'.
	   05  DFHBLINK 			 PIC X VALUE '1'.
	   05  DFHREVRS 			 PIC X VALUE '2'.
	   05  DFHUNDLN 			 PIC X VALUE '4'.
      *
      ******************************************************************
      *    supported 327X Data Stream Orders
      *
	   05  DFHSBA-VAL VALUE 017		  PIC S9(4) COMP-4.
	   05  FILLER REDEFINES DFHSBA-VAL.
	       10  FILLER			 PIC X.
	       10  DFHSBA			 PIC X.
      * 					     x'11'
	   05  DFHEUA-VAL VALUE 018		 PIC S9(4) COMP-4.
	   05  FILLER REDEFINES DFHEUA-VAL.
	       10  FILLER			 PIC X.
	       10  DFHEUA			 PIC X.
      * 					     x'12'
	   05  DFHIC-VAL VALUE 019		 PIC S9(4) COMP-4.
	   05  FILLER REDEFINES DFHIC-VAL.
	       10  FILLER			 PIC X.
	       10  DFHIC			 PIC X.
      * 					     X'13'.
	   05  DFHSF-VAL VALUE 029		 PIC S9(4) COMP-4.
	   05  FILLER REDEFINES DFHSF-VAL.
	       10  FILLER			 PIC X.
	       10  DFHSF			 PIC X.
      * 					     X'1D'.
	   05  DFHPT-VAL VALUE 005		 PIC S9(4) COMP-4.
	       88 DFHPT-VAL-EBCDIC		 VALUE 5.
	       88 DFHPT-VAL-ASCII		 VALUE 9.
	   05  FILLER REDEFINES DFHPT-VAL.
	       10  FILLER			 PIC X.
	       10  DFHPT			 PIC X.
      * 					     EBCDIC X'05'.
      * 					     ASCII  X'09'.
	   05  DFHRA-VAL VALUE 060		 PIC S9(4) COMP-4.
	       88 DFHRA-VAL-EBCDIC		 VALUE 60.
	       88 DFHRA-VAL-ASCII		 VALUE 20.
	   05  FILLER REDEFINES DFHRA-VAL.
	       10  FILLER			 PIC X.
	       10  DFHRA			 PIC X.
      * 					     EBCDIC x'3C'
      * 					     ASCII  x'14'
	   05  DFHSFE-VAL VALUE 041		 PIC S9(4) COMP-4.
	       88 DFHSFE-VAL-EBCDIC		 VALUE 41.
	       88 DFHSFE-VAL-ASCII		 VALUE 31.
	   05  FILLER REDEFINES DFHSFE-VAL.
	       10  FILLER			 PIC X.
	       10  DFHSFE			 PIC X.
      * 					     EBCDIC x'29'
      * 					     ASCII  x'1F'
	   05  DFHMF-VAL VALUE 044		 PIC S9(4) COMP-4.
	       88 DFHMF-VAL-EBCDIC		 VALUE 44.
	       88 DFHMF-VAL-ASCII		 VALUE 23.
	   05  FILLER REDEFINES DFHMF-VAL.
	       10  FILLER			 PIC X.
	       10  DFHMF			 PIC X.
      * 					     EBCDIC x'2C'
      * 					     ASCII  x'17'
      *
      ******************************************************************
      *    unsupported 327X Data Stream order codes
      *
	   05  DFHSA-VAL VALUE 040		 PIC S9(4) COMP-4.
	       88 DFHSA-VAL-EBCDIC		 VALUE 40.
	       88 DFHSA-VAL-ASCII		 VALUE 21.
	   05  FILLER REDEFINES DFHSA-VAL.
	       10  FILLER			 PIC X.
	       10  DFHSA			 PIC X.
      * 					     EBCDIC x'28'
      * 					     ASCII  x'15'
	   05  DFHGE-VAL VALUE 008		 PIC S9(4) COMP-4.
	   05  FILLER REDEFINES DFHGE-VAL.
	       10  FILLER			 PIC X.
	       10  DFHGE			 PIC X.
      * 					     X'08'.
      *
      ******************************************************************
      *    SFE and MF supported attribute types
      *
	   05  DFHCOLOR 			 PIC X VALUE 'ƒ'.
      * 					     EBCDIC x'42'
      * 					     ASCII  x'83'
	   05  DFHHLT				 PIC X VALUE 'Ö'.
      * 					     EBCDIC x'41'
      * 					     ASCII  x'D6'
	   05  DFH3270				 PIC X VALUE '{'.
      *
      *    supported for SEND TEXT command and printer terminal
      *
	   05  DFHBMPNL-VAL VALUE 021		 PIC S9(4) COMP-4.
	       88 DFHBMPNL-VAL-EBCDIC		 VALUE 21.
	       88 DFHBMPNL-VAL-ASCII		 VALUE 10.
	   05  FILLER REDEFINES DFHBMPNL-VAL.
	       10  FILLER			 PIC X.
	       10  DFHBMPNL			 PIC X.
      * 					     EBCDIC X'15'.
      * 					     ASCII  X'0A'.
      *
      ******************************************************************
      *    Printer terminal data stream only
      *
	   05  DFHBMPFF-VAL VALUE 012		 PIC S9(4) COMP-4.
	   05  FILLER REDEFINES DFHBMPFF-VAL.
	       10  FILLER			 PIC X.
	       10  DFHBMPFF			 PIC X.
      * 					     X'0C'.
	   05  DFHBMPCR-VAL VALUE 013		 PIC S9(4) COMP-4.
	   05  FILLER REDEFINES DFHBMPCR-VAL.
	       10  FILLER			 PIC X.
	       10  DFHBMPCR			 PIC X.
      * 					     X'0D'.
	   05  DFHBMPEM-VAL VALUE 025		 PIC S9(4) COMP-4.
	   05  FILLER REDEFINES DFHBMPEM-VAL.
	       10  FILLER			 PIC X.
	       10  DFHBMPEM			 PIC X.
      * 					     X'19'.
      *
      ******************************************************************
      *    unsupported Miscellaneous attributes and constants
      *
	   05  DFHALL				 PIC X VALUE LOW-VALUES.
	   05  DFHBASE				 PIC X VALUE '0'.
	   05  DFHBMDET 			 PIC X VALUE LOW-VALUES.
	   05  DFHBMPSOSI-VAL VALUE 3599	 PIC S9(4) COMP-4.
	   05  FILLER REDEFINES DFHBMPSOSI-VAL.
	       10  DFHBMPSO			 PIC X.
      * 					     X'0E'.
	       10  DFHBMPSI			 PIC X.
      * 					     X'0F'.
	   05  DFHDFT VALUE HIGH-VALUES 	 PIC X.
	   05  DFHERROR 			 PIC X VALUE '¶'.
      * 					     EBCDIC X'1A'.
      * 					     ASCII  X'B6'.
	   05  DFHFIL				 PIC X VALUE '4'.
	   05  DFHMENT				 PIC X VALUE '2'.
	   05  DFHMET				 PIC X VALUE '3'.
	   05  DFHMFE				 PIC X VALUE '6'.
	   05  DFHMFET				 PIC X VALUE '7'.
	   05  DFHMFT				 PIC X VALUE '5'.
	   05  DFHMT				 PIC X VALUE '1'.
	   05  DFHOUTLN 			 PIC X VALUE 'B'.
	   05  DFHPS				 PIC X VALUE '„'.
      * 					     EBCDIC x'43'
      * 					     ASCII  x'84'
	   05  DFHVAL				 PIC X VALUE 'A'.
      *
	   05  DFHSUB-VAL   VALUE 063		 PIC S9(4) COMP-4.
	       88 DFHSUB-VAL-EBCDIC		 VALUE 63.
	       88 DFHSUB-VAL-ASCII		 VALUE 26.
	   05  FILLER REDEFINES DFHSUB-VAL.
	       10  FILLER			 PIC X.
	       10  DFHSUB			 PIC X.
      * 					     EBCDIC X'3F'.
      * 					     ASCII  X'1A'.
      *
	   05  DFHFM-VAL    VALUE 030		 PIC S9(4) COMP-4.
	   05  FILLER REDEFINES DFHFM-VAL.
	       10  FILLER			 PIC X.
	       10  DFHFM			 PIC X.
      * 					     EBCDIC X'1E'.
	   05  DFHEO VALUE HIGH-VALUE		 PIC X.
