      * SYMBOLIC MAP of samm10 Created by CACXBMS Version 6.0.27
       01  SAMM10HI.
	   02  FILLER				      PIC X(12).
	   02  M10DATEL 			      PIC S9(4) COMP.
	   02  M10DATEF 			      PIC X.
	   02  FILLER REDEFINES M10DATEF.
	       03  M10DATEA			      PIC X.
	   02  FILLER				      PIC XXXX.
	   02  M10DATEI 			      PIC X(010).
	   02  PROMPTL				      PIC S9(4) COMP.
	   02  PROMPTF				      PIC X.
	   02  FILLER REDEFINES PROMPTF.
	       03  PROMPTA			      PIC X.
	   02  FILLER				      PIC XXXX.
	   02  PROMPTI				      PIC X(010).
	   02  FCODEL				      PIC S9(4) COMP.
	   02  FCODEF				      PIC X.
	   02  FILLER REDEFINES FCODEF.
	       03  FCODEA			      PIC X.
	   02  FILLER				      PIC XXXX.
	   02  FCODEI				      PIC X(004).
	   02  PROMPT2L 			      PIC S9(4) COMP.
	   02  PROMPT2F 			      PIC X.
	   02  FILLER REDEFINES PROMPT2F.
	       03  PROMPT2A			      PIC X.
	   02  FILLER				      PIC XXXX.
	   02  PROMPT2I 			      PIC X(013).
	   02  SHRTNML				      PIC S9(4) COMP.
	   02  SHRTNMF				      PIC X.
	   02  FILLER REDEFINES SHRTNMF.
	       03  SHRTNMA			      PIC X.
	   02  FILLER				      PIC XXXX.
	   02  SHRTNMI				      PIC X(010).
       01  SAMM10HO REDEFINES SAMM10HI.
	   02  FILLER				      PIC X(12).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  M10DATEC 			      PIC X.
	   02  M10DATEP 			      PIC X.
	   02  M10DATEH 			      PIC X.
	   02  M10DATEV 			      PIC X.
	   02  M10DATEO 			      PIC X(010).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  PROMPTC				      PIC X.
	   02  PROMPTP				      PIC X.
	   02  PROMPTH				      PIC X.
	   02  PROMPTV				      PIC X.
	   02  PROMPTO				      PIC X(010).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  FCODEC				      PIC X.
	   02  FCODEP				      PIC X.
	   02  FCODEH				      PIC X.
	   02  FCODEV				      PIC X.
	   02  FCODEO				      PIC X(004).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  PROMPT2C 			      PIC X.
	   02  PROMPT2P 			      PIC X.
	   02  PROMPT2H 			      PIC X.
	   02  PROMPT2V 			      PIC X.
	   02  PROMPT2O 			      PIC X(013).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  SHRTNMC				      PIC X.
	   02  SHRTNMP				      PIC X.
	   02  SHRTNMH				      PIC X.
	   02  SHRTNMV				      PIC X.
	   02  SHRTNMO				      PIC X(010).
       01  SAMM10DI.
	   02  FILLER				      PIC X(12).
	   02  CCODEL				      PIC S9(4) COMP.
	   02  CCODEF				      PIC X.
	   02  FILLER REDEFINES CCODEF.
	       03  CCODEA			      PIC X.
	   02  FILLER				      PIC XXXX.
	   02  CCODEI				      PIC X(004).
	   02  CNAMEL				      PIC S9(4) COMP.
	   02  CNAMEF				      PIC X.
	   02  FILLER REDEFINES CNAMEF.
	       03  CNAMEA			      PIC X.
	   02  FILLER				      PIC XXXX.
	   02  CNAMEI				      PIC X(040).
	   02  CONTCTL				      PIC S9(4) COMP.
	   02  CONTCTF				      PIC X.
	   02  FILLER REDEFINES CONTCTF.
	       03  CONTCTA			      PIC X.
	   02  FILLER				      PIC XXXX.
	   02  CONTCTI				      PIC X(030).
	   02  PPHONEL				      PIC S9(4) COMP.
	   02  PPHONEF				      PIC X.
	   02  FILLER REDEFINES PPHONEF.
	       03  PPHONEA			      PIC X.
	   02  FILLER				      PIC XXXX.
	   02  PPHONEI				      PIC X(024).
       01  SAMM10DO REDEFINES SAMM10DI.
	   02  FILLER				      PIC X(12).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  CCODEC				      PIC X.
	   02  CCODEP				      PIC X.
	   02  CCODEH				      PIC X.
	   02  CCODEV				      PIC X.
	   02  CCODEO				      PIC X(004).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  CNAMEC				      PIC X.
	   02  CNAMEP				      PIC X.
	   02  CNAMEH				      PIC X.
	   02  CNAMEV				      PIC X.
	   02  CNAMEO				      PIC X(040).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  CONTCTC				      PIC X.
	   02  CONTCTP				      PIC X.
	   02  CONTCTH				      PIC X.
	   02  CONTCTV				      PIC X.
	   02  CONTCTO				      PIC X(030).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  PPHONEC				      PIC X.
	   02  PPHONEP				      PIC X.
	   02  PPHONEH				      PIC X.
	   02  PPHONEV				      PIC X.
	   02  PPHONEO				      PIC X(024).
       01  SAMM10TI.
	   02  FILLER				      PIC X(12).
	   02  MSGL				      PIC S9(4) COMP.
	   02  MSGF				      PIC X.
	   02  FILLER REDEFINES MSGF.
	       03  MSGA 			      PIC X.
	   02  FILLER				      PIC XXXX.
	   02  MSGI				      PIC X(079).
       01  SAMM10TO REDEFINES SAMM10TI.
	   02  FILLER				      PIC X(12).
	   02  FILLER				      PIC XX.
	   02  FILLER				      PIC X.
	   02  MSGC				      PIC X.
	   02  MSGP				      PIC X.
	   02  MSGH				      PIC X.
	   02  MSGV				      PIC X.
	   02  MSGO				      PIC X(079).
