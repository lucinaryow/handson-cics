******************************************************************
*
*  Source File Name = SQLMONCT.CBL
*
*  (C) Copyright IBM Corp. 1993,1995
*  All Rights Reserved
*  Licensed Material - Program Property of IBM
*
*  US Government Users Restricted Rights - Use, duplication or
*  disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*
*  Function = Copy File defining:
*		DB Monitor Constants
*		DB Monitor External APIs
*		DB Monitor Error Messages
*		DB Monitor Local Structures
*
******************************************************************

******************************************************************
* Database Monitor Version Constants
******************************************************************

 77 SQLM-DBMON-VERSION1        PIC S9(4) COMP-5 VALUE 1.
 77 SQLM-DBMON-VERSION2        PIC S9(4) COMP-5 VALUE 2.


******************************************************************
* Snapshot Monitor Collected Information types
* Structure identifier in Snapshot buffer (info_type element)
******************************************************************

 77 SQLM-DB2-SS                PIC X(1) VALUE "1".
*DB2 information

 77 SQLM-DBASE-SS              PIC X(1) VALUE "2".
*Database information

 77 SQLM-APPL-SS               PIC X(1) VALUE "3".
*Application information

 77 SQLM-APPLINFO-SS           PIC X(1) VALUE "4".
*Summary Application information

 77 SQLM-TABLE-HEADER-SS       PIC X(1) VALUE "5".
*Table information

 77 SQLM-TABLE-SS              PIC X(1) VALUE "6".
*Table information

 77 SQLM-DBASE-LOCK-SS         PIC X(1) VALUE "7".
*Lock information

 77 SQLM-APPL-LOCK-SS          PIC X(1) VALUE "8".
*Lock information

 77 SQLM-LOCK-SS               PIC X(1) VALUE "9".
*Lock information

 77 SQLM-DCS-APPLINFO-SS       PIC X(1) VALUE "A".
*Lock information

 77 SQLM-TABLESPACE-HEADER-SS  PIC X(1) VALUE "B".
*Tablespace Header information

 77 SQLM-TABLESPACE-SS         PIC X(1) VALUE "C".
*Tablespace information

******************************************************************
* level of data to collect
******************************************************************

 77 SQLMA-DB2		       PIC S9(4) COMP-5 VALUE 1.
*DB2 related information

 77 SQLMA-DBASE 	       PIC S9(4) COMP-5 VALUE 2.
*Database related information

 77 SQLMA-APPL		       PIC S9(4) COMP-5 VALUE 3.
*Application information - by application id

 77 SQLMA-AGENT-ID	       PIC S9(4) COMP-5 VALUE 4.
*Application information - by agent id

 77 SQLMA-DBASE-TABLES	       PIC S9(4) COMP-5 VALUE 5.
*Table related information for a database

 77 SQLMA-DBASE-APPLS	       PIC S9(4) COMP-5 VALUE 6.
*Application related information for a database

 77 SQLMA-DBASE-APPLINFO       PIC S9(4) COMP-5 VALUE 7.
*Summary application information for a database

 77 SQLMA-DBASE-LOCKS	       PIC S9(4) COMP-5 VALUE 8.
*Lock related information for a database

 77 SQLMA-DBASE-ALL	       PIC S9(4) COMP-5 VALUE 9.
*Database related information for all databases in DB2

 77 SQLMA-APPL-ALL	       PIC S9(4) COMP-5 VALUE 10.
*Application related information for all active applications

 77 SQLMA-APPLINFO-ALL	       PIC S9(4) COMP-5 VALUE 11.
*Summary application information for all active applications.

 77 SQLMA-DCS-APPLINFO-ALL     PIC S9(4) COMP-5 VALUE 12.
*Information for all active DDCS applications.

 77 SQLMA-DBASE-TABLESPACES    PIC S9(4) COMP-5 VALUE 13.
*Tablespace related information for a database

******************************************************************
* size definitions
******************************************************************

 77 SQLM-APPLID-SZ	       PIC S9(4) COMP-5 VALUE 32.
*size of the application id

 77 SQLM-SEQ-SZ 	       PIC S9(4) COMP-5 VALUE 4.
*size of sequence number

 77 SQLM-SH-IDENT-SZ	       PIC S9(4) COMP-5 VALUE 8.
*size of short identifier

 77 SQLM-IDENT-SZ	       PIC S9(4) COMP-5 VALUE 20.
*general identifier size

 77 SQLM-OBJECT-SZ	       PIC S9(4) COMP-5 VALUE 36.
