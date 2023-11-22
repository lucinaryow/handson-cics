      * SYMBOLIC MAP of sm006s Created by CACXBMS Version 6.0.27
       01  SM006MI.
	   02  FILLER				      PIC X(12).
	   02  PF2L				      PIC S9(4) COMP.
	   02  PF2F				      PIC X.
	   02  FILLER REDEFINES PF2F.
	       03  PF2A 			      PIC X.
	   02  PF2I				      PIC X(012).
	   02  PF5L				      PIC S9(4) COMP.
	   02  PF5F				      PIC X.
	   02  FILLER REDEFINES PF5F.
	       03  PF5A 			      PIC X.
	   02  PF5I				      PIC X(011).
	   02  DATE1L				      PIC S9(4) COMP.
	   02  DATE1F				      PIC X.
	   02  FILLER REDEFINES DATE1F.
	       03  DATE1A			      PIC X.
	   02  DATE1I				      PIC X(010).
	   02  TIME1L				      PIC S9(4) COMP.
	   02  TIME1F				      PIC X.
	   02  FILLER REDEFINES TIME1F.
	       03  TIME1A			      PIC X.
	   02  TIME1I				      PIC X(008).
	   02  TIXNOL				      PIC S9(4) COMP.
	   02  TIXNOF				      PIC X.
	   02  FILLER REDEFINES TIXNOF.
	       03  TIXNOA			      PIC X.
	   02  TIXNOI				      PIC X(006).
	   02  REQBYL				      PIC S9(4) COMP.
	   02  REQBYF				      PIC X.
	   02  FILLER REDEFINES REQBYF.
	       03  REQBYA			      PIC X.
	   02  REQBYI				      PIC X(007).
	   02  TITLEL				      PIC S9(4) COMP.
	   02  TITLEF				      PIC X.
	   02  FILLER REDEFINES TITLEF.
	       03  TITLEA			      PIC X.
	   02  TITLEI				      PIC X(025).
	   02  DESC1L				      PIC S9(4) COMP.
	   02  DESC1F				      PIC X.
	   02  FILLER REDEFINES DESC1F.
	       03  DESC1A			      PIC X.
	   02  DESC1I				      PIC X(040).
	   02  DESC2L				      PIC S9(4) COMP.
	   02  DESC2F				      PIC X.
	   02  FILLER REDEFINES DESC2F.
	       03  DESC2A			      PIC X.
	   02  DESC2I				      PIC X(040).
	   02  STATL				      PIC S9(4) COMP.
	   02  STATF				      PIC X.
	   02  FILLER REDEFINES STATF.
	       03  STATA			      PIC X.
	   02  STATI				      PIC X(010).
	   02  UPDBYL				      PIC S9(4) COMP.
	   02  UPDBYF				      PIC X.
	   02  FILLER REDEFINES UPDBYF.
	       03  UPDBYA			      PIC X.
	   02  UPDBYI				      PIC X(008).
	   02  REM1L				      PIC S9(4) COMP.
	   02  REM1F				      PIC X.
	   02  FILLER REDEFINES REM1F.
	       03  REM1A			      PIC X.
	   02  REM1I				      PIC X(025).
	   02  REM2L				      PIC S9(4) COMP.
	   02  REM2F				      PIC X.
	   02  FILLER REDEFINES REM2F.
	       03  REM2A			      PIC X.
	   02  REM2I				      PIC X(025).
	   02  DATE2L				      PIC S9(4) COMP.
	   02  DATE2F				      PIC X.
	   02  FILLER REDEFINES DATE2F.
	       03  DATE2A			      PIC X.
	   02  DATE2I				      PIC X(010).
	   02  TIME2L				      PIC S9(4) COMP.
	   02  TIME2F				      PIC X.
	   02  FILLER REDEFINES TIME2F.
	       03  TIME2A			      PIC X.
	   02  TIME2I				      PIC X(010).
	   02  ERRMSGL				      PIC S9(4) COMP.
	   02  ERRMSGF				      PIC X.
	   02  FILLER REDEFINES ERRMSGF.
	       03  ERRMSGA			      PIC X.
	   02  ERRMSGI				      PIC X(071).
       01  SM006MO REDEFINES SM006MI.
	   02  FILLER				      PIC X(12).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  PF2O				      PIC X(012).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  PF5O				      PIC X(011).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  DATE1O				      PIC X(010).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  TIME1O				      PIC X(008).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  TIXNOO				      PIC X(006).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  REQBYO				      PIC X(007).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  TITLEO				      PIC X(025).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  DESC1O				      PIC X(040).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  DESC2O				      PIC X(040).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  STATO				      PIC X(010).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  UPDBYO				      PIC X(008).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  REM1O				      PIC X(025).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  REM2O				      PIC X(025).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  DATE2O				      PIC X(010).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  TIME2O				      PIC X(010).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  ERRMSGO				      PIC X(071).
