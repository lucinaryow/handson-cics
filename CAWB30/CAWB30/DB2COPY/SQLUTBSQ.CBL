*************************************************************************
*
* Source File Name: SQLUTBSQ
*
* (C) COPYRIGHT International Business Machines Corp. 1987, 1995
* All Rights Reserved
* Licensed Materials - Property of IBM
*
* US Government Users Restricted Rights - Use, duplication or
* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*
* Function: Table space query
*
* Operating System:  Windows NT
*
**************************************************************************
 01 SQLB-TBSQRY-DATA.
     05 SQL-ID		       PIC 9(9) COMP-5.
     05 SQL-NAME-LEN	       PIC 9(9) COMP-5.
     05 SQL-NAME	       PIC X(128).
     05 SQL-TOTAL-PAGES        PIC 9(9) COMP-5.
     05 SQL-USEABLE-PAGES      PIC 9(9) COMP-5.
     05 SQL-FLAGS	       PIC 9(9) COMP-5.
     05 SQL-PAGE-SIZE	       PIC 9(9) COMP-5.
     05 SQL-EXT-SIZE	       PIC 9(9) COMP-5.
     05 SQL-PREFETCH-SIZE      PIC 9(9) COMP-5.
     05 SQL-N-CONTAINERS       PIC 9(9) COMP-5.
     05 SQL-TBS-STATE	       PIC 9(9) COMP-5.
     05 SQL-LIFE-LSN	       PIC X(6).
     05 SQL-PAD 	       PIC X(2).