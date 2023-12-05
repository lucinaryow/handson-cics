*************************************************************************
*
* Source File Name: SQLUTIL
*
* (C) COPYRIGHT International Business Machines Corp. 1987, 1995
* All Rights Reserved
* Licensed Materials - Property of IBM
*
* US Government Users Restricted Rights - Use, duplication or
* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*
* Function = Include File defining:
*	       Utility / Configuration Commands - Constants
*	       Utility / Configuration Commands - Data Structures
*	       Utility / Configuration Commands - Function Prototypes
*	       Utility / Configuration Commands - Labels for SQLCODES
*
* Operating System: Windows NT
*
**************************************************************************
* Interface Parameters/Structures/Return Codes

* Parameters for Rollforward caller action
* Roll forward to requested point
 77  SQLUM-ROLLFWD	       PIC S9(4) COMP-5 VALUE 1.
* End roll-forward recovery
 77  SQLUM-STOP 	       PIC S9(4) COMP-5 VALUE 2.
* Roll forward to requested point and end roll-forward recovery
 77  SQLUM-ROLLFWD-STOP        PIC S9(4) COMP-5 VALUE 3.
* Query nextArcFile, firstDeleteArc, lastDeleteArc, lastCommitTime
 77  SQLUM-QUERY	       PIC S9(4) COMP-5 VALUE 4.
* Parameter check
 77  SQLUM-PARM-CHECK	       PIC S9(4) COMP-5 VALUE 10.
* Continue load recovery.
 77  SQLUM-LOADREC-CONTINUE    PIC S9(4) COMP-5 VALUE 11.
* Terminate load recovery.
 77  SQLUM-LOADREC-TERMINATE   PIC S9(4) COMP-5 VALUE 12.
* Terminate device.Caller action codes 31 - 35 reserved for internal
* use.
 77  SQLUM-LOADREC-DEVICE-TERMINATE PIC S9(4) COMP-5 VALUE 13.

* Constants used for Rollforward
* Roll forward until STOP specified
 77  SQLUM-INFINITY-TIMESTAMP  PIC X(26) value "9999-12-31-23.59.5
-    "9.999999".
* Length of Archive File name
 77  SQLUM-ARCHIVE-FILE-LEN    PIC S9(4) COMP-5 VALUE 12.
* Length of ISO format Timestamp
 77  SQLUM-TIMESTAMP-LEN       PIC S9(4) COMP-5 VALUE 26.

* Rollforward connect mode
* Offline rollforward mode
 77  SQLUM-OFFLINE	       PIC S9(4) COMP-5 VALUE 0.
* Online rollforward mode
 77  SQLUM-ONLINE	       PIC S9(4) COMP-5 VALUE 1.

* Backup backup mode
* Offline backup mode
 77  SQLUB-OFFLINE	       PIC S9(4) COMP-5 VALUE 0.
* Online backup mode
 77  SQLUB-ONLINE	       PIC S9(4) COMP-5 VALUE 1.

* Backup type
 77  SQLUB-FULL 	       PIC S9(4) COMP-5 VALUE 0.
 77  SQLUB-TABLESPACE	       PIC S9(4) COMP-5 VALUE 3.

* Backup calling action values
* initial call
 77  SQLUB-BACKUP	       PIC S9(4) COMP-5 VALUE 0.
* Subsequent call
 77  SQLUB-CONTINUE	       PIC S9(4) COMP-5 VALUE 1.
* Terminating call
 77  SQLUB-TERMINATE	       PIC S9(4) COMP-5 VALUE 2.
* Initial call to run without prompting
 77  SQLUB-NOINTERRUPT	       PIC S9(4) COMP-5 VALUE 3.
* End media device.
 77  SQLUB-DEVICE-TERMINATE    PIC S9(4) COMP-5 VALUE 9.
* for parameter check only.
 77  SQLUB-PARM-CHECK	       PIC S9(4) COMP-5 VALUE 10.

* Restore mode
 77  SQLUD-ROLLFWD	       PIC S9(4) COMP-5 VALUE 0.
 77  SQLUD-NOROLLFWD	       PIC S9(4) COMP-5 VALUE 1.

* Restore calling action values
* initial call
 77  SQLUD-RESTORE	       PIC S9(4) COMP-5 VALUE 0.
* Subsequent call
 77  SQLUD-CONTINUE	       PIC S9(4) COMP-5 VALUE 1.
* Terminating call
 77  SQLUD-TERMINATE	       PIC S9(4) COMP-5 VALUE 2.
* Initial call to run without prompting
 77  SQLUD-NOINTERRUPT	       PIC S9(4) COMP-5 VALUE 3.
* End media device.
 77  SQLUD-DEVICE-TERMINATE    PIC S9(4) COMP-5 VALUE 9.
* for parameter check only.
 77  SQLUD-PARM-CHECK	       PIC S9(4) COMP-5 VALUE 10.
* initial call, tablespace container redefinition requested
 77  SQLUD-RESTORE-STORDEF     PIC S9(4) COMP-5 VALUE 100.
* initial call, tablespace container redefinition requested without
* prompting
 77  SQLUD-STORDEF-NOINTERRUPT PIC S9(4) COMP-5 VALUE 101.

* Restore type
 77  SQLUD-FULL 	       PIC S9(4) COMP-5 VALUE 0.
 77  SQLUD-ONLINE-TABLESPACE   PIC S9(4) COMP-5 VALUE 3.
 77  SQLUD-HISTORY	       PIC S9(4) COMP-5 VALUE 5.
* The following are not supported in V2.1.0
 77  SQLUD-TABLESPACE-TBL      PIC S9(4) COMP-5 VALUE 6.
 77  SQLUD-HIST-TBLSPACE-TBL   PIC S9(4) COMP-5 VALUE 7.

* Backup/Restore Definitions
* length of database alias name
 77  SQLU-ALIAS-SZ	       PIC S9(4) COMP-5 VALUE 8.
* length of userid
 77  SQLU-USERID-LEN	       PIC S9(4) COMP-5 VALUE 8.
* length of password
 77  SQLU-PWD-LEN	       PIC S9(4) COMP-5 VALUE 8.
* length of the backup timestamp in yyyymmddhhmmss format
 77  SQLU-TIME-STAMP-LEN       PIC S9(4) COMP-5 VALUE 14.

* length of filename of backup image:
* dbalias.type.db2instance.node.timestamp.seq
 77  SQLU-BACKUP-NAME-SZ       PIC S9(4) COMP-5 VALUE 44.

* length of directory where backup file will reside:dir - '/' -
* filename
 77  SQLU-BACKUP-DIR-SZ        PIC S9(4) COMP-5 VALUE 978.

* Parameters for Backup/Restore old api's
* User exit used, not SD interface
 77  SQLU-NSD-ID               PIC X(1) value "0".

* Media type for old api's
 77  SQLUB-MEDIA-TARGET        PIC S9(4) COMP-5 VALUE 0.
 77  SQLUB-ADSM 	       PIC S9(4) COMP-5 VALUE 1.
 77  SQLUB-OTHER	       PIC S9(4) COMP-5 VALUE 2.

* Old OS/2 Backup/restore media type values
 77  SQLUD-MEDIA-SRC	       PIC S9(4) COMP-5 VALUE 0.
 77  SQLUD-ADSM 	       PIC S9(4) COMP-5 VALUE 1.
 77  SQLUD-OTHER	       PIC S9(4) COMP-5 VALUE 2.

* Parameters for SQLUHPRN force option
 77  SQLUH-NO-FORCE	       PIC S9(4) COMP-5 VALUE 0.
 77  SQLUH-FORCE	       PIC S9(4) COMP-5 VALUE 1.

* Parameters for SQLUHOPS caller action
 77  SQLUH-LIST-BACKUP	       PIC S9(4) COMP-5 VALUE 0.
 77  SQLUH-LIST-HISTORY        PIC S9(4) COMP-5 VALUE 1.

* History File structure sizes
 77  SQLUH-OP-SZ	       PIC S9(4) COMP-5 VALUE 1.
 77  SQLUH-OBJ-SZ	       PIC S9(4) COMP-5 VALUE 1.
 77  SQLUH-OBJPART-SZ	       PIC S9(4) COMP-5 VALUE 17.
 77  SQLUH-OPTYPE-SZ	       PIC S9(4) COMP-5 VALUE 1.
 77  SQLUH-DEVTYPE-SZ	       PIC S9(4) COMP-5 VALUE 1.
 77  SQLUH-FIRSTLOG-SZ	       PIC S9(4) COMP-5 VALUE 12.
 77  SQLUH-LASTLOG-SZ	       PIC S9(4) COMP-5 VALUE 12.
 77  SQLUH-BACKID-SZ	       PIC S9(4) COMP-5 VALUE 14.
 77  SQLUH-TCREATE-SZ	       PIC S9(4) COMP-5 VALUE 8.
 77  SQLUH-TNAME-SZ	       PIC S9(4) COMP-5 VALUE 18.
 77  SQLUH-NUMTABLESPACE-SZ    PIC S9(4) COMP-5 VALUE 5.
 77  SQLUH-LOC-SZ	       PIC S9(4) COMP-5 VALUE 255.
 77  SQLUH-COMMENT-SZ	       PIC S9(4) COMP-5 VALUE 30.
 77  SQLUH-TABLESPACENAME-SZ   PIC S9(4) COMP-5 VALUE 18.

* Parameters for RUNSTATS
* TABLEOPT = Table w/o Indexes
 77  SQL-STATS-TABLE           PIC X(1) value "T".
* TABLEOPT = Table and Indexes
 77  SQL-STATS-BOTH            PIC X(1) value "B".
* TABLEOPT = Indexes w/o Table
 77  SQL-STATS-INDEX           PIC X(1) value "I".
* TABLEOPT = Table and dist stats
 77  SQL-STATS-EXTTABLE-ONLY   PIC X(1) value "D".
* TABLEOPT = Table and dist stats and basic indexes
 77  SQL-STATS-EXTTABLE-INDEX  PIC X(1) value "E".
* TABLEOPT = Ext stats for indexes only
 77  SQL-STATS-EXTINDEX-ONLY   PIC X(1) value "X".
* TABLEOPT = Ext stats for indexes and basic table stats
 77  SQL-STATS-EXTINDEX-TABLE  PIC X(1) value "Y".
* TABLEOPT = Ext stats for indexes and table with dist stats
 77  SQL-STATS-ALL             PIC X(1) value "A".
* SHAREOPT = Reference
 77  SQL-STATS-REF             PIC X(1) value "R".
* SHAREOPT = Change
 77  SQL-STATS-CHG             PIC X(1) value "C".

* TABLEOPT - no statistics are to be gathered - Load only
 77  SQLU-STATS-NONE           PIC X(1) value " ".

* Parameters for selection method in sqldcol
* Names
 77  SQL-METH-N 	       PIC S9(4) COMP-5 VALUE 78.
* Positional
 77  SQL-METH-P 	       PIC S9(4) COMP-5 VALUE 80.
* Default
 77  SQL-METH-D 	       PIC S9(4) COMP-5 VALUE 68.
* Locations
 77  SQL-METH-L 	       PIC S9(4) COMP-5 VALUE 76.

* File Types for Import/Export
 77  SQL-IXF                   PIC X(3) value "IXF".
 77  SQL-WSF                   PIC X(3) value "WSF".
 77  SQL-DEL                   PIC X(3) value "DEL".
 77  SQL-ASC                   PIC X(3) value "ASC".
* load/unload
 77  SQL-DB2CS                 PIC X(5) value "DB2CS".

* Client Communication Protocols
 77  SQLF-PROTOCOL-TCPIP       PIC X(5) value "TCPIP".
 77  SQLF-PROTOCOL-APPC        PIC X(4) value "APPC".

* Import/Export/Load/Unload calling action values
* Initial call
 77  SQLU-INITIAL	       PIC S9(4) COMP-5 VALUE 0.
* Subsequent call
 77  SQLU-CONTINUE	       PIC S9(4) COMP-5 VALUE 1.
* Terminating call
 77  SQLU-TERMINATE	       PIC S9(4) COMP-5 VALUE 2.
* Initial call - Load/Unload only
 77  SQLU-NOINTERRUPT	       PIC S9(4) COMP-5 VALUE 3.
* Abort call - Load only
 77  SQLU-ABORT 	       PIC S9(4) COMP-5 VALUE 4.
* Restart call - Load only
 77  SQLU-RESTART	       PIC S9(4) COMP-5 VALUE 5.
* Subsequent call - Load/Unload only
 77  SQLU-DEVICE-TERMINATE     PIC S9(4) COMP-5 VALUE 9.

* Actions for quiesce tablespaces for table
 77  SQLU-QUIESCEMODE-SHARE    PIC S9(4) COMP-5 VALUE 0.
 77  SQLU-QUIESCEMODE-INTENT-UPDATE PIC S9(4) COMP-5 VALUE 1.
 77  SQLU-QUIESCEMODE-EXCLUSIVE PIC S9(4) COMP-5 VALUE 2.
 77  SQLU-QUIESCEMODE-RESET    PIC S9(4) COMP-5 VALUE 9.
 77  SQLU-QUIESCEMODE-RESET-OWNED PIC S9(4) COMP-5 VALUE 10.

* Equates for Configuration Utilities

* Token equates for SQLFupd structure for Kernel config file
 77  SQLF-KTN-RQRIOBLK	       PIC S9(4) COMP-5 VALUE 1.
 77  SQLF-KTN-NUMDB	       PIC S9(4) COMP-5 VALUE 6.
 77  SQLF-KTN-NNAME	       PIC S9(4) COMP-5 VALUE 7.
 77  SQLF-KTN-MAXAGENTS        PIC S9(4) COMP-5 VALUE 12.
 77  SQLF-KTN-MAXCAGENTS       PIC S9(4) COMP-5 VALUE 13.
 77  SQLF-KTN-ASLHEAPSZ        PIC S9(4) COMP-5 VALUE 15.
 77  SQLF-KTN-SQLSTMTSZ        PIC S9(4) COMP-5 VALUE 17.
 77  SQLF-KTN-BACKBUFSZ        PIC S9(4) COMP-5 VALUE 18.
 77  SQLF-KTN-RESTBUFSZ        PIC S9(4) COMP-5 VALUE 19.
 77  SQLF-KTN-INDEXREC	       PIC S9(4) COMP-5 VALUE 20.
 77  SQLF-KTN-SHEAPTHRES       PIC S9(4) COMP-5 VALUE 21.
 77  SQLF-KTN-MAXDARI	       PIC S9(4) COMP-5 VALUE 80.
 77  SQLF-KTN-KEEPDARI	       PIC S9(4) COMP-5 VALUE 81.
 77  SQLF-KTN-SVCENAME	       PIC S9(4) COMP-5 VALUE 24.
 77  SQLF-KTN-TPNAME	       PIC S9(4) COMP-5 VALUE 25.
 77  SQLF-KTN-AGENTPRI	       PIC S9(4) COMP-5 VALUE 26.
 77  SQLF-KTN-DFTDBPATH        PIC S9(4) COMP-5 VALUE 27.

* tokens for new Version 2.1 parameters
 77  SQLF-KTN-DFT-ACCOUNT-STR  PIC S9(4) COMP-5 VALUE 28.

* You may manipulate the bits of SQLF_KTN_DFT_MONSWITCHES or you can
* enable disable, or query the current setting through the individual
* tokens
 77  SQLF-KTN-DFT-MONSWITCHES  PIC S9(4) COMP-5 VALUE 29.
* Bit 1 of SQLF_KTN_DFT_MONSWITCHES
 77  SQLF-KTN-DFT-MON-UOW      PIC S9(4) COMP-5 VALUE 30.
* Bit 2 of SQLF_KTN_DFT_MONSWITCHES
 77  SQLF-KTN-DFT-MON-STMT     PIC S9(4) COMP-5 VALUE 31.
* Bit 3 of SQLF_KTN_DFT_MONSWITCHES
 77  SQLF-KTN-DFT-MON-TABLE    PIC S9(4) COMP-5 VALUE 32.
* Bit 4 of SQLF_KTN_DFT_MONSWITCHES
 77  SQLF-KTN-DFT-MON-BUFPOOL  PIC S9(4) COMP-5 VALUE 33.
* Bit 5 of SQLF_KTN_DFT_MONSWITCHES
 77  SQLF-KTN-DFT-MON-LOCK     PIC S9(4) COMP-5 VALUE 34.