*object name size in sqlma

 77 SQLM-RESERVED-SZ	       PIC S9(4) COMP-5 VALUE 32.
*size of reserved area

 77 SQLM-DBPATH-SZ	       PIC S9(4) COMP-5 VALUE 256.
*size of database path

******************************************************************
* Information group state switches
******************************************************************

 77 SQLM-OFF		       PIC S9(4) COMP-5 VALUE 0.
*turn monitoring group OFF

 77 SQLM-ON		       PIC S9(4) COMP-5 VALUE 1.
*turn monitoring group ON

 77 SQLM-HOLD		       PIC S9(4) COMP-5 VALUE 2.
*leave monitoring group in current state

******************************************************************
* Information groups array indexes
******************************************************************

 77 SQLM-UOW-SW 	       PIC S9(4) COMP-5 VALUE 1.
*Select Unit of Work information

 77 SQLM-STATEMENT-SW	       PIC S9(4) COMP-5 VALUE 2.
*Select Statement information

 77 SQLM-TABLE-SW	       PIC S9(4) COMP-5 VALUE 3.
*Select Table information

 77 SQLM-BUFFER-POOL-SW        PIC S9(4) COMP-5 VALUE 4.
*Select Buffer Pool information

 77 SQLM-LOCK-SW	       PIC S9(4) COMP-5 VALUE 5.
*Select Lock information

 77 SQLM-SORT-SW	       PIC S9(4) COMP-5 VALUE 6.
*Select Sort information

 77 SQLM-NUM-GROUPS	       PIC S9(4) COMP-5 VALUE 6.
*Number of monitoring groups

******************************************************************
* Statement Types
******************************************************************

 77 SQLM-STATIC 	       PIC S9(4) COMP-5 VALUE 1.
*Static Statement

 77 SQLM-DYNAMIC	       PIC S9(4) COMP-5 VALUE 2.
*Dynamic Statement

 77 SQLM-NON-STMT	       PIC S9(4) COMP-5 VALUE 3.
*Operation other than an SQL Statement

 77 SQLM-STMT-TYPE-UNKNOWN     PIC S9(4) COMP-5 VALUE 4.
*Unknown statement type

******************************************************************
* Statement Operation Types
******************************************************************

 77 SQLM-PREPARE	       PIC S9(4) COMP-5 VALUE 1.
*Prepare operation

 77 SQLM-EXECUTE	       PIC S9(4) COMP-5 VALUE 2.
*Execute operation

 77 SQLM-EXECUTE-IMMEDIATE     PIC S9(4) COMP-5 VALUE 3.
*Execute Immediate operation

 77 SQLM-OPEN		       PIC S9(4) COMP-5 VALUE 4.
*Open operation

 77 SQLM-FETCH		       PIC S9(4) COMP-5 VALUE 5.
*Fetch operation

 77 SQLM-CLOSE		       PIC S9(4) COMP-5 VALUE 6.
*Close operation

 77 SQLM-DESCRIBE	       PIC S9(4) COMP-5 VALUE 7.
*Describe operation

 77 SQLM-STATIC-COMMIT	       PIC S9(4) COMP-5 VALUE 8.
*Static Commit operation

 77 SQLM-STATIC-ROLLBACK       PIC S9(4) COMP-5 VALUE 9.
*Static Rollback operation

******************************************************************
* Table Types
******************************************************************

 77 SQLM-USER-TABLE	       PIC S9(4) COMP-5 VALUE 1.
*User table

 77 SQLM-DROPPED-TABLE	       PIC S9(4) COMP-5 VALUE 2.
*Dropped User table

 77 SQLM-TEMP-TABLE	       PIC S9(4) COMP-5 VALUE 3.
*Temporary table

 77 SQLM-CATALOG-TABLE	       PIC S9(4) COMP-5 VALUE 4.
*System Catalog table

 77 SQLM-REORG-TABLE	       PIC S9(4) COMP-5 VALUE 5.
*Reorg table

******************************************************************
* lock modes
******************************************************************

 77 SQLM-LNON		       PIC S9(4) COMP-5 VALUE 0.
*No Lock

 77 SQLM-LOIS		       PIC S9(4) COMP-5 VALUE 1.
*Intention Share Lock

 77 SQLM-LOIX		       PIC S9(4) COMP-5 VALUE 2.
*Intention Exclusive Lock

 77 SQLM-LOOS		       PIC S9(4) COMP-5 VALUE 3.
