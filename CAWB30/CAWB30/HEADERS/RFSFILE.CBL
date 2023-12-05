* This is the definition of the File Information Block
* for Realia File System API (RFSAPI)
*
*    The Nested COPY file compiler option must be used
*
* Revision Information
* ^{File:rfsfile.cpy}
* ^{Timestamp:Wed Feb 22 13:59:00 1995}
* ^{Revision:6.0}
*
* This software is the property of Computer Associates International, Inc.
* and is protected by International Copyright law
* Any unauthorized use or reproduction is prohibited
*
* Copyright (c) 1994-1995 Computer Associates International, Inc.
* All rights reserved
*
* This source code may be used only by licensed users
* of CA-Realia Development products.
*
     05  RFSFile-Record-Length		   pic s9(9) binary.
     05  RFSFile-Min-Record-Length	   pic s9(9) binary.
     05  RFSFile-Code-System		   pic s9(4) binary.
	 88  RFSFile-ASCII		   value 0.
	 88  RFSFile-EBCDIC		   value 1.
     05  RFSFile-Organization		   pic s9(4) binary.
	 88  RFSFile-sequential 	   value 0.
	 88  RFSFile-Relative		   value 1.
	 88  RFSFile-Indexed		   value 2.
     05  RFSFile-Open-Mode		   pic s9(4) binary.
	 88  RFSFile-Open-Input 	   value 0.
	 88  RFSFile-Open-Input-Reversed   value 1.
	 88  RFSFile-Open-Input-No-Rewind  value 2.
	 88  RFSFile-Open-Output	   value 3.
	 88  RFSFile-Open-Output-No-Rewind value 4.
	 88  RFSFile-Open-I-O		   value 5.
	 88  RFSFile-Open-Extend	   value 6.
     05  RFSFile-Access-Mode		   pic s9(4) binary.
	 88  RFSFile-Access-Sequential	   value 0.
	 88  RFSFile-Access-Random	   value 1.
	 88  RFSFile-Access-Dynamic	   value 2.
     05  RFSFile-Lock-Mode		   pic s9(4) binary.
	 88  RFSFile-Lock-None		   value 0.
	 88  RFSFile-Lock-Exclusive	   value 1.
	 88  RFSFile-Lock-Manual	   value 2.
	 88  RFSFile-Lock-Automatic	   value 3.
     05  RFSFile-Dynamic-FileSpec	   pic s9(4) binary.
	 88  RFSFile-Dynamic-Nonenv	   value 0.
	 88  RFSFile-Dynamic-Env	   value 1.
     05  RFSFile-Num-Keys		   pic s9(4) binary.
	 88  RFSFile-Keys-Valid 	   value 1 thru 63.
     05  RFSFile-Reserved		   pic s9(4) binary.