* Bit 6 of SQLF_KTN_DFT_MONSWITCHES
 77  SQLF-KTN-DFT-MON-SORT     PIC S9(4) COMP-5 VALUE 35.

 77  SQLF-KTN-SYSADM-GROUP     PIC S9(4) COMP-5 VALUE 39.
 77  SQLF-KTN-DIR-CACHE        PIC S9(4) COMP-5 VALUE 40.
 77  SQLF-KTN-DRDA-HEAP-SZ     PIC S9(4) COMP-5 VALUE 41.
 77  SQLF-KTN-CPUSPEED	       PIC S9(4) COMP-5 VALUE 42.
 77  SQLF-KTN-MIN-PRIV-MEM     PIC S9(4) COMP-5 VALUE 43.
 77  SQLF-KTN-PRIV-MEM-THRESH  PIC S9(4) COMP-5 VALUE 44.
 77  SQLF-KTN-MAXTOTFILOP      PIC S9(4) COMP-5 VALUE 45.
 77  SQLF-KTN-FILESERVER       PIC S9(4) COMP-5 VALUE 47.
 77  SQLF-KTN-OBJECTNAME       PIC S9(4) COMP-5 VALUE 48.
 77  SQLF-KTN-QUERY-HEAP-SZ    PIC S9(4) COMP-5 VALUE 49.

 77  SQLF-KTN-MAX-IDLEAGENTS   PIC S9(4) COMP-5 VALUE 60.
 77  SQLF-KTN-AGENT-STACK-SZ   PIC S9(4) COMP-5 VALUE 61.
 77  SQLF-KTN-SYSMAINT-GROUP   PIC S9(4) COMP-5 VALUE 62.
 77  SQLF-KTN-SYSCTRL-GROUP    PIC S9(4) COMP-5 VALUE 63.

 77  SQLF-KTN-DIAGLEVEL        PIC S9(4) COMP-5 VALUE 64.
 77  SQLF-KTN-DIAGPATH	       PIC S9(4) COMP-5 VALUE 65.

 77  SQLF-KTN-TP-MON-NAME      PIC S9(4) COMP-5 VALUE 66.
 77  SQLF-KTN-TM-DATABASE      PIC S9(4) COMP-5 VALUE 67.
 77  SQLF-KTN-RESYNC-INTERVAL  PIC S9(4) COMP-5 VALUE 68.
 77  SQLF-KTN-UDF-MEM-SZ       PIC S9(4) COMP-5 VALUE 69.

 77  SQLF-KTN-IPX-SOCKET       PIC S9(4) COMP-5 VALUE 71.
 77  SQLF-KTN-DOS-RQRIOBLK     PIC S9(4) COMP-5 VALUE 72.

* token for directory services
 77  SQLF-KTN-DIR-TYPE	       PIC S9(4) COMP-5 VALUE 73.
* token for directory services
 77  SQLF-KTN-DIR-PATH-NAME    PIC S9(4) COMP-5 VALUE 74.
* token for directory services
 77  SQLF-KTN-DIR-OBJ-NAME     PIC S9(4) COMP-5 VALUE 75.
* token for directory services
 77  SQLF-KTN-ROUTE-OBJ-NAME   PIC S9(4) COMP-5 VALUE 76.
* token for directory services
 77  SQLF-KTN-DFT-CLIENT-COMM  PIC S9(4) COMP-5 VALUE 77.
 77  SQLF-KTN-AUTHENTICATION   PIC S9(4) COMP-5 VALUE 78.
 77  SQLF-KTN-MON-HEAP-SZ      PIC S9(4) COMP-5 VALUE 79.

* tokens for syncpoint manager
 77  SQLF-KTN-SPM-LOG-FILE-SZ  PIC S9(4) COMP-5 VALUE 90.
 77  SQLF-KTN-SPM-MAX-RESYNC   PIC S9(4) COMP-5 VALUE 91.
 77  SQLF-KTN-SPM-NAME	       PIC S9(4) COMP-5 VALUE 92.

* tokens for adsm
 77  SQLF-KTN-ADSM-PASSWORD    PIC S9(4) COMP-5 VALUE 93.
 77  SQLF-KTN-ADSM-NODENAME    PIC S9(4) COMP-5 VALUE 94.
 77  SQLF-KTN-ADSM-OWNER       PIC S9(4) COMP-5 VALUE 95.

* equates for diretory type
 77  SQLF-DIRTYPE-NONE	       PIC S9(4) COMP-5 VALUE 0.
 77  SQLF-DIRTYPE-DCE	       PIC S9(4) COMP-5 VALUE 1.

* tokens for internal parameters
 77  SQLF-KTN-NODETYPE	       PIC S9(4) COMP-5 VALUE 100.
 77  SQLF-KTN-RELEASE	       PIC S9(4) COMP-5 VALUE 101.
 77  SQLF-KTN-NOTOKEN	       PIC S9(4) COMP-5 VALUE 200.

* Nodetype equates
 77  SQLF-NT-STANDALONE        PIC S9(4) COMP-5 VALUE 0.
 77  SQLF-NT-SERVER	       PIC S9(4) COMP-5 VALUE 1.
 77  SQLF-NT-REQUESTOR	       PIC S9(4) COMP-5 VALUE 2.
 77  SQLF-NT-STAND-REQ	       PIC S9(4) COMP-5 VALUE 3.

*************************************************************************
* Defines for Database Monitor Switches - SQLF_KTN_DFT_MONSWITCHES
*
* The following meanings apply when the bits are set on.
*
* SQLF_ENABLE_MON_UOW	  -
* SQLF_ENABLE_MON_STMT	  -
* SQLF_ENABLE_MON_TABLE   -
* SQLF_ENABLE_MON_BUFPOOL -
* SQLF_ENABLE_MON_LOCK	  -
* SQLF_ENABLE_MON_SORT	  -
**************************************************************************

* xxxx xxxx xxxx xxx1
 77  SQLF-ENABLE-MON-UOW       PIC S9(4) COMP-5 VALUE 1.
* xxxx xxxx xxxx xx1x
 77  SQLF-ENABLE-MON-STMT      PIC S9(4) COMP-5 VALUE 2.
* xxxx xxxx xxxx x1xx
 77  SQLF-ENABLE-MON-TABLE     PIC S9(4) COMP-5 VALUE 4.
* xxxx xxxx xxxx 1xxx
 77  SQLF-ENABLE-MON-BUFPOOL   PIC S9(4) COMP-5 VALUE 8.
* xxxx xxxx xxx1 xxxx
 77  SQLF-ENABLE-MON-LOCK      PIC S9(4) COMP-5 VALUE 16.
* xxxx xxxx xx1x xxxx
 77  SQLF-ENABLE-MON-SORT      PIC S9(4) COMP-5 VALUE 32.

* Token equates for SQLFupd structure for DB config file
 77  SQLF-DBTN-LOCKLIST        PIC S9(4) COMP-5 VALUE 1.
 77  SQLF-DBTN-BUFF-PAGE       PIC S9(4) COMP-5 VALUE 90.
 77  SQLF-DBTN-MAXFILOP        PIC S9(4) COMP-5 VALUE 3.
 77  SQLF-DBTN-SOFTMAX	       PIC S9(4) COMP-5 VALUE 5.
 77  SQLF-DBTN-MAXAPPLS        PIC S9(4) COMP-5 VALUE 6.
 77  SQLF-DBTN-APPLHEAPSZ      PIC S9(4) COMP-5 VALUE 51.
 77  SQLF-DBTN-DBHEAP	       PIC S9(4) COMP-5 VALUE 50.
 77  SQLF-DBTN-DLCHKTIME       PIC S9(4) COMP-5 VALUE 9.
 77  SQLF-DBTN-SORT-HEAP       PIC S9(4) COMP-5 VALUE 52.
 77  SQLF-DBTN-MAXLOCKS        PIC S9(4) COMP-5 VALUE 15.
 77  SQLF-DBTN-LOGPRIMARY      PIC S9(4) COMP-5 VALUE 16.
 77  SQLF-DBTN-LOGSECOND       PIC S9(4) COMP-5 VALUE 17.
 77  SQLF-DBTN-LOGFILSIZ       PIC S9(4) COMP-5 VALUE 18.
 77  SQLF-DBTN-STMTHEAP        PIC S9(4) COMP-5 VALUE 53.
 77  SQLF-DBTN-NEWLOGPATH      PIC S9(4) COMP-5 VALUE 20.
 77  SQLF-DBTN-DETS	       PIC S9(4) COMP-5 VALUE 21.
 77  SQLF-DBTN-COPY-PROTECT    PIC S9(4) COMP-5 VALUE 22.
 77  SQLF-DBTN-LOG-RETAIN      PIC S9(4) COMP-5 VALUE 23.
 77  SQLF-DBTN-USER-EXIT       PIC S9(4) COMP-5 VALUE 24.
 77  SQLF-DBTN-AUTO-RESTART    PIC S9(4) COMP-5 VALUE 25.
 77  SQLF-DBTN-INDEXREC        PIC S9(4) COMP-5 VALUE 30.
 77  SQLF-DBTN-PCKCACHESZ      PIC S9(4) COMP-5 VALUE 31.
 77  SQLF-DBTN-MINCOMMIT       PIC S9(4) COMP-5 VALUE 32.
 77  SQLF-DBTN-LOGBUFSZ        PIC S9(4) COMP-5 VALUE 33.

* tokens for new Version 2.1 parameters
 77  SQLF-DBTN-LOCKTIMEOUT     PIC S9(4) COMP-5 VALUE 34.
 77  SQLF-DBTN-INDEXSORT       PIC S9(4) COMP-5 VALUE 35.
 77  SQLF-DBTN-NUM-FREQVALUES  PIC S9(4) COMP-5 VALUE 36.
 77  SQLF-DBTN-NUM-IOCLEANERS  PIC S9(4) COMP-5 VALUE 37.
 77  SQLF-DBTN-CHNGPGS-THRESH  PIC S9(4) COMP-5 VALUE 38.
 77  SQLF-DBTN-NUM-IOSERVERS   PIC S9(4) COMP-5 VALUE 39.
 77  SQLF-DBTN-DFT-PREFETCH-SZ PIC S9(4) COMP-5 VALUE 40.
 77  SQLF-DBTN-SEQDETECT       PIC S9(4) COMP-5 VALUE 41.
 77  SQLF-DBTN-DFT-LOADREC-SES PIC S9(4) COMP-5 VALUE 42.
 77  SQLF-DBTN-REC-HIS-RETENTN PIC S9(4) COMP-5 VALUE 43.
 77  SQLF-DBTN-COLLATE-INFO    PIC S9(4) COMP-5 VALUE 44.
 77  SQLF-DBTN-STAT-HEAP-SZ    PIC S9(4) COMP-5 VALUE 45.
* token for directory services
 77  SQLF-DBTN-DIR-OBJ-NAME    PIC S9(4) COMP-5 VALUE 46.
 77  SQLF-DBTN-AVG-APPLS       PIC S9(4) COMP-5 VALUE 47.
 77  SQLF-DBTN-NUM-QUANTILES   PIC S9(4) COMP-5 VALUE 48.
 77  SQLF-DBTN-DFT-EXTENT-SZ   PIC S9(4) COMP-5 VALUE 54.
 77  SQLF-DBTN-UTIL-HEAP-SZ    PIC S9(4) COMP-5 VALUE 55.
 77  SQLF-DBTN-CATALOGCACHE-SZ PIC S9(4) COMP-5 VALUE 56.
 77  SQLF-DBTN-DFT-QUERYOPT    PIC S9(4) COMP-5 VALUE 57.

* tokens for internal parameters
 77  SQLF-DBTN-COUNTRY	       PIC S9(4) COMP-5 VALUE 100.
 77  SQLF-DBTN-CODEPAGE        PIC S9(4) COMP-5 VALUE 101.
 77  SQLF-DBTN-RELEASE	       PIC S9(4) COMP-5 VALUE 102.
 77  SQLF-DBTN-LOGPATH	       PIC S9(4) COMP-5 VALUE 103.
 77  SQLF-DBTN-INTFLAGS        PIC S9(4) COMP-5 VALUE 104.
 77  SQLF-DBTN-LOGHEAD	       PIC S9(4) COMP-5 VALUE 105.
 77  SQLF-DBTN-NEXTACTIVE      PIC S9(4) COMP-5 VALUE 107.
 77  SQLF-DBTN-CONSISTENT      PIC S9(4) COMP-5 VALUE 111.
 77  SQLF-DBTN-BACKUP-PENDING  PIC S9(4) COMP-5 VALUE 112.
 77  SQLF-DBTN-ROLLFWD-PENDING PIC S9(4) COMP-5 VALUE 113.
 77  SQLF-DBTN-LOG-RETAIN-STATUS PIC S9(4) COMP-5 VALUE 114.
 77  SQLF-DBTN-USER-EXIT-STATUS PIC S9(4) COMP-5 VALUE 115.
 77  SQLF-DBTN-CODESET	       PIC S9(4) COMP-5 VALUE 120.
 77  SQLF-DBTN-TERRITORY       PIC S9(4) COMP-5 VALUE 121.
 77  SQLF-DBTN-NUMSEGS	       PIC S9(4) COMP-5 VALUE 122.
 77  SQLF-DBTN-DATABASE-LEVEL  PIC S9(4) COMP-5 VALUE 124.
 77  SQLF-DBTN-NOTOKEN	       PIC S9(4) COMP-5 VALUE 200.

* Index recreate type
 77  SQLF-INX-REC-SYSTEM       PIC S9(4) COMP-5 VALUE 0.
 77  SQLF-INX-REC-REFERENCE    PIC S9(4) COMP-5 VALUE 1.
 77  SQLF-INX-REC-RESTART      PIC S9(4) COMP-5 VALUE 2.

* Special values for configuration defaults
* Default maxcagents
 77  SQLFDMCA		       PIC S9(4) COMP-5 VALUE -1.
* Default maxdari
 77  SQLFDMXD		       PIC S9(4) COMP-5 VALUE -1.
* Default agentpri
 77  SQLFDAPR		       PIC S9(4) COMP-5 VALUE -1.
* keepdari - no
 77  SQLFMKPD		       PIC S9(4) COMP-5 VALUE 0.
* keepdari - yes
 77  SQLFXKPD		       PIC S9(4) COMP-5 VALUE 1.

*************************************************************************
* You may manipulate the bits of SQLF_DBTN_DETS and SQLF_DBTN_INTFLAGS
* or you can enable, disable, or query the current setting through
* the individual tokens.
*
* Defines for: SQLF_DBTN_COPY_PROTECT	 , SQLF_DBTN_LOG_RETAIN
*	       SQLF_DBTN_USER_EXIT	 , SQLF_DBTN_AUTO_RESTART
*	       SQLF_DBTN_CONSISTENT	 , SQLF_DBTN_BACKUP_PENDING
*	       SQLF_DBTN_ROLLFWD_PENDING , SQLF_DBTN_LOG_RETAIN_STATUS
*	       SQLF_DBTN_USER_EXIT_STATUS
**************************************************************************

 77  SQLF-DISABLE	       PIC S9(4) COMP-5 VALUE 0.
 77  SQLF-ENABLE	       PIC S9(4) COMP-5 VALUE 1.
* The third state of rollfwd_pending
 77  SQLF-ROLLFWD-TABLESPACE   PIC S9(4) COMP-5 VALUE 2.
*************************************************************************
* Defines for Database Details - SQLF_DBTN_DETS
*
* The following meanings apply when the bits are set on.
*
* SQLF_COPY_PROTECT	  - Database is copy protected.
* SQLF_ENABLE_LOG_RETAIN  - Next time database is started in normal
*			    conditions, the log files will be retained
*			    for the purpose of roll-forward recovery.
* SQLF_ENABLE_USER_EXIT   - Next time database is started in normal
*			    conditions, the user log exit will be enabled
*			    for the purpose of roll-forward recovery.
* SQLF_ENABLE_AUTO_RESTART- The RESTART DATABASE function will be
*			    invoked when needed.
**************************************************************************

* xxxx xxxx xxxx xxx0
 77  SQLF-COPY-NOPROT	       PIC S9(4) COMP-5 VALUE 0.
* xxxx xxxx xxxx xxx1
 77  SQLF-COPY-PROTECT	       PIC S9(4) COMP-5 VALUE 1.
* xxxx xxxx xxxx xx1x
 77  SQLF-ENABLE-LOG-RETAIN    PIC S9(4) COMP-5 VALUE 2.
* xxxx xxxx xxxx x1xx
 77  SQLF-ENABLE-USER-EXIT     PIC S9(4) COMP-5 VALUE 4.
* xxxx xxxx xxxx 1xxx
 77  SQLF-ENABLE-AUTO-RESTART  PIC S9(4) COMP-5 VALUE 8.

*************************************************************************
* Defines for Logging Flags    - SQLF_DBTN_INTFLAGS
*
* The following meanings apply when the bits are set on.
*
* SQLF_CONSISTENT      - Database is in a consistent state.
* SQLF_BACKUP_PENDING  - User is required to take a backup of the
*			 database before the system will allow the
*			 database to be opened for normal processing.
* SQLF_ROLLFWD_PENDING - User is required to roll forward the database
*			 before the system will allow the database to
*			 be opened for normal processing.
* SQLF_LOG_RETAIN      - Log files are retained so that a database can be
*			 rolled forward after it has been restored from
*			 a backup copy.
* SQLF_USER_EXIT       - User exit is taken when log files are filled and
*			 when log files are needed and not found.
* SQLF_TBS_ROLLFWD     - If the SQLF_ROLLFWD_PENDING bit is off, and this
*			 bit is on, then the tablespace needs to be
*			 rolled forward.
*
**************************************************************************