*Share Lock

 77 SQLM-LSIX		       PIC S9(4) COMP-5 VALUE 4.
*Share with Intention Exclusive Lock

 77 SQLM-LOOX		       PIC S9(4) COMP-5 VALUE 5.
*Exclusive Lock

 77 SQLM-LOIN		       PIC S9(4) COMP-5 VALUE 6.
*Intent None (For Dirty Read)

 77 SQLM-LOOZ		       PIC S9(4) COMP-5 VALUE 7.
*Super Exclusive Lock

 77 SQLM-LOOU		       PIC S9(4) COMP-5 VALUE 8.
*Update Lock

******************************************************************
* application status
******************************************************************

 77 SQLM-CONNECTPEND	       PIC S9(4) COMP-5 VALUE 1.
*Connect Pending

 77 SQLM-CONNECTED	       PIC S9(4) COMP-5 VALUE 2.
*Connect Completed

 77 SQLM-UOWEXEC	       PIC S9(4) COMP-5 VALUE 3.
*Unit of Work executing

 77 SQLM-UOWWAIT	       PIC S9(4) COMP-5 VALUE 4.
*Unit of Work waitng

 77 SQLM-LOCKWAIT	       PIC S9(4) COMP-5 VALUE 5.
*Lock Wait

 77 SQLM-COMMIT-ACT	       PIC S9(4) COMP-5 VALUE 6.
*Commit Active

 77 SQLM-ROLLBACK-ACT	       PIC S9(4) COMP-5 VALUE 7.
*Rollback Active

 77 SQLM-RECOMP 	       PIC S9(4) COMP-5 VALUE 8.
*Recompiling a plan

 77 SQLM-COMP		       PIC S9(4) COMP-5 VALUE 9.
*Compiling an SQL statement

 77 SQLM-INTR		       PIC S9(4) COMP-5 VALUE 10.
*Request interrupted

 77 SQLM-DISCONNECTPEND        PIC S9(4) COMP-5 VALUE 11.
*Disconnect Pending

 77 SQLM-TPREP		       PIC S9(4) COMP-5 VALUE 12.
*Prepared Transaction

 77 SQLM-THCOMT 	       PIC S9(4) COMP-5 VALUE 13.
*Transaction heuristically committed

 77 SQLM-THABRT 	       PIC S9(4) COMP-5 VALUE 14.
*Transaction heuristically rolled back

 77 SQLM-TEND		       PIC S9(4) COMP-5 VALUE 15.
*Transaction ended

 77 SQLM-CREATE-DB	       PIC S9(4) COMP-5 VALUE 16.
*Creating Database

 77 SQLM-RESTART	       PIC S9(4) COMP-5 VALUE 17.
*Restarting a Database

 77 SQLM-RESTORE	       PIC S9(4) COMP-5 VALUE 18.
*Restoring a Database

 77 SQLM-BACKUP 	       PIC S9(4) COMP-5 VALUE 19.
*Performing a Backup

 77 SQLM-LOAD		       PIC S9(4) COMP-5 VALUE 20.
*Performing a fast load

 77 SQLM-UNLOAD 	       PIC S9(4) COMP-5 VALUE 21.
*Performing a fast unload

 77 SQLM-IOERROR-WAIT	       PIC S9(4) COMP-5 VALUE 22.
*Wait to disable tablespace

 77 SQLM-QUIESCE-TABLESPACE    PIC S9(4) COMP-5 VALUE 23.
*Quiescing a tablespace

******************************************************************
* database status
******************************************************************

 77 SQLM-DB-ACTIVE	       PIC S9(4) COMP-5 VALUE 0.
*Database is active

 77 SQLM-DB-QUIESCE-PEND       PIC S9(4) COMP-5 VALUE 1.
*Quiesce is pending for DB

 77 SQLM-DB-QUIESCED	       PIC S9(4) COMP-5 VALUE 2.
*Database has been quiesced

******************************************************************
* database manager status
******************************************************************

 77 SQLM-DB2-ACTIVE	       PIC S9(4) COMP-5 VALUE 0.
*DB2 is active

 77 SQLM-DB2-QUIESCE-PEND      PIC S9(4) COMP-5 VALUE 1.
*Quiesce is pending for DB2

 77 SQLM-DB2-QUIESCED	       PIC S9(4) COMP-5 VALUE 2.
*DB2 has been quiesced

******************************************************************
* UOW completion status
******************************************************************

 77 SQLM-UOWCOMMIT	       PIC S9(4) COMP-5 VALUE 1.
