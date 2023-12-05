      * ^{File:dataclas.cpy}
      * ^{Timestamp:Fri May 16 07:53:34 1997}
      * ^{Revision:5.0}
      *
      * This software is the property of Computer Associates International, Inc.
      * and is protected by International Copyright law
      * Any unauthorized use or reproduction is prohibited
      *
      * Copyright (c) 1993, 1997 Computer Associates International, Inc.
      * All rights reserved
      *
      *    Description: CA-Realia CICS Rel 6.0
      *    definitions of the data classes used in CICSICB
      *
	   88  undefined-class			 value ' ' x'20' x'40'.
	   88  Alpha-class10			 value 'A' x'c1' x'41'.
	   88  valid-class			 value '1' thru '8'
						       x'f1' thru x'f8'
						       x'31' thru x'39'
						       'A' x'c1' x'41'
							   *> A=10 bytes
						       'H' x'c8' x'48'
						       'F' x'c6' x'46'
						       'T' x'e3' x'54'
						       'P' x'd7' x'50'
						       'T' x'e3' x'54'
						       'P' x'd7' x'50'.
	   88  alphabetic-class 		 value '0' thru '8'
						       'A' x'c1' x'41'
							   *> A=10 bytes
						       x'f1' thru x'f8'
						       x'31' thru x'39'.
	   88  halfword-class			 value 'H' x'c8' x'48'.
	   88  fullword-class			 value 'F' x'c6' x'46'.
	   88  numeric-class			 value 'H' x'c8' x'48'
						       'F' x'c6' x'46'
						       'T' x'e3' x'54'
						       'P' x'd7' x'50'.
	   88  time-class			 value 'T' x'e3' x'54'
						       'P' x'd7' x'50'.
	   88  short-time-class 		 value 'T' x'e3' x'54'.
	   88  long-time-class			 value 'P' x'd7' x'50'.