* xxxx xxxx xxxx xxx1
 77  SQLF-CONSISTENT	       PIC S9(4) COMP-5 VALUE 1.
* xxxx xxxx xxxx x1xx
 77  SQLF-BACKUP-PENDING       PIC S9(4) COMP-5 VALUE 4.
* xxxx xxxx xxxx 1xxx
 77  SQLF-ROLLFWD-PENDING      PIC S9(4) COMP-5 VALUE 8.
* xxxx xxxx xxx1 xxxx
 77  SQLF-LOG-RETAIN	       PIC S9(4) COMP-5 VALUE 16.
* xxxx xxxx xx1x xxxx
 77  SQLF-USER-EXIT	       PIC S9(4) COMP-5 VALUE 32.
* xxxx xxxx x1xx xxxx
 77  SQLF-TBS-ROLLFWD	       PIC S9(4) COMP-5 VALUE 64.

* length of tpname config parm
 77  SQL-TPNAME-SZ	       PIC S9(4) COMP-5 VALUE 64.

* length of syncpoint manager name
 77  SQL-SPM-NAME-SZ	       PIC S9(4) COMP-5 VALUE 8.

* max length of log parms
 77  SQL-LOGPATH-SZ	       PIC S9(4) COMP-5 VALUE 242.
* max length of log file name
 77  SQL-LOGFILE-NAME-SZ       PIC S9(4) COMP-5 VALUE 12.
* max length of db path parm
 77  SQL-DBPATH-SZ	       PIC S9(4) COMP-5 VALUE 215.
* max length of diagpath parm
 77  SQL-FFDCPATH-SZ	       PIC S9(4) COMP-5 VALUE 215.

* LOAD and UNLOAD defines
* restart at load phase
 77  SQLU-LOAD-PHASE           PIC X(1) value "L".
* restart at build phase
 77  SQLU-BUILD-PHASE          PIC X(1) value "B".
* restart at delete phase
 77  SQLU-DELETE-PHASE         PIC X(1) value "D".

 01 SQL-DCOLDATA.
     05 SQL-DCOLMETH	       PIC S9(4) COMP-5.
     05 SQL-DCOLNUM	       PIC S9(4) COMP-5.
     05 SQLDCOLN OCCURS 0 TO 255 TIMES DEPENDING ON SQL-DCOLNUM.
	 10 SQL-DCOLNLEN       PIC S9(4) COMP-5.
	 10 FILLER	       PIC X(2).
	 10 SQL-DCOLN-PTR      USAGE IS POINTER.

*  Note that SQL-FILETMOD-DATA is defined to have 256 characters.
*  256 is an arbitrary maximum that should be large enough.
 01 SQL-FILETMOD.
     05 SQL-FILETMOD-LEN PIC 9(4) COMP-5 VALUE 0.
     05 SQL-FILETMOD-DATA PIC X(256) VALUE SPACES.


*  Note that SQL-TCOLSTRG-DATA is defined to have 256 characters.
*  256 is an arbitrary maximum that should be large enough.
 01 SQL-TCOLSTRG.
     05 SQL-TCOLSTRG-LEN PIC 9(4) COMP-5 VALUE 0.
     05 SQL-TCOLSTRG-DATA PIC X(256) VALUE SPACES.

* Structure for Pairs of Locations for ASC files
 01 SQL-LOCTAB.
     05 SQL-LOC-PAIR OCCURS 1 TIMES.
	 10 SQL-BEGIN-LOC      PIC S9(4) COMP-5.
	 10 SQL-END-LOC        PIC S9(4) COMP-5.

* Structures for Input and Output Data for Import and Export

 01 SQL-UIMPT-IN.
     05 SQL-SIZE-OF-UIMPT-IN   PIC 9(9) COMP-5 VALUE 12.
     05 SQL-COMMITCNT	       PIC 9(9) COMP-5 VALUE 0.
     05 SQL-RESTARTCNT	       PIC 9(9) COMP-5 VALUE 0.

 01 SQL-UIMPT-OUT.
     05 SQL-SIZE-OF-UIMPT-OUT  PIC 9(9) COMP-5 VALUE 28.
     05 SQL-ROWSREAD	       PIC 9(9) COMP-5 VALUE 0.
     05 SQL-ROWSSKIPPED        PIC 9(9) COMP-5 VALUE 0.
     05 SQL-ROWSINSERTED       PIC 9(9) COMP-5 VALUE 0.
     05 SQL-ROWSUPDATED        PIC 9(9) COMP-5 VALUE 0.
     05 SQL-ROWSREJECTED       PIC 9(9) COMP-5 VALUE 0.
     05 SQL-ROWSCOMMITTED      PIC 9(9) COMP-5 VALUE 0.

 01 SQL-UEXPT-OUT.
     05 SQL-SIZE-OF-UEXPT-OUT  PIC 9(9) COMP-5 VALUE 8.
     05 SQL-ROWSEXPORTED       PIC 9(9) COMP-5 VALUE 0.

 77  SQLUIMPT-IN-SIZE	       PIC S9(4) COMP-5 VALUE 12.
 77  SQLUIMPT-OUT-SIZE	       PIC S9(4) COMP-5 VALUE 28.
 77  SQLUEXPT-OUT-SIZE	       PIC S9(4) COMP-5 VALUE 8.

* Structures for Input and Output Data for Load and Unload

 01 SQLULOAD-IN.
     05 SQL-SIZE-OF-STRUCT     PIC 9(9) COMP-5 VALUE 32.
     05 SQL-SAVECNT	       PIC 9(9) COMP-5.
     05 SQL-RESTARTCOUNT       PIC 9(9) COMP-5.
     05 SQL-ROWCNT	       PIC 9(9) COMP-5.
     05 SQL-WARNINGCNT	       PIC 9(9) COMP-5.
     05 SQL-DATA-BUFFER-SIZE   PIC 9(9) COMP-5.
     05 SQL-SORT-BUFFER-SIZE   PIC 9(9) COMP-5.
     05 SQL-HOLD-QUIESCE       PIC 9(4) COMP-5.
     05 SQL-RESTARTPHASE       PIC X.
     05 SQL-STATSOPT	       PIC X.

 01 SQLULOAD-OUT.
     05 SQL-SIZE-OF-STRUCT     PIC 9(9) COMP-5 VALUE 28.
     05 SQL-ROWS-READ	       PIC 9(9) COMP-5.
     05 SQL-ROWS-SKIPPED       PIC 9(9) COMP-5.
     05 SQL-ROWS-LOADED        PIC 9(9) COMP-5.
     05 SQL-ROWS-REJECTED      PIC 9(9) COMP-5.
     05 SQL-ROWS-DELETED       PIC 9(9) COMP-5.
     05 SQL-ROWS-COMMITTED     PIC 9(9) COMP-5.

 01 SQLUUNLD-IN.
     05 SQL-SIZE-OF-STRUCT     PIC 9(9) COMP-5 VALUE 24.
     05 SQL-DATA-BUFFER-SIZE   PIC 9(9) COMP-5.
     05 SQL-SORT-BUFFER-SIZE   PIC 9(9) COMP-5.
     05 SQL-HOLD-QUIESCE       PIC 9(4) COMP-5.
     05 SQL-INTENT-UPDATE      PIC 9(4) COMP-5.
     05 SQL-SERIAL-WRITE       PIC 9(4) COMP-5.
     05 SQL-NUM-BUFFERS        PIC 9(4) COMP-5.
     05 SQL-REORG-LOBS	       PIC 9(4) COMP-5.
     05 SQL-FILLER	       PIC 9(4) COMP-5.

 01 SQLUUNLD-OUT.
     05 SQL-SIZE-OF-STRUCT     PIC 9(9) COMP-5 VALUE 8.
     05 SQL-ROWS-UNLOADED      PIC 9(9) COMP-5.

 77  SQLULOAD-IN-SIZE	       PIC S9(4) COMP-5 VALUE 32.
 77  SQLULOAD-OUT-SIZE	       PIC S9(4) COMP-5 VALUE 28.
 77  SQLUUNLD-IN-SIZE	       PIC S9(4) COMP-5 VALUE 24.
 77  SQLUUNLD-OUT-SIZE	       PIC S9(4) COMP-5 VALUE 8.

* Structures for Configuration Utility APIs.

 01 SQL-FUPD.
     05 SQL-TOKEN	       PIC 9(4) COMP-5.
     05 FILLER		       PIC X(2).
     05 SQL-VALUE-PTR	       USAGE IS POINTER.

* Constants and structure used by sqlgadau and sqluadau.
 77  SQL-USER-AUTHORIZED       PIC S9(4) COMP-5 VALUE 1.
 77  SQL-USER-UNAUTHORIZED     PIC S9(4) COMP-5 VALUE 0.
 77  SQL-AUTHORIZATION-SIZE-OLD PIC S9(4) COMP-5 VALUE 22.
 77  SQL-AUTHORIZATION-SIZE    PIC S9(4) COMP-5 VALUE 34.

 01 SQL-AUTHORIZATIONS.
     05 SQL-AUTHORIZATIONS-LEN PIC S9(4) COMP-5.
     05 SQL-SYSADM-AUTH        PIC S9(4) COMP-5.
     05 SQL-DBADM-AUTH	       PIC S9(4) COMP-5.
     05 SQL-CREATETAB-AUTH     PIC S9(4) COMP-5.
     05 SQL-BINDADD-AUTH       PIC S9(4) COMP-5.
     05 SQL-CONNECT-AUTH       PIC S9(4) COMP-5.
     05 SQL-SYSADM-GRP-AUTH    PIC S9(4) COMP-5.
     05 SQL-DBADM-GRP-AUTH     PIC S9(4) COMP-5.
     05 SQL-CREATETAB-GRP-AUTH PIC S9(4) COMP-5.
     05 SQL-BINDADD-GRP-AUTH   PIC S9(4) COMP-5.
     05 SQL-CONNECT-GRP-AUTH   PIC S9(4) COMP-5.
     05 SQL-SYSCTRL-AUTH       PIC S9(4) COMP-5.
     05 SQL-SYSCTRL-GRP-AUTH   PIC S9(4) COMP-5.
     05 SQL-SYSMAINT-AUTH      PIC S9(4) COMP-5.
     05 SQL-SYSMAINT-GRP-AUTH  PIC S9(4) COMP-5.
     05 SQL-CREATE-NOT-FENC-AUTH PIC S9(4) COMP-5.
     05 SQL-CREATE-NOT-FENC-GRP-AUTH PIC S9(4) COMP-5.

* Constants and structure used for backup and restore
 77  SQLU-MAX-TBS-NAME-LEN     PIC S9(4) COMP-5 VALUE 18.
 77  SQLU-DB-DIR-LEN	       PIC S9(4) COMP-5 VALUE 215.
 77  SQLU-SHR-LIB-LEN	       PIC S9(4) COMP-5 VALUE 255.
 77  SQLU-MEDIA-LOCATION-LEN   PIC S9(4) COMP-5 VALUE 255.
 77  SQLU-APPLID-LEN	       PIC S9(4) COMP-5 VALUE 32.
 77  SQLU-MAX-SESSIONS	       PIC S9(4) COMP-5 VALUE 999.

 01 SQLU-TABLESPACE-ENTRY.
     05 SQL-TBSP-LEN	       PIC 9(9) COMP-5.
     05 SQL-TABLESPACE-ENTRY   PIC X(18).
     05 FILLER		       PIC X.
     05 SQL-FILLER	       PIC X(1).

 01 SQLU-TABLESPACE-BKRST-LIST.
     05 SQL-NUM-ENTRY	       PIC S9(9) COMP-5.
     05 SQL-TABLESPACE	       USAGE IS POINTER.

 01 SQLU-MEDIA-ENTRY.
     05 SQL-MEDENT-LEN	       PIC 9(9) COMP-5.
     05 SQL-MEDIA-ENTRY        PIC X(215).
     05 FILLER		       PIC X.

 01 SQLU-VENDOR.
     05 SQL-SHRLIB-LEN	       PIC 9(9) COMP-5.
     05 SQL-SHR-LIB	       PIC X(255).
     05 FILLER		       PIC X.
     05 SQL-FILENAME-LEN       PIC 9(9) COMP-5.
     05 SQL-FILENAME	       PIC X(255).
     05 FILLER		       PIC X.

 01 SQLU-LOCATION-ENTRY.
     05 SQL-LOCATION-LEN       PIC 9(9) COMP-5.
     05 SQL-LOCATION-ENTRY     PIC X(255).
     05 FILLER		       PIC X.

* path/device
 77  SQLU-LOCAL-MEDIA          PIC X(1) value "L".
* remote file/device/named pipe
 77  SQLU-SERVER-LOCATION      PIC X(1) value "S".
* local file/device/named pipe
 77  SQLU-CLIENT-LOCATION      PIC X(1) value "C".
* ADSM
 77  SQLU-ADSM-MEDIA           PIC X(1) value "A".
* vendor library
 77  SQLU-OTHER-MEDIA          PIC X(1) value "O".
* user exit
 77  SQLU-USER-EXIT            PIC X(1) value "U".
* Generated only by vendors
 77  SQLU-DISK-MEDIA           PIC X(1) value "D".
* Generated only by vendors
 77  SQLU-DISKETTE-MEDIA       PIC X(1) value "K".
* Generated only by vendors
 77  SQLU-TAPE-MEDIA           PIC X(1) value "T".
* Generated only by vendors
 77  SQLU-PIPE-MEDIA           PIC X(1) value "P".

 01 SQLU-MEDIA-LIST.
     05 SQL-MEDIA-TYPE	       PIC X.
     05 SQL-FILLER	       PIC X(3).
     05 SQL-SESSIONS	       PIC S9(9) COMP-5.
     05 SQL-TARGET.
	 10 SQL-MEDIA	       USAGE IS POINTER.
	 10 SQL-VENDOR	       REDEFINES SQL-MEDIA
			       USAGE IS POINTER.
	 10 SQL-LOCATION       REDEFINES SQL-MEDIA
			       USAGE IS POINTER.
	 10 FILLER	       REDEFINES SQL-MEDIA
			       PIC X(4).

 01 SQLUHTSP.
     05 SQL-TABLESPACE-NAME    PIC X(18).
     05 FILLER		       PIC X.
     05 SQL-FILLER	       PIC X.

 01 SQLUHINFO.
     05 SQLUHINFOID	       PIC X(8).
     05 SQLUHINFOBC	       PIC S9(9) COMP-5.
     05 SQLH-SQLN	       PIC S9(4) COMP-5.
     05 SQLH-SQLD	       PIC S9(4) COMP-5.
     05 SQL-OPERATION	       PIC X(1).
     05 FILLER		       PIC X.
     05 SQL-OBJECT	       PIC X(1).
     05 FILLER		       PIC X.
     05 SQL-OBJECT-PART        PIC X(17).
     05 FILLER		       PIC X.
     05 SQL-OPTYPE	       PIC X(1).
     05 FILLER		       PIC X.
     05 SQL-DEVICE-TYPE        PIC X(1).
     05 FILLER		       PIC X.
     05 SQL-FIRST-LOG	       PIC X(12).
     05 FILLER		       PIC X.
     05 SQL-LAST-LOG	       PIC X(12).
     05 FILLER		       PIC X.
     05 SQL-BACKUP-ID	       PIC X(14).
     05 FILLER		       PIC X.
     05 SQL-TABLE-CREATOR      PIC X(8).
     05 FILLER		       PIC X.
     05 SQL-TABLE-NAME	       PIC X(18).
     05 FILLER		       PIC X.
     05 SQL-NUM-OF-TABLESPACES PIC X(5).
     05 FILLER		       PIC X.
     05 SQL-LOCATION	       PIC X(255).
     05 FILLER		       PIC X.
     05 SQL-COMMENT	       PIC X(30).
     05 FILLER		       PIC X.
     05 SQL-TABLESPACE OCCURS 1 TIMES.
	 10 SQL-TABLESPACE-NAME PIC X(18).
	 10 FILLER	       PIC X.
	 10 SQL-FILLER	       PIC X.

* Definitions needed for the sqlb api calls
*
* nb: 'tbs' is an abbreviaton for 'TABLESPACE'

* maximum length of a table space name
 77  SQLB-MAX-TBS-NAME-SZ      PIC S9(4) COMP-5 VALUE 128.
* NB: this constant is set to the maximum size that is likely to be
* needed in future.  Don't confuse this with SQLU_MAX_TBS_NAME_LEN
* which is set to the current maximum size (18).

* Externally visibile flags of a table space
* storage manager class
* System   Managed Space
 77  SQLB-TBS-SMS	       PIC S9(4) COMP-5 VALUE 1.