*Unit of Work issued a commit

 77 SQLM-UOWROLLBACK	       PIC S9(4) COMP-5 VALUE 2.
*Unit of Work issued a rollback

 77 SQLM-UOWDEADLOCK	       PIC S9(4) COMP-5 VALUE 3.
*Unit of Work was rolled back due to a deadlock

 77 SQLM-UOWABEND	       PIC S9(4) COMP-5 VALUE 4.
*Unit of Work was rolled back due to an abend

 77 SQLM-APPL-END	       PIC S9(4) COMP-5 VALUE 5.
*Normal application termination

 77 SQLM-UOWLOCKTIMEOUT        PIC S9(4) COMP-5 VALUE 6.
*Unit of work was rolled back from a lock timeout

******************************************************************
* lock object type
******************************************************************

 77 SQLM-TABLE-LOCK	       PIC S9(4) COMP-5 VALUE 1.
*Table lock type

 77 SQLM-ROW-LOCK	       PIC S9(4) COMP-5 VALUE 2.
*Table Row lock type

 77 SQLM-INTERNAL-LOCK	       PIC S9(4) COMP-5 VALUE 3.
*Internal lock type

 77 SQLM-TABLESPACE-LOCK       PIC S9(4) COMP-5 VALUE 4.
*Tablespace lock type

******************************************************************
* lock status
******************************************************************

 77 SQLM-LRBGRNT	       PIC S9(4) COMP-5 VALUE 1.
*Granted State

 77 SQLM-LRBCONV	       PIC S9(4) COMP-5 VALUE 2.
*Converting State


******************************************************************
* client communications protocols
******************************************************************

 77 SQLM-PROT-APPC	       PIC S9(4) COMP-5 VALUE 0.
*appc

 77 SQLM-PROT-NETBIOS	       PIC S9(4) COMP-5 VALUE 1.
*netbios

 77 SQLM-PROT-APPN	       PIC S9(4) COMP-5 VALUE 2.
*appn

 77 SQLM-PROT-TCPIP	       PIC S9(4) COMP-5 VALUE 3.
*tcp/ip

 77 SQLM-PROT-CPIC	       PIC S9(4) COMP-5 VALUE 4.
*cpic

 77 SQLM-PROT-IPXSPX	       PIC S9(4) COMP-5 VALUE 5.
*ipx/spx

 77 SQLM-PROT-LOCAL	       PIC S9(4) COMP-5 VALUE 6.
*local client

 77 SQLM-PROT-NPIPE	       PIC S9(4) COMP-5 VALUE 7.
*named pipe


******************************************************************
* client platforms
******************************************************************
 77 SQLM-PLATFORM-UNKNOWN      PIC S9(4) COMP-5 VALUE  0.
*Unknown client platform

 77 SQLM-PLATFORM-OS2	       PIC S9(4) COMP-5 VALUE  1.
*OS/2 client

 77 SQLM-PLATFORM-DOS	       PIC S9(4) COMP-5 VALUE  2.
*DOS client

 77 SQLM-PLATFORM-WINDOWS      PIC S9(4) COMP-5 VALUE  3.
*Windows client

 77 SQLM-PLATFORM-AIX	       PIC S9(4) COMP-5 VALUE  4.
*AIX client

 77 SQLM-PLATFORM-NT	       PIC S9(4) COMP-5 VALUE  5.
*NT client

 77 SQLM-PLATFORM-HP	       PIC S9(4) COMP-5 VALUE  6.
*HP client

 77 SQLM-PLATFORM-SUN	       PIC S9(4) COMP-5 VALUE  7.
*Sun client

 77 SQLM-PLATFORM-MVS-DRDA     PIC S9(4) COMP-5 VALUE  8.
*MVS client via DRDA

 77 SQLM-PLATFORM-AS400-DRDA   PIC S9(4) COMP-5 VALUE  9.
*AS400 client via DRDA

 77 SQLM-PLATFORM-VM-DRDA      PIC S9(4) COMP-5 VALUE 10.
*VM client via DRDA

 77 SQLM-PLATFORM-VSE-DRDA     PIC S9(4) COMP-5 VALUE 11.
*VSE client via DRDA

 77 SQLM-PLATFORM-UNKNOWN-DRDA PIC S9(4) COMP-5 VALUE 12.
*Unknown DRDA Client

 77 SQLM-PLATFORM-SNI	       PIC S9(4) COMP-5 VALUE 13.
