*$PP-DEF HEADER NI EXTERNAL PROGRAM
*$PP-NOLIST HEADER NI
*$PP-RELATIVE-LINE-ADJ +000000003
 IDENTIFICATION DIVISION.
 PROGRAM-ID. CARFSAPI EXTERNAL.
*
* Header File for CA-Realia File System (CARFSAPI) Version 2.0
*
* This software is the property of
* Computer Associates International, Inc.
* and is protected by International Copyright law.
* Any unauthorized use or reproduction is prohibited.
*
* Copyright (c) 1992, 1995 Computer Associates International, Inc.
* All rights reserved.
*
* **> Note: The reserved area of the parameter block now contains the
*	    following flag bits:
*
*	 1 - RFSFile-NoFCreate - This flag causes the file open
*	     to behave as if the NOFCREATE option is in effect.
*
*	 2 - RFSFile-Realia-ReadPrior - This flag causes the
*	     callable file system to behave like CA-Realia COBOL
*	     when a READ PRIOR follows a START. The default
*	     behavior is to emulate VSAM on the mainframe.
*
*	 4 - RFSFile-Open-Optional - This flag causes the
*	     file to be opened as if OPTIONAL was coded
*	     on the SELECT statement.
*
 DATA DIVISION.
 LINKAGE SECTION.
 01  RFSFileSpec			   PIC X.
 01  RFSRecArea 			   PIC X.
 01  RFSFileHandle			   PIC S9(9) BINARY.
 01  RFSKeyRandom			   PIC S9(9) BINARY.
 01  RFSKey				   PIC X.
 01  RFSKeyLength			   PIC S9(9) BINARY.
 01  RFSFilePosition			   PIC S9(9) BINARY.
 01  RFSDataLength			   PIC S9(9) BINARY.
 01  RFSAdvCount			   PIC S9(9) BINARY.
 01  RFSDateTime.
     05  RFSFileDate-YY 		   PIC S9(4) BINARY.
     05  RFSFileDate-MM 		   PIC S9(4) BINARY.
     05  RFSFileDate-DD 		   PIC S9(4) BINARY.
     05  RFSFileTime-HH 		   PIC S9(4) BINARY.
     05  RFSFileTime-MM 		   PIC S9(4) BINARY.
     05  RFSFileTime-SS 		   PIC S9(4) BINARY.
 01  RFSFileType			   PIC X.
     88  RFSFileType-Binary		   VALUE 'B'.
     88  RFSFileType-Compressed 	   VALUE 'C'.
     88  RFSFileType-FixedWithDelete	   VALUE 'D'.
     88  RFSFileType-Fixed		   VALUE 'F'.
     88  RFSFileType-Relative		   VALUE 'R'.
     88  RFSFileType-Text		   VALUE 'T'.
     88  RFSFileType-Text-NoTab 	   VALUE 'N'.
     88  RFSFileType-Variable		   VALUE 'V'.
     88  RFSFileType-Indexed		   VALUE 'X'.
     88  RFSFileType-Installable	   VALUE 'Z'.
 01  RFSStartType			   PIC S9(4) BINARY.
     88  RFSStart-Equal 		   VALUE 0.
     88  RFSStart-GT			   VALUE 1.
     88  RFSStart-GTEQ			   VALUE 2.
 01  RFSCloseMode			   PIC S9(4) BINARY.
     88  RFSClose-Standard		   VALUE 0.
     88  RFSClose-Lock			   VALUE 1.
     88  RFSClose-Rewind		   VALUE 2.
 01  RFSLockMode			   PIC S9(4) BINARY.
     88  RFSLock-Record-No		   VALUE 0.
     88  RFSLock-Record 		   VALUE 1.
 01  RFSAdvType 			   PIC S9(4) BINARY.
     88  RFSAdvType-None		   VALUE 0.
     88  RFSAdvType-Before-Page 	   VALUE 1.
     88  RFSAdvType-After-Page		   VALUE 2.
     88  RFSAdvType-Before-Line 	   VALUE 3.
     88  RFSAdvType-After-Line		   VALUE 4.
 01  RFSAdvInfo 			   PIC S9(4) BINARY.
     88  RFSAdvInfo-None		   VALUE 0.
     88  RFSAdvInfo-LF			   VALUE 1.
     88  RFSAdvInfo-FF			   VALUE 2.
     88  RFSAdvInfo-CR			   VALUE 3.
 01  RFSKeyNumber			   PIC S9(4) BINARY.
 01  RFSFileBlock.
     05  RFSFile-Record-Length		   PIC S9(9) BINARY.
     05  RFSFile-Min-Record-Length	   PIC S9(9) BINARY.
	 88  RFSFile-Rec-Length-FIXED	   VALUE 0.
	 88  RFSFile-Rec-Length-VARIABLE   VALUE 1.
     05  RFSFile-Code-System		   PIC S9(4) BINARY.
	 88  RFSFile-ASCII		   VALUE 0.
	 88  RFSFile-EBCDIC		   VALUE 1.
     05  RFSFile-Organization		   PIC S9(4) BINARY.
	 88  RFSFile-sequential 	   VALUE 0.
	 88  RFSFile-Relative		   VALUE 1.
	 88  RFSFile-Indexed		   VALUE 2.
     05  RFSFile-Open-Mode		   PIC S9(4) BINARY.
	 88  RFSFile-Open-Input 	   VALUE 0.
	 88  RFSFile-Open-Input-Reversed   VALUE 1.
	 88  RFSFile-Open-Input-No-Rewind  VALUE 2.
	 88  RFSFile-Open-Output	   VALUE 3.
	 88  RFSFile-Open-Output-No-Rewind VALUE 4.
	 88  RFSFile-Open-I-O		   VALUE 5.
	 88  RFSFile-Open-Extend	   VALUE 6.
     05  RFSFile-Access-Mode		   PIC S9(4) BINARY.
	 88  RFSFile-Access-Sequential	   VALUE 0.
	 88  RFSFile-Access-Random	   VALUE 1.
	 88  RFSFile-Access-Dynamic	   VALUE 2.
     05  RFSFile-Lock-Mode		   PIC S9(4) BINARY.
	 88  RFSFile-Lock-None		   VALUE 0.
	 88  RFSFile-Lock-Exclusive	   VALUE 1.
	 88  RFSFile-Lock-Manual	   VALUE 2.
	 88  RFSFile-Lock-Automatic	   VALUE 3.
     05  RFSFile-Dynamic-FileSpec	   PIC S9(4) BINARY.
	 88  RFSFile-Dynamic-Nonenv	   VALUE 0.
	 88  RFSFile-Dynamic-Env	   VALUE 1.
     05  RFSFile-Num-Keys		   PIC S9(4) BINARY.
	 88  RFSFile-Keys-Valid 	   VALUE 1 thru 63.
     05  RFSFile-Reserved		   PIC S9(4) BINARY.
	 88  RFSFile-NoFCreate		   VALUE 1.
	 88  RFSFile-Realia-ReadPrior	   VALUE 2.
	 88  RFSFile-Open-Optional	   VALUE 4.