* Database Managed Space
 77  SQLB-TBS-DMS	       PIC S9(4) COMP-5 VALUE 2.
* table space contents
* regular contents
 77  SQLB-TBS-ANY	       PIC S9(4) COMP-5 VALUE 0.
* long field data
 77  SQLB-TBS-LONG	       PIC S9(4) COMP-5 VALUE 32.
* temp data
 77  SQLB-TBS-TMP	       PIC S9(4) COMP-5 VALUE 16.
* other flags values
* temp table space is reserved for completion of reorg recovery
 77  SQLB-TBS-TMP-RECOVERY     PIC S9(9) COMP-5 VALUE 131072.

* The externally visible state of a table space is composed of the
* hexadecimal sum of various of the following state values.  For
* example if the state is 'quiesced exclusive' and 'load pending', the
* value would be 0x0004 + 0x0008 which is 0x000c.
*
* You may use the tool db2tbst to do the reverse calculation (from
* 0x000c to 'load pending' and 'quiesced exclusive', for example)
* which is more complex. In our example, execute:
*
*  db2tbst 0x000c
*
* which yields:
*
* State = Quiesced Exclusive
*	+ Load Pending
* Normal
 77  SQLB-NORMAL	       PIC S9(4) COMP-5 VALUE 0.
* Quiesced: SHARE
 77  SQLB-QUIESCED-SHARE       PIC S9(4) COMP-5 VALUE 1.
* Quiesced: UPDATE
 77  SQLB-QUIESCED-UPDATE      PIC S9(4) COMP-5 VALUE 2.
* Quiesced: EXCLUSIVE
 77  SQLB-QUIESCED-EXCLUSIVE   PIC S9(4) COMP-5 VALUE 4.
* Load pending
 77  SQLB-LOAD-PENDING	       PIC S9(4) COMP-5 VALUE 8.
* Delete pending
 77  SQLB-DELETE-PENDING       PIC S9(4) COMP-5 VALUE 16.
* Backup pending
 77  SQLB-BACKUP-PENDING       PIC S9(4) COMP-5 VALUE 32.
* Roll forward in progress
 77  SQLB-ROLLFORWARD-IN-PROGRESS PIC S9(4) COMP-5 VALUE 64.
* Roll forward pending
 77  SQLB-ROLLFORWARD-PENDING  PIC S9(4) COMP-5 VALUE 128.
* Restore pending
 77  SQLB-RESTORE-PENDING      PIC S9(4) COMP-5 VALUE 256.
* Recovery pending (use SQLB_RESTORE_PENDING)
 77  SQLB-RECOVERY-PENDING     PIC S9(4) COMP-5 VALUE 256.
* Disable pending
 77  SQLB-DISABLE-PENDING      PIC S9(4) COMP-5 VALUE 512.
* Reorg in progress
 77  SQLB-REORG-IN-PROGRESS    PIC S9(4) COMP-5 VALUE 1024.
* Backup in progress
 77  SQLB-BACKUP-IN-PROGRESS   PIC S9(4) COMP-5 VALUE 2048.
* storage must be defined
 77  SQLB-STORDEF-PENDING      PIC S9(4) COMP-5 VALUE 4096.
* Restore in progress
 77  SQLB-RESTORE-IN-PROGRESS  PIC S9(4) COMP-5 VALUE 8192.
* storage may be defined
 77  SQLB-STORDEF-ALLOWED      PIC S9(9) COMP-5 VALUE 33554432.
* storDef is in 'final' state
 77  SQLB-STORDEF-FINAL-VERSION PIC S9(9) COMP-5 VALUE 67108864.
* storDef was changed prior to rollforward
 77  SQLB-STORDEF-CHANGED      PIC S9(9) COMP-5 VALUE 134217728.
* dms rebalancer is active
 77  SQLB-REBAL-IN-PROGRESS    PIC S9(9) COMP-5 VALUE 268435456.
* TBS deletion in progress
 77  SQLB-PSTAT-DELETION       PIC S9(9) COMP-5 VALUE 536870912.
* TBS creation in progress
* Value of SQLB-PSTAT-CREATION is 1073741824
 01  SQLB-PSTAT-CREATION-INIT PIC X(4) VALUE x"40000000".
 01  SQLB-PSTAT-CREATION REDEFINES
     SQLB-PSTAT-CREATION-INIT PIC S9(9) COMP-5.

* Provide info about a tableSpace in a database

 77  SQLB-TBSQRY-DATA-SIZE     PIC S9(4) COMP-5 VALUE 176.
* container type
* SMS: directory path specs
 77  SQLB-CONT-PATH	       PIC S9(4) COMP-5 VALUE 0.
* DMS: a 'raw' or 'device' spec
 77  SQLB-CONT-DISK	       PIC S9(4) COMP-5 VALUE 1.
* DMS: a 'cooked file' -> file spec
 77  SQLB-CONT-FILE	       PIC S9(4) COMP-5 VALUE 2.

* provide information about the containers on which tablespaces are
* based

 77  SQLB-TBSCONTQRY-DATA-SIZE PIC S9(4) COMP-5 VALUE 292.
* provide statistics on a tablespace
* BETA NOTE: currently, we only provide stats on DMS tablespaces
* SRSFIX: determine what SMS support to ship with V2
 01 SQLB-TBS-STATS.
     05 SQL-TOTAL-PAGES        PIC 9(9) COMP-5.
     05 SQL-USEABLE-PAGES      PIC 9(9) COMP-5.
     05 SQL-USED-PAGES	       PIC 9(9) COMP-5.
     05 SQL-FREE-PAGES	       PIC 9(9) COMP-5.
     05 SQL-HIGH-WATER-MARK    PIC 9(9) COMP-5.

* all tablespaces in database
 77  SQLB-OPEN-TBS-ALL	       PIC S9(4) COMP-5 VALUE 0.
* all tablespaces my agent is restoring
 77  SQLB-OPEN-TBS-RESTORE     PIC S9(4) COMP-5 VALUE 1.
* all tablespaces where storage definition is allowed
 77  SQLB-OPEN-TBS-STORDEF     PIC S9(4) COMP-5 VALUE 2.

* constant used in place of tablespace id to indicate all table spaces
* in db
 77  SQLB-ALL-TABLESPACES      PIC S9(9) COMP-5 VALUE 65534.


 77  SQLB-SET-CONT-INIT-STATE  PIC S9(4) COMP-5 VALUE 0.
 77  SQLB-SET-CONT-FINAL-STATE PIC S9(4) COMP-5 VALUE 1.





* SQL Return Codes in SQLCODE for UTILITY/CONFIGURATION Commands

* If using the symbolic constants SQL-RC-OK and SQL-RC-INVALID-SQLCA
* ensure sql.cbl is included.

* ROLL FORWARD Return Codes - more in the 4900's

* Log Control file not found.
 77  SQLU-RC-NOLFH	       PIC S9(4) COMP-5 VALUE -1258.
* I/O Error accessing LFH.
 77  SQLU-RC-IOELFH	       PIC S9(4) COMP-5 VALUE -1259.
* DB not enabled for Roll Fwd
 77  SQLU-RC-RFNOTEN	       PIC S9(4) COMP-5 VALUE -1260.
* Roll Forward is not Pending
 77  SQLU-RC-RFNOTP	       PIC S9(4) COMP-5 VALUE -1261.
* Bad Point in Time specified
 77  SQLU-RC-BADPIT	       PIC S9(4) COMP-5 VALUE -1262.
* Invalid Log Extent file
 77  SQLU-RC-INVEXT	       PIC S9(4) COMP-5 VALUE -1263.
* Log Extent file does not belong to DB
 77  SQLU-RC-NOTEXT	       PIC S9(4) COMP-5 VALUE -1264.
* Log extent file is incorrect version
 77  SQLU-RC-IVREXT	       PIC S9(4) COMP-5 VALUE -1265.
* Time specified is before previous roll-forward time
 77  SQLU-RC-PRTIME	       PIC S9(4) COMP-5 VALUE -1266.
* User exit encountered an error (other than retry) while attempting
* to retrieve a log extent file for roll forward
 77  SQLU-RC-UEXIT-ERR	       PIC S9(4) COMP-5 VALUE -1268.
* Rollforward by tablespace in progress.
 77  SQLU-RC-RFINPRG	       PIC S9(4) COMP-5 VALUE -1269.
* Roll forward complete but I/O errors encountered
 77  SQLU-RC-RCVIOERR	       PIC S9(4) COMP-5 VALUE 1271.
* Rollforward by tablespace has stopped.
 77  SQLU-RC-RFSTOP	       PIC S9(4) COMP-5 VALUE -1272.
* Missing log extent file.
 77  SQLU-RC-MISSING-EXT       PIC S9(4) COMP-5 VALUE -1273.
* Invalid stop time for tablespace rollforward.
 77  SQLU-RC-INVTSP-STOPTIME   PIC S9(4) COMP-5 VALUE -1274.
* invalid stop time specified
 77  SQLU-INVRFR-STOPTIME      PIC S9(4) COMP-5 VALUE -1275.
* invalid time to issue a stop
 77  SQLU-INVRFR-STOP	       PIC S9(4) COMP-5 VALUE -1276.
* Restore found one or more containers are inaccessable
 77  SQLUD-INACCESSABLE-CONTAINER PIC S9(4) COMP-5 VALUE 1277.
* Restart complete but not all invalid	indexes were recreated
 77  SQL-RC-RECREATE-INDEXES   PIC S9(4) COMP-5 VALUE 1279.

* invalid client comm. protocols
 77  SQLF-RC-INV-CLIENT-COMM   PIC S9(4) COMP-5 VALUE -1290.
* invalid directory services field
 77  SQLF-RC-INV-DIR-FIELD     PIC S9(4) COMP-5 VALUE -1296.

* hostname in node dir unknown
 77  SQLCC-RC-UNKNOWN-HOST     PIC S9(4) COMP-5 VALUE -1336.
* service name in node directory is unknown
 77  SQLCC-RC-UNKNOWN-SERVICE  PIC S9(4) COMP-5 VALUE -1337.
* CPI-C symdestname is unknown
 77  SQLCC-RC-UNKNOWN-SYM-DEST-NAME PIC S9(4) COMP-5 VALUE -1338.
* wrkstn name (nname)
 77  SQLCC-RC-NNAME-NOTFOUND   PIC S9(4) COMP-5 VALUE -1341.
* SOCKS env vars not found
 77  SQLCC-RC-NO-SOCKS-ENV-VAR PIC S9(4) COMP-5 VALUE -1460.

* GENERAL UTILITY Return Codes

* Invalid output drive
 77  SQLU-BAD-DRIVE	       PIC S9(4) COMP-5 VALUE -2000.
* Backup terminated by user
 77  SQLU-USER-TERM	       PIC S9(4) COMP-5 VALUE -2001.
* database not local
 77  SQLU-NOT-LOCAL	       PIC S9(4) COMP-5 VALUE -2002.
* base op system error
 77  SQLU-DOS-ERROR	       PIC S9(4) COMP-5 VALUE -2003.
* SQL error occurred
 77  SQLU-SQL-ERROR	       PIC S9(4) COMP-5 VALUE -2004.
* read wrong # of bytes
 77  SQLU-READ-ERROR	       PIC S9(4) COMP-5 VALUE -2005.
* call out of sequence
 77  SQLU-INVALID-ACTION       PIC S9(4) COMP-5 VALUE -2008.
* insufficient memory
 77  SQLU-INSUFF-MEMORY        PIC S9(4) COMP-5 VALUE -2009.
* error in Start Using
 77  SQLU-STRD-ERROR	       PIC S9(4) COMP-5 VALUE -2010.
* error in Stop Using
 77  SQLU-STPD-ERROR	       PIC S9(4) COMP-5 VALUE -2011.
* directory Scan error
 77  SQLU-DIR-ERROR	       PIC S9(4) COMP-5 VALUE -2013.
* invalid database name
 77  SQLU-INVALID-DBNAME       PIC S9(4) COMP-5 VALUE -2015.
* invalid path in environment
 77  SQLU-INVALID-PATH	       PIC S9(4) COMP-5 VALUE -2016.
* Start Session failed
 77  SQLU-START-SESSION        PIC S9(4) COMP-5 VALUE -2017.
* invalid authorizations
 77  SQLU-INVALID-AUTHS        PIC S9(4) COMP-5 VALUE -2018.
* auto-binding failed
 77  SQLU-AUTOBIND	       PIC S9(4) COMP-5 VALUE -2019.
* conflict after auto-bind control file
 77  SQLU-TIMESTAMP	       PIC S9(4) COMP-5 VALUE -2020.
* I/O error in accessing the log
 77  SQLU-IO-ERROR-LFH	       PIC S9(4) COMP-5 VALUE -2023.
* I/O error in accessing the Backup/Restore flag file
 77  SQLU-IO-ERROR-BRG	       PIC S9(4) COMP-5 VALUE -2024.
* System I/O error occurred
 77  SQLU-IO-ERROR	       PIC S9(4) COMP-5 VALUE -2025.
* error in PAUSE the started DB
 77  SQLU-PAUSE-ERROR	       PIC S9(4) COMP-5 VALUE -2026.
* error in CONTINUE the stoped DB
 77  SQLU-CONT-ERROR	       PIC S9(4) COMP-5 VALUE -2027.
* interruption installing error
 77  SQLU-INT-INST-ERR	       PIC S9(4) COMP-5 VALUE -2028.
* user exit returned non-zero rc
 77  SQLU-UEXIT-RC	       PIC S9(4) COMP-5 VALUE -2029.

* warning to mount tape
 77  SQLU-FIRST-TAPE-WARNING   PIC S9(4) COMP-5 VALUE 2031.
* parameter to utility incorrect
 77  SQLU-INVALID-PARM	       PIC S9(4) COMP-5 VALUE -2032.
* ADSM reported error
 77  SQLU-ADSM-ERROR	       PIC S9(4) COMP-5 VALUE -2033.
* address of parameter incorrect
 77  SQLU-INVALID-PARM-ADDRESS PIC S9(4) COMP-5 VALUE -2034.
* error during nointerrupt action
 77  SQLU-NOINT-ERROR	       PIC S9(4) COMP-5 VALUE -2035.
* directory does not exist
 77  SQLU-PATH-ERROR	       PIC S9(4) COMP-5 VALUE -2036.
* unable to load ADSM
 77  SQLU-LOAD-ADSM-ERROR      PIC S9(4) COMP-5 VALUE -2037.
* database system error
 77  SQLU-DBSYSTEM-ERROR       PIC S9(4) COMP-5 VALUE -2038.
* application terminated
 77  SQLU-NO-APP-ERROR	       PIC S9(4) COMP-5 VALUE -2039.
* alias parameter error
 77  SQLU-ALIAS-ERROR	       PIC S9(4) COMP-5 VALUE -2040.
* buff_size parameter error
 77  SQLU-BUFFSIZE-ERROR       PIC S9(4) COMP-5 VALUE -2041.
* I/O error during change tape
 77  SQLU-IO-WARNING	       PIC S9(4) COMP-5 VALUE 2042.
* Spawn child process error
 77  SQLU-SPAWN-EDU-ERROR      PIC S9(4) COMP-5 VALUE -2043.
* Message queue error
 77  SQLU-QUEUE-ERROR	       PIC S9(4) COMP-5 VALUE -2044.
* Object access error
 77  SQLU-OBJECT-ACCESS-ERROR  PIC S9(4) COMP-5 VALUE -2048.
* Bad backup image
 77  SQLU-CORRUPT-IMAGE-ERROR  PIC S9(4) COMP-5 VALUE -2054.
* Unable to access memory set
 77  SQLU-MEMORY-ACCESS-ERROR  PIC S9(4) COMP-5 VALUE -2055.
* device path point to unknown device type
 77  SQLU-UNKNOWN-MEDIA-TYPE   PIC S9(4) COMP-5 VALUE -2056.
* device or file already opened by other process
 77  SQLU-MEDIA-CANNOT-BE-SHARED PIC S9(4) COMP-5 VALUE -2057.
* End of tape or file encountered during read
 77  SQLU-END-OF-MEDIA-WARNING PIC S9(4) COMP-5 VALUE 2058.
* Device is full during write
 77  SQLU-DEVICE-FULL-WARNING  PIC S9(4) COMP-5 VALUE 2059.
* Empty device or file not found during read
 77  SQLU-MEDIA-EMPTY-WARNING  PIC S9(4) COMP-5 VALUE 2060.
* Access denied due to authority level
 77  SQLU-MEDIA-ACCESS-DENIED  PIC S9(4) COMP-5 VALUE -2061.
* Access error
 77  SQLU-MEDIA-ACCESS-ERROR   PIC S9(4) COMP-5 VALUE -2062.
* Terminate last Media IO.
 77  SQLU-TERM-LAST-MEDIA-WARNING PIC S9(4) COMP-5 VALUE 2065.