*Siemens Nixdorf Client

 77 SQLM-PLATFORM-MAC	       PIC S9(4) COMP-5 VALUE 14.
*Macintosh Client



******************************************************************
* Event Monitor Type Identifiers
******************************************************************
 77 SQLM-EVENT-DB	       PIC S9(4) COMP-5 VALUE  1.
*Database Event

 77 SQLM-EVENT-CONN	       PIC S9(4) COMP-5 VALUE  2.
*Connection Event

 77 SQLM-EVENT-TABLE	       PIC S9(4) COMP-5 VALUE  3.
*Table Event

 77 SQLM-EVENT-STMT	       PIC S9(4) COMP-5 VALUE  4.
*Statement Event

 77 SQLM-EVENT-STMTTEXT        PIC S9(4) COMP-5 VALUE  5.
*Dynamic Statement Text Event

 77 SQLM-EVENT-XACT	       PIC S9(4) COMP-5 VALUE  6.
*Transaction Event

 77 SQLM-EVENT-DEADLOCK        PIC S9(4) COMP-5 VALUE  7.
*Deadlock Event

 77 SQLM-EVENT-DLCONN	       PIC S9(4) COMP-5 VALUE  8.
*Deadlock Connection Event

 77 SQLM-EVENT-TABLESPACE      PIC S9(4) COMP-5 VALUE  9.
*Tablespace Event

 77 SQLM-EVENT-DBHEADER        PIC S9(4) COMP-5 VALUE 10.
*Database Header Event

 77 SQLM-EVENT-START	       PIC S9(4) COMP-5 VALUE 11.
*Event Monitor Start Event

 77 SQLM-EVENT-CONNHEADER      PIC S9(4) COMP-5 VALUE 12.
*Connection Header Event

 77 SQLM-EVENT-OVERFLOW        PIC S9(4) COMP-5 VALUE 13.
*Overflow Event

******************************************************************
* Event Monitor Byte Order Identifiers
******************************************************************
 77 SQLM-LITTLE-ENDIAN	       PIC S9(4) COMP-5 VALUE  0.
*Little endian server

 77 SQLM-BIG-ENDIAN	       PIC S9(4) COMP-5 VALUE -1.
*Big endian server


**********************************************************************
* Database Monitor Structure Size Constants
* DON'T USE THESE CONSTANTS. THEY ARE PROVIDED FOR COMPATIBILITY ONLY
**********************************************************************

 77 SQLM-DB2-SZ 	       PIC S9(4) COMP-5 VALUE 100.
*structure SQLM-DB2

 77 SQLM-DBASE-SZ	       PIC S9(4) COMP-5 VALUE 548.
*structure SQLM-DBASE

 77 SQLM-APPL-SZ	       PIC S9(4) COMP-5 VALUE 880.
*structure SQLM-APPL

 77 SQLM-APPLINFO-SZ	       PIC S9(4) COMP-5 VALUE 492.
*structure SQLM-APPLINFO

 77 SQLM-DCS-APPLINFO-SZ       PIC S9(4) COMP-5 VALUE 260.
*structure SQLM-DCS-APPLINFO

 77 SQLM-TABLE-HEADER-SZ       PIC S9(4) COMP-5 VALUE 356.
*structure SQLM-TABLE-HEADER

 77 SQLM-TABLE-SZ	       PIC S9(4) COMP-5 VALUE 60.
*structure SQLM-TABLE

 77 SQLM-DBASE-LOCK-SZ	       PIC S9(4) COMP-5 VALUE 352.
*structure SQLM-DBASE-LOCK

 77 SQLM-APPL-LOCK-SZ	       PIC S9(4) COMP-5 VALUE 216.
*structure SQLM-APPL-LOCK

 77 SQLM-LOCK-SZ	       PIC S9(4) COMP-5 VALUE 60.
*structure SQLM-LOCK

 77 SQLM-TIMESTAMP-SZ	       PIC S9(4) COMP-5 VALUE 8.
*structure SQLM-TIMESTAMP

 77 SQLM-COLLECTED-SZ	       PIC S9(4) COMP-5 VALUE 232.
*structure SQLM-COLLECTED

******************************************************************
* Database Monitor Error Constants
******************************************************************

 77 SQLM-RC-INV-PTR	       PIC S9(4) COMP-5 VALUE -1601.
*Parameter is a NULL pointer

 77 SQLM-RC-INV-OBJ-TYPE       PIC S9(4) COMP-5 VALUE -1602.
