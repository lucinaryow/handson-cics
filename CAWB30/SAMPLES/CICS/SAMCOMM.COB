      * Revision Information
      * ^{File:samcomm.cob }
      * ^{Timestamp:Fri May 16 07:32:10 1997}
      * ^{Revision:3.0}
      *
      * CA-Realia CICS Version 6.0
      *
      * This software is the property of Computer Associates International, Inc.
      * and is protected by International Copyright law
      * Any unauthorized use or reproduction is prohibited
      *
      * Copyright (c) 1984, 1997 Computer Associates International, Inc.
      *
      * This software is provided by Computer Associates
      * as an example of a CICS application program.
      * It should not be considered complete or correct.					       *
      *
      ******************************************************************
      * DFHCOMMAREA for SAMPLE application
      ******************************************************************
	   05  LS-ACTION			 PIC X(8).
	   05  LS-LAST-PROG			 PIC X(8).
	   05  LS-NEXT-PROG			 PIC X(8).
	       88  LS-MENU-PROG 		 VALUE 'SAMP00'.
	       88  LS-LIST-PROG 		 VALUE 'SAMP10'.
	       88  LS-MAINT-PROG		 VALUE 'SAMP20'.
	       88  LS-PRINT-PROG		 VALUE 'SAMP30'.
	   05  LS-CURRENT-MAP			 PIC X(7).
	   05  LS-KEYS.
	       10  LS-RIDFLD			 PIC X(10).
	       10  LS-CODE			 PIC X(4).
	       10  LS-FIRST-RIDFLD		 PIC X(10).
	       10  LS-FIRST-CODE		 PIC X(4).
	       10  LS-LAST-RIDFLD		 PIC X(10).
	       10  LS-LAST-CODE 		 PIC X(4).
	   05  LS-FILE				 PIC X(8).
	       88  LS-NAMEFILE			 VALUE 'NAMEFILE'.
	       88  LS-SHORTNAME 		 VALUE 'SHORTNAM'.
	   05  LS-PRINT-REQUEST 		 PIC X.
	       88  LS-PRINT-ONE 		 VALUE 'A'.
	       88  LS-PRINT-ALL 		 VALUE 'B'.