* Invalid tablespace name
 77  SQLU-BAD-TABLESPACE-NAME  PIC S9(4) COMP-5 VALUE -2066.
* Could not locate media header in backup or copy image
 77  SQLU-NO-MEDIA-HEADER      PIC S9(4) COMP-5 VALUE -2068.
* Mismatch alias name from media
 77  SQLU-INCORRECT-DBALIAS    PIC S9(4) COMP-5 VALUE -2069.
* Mismatch timestamp read from media
 77  SQLU-INCORRECT-TIMESTAMP  PIC S9(4) COMP-5 VALUE -2070.

* Shared library access error
 77  SQLU-SHR-LIB-ACCESS-ERROR PIC S9(4) COMP-5 VALUE -2071.
* Bind shared library error
 77  SQLU-BIND-SHR-LIB-ERROR   PIC S9(4) COMP-5 VALUE -2072.

* Out of sequence tablespace restore
 77  SQLUD-TSP-RESTORE-OUT-OF-SEQ PIC S9(4) COMP-5 VALUE -2154.

* HISTORY TABLE Return Codes
* Changes were made to historyfile during update.
 77  SQLUH-SCAN-UPDATED-WARNING PIC S9(4) COMP-5 VALUE 2155.
* MAX # open scans exceeded
 77  SQLUH-MAX-SCANS-EXCEEDED  PIC S9(4) COMP-5 VALUE -2157.
* History file is unfixable
 77  SQLUH-DAMAGED-FILE        PIC S9(4) COMP-5 VALUE -2161.
* number of tablespaces changed
 77  SQLUH-SQLUHINFO-VARS-WARNING PIC S9(4) COMP-5 VALUE 2165.
* Entry not found on update
 77  SQLUH-ENTRY-NOT-FOUND     PIC S9(4) COMP-5 VALUE -2171.

* REORGANIZE TABLE Return Codes
* invalid authid on index name
 77  SQLUR-INVALID-AUTHID      PIC S9(4) COMP-5 VALUE -2200.
* invalid tablename syntax
 77  SQLUR-INVALID-TABLENAME   PIC S9(4) COMP-5 VALUE -2203.
* invalid tablename syntax
 77  SQLUR-INVALID-INDEXNAME   PIC S9(4) COMP-5 VALUE -2204.
* index doesn't exist
 77  SQLUR-INDEX-NOT-FOUND     PIC S9(4) COMP-5 VALUE -2205.
* invalid filepath pointer
 77  SQLUR-INVALID-FILEPATH    PIC S9(4) COMP-5 VALUE -2207.
* invalid tablespace pointer
 77  SQLUR-INVALID-TABLESPACE  PIC S9(4) COMP-5 VALUE -2208.
* table does not exist
 77  SQLUR-TABLE-NOT-FOUND     PIC S9(4) COMP-5 VALUE -2211.
* cannot reorg a view
 77  SQLUR-VIEW-ERROR	       PIC S9(4) COMP-5 VALUE -2212.
* Incorrect tablespace type
 77  SQLUR-INCORRECT-TABLESPACE PIC S9(4) COMP-5 VALUE -2213.
* insuffic authority
 77  SQLUR-INSAUTH	       PIC S9(4) COMP-5 VALUE -2214.
* SQL error commiting prev work
 77  SQLUR-SQLERR-COMPREV      PIC S9(4) COMP-5 VALUE -2215.
* SQL error during reorganization
 77  SQLUR-SQLERR-REORG        PIC S9(4) COMP-5 VALUE -2216.

* RUN STATISTICS Return Codes
* invalid authid
 77  SQLUS-INVALID-AUTHID      PIC S9(4) COMP-5 VALUE -2300.
* invalid table name
 77  SQLUS-INVALID-TABLE-NAME  PIC S9(4) COMP-5 VALUE -2301.
* invalid index pointer
 77  SQLUS-INVALID-INDEX-LIST  PIC S9(4) COMP-5 VALUE -2302.
* statsopt parameter invalid
 77  SQLUS-INVALID-STATS-OPT   PIC S9(4) COMP-5 VALUE -2303.
* sharelev parameter invalid
 77  SQLUS-INVALID-SHARE-LEV   PIC S9(4) COMP-5 VALUE -2304.
* table specified is a view
 77  SQLUS-VIEWS-NOT-ALLOWED   PIC S9(4) COMP-5 VALUE -2305.
* object doesn't exist
 77  SQLUS-OBJ-DOES-NOT-EXIST  PIC S9(4) COMP-5 VALUE -2306.
* system table not allowed
 77  SQLUS-SYS-TABLE-NOT-ALLOWED PIC S9(4) COMP-5 VALUE -2307.
* index authid invalid
 77  SQLUS-INVALID-INDEX-AUTHID PIC S9(4) COMP-5 VALUE -2308.
* index name invalid
 77  SQLUS-INVALID-INDEX-NAME  PIC S9(4) COMP-5 VALUE -2309.
* error running statistics
 77  SQLUS-ERROR-STAT	       PIC S9(4) COMP-5 VALUE -2310.
* insuffic authority for runstats
 77  SQLUS-INSAUTH	       PIC S9(4) COMP-5 VALUE -2311.
* statistics heap is too small
 77  SQLUS-STATS-HEAP-TOO-SMALL PIC S9(4) COMP-5 VALUE -2312.
* incomplete statistics collected
 77  SQLUS-PARTIAL-SUCCESS     PIC S9(4) COMP-5 VALUE 2313.

* Rst DB turn off roll fwd pend, old OS/2 API only
 77  SQLUD-RST-NOROLLFWD       PIC S9(4) COMP-5 VALUE 3.
* Old OS/2 Backup calling action values
* backup entire database
 77  SQLU-BACK-ALL	       PIC S9(4) COMP-5 VALUE 0.
* backup changes only
 77  SQLU-BACK-CHANGES	       PIC S9(4) COMP-5 VALUE 1.
* quiesce during backup
 77  SQLU-BACK-QUIESCE	       PIC S9(4) COMP-5 VALUE 2048.
* New UOW return error immed
 77  SQLU-NEW-UOW-RETURN-ERROR PIC S9(4) COMP-5 VALUE 1024.

* pause or Continue or migration error
 77  SQLU-DBM-ERROR	       PIC S9(4) COMP-5 VALUE -2014.
* Wrong diskette inserted
 77  SQLU-WRONG-DISKETTE       PIC S9(4) COMP-5 VALUE -2021.
* a specific fixed disk is full
 77  SQLU-DISK-FULL	       PIC S9(4) COMP-5 VALUE -2030.

* invalid type
 77  SQLUB-BAD-TYPE	       PIC S9(4) COMP-5 VALUE -2400.
* type must be database
 77  SQLUB-TYPE-MUSTBE-DB      PIC S9(4) COMP-5 VALUE -2401.
* insufficient auth for backup
 77  SQLUB-USER-NOT-AUTH       PIC S9(4) COMP-5 VALUE -2403.
* The target disk/diskette is full
 77  SQLUB-MEDIA-FULL	       PIC S9(4) COMP-5 VALUE -2404.
* The Backup can't run because B/R flag file existed and read I/O
* error occurred
 77  SQLUB-BR-INPROG	       PIC S9(4) COMP-5 VALUE -2407.
* Backup process is successful, but unable to delete BRG file
 77  SQLUB-DEL-BRG-ERR	       PIC S9(4) COMP-5 VALUE 2408.
* 'change-only' is only applied to the most recent base image
 77  SQLUB-WRONG-BASE-IMAGE    PIC S9(4) COMP-5 VALUE -2409.
* change only, backup not allowed to user exit
 77  SQLUB-NO-CHG-NSD	       PIC S9(4) COMP-5 VALUE -2410.
* I/O error during backup
 77  SQLUB-IO-ERROR	       PIC S9(4) COMP-5 VALUE -2411.
* Restore utility not bound
 77  SQLUD-BIND-WARNING        PIC S9(4) COMP-5 VALUE 2507.
* error dropping database
 77  SQLUD-DROP-ERROR	       PIC S9(4) COMP-5 VALUE -2511.

* BACKUP Return Codes
* The backup can't run because the Restore is in progress
 77  SQLUB-RST-IN-PROG	       PIC S9(4) COMP-5 VALUE -2405.
* The Backup can't run because roll forward is pending
 77  SQLUB-ROLLFWD-PENDING     PIC S9(4) COMP-5 VALUE -2406.
* data page encountered during backup is corrupted
 77  SQLUB-CORRUPT-PAGE        PIC S9(4) COMP-5 VALUE -2412.
* retain req'd for online backup
 77  SQLUB-LOGRETAIN-ONLINE-ERROR PIC S9(4) COMP-5 VALUE -2413.
* no space for control info
 77  SQLUB-INSUF-SPACE-WARNING PIC S9(4) COMP-5 VALUE 2414.
* tape full, mount another
 77  SQLUB-NEXT-TAPE-WARNING   PIC S9(4) COMP-5 VALUE 2416.
* database does not exist
 77  SQLUB-DBASE-DOES-NOT-EXIST PIC S9(4) COMP-5 VALUE -2418.
* disk full during backup
 77  SQLUB-DISK-FULL-ERROR     PIC S9(4) COMP-5 VALUE -2419.

* first tape cannot hold header
 77  SQLUB-FIRST-TAPE-ERROR    PIC S9(4) COMP-5 VALUE -2420.
* retain req'd for tbs backup
 77  SQLUB-LOGRETAIN-TBS-ERROR PIC S9(4) COMP-5 VALUE -2421.
* the backup API used does not support this format of database
 77  SQLUB-DB-UNSUPPORTED-BY-API PIC S9(4) COMP-5 VALUE -2422.
* A required index is missing during an offline backup
 77  SQLUB-MISSING-INDEX       PIC S9(4) COMP-5 VALUE -2423.

* RESTORE Return Codes
* can't read restored database
 77  SQLUD-CANNOT-RESTORE      PIC S9(4) COMP-5 VALUE -2501.
* error reading backup diskette
 77  SQLUD-DISKETTE-ERROR      PIC S9(4) COMP-5 VALUE -2502.
* wrong backup diskette
 77  SQLUD-WRONG-DATABASE      PIC S9(4) COMP-5 VALUE -2503.
* prompt for backup diskette
 77  SQLUD-DISKETTE-PROMPT     PIC S9(4) COMP-5 VALUE 2504.
* warn that drop will be done
 77  SQLUD-DROP-WARNING        PIC S9(4) COMP-5 VALUE 2505.
* Restore worked, but not cleanup
 77  SQLUD-DATABASE-WARNING    PIC S9(4) COMP-5 VALUE 2506.
* timestamp incorrectly specified
 77  SQLUD-INVALID-TIMESTAMP   PIC S9(4) COMP-5 VALUE -2508.
* invalid database drive
 77  SQLUD-INVALID-DBDRV       PIC S9(4) COMP-5 VALUE -2509.
* semaphore error
 77  SQLUD-SEM-ERROR	       PIC S9(4) COMP-5 VALUE -2510.
* error creating database
 77  SQLUD-CREATE-ERROR        PIC S9(4) COMP-5 VALUE -2512.
* error renaming database
 77  SQLUD-REN-ERROR	       PIC S9(4) COMP-5 VALUE -2513.
* restored database wrong version
 77  SQLUD-BAD-VERSION	       PIC S9(4) COMP-5 VALUE -2514.
* insuffic authority to restore
 77  SQLUD-INSAUTH	       PIC S9(4) COMP-5 VALUE -2515.
* a database active
 77  SQLUD-DBACT	       PIC S9(4) COMP-5 VALUE -2516.
* database migrated
 77  SQLUD-MIGRATED	       PIC S9(4) COMP-5 VALUE 2517.
* error in restoring DB config.
 77  SQLUD-RST-DBCONG-ERR      PIC S9(4) COMP-5 VALUE -2518.
* error in migrating the database
 77  SQLUD-MIGRATE-ERROR       PIC S9(4) COMP-5 VALUE -2519.
* DBCON file is restored using the backup version
 77  SQLUD-DBCON-WARN	       PIC S9(4) COMP-5 VALUE 2520.
* Restore process is successful, but unable to delete BRG file
 77  SQLUD-DEL-BRG-ERR	       PIC S9(4) COMP-5 VALUE 2521.
* more than one file match
 77  SQLUD-TOO-MANY-BACKUP-FILES PIC S9(4) COMP-5 VALUE -2522.
* corrupted backup image
 77  SQLUD-MEDIA-CORRUPT       PIC S9(4) COMP-5 VALUE -2530.
* image of wrong database
 77  SQLUD-WRGIMAGE-ERROR      PIC S9(4) COMP-5 VALUE -2532.
* image of wrong database
 77  SQLUD-WRGIMAGE-WARNING    PIC S9(4) COMP-5 VALUE 2533.
* seq number of backup incorrect
 77  SQLUD-WRONGSEQ-WARNING    PIC S9(4) COMP-5 VALUE 2536.
* roll forward required
 77  SQLUD-MUST-ROLLFWD        PIC S9(4) COMP-5 VALUE -2537.
* end of file reached unexpectedly
 77  SQLUD-UNEXPECT-EOF-ERROR  PIC S9(4) COMP-5 VALUE -2538.
* noint type restore had warning
 77  SQLUD-NOINT-WARNING       PIC S9(4) COMP-5 VALUE 2540.
* unable to close backup file
 77  SQLUD-CLOSE-MEDIA-WARNING PIC S9(4) COMP-5 VALUE 2541.
* no backup file match found
 77  SQLUD-NO-BACKUP-FILE-MATCH PIC S9(4) COMP-5 VALUE -2542.
* invalid directory for new dbase
 77  SQLUD-DB-DIR-ERROR        PIC S9(4) COMP-5 VALUE -2543.
* disk full during restore
 77  SQLUD-DISK-FULL-ERROR     PIC S9(4) COMP-5 VALUE -2544.
* restore requires first image first
 77  SQLUD-NOT-FIRST-IMAGE     PIC S9(4) COMP-5 VALUE -2546.
* cannot restore online backup from a previous release
 77  SQLUD-OLD-ONLINE-IMAGE-ERROR PIC S9(4) COMP-5 VALUE -2547.
* backup has diff codepage from disk DB
 77  SQLUD-IMAGE-DB-CP-MISMATCH PIC S9(4) COMP-5 VALUE -2548.

*************************************************************************
*  the meaning of the following 8 warnings :
*	 A -> database alias
*	 N -> database name
*	 S -> database seed
*	 0 -> target db value DOES NOT matches backup image value
*	 1 -> target db value matches backup image value
*
**************************************************************************
 77  SQLUD-A0N0S0-WARNING      PIC S9(4) COMP-5 VALUE 2529.
 77  SQLUD-A0N0S1-WARNING      PIC S9(4) COMP-5 VALUE 2528.
 77  SQLUD-A0N1S0-WARNING      PIC S9(4) COMP-5 VALUE 2525.
 77  SQLUD-A0N1S1-WARNING      PIC S9(4) COMP-5 VALUE 2524.
 77  SQLUD-A1N0S0-WARNING      PIC S9(4) COMP-5 VALUE 2527.
 77  SQLUD-A1N0S1-WARNING      PIC S9(4) COMP-5 VALUE 2526.
 77  SQLUD-A1N1S0-WARNING      PIC S9(4) COMP-5 VALUE 2523.
 77  SQLUD-A1N1S1-WARNING      PIC S9(4) COMP-5 VALUE 2539.
* restore tablespace to a non original database.
 77  SQLUD-TBLSP-TO-OTHER-DB   PIC S9(4) COMP-5 VALUE -2560.
* restore tablespace to a new data base.
 77  SQLUD-TBLSP-TO-NEW-DB     PIC S9(4) COMP-5 VALUE 2561.
* restore tablespace from full backup image.
 77  SQLUD-TBLSP-FR-FULL-BKUP  PIC S9(4) COMP-5 VALUE -2562.
* Not all tablespases were restored
 77  SQLUD-NOTALL-TBS-RESTORED PIC S9(4) COMP-5 VALUE 2563.
* Mismatch between restore image and database restored to
 77  SQLUD-DB-MISMATCH	       PIC S9(4) COMP-5 VALUE 2565.
* Problem on first media write
 77  SQLU-HEADER-WRITE-ERR     PIC S9(4) COMP-5 VALUE 2045.

* sqlgadau and sqluadau Return codes
* sql_authorizations parm is bad
 77  SQLUA-BAD-INPUT-PARAMETER PIC S9(4) COMP-5 VALUE -2600.

* IMPORT/EXPORT Return codes
* error opening output file
 77  SQLUE-DFO		       PIC S9(4) COMP-5 VALUE -3001.
* i/o error writing output file
 77  SQLUE-IOE		       PIC S9(4) COMP-5 VALUE -3002.
* i/o error closing output file
 77  SQLUE-CLS		       PIC S9(4) COMP-5 VALUE -3003.