* RFSAPI Key decriptor Block
 01  RFSKeyBlock.
     05  RFSKey-Start			   PIC S9(9) BINARY.
     05  RFSKey-Length			   PIC S9(9) BINARY.
     05  RFSKey-Type			   PIC S9(4) BINARY.
	 88  RFSKey-Alpha		   VALUE 0.
	 88  RFSKey-Integer		   VALUE 1.
	 88  RFSKey-Packed		   VALUE 2.
	 88  RFSKey-Float		   VALUE 3.
     05  RFSKey-Duplicate		   PIC S9(4) BINARY.
	 88  RFSKey-Duplicate-No	   VALUE 0.
	 88  RFSKey-Duplicate-Yes	   VALUE 1.
     05  RFSKey-Null			   PIC S9(4) BINARY.
	 88  RFSKey-NullKey-No		   VALUE 0.
	 88  RFSKey-NullKey-NoSpace	   VALUE 1.
	 88  RFSKey-NullKey-NoZeros	   VALUE 2.
	 88  RFSKey-NullKey-NoLowValue	   VALUE 3.
     05  RFSKey-Reserved		   PIC S9(4) BINARY.
 01  RFSAPIStatus			   PIC S9(4) BINARY.
	 88  RFS-Ok			   VALUE 00.
	 88  RFS-Dupkey 		   VALUE 02.
	 88  RFS-Read-Len-Error 	   VALUE 04.
	 88  RFS-Open-Not-Present	   VALUE 05.
	 88  RFS-Tape-Spec-Error	   VALUE 07.
	 88  RFS-End-of-File		   VALUE 10.
	 88  RFS-Read-RRN-Error 	   VALUE 14.
	 88  RFS-Seq-Error		   VALUE 21.
	 88  RFS-Dup-Record		   VALUE 22.
	 88  RFS-No-Key 		   VALUE 23.
	 88  RFS-Disk-Full		   VALUE 24 34.
	 88  RFS-Io-Error-Undefined	   VALUE 30.
	 88  RFS-Open-No-File		   VALUE 35.
	 88  RFS-Open-bad-Mode		   VALUE 37.
	 88  RFS-Open-File-Locked	   VALUE 38.
	 88  RFS-Open-Bad-Format	   VALUE 39.
	 88  RFS-Second-Open		   VALUE 41.
	 88  RFS-Second-Close		   VALUE 42.
	 88  RFS-Rewrite-Error		   VALUE 43.
	 88  RFS-Write-Len-Error	   VALUE 44.
	 88  RFS-Read-Pos-Error 	   VALUE 46.
	 88  RFS-Read-Not-Allowed	   VALUE 47.
	 88  RFS-Write-Not-Allowed	   VALUE 48.
	 88  RFS-Rewrite-Not-Allowed	   VALUE 49.
	 88  RFS-Access-Denied		   VALUE 91.
	 88  RFS-File-Not-Found 	   VALUE 92.
	 88  RFS-No-Memory		   VALUE 96.
	 88  RFS-Critical-Error 	   VALUE 97.
	 88  RFS-Open-NC-File		   VALUE 107.
	 88  RFS-Open-JC-File		   VALUE 108.
	 88  RFS-Open-JCR-File		   VALUE 109.
	 88  RFS-Dead-lock		   VALUE 110.
	 88  RFS-Invalid-Cmd-Logged-File   VALUE 115.
	 88  RFS-File-Busy		   VALUE 118.
	 88  RFS-Max-Locks-Exceeded	   VALUE 119.
	 88  RFS-Roll-Back-Forced	   VALUE 124.
	 88  RFS-Wrong-File-Version	   VALUE 128.
