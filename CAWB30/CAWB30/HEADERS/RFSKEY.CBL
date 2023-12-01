* This is the definition of the Key Information block
* for Realia File System API (RFSAPI)
*
*    The Nested COPY file compiler option must be used
*
* Revision Information
* ^{File:rfskey.cbl}
* ^{Timestamp:Thu May 11 17:55:16 1995}
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
	 10  RFSKey-Start		   pic s9(9) binary.
	 10  RFSKey-Length		   pic s9(9) binary.
	 10  RFSKey-Type		   pic s9(4) binary.
	     88  RFSKey-Alpha		   value 0.
	     88  RFSKey-Integer 	   value 1.
	     88  RFSKey-Packed		   value 2.
	     88  RFSKey-Float		   value 3.
	 10  RFSKey-Duplicate		   pic s9(4) binary.
	     88  RFSKey-Duplicate-No	   value 0.
	     88  RFSKey-Duplicate-Yes	   value 1.
	 10  RFSKey-Null		   pic s9(4) binary.
	     88  RFSKey-NullKey-No	   value 0.
	     88  RFSKey-NullKey-NoSpace    value 1.
	     88  RFSKey-NullKey-NoZeros    value 2.
	     88  RFSKey-NullKey-NoLowValue value 3.
	 10  RFSKey-Reserved		   pic s9(4) binary.
