* This is the definition of the Result Status code values
* for Realia File System API (RFSAPI)
*
* Revision Information
* ^{File:rfstatus.cbl}
* ^{Timestamp:Fri Apr 07 16:53:46 1995}
* ^{Revision:1.0}
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
*    RFSAPIStatus is returned by Realia File Service Module.
	 88  RFS-Ok			     value 00.
	 88  RFS-Dupkey 		     value 02.
	 88  RFS-Read-Len-Error 	     value 04.
	 88  RFS-Open-Not-Present	     value 05.
	 88  RFS-Tape-Spec-Error	     value 07.
	 88  RFS-End-of-File		     value 10.
	 88  RFS-Read-RRN-Error 	     value 14.
	 88  RFS-Seq-Error		     value 21.
	 88  RFS-Dup-Record		     value 22.
	 88  RFS-No-Key 		     value 23.
	 88  RFS-Disk-Full		     value 24 34.
	 88  RFS-Io-Error-Undefined	     value 30.
	 88  RFS-Open-No-File		     value 35.
	 88  RFS-Open-bad-Mode		     value 37.
	 88  RFS-Open-File-Locked	     value 38.
	 88  RFS-Open-Bad-Format	     value 39.
	 88  RFS-Second-Open		     value 41.
	 88  RFS-Second-Close		     value 42.
	 88  RFS-Rewrite-Error		     value 43.
	 88  RFS-Write-Len-Error	     value 44.
	 88  RFS-Read-Pos-Error 	     value 46.
	 88  RFS-Read-Not-Allowed	     value 47.
	 88  RFS-Write-Not-Allowed	     value 48.
	 88  RFS-Rewrite-Not-Allowed	     value 49.
	 88  RFS-No-Memory		     value 96.
	 88  RFS-Critical-Error 	     value 97.
	 88  RFS-Open-NC-File		     value 107.
	 88  RFS-Open-JC-File		     value 108.
	 88  RFS-Open-JCR-File		     value 109.
	 88  RFS-Dead-lock		     value 110.
	 88  RFS-Invalid-Cmd-Logged-File     value 115.
	 88  RFS-File-Busy		     value 118.
	 88  RFS-Max-Locks-Exceeded	     value 119.
	 88  RFS-Roll-Back-Forced	     value 124.
	 88  RFS-Wrong-File-Version	     value 128.
