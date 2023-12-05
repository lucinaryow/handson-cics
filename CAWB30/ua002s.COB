      * SYMBOLIC MAP of ua002s Created by CACXBMS Version 6.0.27
       01  UA002MI.
	   02  FILLER				      PIC X(12).
	   02  DATEL				      PIC S9(4) COMP.
	   02  DATEF				      PIC X.
	   02  FILLER REDEFINES DATEF.
	       03  DATEA			      PIC X.
	   02  DATEI				      PIC X(010).
	   02  TIMEL				      PIC S9(4) COMP.
	   02  TIMEF				      PIC X.
	   02  FILLER REDEFINES TIMEF.
	       03  TIMEA			      PIC X.
	   02  TIMEI				      PIC X(008).
	   02  USERL				      PIC S9(4) COMP.
	   02  USERF				      PIC X.
	   02  FILLER REDEFINES USERF.
	       03  USERA			      PIC X.
	   02  USERI				      PIC X(008).
	   02  REQUESTL 			      PIC S9(4) COMP.
	   02  REQUESTF 			      PIC X.
	   02  FILLER REDEFINES REQUESTF.
	       03  REQUESTA			      PIC X.
	   02  REQUESTI 			      PIC X(001).
	   02  ADMINL				      PIC S9(4) COMP.
	   02  ADMINF				      PIC X.
	   02  FILLER REDEFINES ADMINF.
	       03  ADMINA			      PIC X.
	   02  ADMINI				      PIC X(001).
	   02  APPROVEL 			      PIC S9(4) COMP.
	   02  APPROVEF 			      PIC X.
	   02  FILLER REDEFINES APPROVEF.
	       03  APPROVEA			      PIC X.
	   02  APPROVEI 			      PIC X(001).
	   02  SERVICEL 			      PIC S9(4) COMP.
	   02  SERVICEF 			      PIC X.
	   02  FILLER REDEFINES SERVICEF.
	       03  SERVICEA			      PIC X.
	   02  SERVICEI 			      PIC X(001).
	   02  ERRMSGL				      PIC S9(4) COMP.
	   02  ERRMSGF				      PIC X.
	   02  FILLER REDEFINES ERRMSGF.
	       03  ERRMSGA			      PIC X.
	   02  ERRMSGI				      PIC X(071).
       01  UA002MO REDEFINES UA002MI.
	   02  FILLER				      PIC X(12).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  DATEO				      PIC X(010).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  TIMEO				      PIC X(008).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  USERO				      PIC X(008).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  REQUESTO 			      PIC X(001).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  ADMINO				      PIC X(001).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  APPROVEO 			      PIC X(001).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  SERVICEO 			      PIC X(001).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  ERRMSGO				      PIC X(071).
