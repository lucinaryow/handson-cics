*************************************************************************
*
* Source File Name: SQLUTBCQ
*
* (C) COPYRIGHT International Business Machines Corp. 1987, 1995
* All Rights Reserved
* Licensed Materials - Property of IBM
*
* US Government Users Restricted Rights - Use, duplication or
* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*
* Function: Table space container query
*
* Operating System:  Windows NT
*
**************************************************************************
 01 SQLB-TBSCONTQRY-DATA.
     05 SQL-ID		       PIC 9(9) COMP-5.
     05 SQL-N-TBS	       PIC 9(9) COMP-5.
     05 SQL-TBS-ID	       PIC 9(9) COMP-5.
     05 SQL-NAME-LEN	       PIC 9(9) COMP-5.
     05 SQL-NAME	       PIC X(256).
     05 SQL-UNDER-DBDIR        PIC 9(9) COMP-5.
     05 SQL-CONT-TYPE	       PIC 9(9) COMP-5.
     05 SQL-TOTAL-PAGES        PIC 9(9) COMP-5.
     05 SQL-USEABLE-PAGES      PIC 9(9) COMP-5.
     05 SQL-OK		       PIC 9(9) COMP-5.