*
 PROCEDURE DIVISION.
     Entry 'S_RealiaFSClose'
	 Using BY REFERENCE RFSFileHandle
	       BY VALUE     RFSCloseMode
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSCommit'
	 Using BY REFERENCE RFSFileHandle
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSDelete'
	 Using BY REFERENCE RFSFileHandle
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSFileInfo'
	 Using BY REFERENCE RFSFileSpec delimited
	       BY REFERENCE RFSFileBlock
	       BY REFERENCE RFSFileType
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSGetDateTime'
	 Using BY REFERENCE RFSFileHandle
	       BY REFERENCE RFSDateTime
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSGetPosition'
	 Using BY REFERENCE RFSFileHandle
	 Returning RFSFilePosition.

     Entry 'S_RealiaFSKeyInfo'
	 Using BY REFERENCE RFSFileSpec delimited
	       BY REFERENCE RFSFileBlock
	       BY REFERENCE RFSKeyBlock
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSOpen'
	 Using BY REFERENCE RFSFileHandle
	       BY REFERENCE RFSFileSpec delimited
	       BY REFERENCE RFSFileBlock
	       BY REFERENCE RFSKeyBlock
	       BY REFERENCE RFSRecArea
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSReadAdv'
	 Using BY REFERENCE RFSFileHandle
	       BY VALUE     RFSLockMode
	       BY REFERENCE RFSDataLength
	       BY REFERENCE RFSAdvInfo
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSReadKey'
	 Using BY REFERENCE RFSFileHandle
	       BY VALUE     RFSKeyNumber
	       BY REFERENCE RFSKey
	       BY VALUE     RFSLockMode
	       BY REFERENCE RFSDataLength
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSReadNext'
	 Using BY REFERENCE RFSFileHandle
	       BY VALUE     RFSLockMode
	       BY REFERENCE RFSDataLength
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSReadPrior'
	 Using BY REFERENCE RFSFileHandle
	       BY VALUE     RFSLockMode
	       BY REFERENCE RFSDataLength
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSStart'
	 Using BY REFERENCE RFSFileHandle
	       BY VALUE     RFSKeyNumber
	       BY VALUE     RFSKeyLength
	       BY REFERENCE RFSKey
	       BY VALUE     RFSStartType
	       BY VALUE     RFSLockMode
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSReWrite'
	 Using BY REFERENCE RFSFileHandle
	       BY VALUE     RFSDataLength
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSReWriteRel'
	 Using BY REFERENCE RFSFileHandle
	       BY VALUE     RFSKeyRandom
	       BY VALUE     RFSDataLength
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSRollback'
	 Using BY REFERENCE RFSFileHandle
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSUnlock'
	 Using BY REFERENCE RFSFileHandle
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSWrite'
	 Using BY REFERENCE RFSFileHandle
	       BY VALUE     RFSDataLength
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSWriteAdv'
	 Using BY REFERENCE RFSFileHandle
	       BY VALUE     RFSAdvType
	       BY VALUE     RFSAdvCount
	       BY VALUE     RFSDataLength
	 Returning RFSAPIStatus.

     Entry 'S_RealiaFSWriteRel'
	 Using BY REFERENCE RFSFileHandle
	       BY VALUE     RFSKeyRandom
	       BY VALUE     RFSDataLength
	 Returning RFSAPIStatus.

 End Program CARFSAPI.
*$PP-LIST HEADER