*invalid obj-type in sqlma structure

 77 SQLM-RC-NOT-SPECIFIED      PIC S9(4) COMP-5 VALUE -1603.
*database alias or application id not specified in sqlma structure

 77 SQLM-RC-NOT-NULL-TERM      PIC S9(4) COMP-5 VALUE -1604.
*database alias or application id not NULL terminated

 77 SQLM-RC-DBNOACT	       PIC S9(4) COMP-5 VALUE  1605.
*specified database is not active

 77 SQLM-RC-BUFFER-FULL        PIC S9(4) COMP-5 VALUE  1606.
*Database Monitor buffer area is full

 77 SQLM-RC-NOMEM	       PIC S9(4) COMP-5 VALUE -1607.
*not enough working memory for Database Monitor request

 77 SQLM-RC-DUPLICATE-DB       PIC S9(4) COMP-5 VALUE  1608.
*duplicate database aliases were specified

 77 SQLM-RC-REMOTE-DB	       PIC S9(4) COMP-5 VALUE -1609.
*Database Monitor cannot monitor remote databases

 77 SQLM-RC-INV-VALUE	       PIC S9(4) COMP-5 VALUE -1610.
*Invalid value for input parameter

 77 SQLM-RC-NO-DATA	       PIC S9(4) COMP-5 VALUE  1611.
*No data returned by Database Monitor


******************************************************************
* Database Monitor Data Structures
******************************************************************

******************************************************************
*  SQL Monitor Area
******************************************************************

 01 SQLMA.
    05 OBJ-NUM		       PIC 9(9) COMP-5.
    05 OBJ-VAR OCCURS 0 TO 100 TIMES DEPENDING ON OBJ-NUM.
       10 AGENT-ID	       PIC 9(9) COMP-5.
       10 OBJ-TYPE	       PIC 9(9) COMP-5.
       10 SQLMA-OBJECT	       PIC X(36).

******************************************************************
* time stamp data structure
******************************************************************

 01 SQLM-TIMESTAMP.
    05 SECONDS		       PIC 9(9) COMP-5.
    05 MICROSEC 	       PIC 9(9) COMP-5.

******************************************************************
* Elpased time data structure  (For CPU times)
******************************************************************

 01 SQLM-TIME.
    05 SECONDS		       PIC 9(9) COMP-5.
    05 MICROSEC 	       PIC 9(9) COMP-5.

******************************************************************
* State information for each monitor group
******************************************************************

 01 SQLM-RECORDING-GROUP.
    05 SQLM-RECORDING-GROUP-STATES OCCURS 6 TIMES.
       10 INPUT-STATE	       PIC 9(9) COMP-5.
       10 OUTPUT-STATE	       PIC 9(9) COMP-5.
       10 START-TIME.
	  15 SECONDS	       PIC 9(9) COMP-5.
	  15 MICROSEC	       PIC 9(9) COMP-5.

******************************************************************
* collection count data structure returned from get monitor info
******************************************************************

 01 SQLM-COLLECTED.
    05 SQLM-SIZE	       PIC 9(9) COMP-5.
    05 DB2		       PIC 9(9) COMP-5.
    05 DATABASES	       PIC 9(9) COMP-5.
    05 TABLE-DATABASES	       PIC 9(9) COMP-5.
    05 LOCK-DATABASES	       PIC 9(9) COMP-5.
    05 APPLICATIONS	       PIC 9(9) COMP-5.
    05 APPLINFOS	       PIC 9(9) COMP-5.
    05 DCS-APPLINFOS	       PIC 9(9) COMP-5.
    05 SERVER-DB2-TYPE	       PIC 9(9) COMP-5.
    05 TIME-STAMP.
       10 SECONDS	       PIC 9(9) COMP-5.
       10 MICROSEC	       PIC 9(9) COMP-5.
    05 GROUP-STATES OCCURS 6.
       10 INPUT-STATE	       PIC 9(9) COMP-5.
       10 OUTPUT-STATE	       PIC 9(9) COMP-5.
       10 START-TIME.
	  15 SECONDS	       PIC 9(9) COMP-5.
	  15 MICROSEC	       PIC 9(9) COMP-5.
    05 SERVER-PRDID	       PIC X(20).
    05 SERVER-NNAME	       PIC X(20).
    05 SERVER-INSTANCE-NAME    PIC X(20).
    05 RESERVED 	       PIC X(32).
    05 TABLESPACE-DATABASES    PIC 9(9) COMP-5.
    05 SERVER-VERSION	       PIC 9(9) COMP-5.