* invalid filetype parameter
 77  SQLUE-IFT		       PIC S9(4) COMP-5 VALUE -3004.
* function interrupted
 77  SQLUE-CBI		       PIC S9(4) COMP-5 VALUE -3005.
* i/o error opening message file
 77  SQLUE-MFO		       PIC S9(4) COMP-5 VALUE -3006.
* i/o error writing message file
 77  SQLUE-MFW		       PIC S9(4) COMP-5 VALUE -3007.
* start using database failed
 77  SQLUE-STA		       PIC S9(4) COMP-5 VALUE -3008.
* invalid tcolstrg
 77  SQLUE-STR		       PIC S9(4) COMP-5 VALUE -3009.
* invalid dcoldata
 77  SQLUE-COL		       PIC S9(4) COMP-5 VALUE -3010.

* memory allocation error
 77  SQLUE-MEM		       PIC S9(4) COMP-5 VALUE -3011.
* system error
 77  SQLUE-SYSERR	       PIC S9(4) COMP-5 VALUE -3012.
* invalid filetmod
 77  SQLUE-FTMOD	       PIC S9(4) COMP-5 VALUE -3013.
* failure on closing message file
 77  SQLUE-MFC		       PIC S9(4) COMP-5 VALUE -3014.
* SQL error occurred
 77  SQLUE-SQLERR	       PIC S9(4) COMP-5 VALUE -3015.
* no keywords found
 77  SQLUE-FMODNK	       PIC S9(4) COMP-5 VALUE -3016.
* invalid delimiter or duplicate
 77  SQLUE-FMODID	       PIC S9(4) COMP-5 VALUE -3017.
* decimal used for char delimiter
 77  SQLUE-FMODDEC	       PIC S9(4) COMP-5 VALUE -3018.
* no tcolstrg
 77  SQLUE-NTS		       PIC S9(4) COMP-5 VALUE -3019.
* insufficient authority for exp.
 77  SQLUE-RC-INSAUTH	       PIC S9(4) COMP-5 VALUE -3020.

* insufficient authority for imp.
 77  SQLUI-RC-INSAUTH	       PIC S9(4) COMP-5 VALUE -3021.
* SQL error on input string
 77  SQLUE-SQL-PREP-ERR        PIC S9(4) COMP-5 VALUE -3022.
* invalid database name
 77  SQLUE-DATABASE	       PIC S9(4) COMP-5 VALUE -3023.
* invalid datafile
 77  SQLUE-DATAFILE	       PIC S9(4) COMP-5 VALUE -3025.
* invalid msgfile
 77  SQLUE-MSGFILE	       PIC S9(4) COMP-5 VALUE -3026.
* Export method indicator not n/d
 77  SQLUE-DCOLMETH	       PIC S9(4) COMP-5 VALUE -3028.
* filetype is null
 77  SQLUE-NUL-FTYPE	       PIC S9(4) COMP-5 VALUE -3029.

* error opening input data file
 77  SQLUI-DFO		       PIC S9(4) COMP-5 VALUE -3030.
* i/o error reading input file
 77  SQLUI-IOE		       PIC S9(4) COMP-5 VALUE -3031.
* Import method not n/d/p
 77  SQLUI-DCOLMETH	       PIC S9(4) COMP-5 VALUE -3032.
* invalid insert in tcolstrg
 77  SQLUI-TINSERT	       PIC S9(4) COMP-5 VALUE -3033.
* invalid into in tcolstrg
 77  SQLUI-TINTO	       PIC S9(4) COMP-5 VALUE -3034.
* invalid tablename in tcolstrg
 77  SQLUI-TABLENAME	       PIC S9(4) COMP-5 VALUE -3035.
* close paren not in tcolstrg
 77  SQLUI-CPAREN	       PIC S9(4) COMP-5 VALUE -3036.
* SQL error on insert string
 77  SQLUE-SQL-PREP-INSERT     PIC S9(4) COMP-5 VALUE -3037.
* tcolstrg invalid
 77  SQLUI-TCOLJUNK	       PIC S9(4) COMP-5 VALUE -3038.
* lob file error
 77  SQLUE-LOBFILE-ERROR       PIC S9(4) COMP-5 VALUE -3040.

* invalid dcol position for CSV
 77  SQLUIC-BAD-DCOL-POS       PIC S9(4) COMP-5 VALUE -3045.
* non-default dcol and no cols
 77  SQLUI-NONDEF-DCOL-NOCOLS  PIC S9(4) COMP-5 VALUE -3046.
* dcolinfo has invalid method
 77  SQLUI-BAD-DCOL-METH       PIC S9(4) COMP-5 VALUE -3047.
* non nullable column
 77  SQLUI-NODCOL-FOR-NONNULL-DBCOL PIC S9(4) COMP-5 VALUE -3048.
* unsupported column type
 77  SQLUIC-UNSUPTYP-NONULLS   PIC S9(4) COMP-5 VALUE -3049.

* conversion for cdpg
 77  SQLUII-CONVERSION	       PIC S9(4) COMP-5 VALUE 3050.
* too many rows for WSF export
 77  SQLUE-ROWCT-TOOBIG        PIC S9(4) COMP-5 VALUE -3053.
* eof reading first rec in IXF
 77  SQLUII-HEOF	       PIC S9(4) COMP-5 VALUE -3054.
* length of 'H' rec not numeric
 77  SQLUII-HLEN-CONV	       PIC S9(4) COMP-5 VALUE -3055.
* first record too short
 77  SQLUII-HLEN-SHORT	       PIC S9(4) COMP-5 VALUE -3056.
* first IXF rec is not 'H'
 77  SQLUII-HTYP	       PIC S9(4) COMP-5 VALUE -3057.
* no IXF identifier in 'H'
 77  SQLUII-HID 	       PIC S9(4) COMP-5 VALUE -3058.
* invalid version field in 'H'
 77  SQLUII-HVERS	       PIC S9(4) COMP-5 VALUE -3059.

* HCNT in 'H' not numeric
 77  SQLUII-HCNT	       PIC S9(4) COMP-5 VALUE -3060.
* SBCP in 'H' not numeric
 77  SQLUII-HSBCP-BAD	       PIC S9(4) COMP-5 VALUE -3061.
* DBCP in 'H' not numeric
 77  SQLUII-HDBCP-BAD	       PIC S9(4) COMP-5 VALUE -3062.
* 'H' SBCP not compat w/data SBCP
 77  SQLUII-HSBCP-CMP	       PIC S9(4) COMP-5 VALUE -3063.
* 'H' DBCP not compat w/data DBCP
 77  SQLUII-HDBCP-CMP	       PIC S9(4) COMP-5 VALUE -3064.
* can't get codepages
 77  SQLUII-DB-CODEPG	       PIC S9(4) COMP-5 VALUE -3065.
* eof reading/looking for 'T' rec
 77  SQLUII-TEOF	       PIC S9(4) COMP-5 VALUE -3066.
* length of 'T' rec not numeric
 77  SQLUII-TLEN-CONV	       PIC S9(4) COMP-5 VALUE -3067.
* 'T' record is too short
 77  SQLUII-TLEN-SHORT	       PIC S9(4) COMP-5 VALUE -3068.
* first non-'A' rec not 'T' rec
 77  SQLUII-TTYP	       PIC S9(4) COMP-5 VALUE -3069.

* invalid rec length of 'A' rec
 77  SQLUII-ALEN-BAD	       PIC S9(4) COMP-5 VALUE -3070.
* invalid data convention in 'T'
 77  SQLUII-TCONV	       PIC S9(4) COMP-5 VALUE -3071.
* invalid data format in 'T'
 77  SQLUII-TFORM	       PIC S9(4) COMP-5 VALUE -3072.
* invalid machine form in 'T'
 77  SQLUII-TMFRM	       PIC S9(4) COMP-5 VALUE -3073.
* invalid data location in 'T'
 77  SQLUII-TLOC	       PIC S9(4) COMP-5 VALUE -3074.
* 'C' rec cnt in 'T' not numeric
 77  SQLUII-TCCNT	       PIC S9(4) COMP-5 VALUE -3075.
* name len fld in 'T' not numeric
 77  SQLUII-TNAML	       PIC S9(4) COMP-5 VALUE -3076.
* too many 'C' records
 77  SQLUII-CCNT-HIGH	       PIC S9(4) COMP-5 VALUE -3077.
* length of 'A' rec not numeric
 77  SQLUII-ALEN-CONV	       PIC S9(4) COMP-5 VALUE -3078.
* length of 'C' rec not numeric
 77  SQLUII-CLEN-CONV	       PIC S9(4) COMP-5 VALUE -3079.

* 'C' record is too short
 77  SQLUII-CLEN-SHORT	       PIC S9(4) COMP-5 VALUE -3080.
* wrong rec type / 'C' expected
 77  SQLUII-CTYP	       PIC S9(4) COMP-5 VALUE -3081.
* EOF while processing 'C' recs
 77  SQLUII-CEOF	       PIC S9(4) COMP-5 VALUE -3082.
* 'D' rec id field not numeric
 77  SQLUII-CDRID	       PIC S9(4) COMP-5 VALUE -3083.
* 'D' rec posn field not numeric
 77  SQLUII-CPOSN	       PIC S9(4) COMP-5 VALUE -3084.
* 'D' id/position not consistent
 77  SQLUII-CIDPOS	       PIC S9(4) COMP-5 VALUE -3085.
* IXF column does not exist
 77  SQLUII-NOCREC-FOR-NONNULL-DBCO PIC S9(4) COMP-5 VALUE -3086.
* IXF column not valid
 77  SQLUII-INVCREC-NONNULL-DBCOL PIC S9(4) COMP-5 VALUE -3087.
* IXF column not compatible
 77  SQLUII-CRECCOMP-NONNULL-DBCOL PIC S9(4) COMP-5 VALUE -3088.
* wrong rec type / 'D' expected
 77  SQLUII-DTYP	       PIC S9(4) COMP-5 VALUE -3089.

* length of 'D' rec not numeric
 77  SQLUII-DLEN-CONV	       PIC S9(4) COMP-5 VALUE -3090.
* length of 'D' rec not valid
 77  SQLUII-DLEN-RANGE	       PIC S9(4) COMP-5 VALUE -3091.
* invalid id field in 'D' rec
 77  SQLUII-DID 	       PIC S9(4) COMP-5 VALUE -3092.
* import file not valid WSF
 77  SQLUIW-IFILE-INV	       PIC S9(4) COMP-5 VALUE -3093.
* DOS non-nullable name not found
 77  SQLUIW-NNCOL-LOST	       PIC S9(4) COMP-5 VALUE -3094.
* col position out of range
 77  SQLUIW-PCOL-INV	       PIC S9(4) COMP-5 VALUE -3095.
* unsup col type - not nullable
 77  SQLUIW-UCOLTYP-NONUL      PIC S9(4) COMP-5 VALUE -3096.
* record length invalid
 77  SQLUIW-RECLEN-INV	       PIC S9(4) COMP-5 VALUE -3097.
* row number out of range
 77  SQLUIW-INROW-INV	       PIC S9(4) COMP-5 VALUE -3098.
* col number out of range
 77  SQLUIW-INCOL-INV	       PIC S9(4) COMP-5 VALUE -3099.

* column longer than 254 chars
 77  SQLUE-COL-TOOBIG	       PIC S9(4) COMP-5 VALUE 3100.
* column has char delimiter
 77  SQLUE-DATA-CHARDEL        PIC S9(4) COMP-5 VALUE 3101.
* dcol column nbr > tcol number
 77  SQLUE-DCNUM-HIGH	       PIC S9(4) COMP-5 VALUE 3102.
* dcol column nbr < tcol number
 77  SQLUE-DCNUM-LOW	       PIC S9(4) COMP-5 VALUE 3103.
* warning message issued
 77  SQLUE-WARNING	       PIC S9(4) COMP-5 VALUE 3107.

* extra database cols
 77  SQLUI-FEWER-DCOLS-DBCOLS-NULLE PIC S9(4) COMP-5 VALUE 3112.
* column will be nulled
 77  SQLUIC-UNSUPTYP-NULLABLE  PIC S9(4) COMP-5 VALUE 3113.
* character ignored
 77  SQLUIC-IGNORED-CHAR       PIC S9(4) COMP-5 VALUE 3114.
* input CSV field too long
 77  SQLUIC-FIELD-TOO-LONG     PIC S9(4) COMP-5 VALUE 3115.
* field value missing
 77  SQLUIC-CF-REQFIELD-MISSING PIC S9(4) COMP-5 VALUE 3116.
* smallint field nulled
 77  SQLUIC-CFINT2-NULLED      PIC S9(4) COMP-5 VALUE 3117.
* smallint field error
 77  SQLUIC-CFINT2-ROWREJ      PIC S9(4) COMP-5 VALUE 3118.
* int field nulled
 77  SQLUIC-CFINT4-NULLED      PIC S9(4) COMP-5 VALUE 3119.

* int field error
 77  SQLUIC-CFINT4-ROWREJ      PIC S9(4) COMP-5 VALUE 3120.
* float field nulled
 77  SQLUIC-CFFLOAT-NULLED     PIC S9(4) COMP-5 VALUE 3121.
* float field error
 77  SQLUIC-CFFLOAT-ROWREJ     PIC S9(4) COMP-5 VALUE 3122.
* decimal field nulled
 77  SQLUIC-CFDEC-NULLED       PIC S9(4) COMP-5 VALUE 3123.
* decimal field error
 77  SQLUIC-CFDEC-ROWREJ       PIC S9(4) COMP-5 VALUE 3124.
* char field truncated
 77  SQLUIC-CFTRUNC	       PIC S9(4) COMP-5 VALUE 3125.

* char field nulled
 77  SQLUIC-CFCHAR-NULLED      PIC S9(4) COMP-5 VALUE 3126.
* char field error
 77  SQLUIC-CFCHAR-ROWREJ      PIC S9(4) COMP-5 VALUE 3127.
* date field truncated
 77  SQLUIC-CFDATETRUNC        PIC S9(4) COMP-5 VALUE 3128.
* date/time/stamp field padded
 77  SQLUIC-CFDTPAD	       PIC S9(4) COMP-5 VALUE 3129.

* time field truncated
 77  SQLUIC-CFTIMETRUNC        PIC S9(4) COMP-5 VALUE 3130.
* stamp field truncated
 77  SQLUIC-CFSTAMPTRUNC       PIC S9(4) COMP-5 VALUE 3131.
* char field truncated
 77  SQLUE-TRUNCATE	       PIC S9(4) COMP-5 VALUE 3132.
* not enough columns
 77  SQLUIC-ROWTOOSHORT        PIC S9(4) COMP-5 VALUE 3137.
* end of input data file
 77  SQLUIC-EOF-IN-CHARDELS    PIC S9(4) COMP-5 VALUE 3138.
* stop using database failed
 77  SQLUE-SQLSTPDB-ERR        PIC S9(4) COMP-5 VALUE 3139.

* WSF label too big
 77  SQLUE-WSFLAB-LEN	       PIC S9(4) COMP-5 VALUE 3142.
* WSF char type length too long
 77  SQLUE-CHAR-MTRUNC	       PIC S9(4) COMP-5 VALUE 3143.
* WSF char type length too long
 77  SQLUE-CHAR-WTRUNC	       PIC S9(4) COMP-5 VALUE 3144.
* WSF char truncated at 240
 77  SQLUE-CHAR-ITRUNC	       PIC S9(4) COMP-5 VALUE 3145.
* row count exceeds 2048
 77  SQLUE-ROWCT-LARGE	       PIC S9(4) COMP-5 VALUE 3147.
* row not inserted
 77  SQLUE-3148 	       PIC S9(4) COMP-5 VALUE 3148.

* 'H' hcnt not equal 'T' rec ccnt
 77  SQLUII-TCNTCMP	       PIC S9(4) COMP-5 VALUE 3154.
* invalid name length in 'C' rec
 77  SQLUII-CNAML	       PIC S9(4) COMP-5 VALUE 3155.
* invalid null field in 'C' rec
 77  SQLUII-CNULL	       PIC S9(4) COMP-5 VALUE 3156.
* invalid type field in 'C' rec
 77  SQLUII-CTYPE	       PIC S9(4) COMP-5 VALUE 3157.
* invalid SBCP field in 'C' rec
 77  SQLUII-CSBCP	       PIC S9(4) COMP-5 VALUE 3158.
* invalid DBCP field in 'C' rec
 77  SQLUII-CDBCP	       PIC S9(4) COMP-5 VALUE 3159.

* invalid col len fld in 'C' rec
 77  SQLUII-CLENG	       PIC S9(4) COMP-5 VALUE 3160.
* invalid precision in 'C' rec
 77  SQLUII-CPREC	       PIC S9(4) COMP-5 VALUE 3161.
* invalid scale field in 'C' rec
 77  SQLUII-CSCAL	       PIC S9(4) COMP-5 VALUE 3162.
