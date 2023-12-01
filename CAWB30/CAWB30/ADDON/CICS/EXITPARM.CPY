      * CA-Realia PAN/LCM keyword standards
      * ^{File:exitparm.cpy}
      * ^{Timestamp:Fri May 16 07:53:42 1997}
      * ^{Revision:3.0}
      *
      *    Runtime Exit interface record for
      *    CA-Realia CICS Rel 6.0
      *
      *    Some fields are for CICS specific use only, marked CSUO.
      *
      *    EXIT-AREA
      *    contains control information
      *    and an array of address and size variables
      *    each entry represents an area and its size
      *    The meaning of each value is exit specific
      *
      *    This is the only parameter passed
      *    If appropriate, the address to a CICSICB and EIBLK will be passed
      *    in EXIT-EIB and EXIT-ICB
      *    EXIT-ICB is not valid except during In-Task activity
      *
	   05  EXIT-CALLING-SYSTEM		 PIC S9(4) binary.
	       88  EXIT-IMS-CALLED		 VALUE 0.
	       88  EXIT-CICS-CALLED		 VALUE 1.
	   05  EXIT-STATUS			 PIC S9(4) binary.
	       88  EXIT-OK			 VALUE 0.
	       88  EXIT-INVALID-CALL		 VALUE 1.
	   05  EXIT-PHASE			 PIC S9(4) binary.
	   *> the phase that exit-calling-system is in for this call
	   *> all exits routines get called for EXIT-init and EXIT-shutdown
	   *> other phase calls are exit specific
	       88  EXIT-INIT			 VALUE 01.
	       88  EXIT-SHUTDOWN		 VALUE 90.
	       88  EXIT-START-TASK		 VALUE 10.
	       88  EXIT-END-TASK		 VALUE 11. *> CSUO
	       88  EXIT-SYNCPOINT		 VALUE 20. *> CSUO
	       88  EXIT-SYNCPOINT-ROLLBACK	 VALUE 21. *> CSUO
	       88  EXIT-AT-ERROR		 VALUE 22. *> CSUO
	       88  EXIT-IN-TASK 		 VALUE 20 THRU 29. *> CSUO
	   05  EXIT-CLASS			 pic s9(4) binary.
	   *> EXIT-CLASS should be set by the module during EXIT-INIT
	   *> to indicate how this module is to be called
	       88  EXIT-SESSION 		 value 1 thru 4.
		   *> Value 1 will only be called at start / end of SESSION
	       88  EXIT-TASK			 value 2 thru 4.
		   *> Value 2 will be called at start / end of SESSION
		   *> Value 2 will be called at start / end of TASK
		   *> Value 2 will be called at SYNCHPOINT
	       88  EXIT-COMMAND 		 value 3. *> CSUO
		   *> Value 3 not currently supported
	       88  EXIT-ERROR-PROCESSING	 value 4. *> CSUO
		   *> Value 4 will be called at start / end of SESSION
		   *> Value 4 will be called at start / end of TASK
		   *> Value 4 will be called at SYNCHPOINT
		   *> Value 4 will be called at Unsupported command
		   *> Value 4 will be called at Unknown command
		   *> Value 4 will be called at SYSIDERR
	   05  EXIT-AREA-SIZE  value 1	    PIC S9(9) binary.
	   *> These areas are exit specific
	   *> this will become a larger area as other exits are added
	   05  EXIT-AREA-ENTRY			 OCCURS 1
						 INDEXED BY EXIT-IX.
	       10  EXIT-ADDRESS 		 POINTER.
	       10  EXIT-SIZE			 PIC 9(9) binary.
	   *> EXIT-MODULE-AREA pointer is maintained by the exit
	   *> program and is NEVER modified by the exit-calling-system
	   *> except during the initial call when it contains a pointer
	   *> to the invocation string in the CSR. It can be modified
	   *> by the exit program. It is set to NULL by the the runtime
	   *> if not modified by the exit initialization phase.
	   05  EXIT-MODULE-AREA 		 POINTER.
	   05  EXIT-ICB 			 POINTER. *> CSUO
	   05  EXIT-EIBLK			 POINTER. *> CSUO
