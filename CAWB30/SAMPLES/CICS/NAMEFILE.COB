      * Revision Information
      * ^{File:namefile.cob}
      * ^{Timestamp:Fri May 16 07:26:12 1997}
      * ^{Revision:2.0}
      *
      * CA-Realia CICS Version 6.0
      *
      * This software is the property of Computer Associates International, Inc.
      * and is protected by International Copyright law
      * Any unauthorized use or reproduction is prohibited
      *
      * Copyright (c) 1992, 1997 Computer Associates International, Inc.
      *
      * This software is provided by Computer Associates
      * as an example of a CICS application program.
      * It should not be considered complete or correct.					       *
      *
      ******************************************************************
      *DESCRIPTION: master layout
      ******************************************************************
      *
	   05  KEY1.
	       10  NAME-CODE			 PIC X(4).
      *        10  NAME-CODE-NUM REDEFINES NAME-CODE PIC 9999.
	   05  KEY2.
	       10  SHORT-NAME			 PIC X(10).
	   05  NAME				 PIC X(50).
	   05  CONTACT-NAME			 PIC X(30).
	   05  FULL-ADDRESS.
	       10  ADDRESS1			 PIC X(50).
	       10  ADDRESS2			 PIC X(50).
	       10  ADDRESS3			 PIC X(50).
	       10  ADDRESS4			 PIC X(50).
	       10  POSTAL-CODE			 PIC X(12).
	   05  PHONE				 PIC X(24).
	   05  FAX				 PIC X(24).
	   05  COMMENT				 PIC X(60).