* use 00008 for float col length
 77  SQLUII-CFLOAT-BLANKLENG   PIC S9(4) COMP-5 VALUE 3163.
* invalid float col len in 'C'.
 77  SQLUII-CFLOAT-BADLENG     PIC S9(4) COMP-5 VALUE 3164.
* 'C' record has invalid type
 77  SQLUII-CUTYPE	       PIC S9(4) COMP-5 VALUE 3165.
* IXF col does not exist
 77  SQLUII-NOCREC-FOR-NULL-DBCOL PIC S9(4) COMP-5 VALUE 3166.
* IXF col is invalid
 77  SQLUII-INVCREC-FOR-NULL-DBCOL PIC S9(4) COMP-5 VALUE 3167.
* IXF col not compatible
 77  SQLUII-CRECCOMP-NULL-DBCOL PIC S9(4) COMP-5 VALUE 3168.

* EOF found in row of data
 77  SQLUII-DEOF-INROW	       PIC S9(4) COMP-5 VALUE 3170.
* non-label cell in hdr row
 77  SQLUIW-NONLAB-HDR	       PIC S9(4) COMP-5 VALUE 3171.
* nullable colnam not found
 77  SQLUIW-NCOL-LOST	       PIC S9(4) COMP-5 VALUE 3172.
* unsup col type - nullable
 77  SQLUIW-UCOLTYP-NULL       PIC S9(4) COMP-5 VALUE 3174.
* wrong rec type for db col
 77  SQLUIW-INTYPE-INV	       PIC S9(4) COMP-5 VALUE 3175.
* date value out of range
 77  SQLUIW-DATE-INV	       PIC S9(4) COMP-5 VALUE 3176.
* time value out of range
 77  SQLUIW-TIME-INV	       PIC S9(4) COMP-5 VALUE 3177.
* int rec for time invalid
 77  SQLUIW-INTIME-INV	       PIC S9(4) COMP-5 VALUE 3178.
* no data / non nullable col
 77  SQLUIW-NODATA-NNULL       PIC S9(4) COMP-5 VALUE 3179.

* insert diskette request
 77  SQLUE-INSERT-DISK	       PIC S9(4) COMP-5 VALUE 3180.
* file ended before AE rec
 77  SQLUII-AE-NOTFOUND        PIC S9(4) COMP-5 VALUE 3181.
* retry to insert diskette
 77  SQLUII-INSERT-DISK-RETRY  PIC S9(4) COMP-5 VALUE 3182.
* mult del o'rides/no blanks
 77  SQLUEC-NOBLANK-B4KW       PIC S9(4) COMP-5 VALUE 3183.
* row of previous warning
 77  SQLUI-PREVMESG-ROWNO      PIC S9(4) COMP-5 VALUE 3185.
* log full inserting row
 77  SQLUI-LOGFULL-INSWARN     PIC S9(4) COMP-5 VALUE 3186.
* error creating index
 77  SQLUI-INDEX-WARN	       PIC S9(4) COMP-5 VALUE 3187.
* error truncating table
 77  SQLUI-TRUNCATE-TABLE      PIC S9(4) COMP-5 VALUE -3188.

* invalid INDEXIXF option
 77  SQLUI-INDEXIXF	       PIC S9(4) COMP-5 VALUE -3190.
* cannot import to this view
 77  SQLUI-VIEW-ERROR	       PIC S9(4) COMP-5 VALUE -3193.
* cannot import system table
 77  SQLUI-SYSTBL-ERROR        PIC S9(4) COMP-5 VALUE -3194.
* not enough space
 77  SQLUE-RETRY-DISK	       PIC S9(4) COMP-5 VALUE 3195.
* input file not found
 77  SQLUI-IN-NOTFD	       PIC S9(4) COMP-5 VALUE -3196.
* import/export in use
 77  SQLUI-IMPBUSY	       PIC S9(4) COMP-5 VALUE -3197.

* cant replace parent table
 77  SQLUI-REPL-PAR	       PIC S9(4) COMP-5 VALUE -3201.
* cant update without PK's
 77  SQLUI-IUOPT-NOPK	       PIC S9(4) COMP-5 VALUE -3203.
* cant update views
 77  SQLUI-IUOPT-NOVIEW        PIC S9(4) COMP-5 VALUE -3204.
* cant replace ref cons view
 77  SQLUI-VIEW-REF	       PIC S9(4) COMP-5 VALUE -3205.
* cant replace subquery view
 77  SQLUI-VIEW-SQUERY	       PIC S9(4) COMP-5 VALUE -3206.

* AIX req next file
 77  SQLUE-PROVIDE-FILE-PART   PIC S9(4) COMP-5 VALUE 3220.
* start commit
 77  SQLUI-START-COMMIT        PIC S9(4) COMP-5 VALUE 3221.
* finish commit
 77  SQLUI-FINISH-COMMIT       PIC S9(4) COMP-5 VALUE 3222.
* bad input parms
 77  SQLUI-BAD-STRUCT-PARM     PIC S9(4) COMP-5 VALUE -3223.
* restartcnt too big
 77  SQLUI-SKIPPED-ALL-ROWS    PIC S9(4) COMP-5 VALUE -3225.
* compound=x error
 77  SQLUI-COMPOUND-ERR        PIC S9(4) COMP-5 VALUE -3250.

* row/col sequence invalid
 77  SQLUIW-RCSEQ-INV	       PIC S9(4) COMP-5 VALUE -3300.
* BOF in middle of WSF file
 77  SQLUIW-BOF-INV	       PIC S9(4) COMP-5 VALUE -3301.
* unexpected EOF
 77  SQLUIW-EARLY-EOF	       PIC S9(4) COMP-5 VALUE -3302.
* filetype not ixf
 77  SQLUI-IXFONLY	       PIC S9(4) COMP-5 VALUE -3303.
* table does not exist
 77  SQLUI-DELTABLE	       PIC S9(4) COMP-5 VALUE -3304.
* table already exists
 77  SQLUI-CREATE-ERR	       PIC S9(4) COMP-5 VALUE -3305.
* SQL error during insert
 77  SQLUI-EXECUTE-ERR	       PIC S9(4) COMP-5 VALUE -3306.
* incomplete col info
 77  SQLUI-INC-COL	       PIC S9(4) COMP-5 VALUE -3307.
* codepage mismatch
 77  SQLUI-CP-MISMATCH	       PIC S9(4) COMP-5 VALUE -3308.
* double byte data found
 77  SQLUI-DBLDATA	       PIC S9(4) COMP-5 VALUE -3309.

* unrec col type
 77  SQLUI-UNREC-CTYPE	       PIC S9(4) COMP-5 VALUE -3310.
* invalid IXF column
 77  SQLUI-INVCREC-FOR-CREATE  PIC S9(4) COMP-5 VALUE -3310.

* disk full - OS/2
 77  SQLUE-DISK-FULL-DB2OS2    PIC S9(4) COMP-5 VALUE -3313.
* disk full - Windows NT
 77  SQLUE-DISK-FULL-DB2NT     PIC S9(4) COMP-5 VALUE -3313.
* disk full - DOS
 77  SQLUE-DISK-FULL-DB2DOS    PIC S9(4) COMP-5 VALUE -3313.
* disk full - Windows
 77  SQLUE-DISK-FULL-DB2WIN    PIC S9(4) COMP-5 VALUE -3313.
* disk full - AIX
 77  SQLUE-DISK-FULL-DB2AIX    PIC S9(9) COMP-5 VALUE -10018.
* disk full - MacOS
 77  SQLUE-DISK-FULL-DB2MAC    PIC S9(4) COMP-5 VALUE -3313.

 77  SQLUE-DISK-FULL	       PIC S9(4) COMP-5 VALUE -3313.

* 'A' data/ time not as 'H'.
 77  SQLUII-ASTAMP-NOMATCH     PIC S9(4) COMP-5 VALUE -3314.
* invalid volume info
 77  SQLUII-ACREC-BADVOL       PIC S9(4) COMP-5 VALUE -3315.
* error closing IXF file
 77  SQLUII-CLOSE-NOTLAST      PIC S9(4) COMP-5 VALUE -3316.
* conflict in filetmod
 77  SQLUW-FTMOD-INV	       PIC S9(4) COMP-5 VALUE -3317.
* keyword repeated/filetmod
 77  SQLUEC-DUP-KEYWORD        PIC S9(4) COMP-5 VALUE -3318.
* error creating table
 77  SQLUI-ERR-CREATETAB       PIC S9(4) COMP-5 VALUE -3319.

* keyword at end of filetmod
 77  SQLUEC-NOROOM-AFTERKW     PIC S9(4) COMP-5 VALUE -3320.
* circular log full
 77  SQLUI-LOGFULL-INSERR      PIC S9(4) COMP-5 VALUE -3321.
* semaphore error
 77  SQLUE-SEM-ERROR	       PIC S9(4) COMP-5 VALUE -3322.
* column type invalid
 77  SQLUE-INVCOLTYPE	       PIC S9(4) COMP-5 VALUE -3324.
* ignored WSF row
 77  SQLUEW-IGNORED-ROW        PIC S9(4) COMP-5 VALUE 3325.
* column list invalid
 77  SQLUI-COL-LIST	       PIC S9(4) COMP-5 VALUE -3326.
* system error
 77  SQLUEI-SYSERROR	       PIC S9(4) COMP-5 VALUE -3327.

* odd leng char -> graphic
 77  SQLUII-ODD2GRAPH	       PIC S9(4) COMP-5 VALUE 3330.
* permission denied
 77  SQLUE-OEACCESS	       PIC S9(4) COMP-5 VALUE -3331.
* too many files open
 77  SQLUE-OEMFILE	       PIC S9(4) COMP-5 VALUE -3332.
* no such file or directory
 77  SQLUE-OENOENT	       PIC S9(4) COMP-5 VALUE -3333.
* not enough memory
 77  SQLUE-OENOMEM	       PIC S9(4) COMP-5 VALUE -3334.
* no space left
 77  SQLUE-OENOSPC	       PIC S9(4) COMP-5 VALUE -3335.

* invalid method for ASC
 77  SQLUIA-BAD-DCOL-METH      PIC S9(4) COMP-5 VALUE -3400.
* invalid import method
 77  SQLUI-DCOLM-ALL	       PIC S9(4) COMP-5 VALUE -3401.
* zeroes as begin/end
 77  SQLUIA-NULLLOC	       PIC S9(4) COMP-5 VALUE -3402.
* invalid pair
 77  SQLUIA-LOCPAIR	       PIC S9(4) COMP-5 VALUE -3403.
* invalid pair for number
 77  SQLUIA-LOCNUM	       PIC S9(4) COMP-5 VALUE -3404.
* invalid pair for date
 77  SQLUIA-LOCDATE	       PIC S9(4) COMP-5 VALUE -3405.
* invalid pair for time
 77  SQLUIA-LOCTIME	       PIC S9(4) COMP-5 VALUE -3406.
* invalid pair for timestamp
 77  SQLUIA-LOCSTAMP	       PIC S9(4) COMP-5 VALUE -3407.
* pair defines long field
 77  SQLUIA-LOCLONG	       PIC S9(4) COMP-5 VALUE 3408.
* pair defines short field
 77  SQLUIA-LOCSHORT	       PIC S9(4) COMP-5 VALUE 3409.
* invalid pair for graphic
 77  SQLUIA-LOCODD	       PIC S9(4) COMP-5 VALUE -3410.
* value not graphic--null
 77  SQLUIA-CFGRAPH-NULLED     PIC S9(4) COMP-5 VALUE 3411.
* value not graphic--not null
 77  SQLUIA-CFGRAPH-ROWREJ     PIC S9(4) COMP-5 VALUE 3412.
* field too short--nulled
 77  SQLUIA-SHORTFLDNULLED     PIC S9(4) COMP-5 VALUE 3413.

* number of warnings hit threshold
 77  SQLU-TOO-MANY-WARNINGS    PIC S9(4) COMP-5 VALUE 3502.
* number of rows hit threshold
 77  SQLU-ROWCNT	       PIC S9(4) COMP-5 VALUE 3503.
* reclen > 32767
 77  SQLULA-INVALID-RECLEN     PIC S9(4) COMP-5 VALUE -3505.
* null ind value not Y or N
 77  SQLULA-NULLIND-IGNORED    PIC S9(4) COMP-5 VALUE 3506.
* nullind column is invalid
 77  SQLUI-NULLIND	       PIC S9(4) COMP-5 VALUE -3507.
* file access error during load
 77  SQLUL-FILE-ERROR	       PIC S9(4) COMP-5 VALUE -3508.
* num of row deleted after load
 77  SQLUL-NUM-ROW-DELETED     PIC S9(4) COMP-5 VALUE 3509.
* work directory is invalid
 77  SQLU-SORT-WORK-DIR-ERROR  PIC S9(4) COMP-5 VALUE -3510.
* lobfile missing but nullable col
 77  SQLU-NB-LOBFILE-MISSING   PIC S9(4) COMP-5 VALUE 3511.
* lobfile missing, nonnullable col
 77  SQLU-NNB-LOBFILE-MISSING  PIC S9(4) COMP-5 VALUE 3512.
* codepage doesn't match db
 77  SQLUL-UNMATCHED-CODEPAGE  PIC S9(4) COMP-5 VALUE -3513.
* system error with reason code
 77  SQLUL-SYSERR-WITH-REASON  PIC S9(4) COMP-5 VALUE -3514.
* unexpected rec in db2cs
 77  SQLUL-UNEXPECTED-RECORD   PIC S9(4) COMP-5 VALUE -3517.
* coltype incompatible for db2cs
 77  SQLUL-INCOMPATIBLE-TABLE  PIC S9(4) COMP-5 VALUE -3518.
* missing file
 77  SQLUL-FILE-NOT-FOUND      PIC S9(4) COMP-5 VALUE -3521.
* copy spec, no logretain/userexit
 77  SQLUL-COPY-LOGRETAIN-OFF  PIC S9(4) COMP-5 VALUE -3522.
* no messages to be retrieved
 77  SQLUL-NO-MESSAGES	       PIC S9(4) COMP-5 VALUE 3523.
* freespace option invalid
 77  SQLUL-FREESPACE-OPT       PIC S9(4) COMP-5 VALUE -3524.
* incompatible options
 77  SQLU-INCOMPAT-OPT	       PIC S9(4) COMP-5 VALUE -3525.
* mount new tape
 77  SQLU-NEXT-TAPE-WARNING    PIC S9(4) COMP-5 VALUE 3700.
* no lobs/longs but lobpath nonull
 77  SQLU-LOBPATHS-IGNORED     PIC S9(4) COMP-5 VALUE 3701.
* device error but ignored
 77  SQLU-DEVICE-IGNORED       PIC S9(4) COMP-5 VALUE 3702.
* invalid number of buffers
 77  SQLU-NUM-BUFFERS	       PIC S9(4) COMP-5 VALUE -3704.
* invalid load/unload buffer size
 77  SQLU-BUFFER-SIZE-ERROR    PIC S9(4) COMP-5 VALUE -3705.
* copy target full
 77  SQLUL-DISK-FULL	       PIC S9(4) COMP-5 VALUE -3706.
* invalid sort buffer size
 77  SQLU-SORT-BUFFSIZE-ERROR  PIC S9(4) COMP-5 VALUE -3707.

* Load / unload / load recovery SQLCODES
 77  SQLU-OPEN-COPY-LOC-FILE-ERROR PIC S9(4) COMP-5 VALUE -3783.
 77  SQLU-INV-COPY-LOC-FILE-INPUT PIC S9(4) COMP-5 VALUE -3784.
 77  SQLU-LOAD-RECOVERY-FAILED PIC S9(4) COMP-5 VALUE -3785.
 77  SQLU-INVALID-PARM-WARNING PIC S9(4) COMP-5 VALUE 3798.
 77  SQLU-LOAD-RECOVERY-PENDING PIC S9(4) COMP-5 VALUE 3799.

* load recovery - copy location input error type
 77  SQLU-KEYWORD-CODE	       PIC S9(4) COMP-5 VALUE 1.
 77  SQLU-OVERRIDE-CODE        PIC S9(4) COMP-5 VALUE 2.
 77  SQLU-UNEXPECTED-EOF-CODE  PIC S9(4) COMP-5 VALUE 3.
 77  SQLU-IOERROR-CODE	       PIC S9(4) COMP-5 VALUE 4.

* Loadapi SQLCODES
 77  SQLU-INVALID-QUIESCEMODE  PIC S9(4) COMP-5 VALUE -3802.
 77  SQLU-INVALID-INDEX        PIC S9(4) COMP-5 VALUE -3804.
 77  SQLU-INVALID-LOADAPI-ACTION PIC S9(4) COMP-5 VALUE -3805.
 77  SQLU-CONSTRAINTS-NOT-OFF  PIC S9(4) COMP-5 VALUE -3806.
 77  SQLU-NO-LIFEBOAT	       PIC S9(4) COMP-5 VALUE -3414.

