*************************************************************************
*
* Source File Name: SQLETSD
*
* (C) COPYRIGHT International Business Machines Corp. 1987, 1995
* All Rights Reserved
* Licensed Materials - Property of IBM
*
* US Government Users Restricted Rights - Use, duplication or
* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*
* Function: Table space descriptor
*
* Operating System:  Windows NT
*
**************************************************************************
 01 SQLETSDESC.
     05 SQLTSDID	       PIC X(8).
     05 SQLEXTNT	       PIC S9(9) COMP-5.
     05 SQLPRFTC	       PIC S9(9) COMP-5.
     05 SQLPOVHD	       USAGE COMP-2.
     05 SQLTRFRT	       USAGE COMP-2.
     05 SQLTSTYP	       PIC X.
     05 SQL-PAD1	       PIC X.
     05 SQLCCNT 	       PIC S9(4) COMP-5.
     05 SQL-CONTAINR OCCURS 001 TIMES.
	 10 SQLCTYPE	       PIC X.
	 10 SQL-PAD1	       PIC X(3).
	 10 SQLCSIZE	       PIC S9(9) COMP-5.
	 10 SQLCLEN	       PIC S9(4) COMP-5.
	 10 SQLCONTR	       PIC X(256).
	 10 SQL-PAD2	       PIC X(2).