* Export SQLCODES
* Export message
 77  SQLUE-MSG		       PIC S9(4) COMP-5 VALUE -3999.

* Roll-Forward Recovery SQLCODES
* invalid parameter
 77  SQLU-INVALID-PARAM        PIC S9(4) COMP-5 VALUE -4904.
* invalid parameter range
 77  SQLU-INVALID-RANGE        PIC S9(4) COMP-5 VALUE -4905.

* Configuration SQLCODES
* only SYSADM_GROUP can change db2 configuration file
 77  SQLF-RC-SYSAUTH	       PIC S9(4) COMP-5 VALUE -5001.
* system error
 77  SQLF-RC-SYSERR	       PIC S9(4) COMP-5 VALUE -5005.
* path name error
 77  SQLF-RC-PATHNAME	       PIC S9(4) COMP-5 VALUE -5010.
* invalid node name
 77  SQLF-RC-INVNODENAME       PIC S9(4) COMP-5 VALUE -5020.
* invalid system flag
 77  SQLF-RC-INVSYSIDX	       PIC S9(4) COMP-5 VALUE -5021.
* invalid database flag
 77  SQLF-RC-INVDBIDX	       PIC S9(4) COMP-5 VALUE -5022.
* not current db2 configuration
 77  SQLF-RC-KCON	       PIC S9(4) COMP-5 VALUE -5025.
* invalid sysadm_group
 77  SQLF-RC-INVSYSADM	       PIC S9(4) COMP-5 VALUE -5028.
* invalid release number
 77  SQLF-RC-REL	       PIC S9(4) COMP-5 VALUE -5030.
* database needs migration; release number is back-level
 77  SQLF-RC-NEEDMIG	       PIC S9(4) COMP-5 VALUE -5035.

* insufficient memory to support stack switching
 77  SQLF-RC-INSMEM	       PIC S9(4) COMP-5 VALUE -5047.
* invalid db2 configuration file
 77  SQLF-RC-SYSCSUM	       PIC S9(4) COMP-5 VALUE -5050.
* invalid db configuration file
 77  SQLF-RC-DBCSUM	       PIC S9(4) COMP-5 VALUE -5055.
* invalid token parameter
 77  SQLF-RC-INVTKN	       PIC S9(4) COMP-5 VALUE -5060.
* invalid ptr to sqlfupd
 77  SQLF-RC-INVTKN-STRUCT     PIC S9(4) COMP-5 VALUE -5061.
* invalid token ptr value
 77  SQLF-RC-INVTKN-PTR        PIC S9(4) COMP-5 VALUE -5062.
* invalid node type
 77  SQLF-RC-INVNT	       PIC S9(4) COMP-5 VALUE -5065.
* invalid count parameter
 77  SQLF-RC-CNTINV	       PIC S9(4) COMP-5 VALUE -5070.
* interrupt received
 77  SQLF-RC-CNTBRK	       PIC S9(4) COMP-5 VALUE -5075.
* invalid initial log size
 77  SQLF-RC-INVILF	       PIC S9(4) COMP-5 VALUE -5083.

* invalid logfile extention
 77  SQLF-RC-INVLFE	       PIC S9(4) COMP-5 VALUE -5091.
* invalid # of log extention
 77  SQLF-RC-INVNLE	       PIC S9(4) COMP-5 VALUE -5092.
* invalid new log path
 77  SQLF-RC-INVNEWLOGP        PIC S9(4) COMP-5 VALUE -5099.

* incompatible logfile parameter
 77  SQLF-RC-INVDB1	       PIC S9(4) COMP-5 VALUE -5101.
* invalid bit value - must be 0 or 1
 77  SQLF-RC-INV-BIT-VALUE     PIC S9(4) COMP-5 VALUE -5112.

* both R1 & R3 Log parameters may not be modified
 77  SQLF-RC-LF-1-3	       PIC S9(4) COMP-5 VALUE -5120.
* invalid DB configuration details
 77  SQLF-RC-INVDETS	       PIC S9(4) COMP-5 VALUE -5121.
* database is copy protected
 77  SQLF-RC-PROTECT	       PIC S9(4) COMP-5 VALUE -5122.
* I/O Error with log header
 77  SQLF-RC-LOGIO	       PIC S9(4) COMP-5 VALUE -5123.
* invalid db2 config file entry
 77  SQLF-RC-INV-DBMENT        PIC S9(4) COMP-5 VALUE -5126.
* integer out of range
 77  SQLF-RC-INV-RANGE	       PIC S9(4) COMP-5 VALUE -5130.
* integer out of range (-1)
 77  SQLF-RC-INV-RANGE-2       PIC S9(4) COMP-5 VALUE -5131.
* string null or too long
 77  SQLF-RC-INV-STRING        PIC S9(4) COMP-5 VALUE -5132.
* char/int not in set
 77  SQLF-RC-INV-SET	       PIC S9(4) COMP-5 VALUE -5133.
* tpname not valid
 77  SQLF-RC-INVTPNAME	       PIC S9(4) COMP-5 VALUE -5134.
* maxappls*maxlocks too low
 77  SQLF-RC-LOW-APPLS-AND-LOCKS PIC S9(4) COMP-5 VALUE -5135.
* dftdbpath not valid
 77  SQLF-RC-INV-DBPATH        PIC S9(4) COMP-5 VALUE -5136.
* diagpath not valid
 77  SQLF-RC-INV-DIAGPATH      PIC S9(4) COMP-5 VALUE -5137.
* To many items on update or get
 77  SQLF-RC-MAX-ITEMS-EXCEEDED PIC S9(4) COMP-5 VALUE -5139.
* invalid authentication
 77  SQLF-RC-INV-AUTHENTICATION PIC S9(4) COMP-5 VALUE -5140.
* invalid AVG_APPLS
 77  SQLF-RC-INV-AVG-APPLS     PIC S9(4) COMP-5 VALUE -5141.
* invalid agent priority
 77  SQLF-RC-INV-AGENTPRI      PIC S9(4) COMP-5 VALUE -5131.
* out of range - maximum limited by an expression
 77  SQLF-RC-INV-RANGE-MAX-EXPR PIC S9(4) COMP-5 VALUE -5144.
* out of range - maximum limited by an expression (range includes -1)
 77  SQLF-RC-INV-RANGE-MAX-EXPR-2 PIC S9(4) COMP-5 VALUE -5145.
* out of range - minimum limited by an expression
 77  SQLF-RC-INV-RANGE-MIN-EXPR PIC S9(4) COMP-5 VALUE -5146.
* out of range - minimum limited by an expression (range includes -1)
 77  SQLF-RC-INV-RANGE-MIN-EXPR-2 PIC S9(4) COMP-5 VALUE -5147.

* Repository for obsolete Return Codes

* wrote wrong # of bytes
 77  SQLU-WRITE-ERROR	       PIC S9(4) COMP-5 VALUE -2006.
* error in Start Using
 77  SQLU-CONNECT-ERROR        PIC S9(4) COMP-5 VALUE -2010.
* error in ints
 77  SQLU-INT-ERROR	       PIC S9(4) COMP-5 VALUE -2012.
* media header not present
 77  SQLUD-NO-MHEADER-ERROR    PIC S9(4) COMP-5 VALUE -2531.
* media header missing
 77  SQLUD-NO-MHEADER-WARNING  PIC S9(4) COMP-5 VALUE 2534.
* another tape mount required
 77  SQLUD-NEXT-TAPE-WARNING   PIC S9(4) COMP-5 VALUE 2535.
* waiting for ADSM server to access data on removable media
 77  SQLUD-ADSM-MOUNT-WAIT     PIC S9(4) COMP-5 VALUE 2545.

*************************************************************************
* Configuration parameter obsolete return codes defines -
* Some configuration parameters had specific out of range return
* codes; these have been replaced by generic out of range messages
* In these cases the old token names for the specific return codes
* are given, but the values are replaced by the new values returned
* when out of range.
**************************************************************************

* only SYSADM can changedatabase configuration file
 77  SQLF-RC-DBAUTH	       PIC S9(4) COMP-5 VALUE -5002.
* invalid # of concurrent db
 77  SQLF-RC-INVNDB	       PIC S9(4) COMP-5 VALUE -5130.
* invalid req I/O blk size
 77  SQLF-RC-INVRIO	       PIC S9(4) COMP-5 VALUE -5130.
* invalid serv I/O blk size
 77  SQLF-RC-INVSIO	       PIC S9(4) COMP-5 VALUE -5015.
* invalid communications heap
 77  SQLF-RC-INVCHEAP	       PIC S9(4) COMP-5 VALUE -5016.
* invalid remote services heap
 77  SQLF-RC-INVRSHEAP	       PIC S9(4) COMP-5 VALUE -5017.
* invalid sort heap threshold
 77  SQLF-RC-INVSHPTHR	       PIC S9(4) COMP-5 VALUE -5130.
* invalid DB2COMM value
 77  SQLCC-RC-BAD-DB2COMM      PIC S9(4) COMP-5 VALUE -5036.
* service name not definein db2 config file
 77  SQLCC-RC-NO-SERV-IN-DBMCFG PIC S9(4) COMP-5 VALUE -5037.
* service name not found in/etc/services file
 77  SQLCC-RC-SERV-NOT-FOUND   PIC S9(4) COMP-5 VALUE -5038.
* interrupt port not found in/etc/services file
 77  SQLCC-RC-INT-PORT-NOT-FOUND PIC S9(4) COMP-5 VALUE -5039.
* socket address in use
 77  SQLCC-RC-SOCKADDR-IN-USE  PIC S9(4) COMP-5 VALUE -5040.
* trans program name not definedin db2 configuration file
 77  SQLCC-RC-NO-TPN-IN-DBMCFG PIC S9(4) COMP-5 VALUE -5041.
* general failure in servercommunications support
 77  SQLCC-RC-COMM-SUPPORT-FAILED PIC S9(4) COMP-5 VALUE -5042.
* invalid # of locklist
 77  SQLF-RC-INVNLL	       PIC S9(4) COMP-5 VALUE -5130.
* invalid # bufr pool pages
 77  SQLF-RC-INVNBP	       PIC S9(4) COMP-5 VALUE -5130.
* invalid # of DB files open
 77  SQLF-RC-INVNDBF	       PIC S9(4) COMP-5 VALUE -5130.
* invalid soft check point value
 77  SQLF-RC-INVSCP-DB2OS2     PIC S9(4) COMP-5 VALUE -5130.
* invalid soft check point value
 77  SQLF-RC-INVSCP-DB2AIX     PIC S9(4) COMP-5 VALUE -5130.
* invalid soft check point value
 77  SQLF-RC-INVSCP	       PIC S9(4) COMP-5 VALUE -5130.
* invalid # of active appls
 77  SQLF-RC-INVNAP	       PIC S9(4) COMP-5 VALUE -5130.
* invalid application heapsz
 77  SQLF-RC-INVAHP	       PIC S9(4) COMP-5 VALUE -5130.
* invalid database heap size
 77  SQLF-RC-INVDHP	       PIC S9(4) COMP-5 VALUE -5130.
* invalid deadlock detection
 77  SQLF-RC-INVDLT	       PIC S9(4) COMP-5 VALUE -5130.
* invalid # of total files openper application
 77  SQLF-RC-INVTAF	       PIC S9(4) COMP-5 VALUE -5130.
* invalid sortlist heap
 77  SQLF-RC-INVSHP	       PIC S9(4) COMP-5 VALUE -5130.
* invalid maxlocks per application
 77  SQLF-RC-INVMAL	       PIC S9(4) COMP-5 VALUE -5130.
* invalid statement heap
 77  SQLF-RC-INVSTMHP	       PIC S9(4) COMP-5 VALUE -5130.
* invalid number primary log files
 77  SQLF-RC-INVLOGPRIM        PIC S9(4) COMP-5 VALUE -5130.
* invalid number of secondary log files
 77  SQLF-RC-INVLOG2ND	       PIC S9(4) COMP-5 VALUE -5130.
* invalid log file size
 77  SQLF-RC-INVLOGFSZ	       PIC S9(4) COMP-5 VALUE -5130.
* incompatible file open parmeter
 77  SQLF-RC-INVDB2	       PIC S9(4) COMP-5 VALUE -5102.
* no DB's / requestor only
 77  SQLF-RC-INVK2	       PIC S9(4) COMP-5 VALUE -5104.
* standalone nodetype does notsupport nodename
 77  SQLF-RC-INVK3	       PIC S9(4) COMP-5 VALUE -5126.
* remote workstation has alreadybeen configured
 77  SQLF-RC-RWS-EXIST	       PIC S9(4) COMP-5 VALUE -5106.
* <authid> does not haveauthority to add or drop a remote workstation
 77  SQLF-RC-RWS-SYSADM        PIC S9(4) COMP-5 VALUE -5107.
* remote workstation has notbeen previously setup using sqlarws
 77  SQLF-RC-RWS-NOT-EXIST     PIC S9(4) COMP-5 VALUE -5108.
* machine name is missing ors too long.
 77  SQLF-RC-RWS-MACHINENAME   PIC S9(4) COMP-5 VALUE -5109.
* configuration option is invalid
 77  SQLF-RC-RWS-INV-OPT       PIC S9(4) COMP-5 VALUE -5110.
* environment variableDB2WKSTPROF is not defined
 77  SQLF-RC-ENV-VAR-NOTDEF    PIC S9(4) COMP-5 VALUE -5111.
* incompatible buffer pool and maximum # of applications
 77  SQLF-RC-INVDB3	       PIC S9(4) COMP-5 VALUE -5146.
* invalid QUERY_HEAP_SZ
 77  SQLF-RC-INV-QUERY-HEAP-SZ PIC S9(4) COMP-5 VALUE -5143.
* out of range - limited by a parm
 77  SQLF-RC-INV-RANGE-3       PIC S9(4) COMP-5 VALUE -5144.

* obsolete database manager configuration parameter tokens
 77  SQLF-KTN-SVRIOBLK	       PIC S9(4) COMP-5 VALUE 3.
 77  SQLF-KTN-SQLENSEG	       PIC S9(4) COMP-5 VALUE 5.
 77  SQLF-KTN-COMHEAPSZ        PIC S9(4) COMP-5 VALUE 8.
 77  SQLF-KTN-RSHEAPSZ	       PIC S9(4) COMP-5 VALUE 9.
 77  SQLF-KTN-NUMRC	       PIC S9(4) COMP-5 VALUE 10.
 77  SQLF-KTN-CUINTERVAL       PIC S9(4) COMP-5 VALUE 14.
 77  SQLF-KTN-COMHEAPSZ-P      PIC S9(4) COMP-5 VALUE 50.
 77  SQLF-KTN-RSHEAPSZ-P       PIC S9(4) COMP-5 VALUE 51.
 77  SQLF-KTN-IPX-FILESERVER   PIC S9(4) COMP-5 VALUE 47.
 77  SQLF-KTN-IPX-OBJECTNAME   PIC S9(4) COMP-5 VALUE 48.

* obsolete database configuration parameter tokens
 77  SQLF-DBTN-LOGFILE	       PIC S9(4) COMP-5 VALUE 4.
 77  SQLF-DBTN-MAXTOTFILOP     PIC S9(4) COMP-5 VALUE 10.
 77  SQLF-DBTN-LOGEXT	       PIC S9(4) COMP-5 VALUE 12.
 77  SQLF-DBTN-LOGMAXEXT       PIC S9(4) COMP-5 VALUE 13.
 77  SQLF-DBTN-AGENTHEAP       PIC S9(4) COMP-5 VALUE 14.
 77  SQLF-DBTN-SEGPAGES        PIC S9(4) COMP-5 VALUE 123.
 77  SQLF-DBTN-BUFFPAGE        PIC S9(4) COMP-5 VALUE 2.
 77  SQLF-DBTN-SORTHEAP        PIC S9(4) COMP-5 VALUE 91.
 77  SQLF-DBTN-SORTHEAPSZ-P    PIC S9(4) COMP-5 VALUE 52.
 77  SQLF-DBTN-DBHEAP-P        PIC S9(4) COMP-5 VALUE 50.
 77  SQLF-DBTN-APPLHEAPSZ-P    PIC S9(4) COMP-5 VALUE 51.
 77  SQLF-DBTN-STMTHEAPSZ-P    PIC S9(4) COMP-5 VALUE 53.


* Repository for obsolete prototypes

*************************************************************************
*
* The following functions and symbols are obsolete and may not be supporte
* in future releases. The obsolete functions are provided for backward com
* and exported from DB2API.LIB. All applications should be migrated to use
* Note: Some of the function parameters may be NO-OP.
*
**************************************************************************
* invalid into in tcolstrg
 77  SQL-SLQUI-TINTO	       PIC S9(4) COMP-5 VALUE -3034.
*************************************************************************
*
* End of obsolete functions and symbols
*
**************************************************************************