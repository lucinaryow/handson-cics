*************************************************************************
*
* Source File Name: SQLENV
*
* (C) COPYRIGHT International Business Machines Corp. 1987, 1995
* All Rights Reserved
* Licensed Materials - Property of IBM
*
* US Government Users Restricted Rights - Use, duplication or
* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*
* Function = Include File defining:
*	       Environment Commands - Constants
*	       Environment Commands - Structures
*	       Environment Commands - Function Prototypes
*	       Environment Commands - Labels for SQLCODES
*
* Operating System: Windows NT
*
**************************************************************************
* Interface Parameters/Structures/Return Codes

* Parameters for START USING DATABASE
* USE = Share
 77  SQL-USE-SHR               PIC X(1) value "S".
* USE = Exclusive
 77  SQL-USE-EXC               PIC X(1) value "X".

* Sizes for entries in sqledinfo, sqleninfo, sqledbstat, sqleusrstat,
* sql_dir_entry, sqle_reg_nwbindery
* Alias name
 77  SQL-ALIAS-SZ	       PIC S9(4) COMP-5 VALUE 8.
* User Id
 77  SQL-USERID-SZ	       PIC S9(4) COMP-5 VALUE 8.
* Database name
 77  SQL-DBNAME-SZ	       PIC S9(4) COMP-5 VALUE 8.

* Drive (Qualified) - OS/2
 77  SQL-DRIVE-SZ-DB2OS2       PIC S9(4) COMP-5 VALUE 2.
* Drive (Qualified) - Windows
 77  SQL-DRIVE-SZ-DB2DOS       PIC S9(4) COMP-5 VALUE 2.
* Drive (Qualified) - NT
 77  SQL-DRIVE-SZ-DB2WINT      PIC S9(4) COMP-5 VALUE 12.
* Path (Qualified) - AIX/UNIX
 77  SQL-DRIVE-SZ-DB2AIX       PIC S9(4) COMP-5 VALUE 215.
 77  SQL-DRIVE-SZ	       PIC S9(4) COMP-5 VALUE 12.

* Internal db name
 77  SQL-INAME-SZ	       PIC S9(4) COMP-5 VALUE 8.
* Node name
 77  SQL-NNAME-SZ	       PIC S9(4) COMP-5 VALUE 8.
* Instance Name
 77  SQL-INSTNAME-SZ	       PIC S9(4) COMP-5 VALUE 8.
* Type of database
 77  SQL-DBTYP-SZ	       PIC S9(4) COMP-5 VALUE 20.
* Comment
 77  SQL-CMT-SZ 	       PIC S9(4) COMP-5 VALUE 30.
* Local_lu
 77  SQL-LOCLU-SZ	       PIC S9(4) COMP-5 VALUE 8.
* Partner_lu
 77  SQL-RMTLU-SZ	       PIC S9(4) COMP-5 VALUE 8.
* Mode
 77  SQL-MODE-SZ	       PIC S9(4) COMP-5 VALUE 8.
* Reserved
 77  SQL-NRESERVE-SZ	       PIC S9(4) COMP-5 VALUE 0.
* Alias name
 77  SQL-DBSTAT-ALIAS-SZ       PIC S9(4) COMP-5 VALUE 16.
* Database name
 77  SQL-DBSTAT-DBNAME-SZ      PIC S9(4) COMP-5 VALUE 16.
* Host database name
 77  SQL-LONG-NAME-SZ	       PIC S9(4) COMP-5 VALUE 18.
* collating sequence
 77  SQL-CS-SZ		       PIC S9(4) COMP-5 VALUE 256.
* Parameter string
 77  SQL-PARAMETER-SZ	       PIC S9(4) COMP-5 VALUE 512.
* Network ID
 77  SQL-NETID-SZ	       PIC S9(4) COMP-5 VALUE 8.
* Maximum Path size
 77  SQL-PATH-SZ	       PIC S9(4) COMP-5 VALUE 1024.
* Host Name
 77  SQL-HOSTNAME-SZ	       PIC S9(4) COMP-5 VALUE 255.
* Service Name
 77  SQL-SERVICE-NAME-SZ       PIC S9(4) COMP-5 VALUE 14.
* TP Monitor Name
 77  SQL-TPMON-NAME-SZ	       PIC S9(4) COMP-5 VALUE 19.
* Symbolic Destination Name
 77  SQL-SYM-DEST-NAME-SZ      PIC S9(4) COMP-5 VALUE 8.
* TM Database Name
 77  SQL-TMDATABASE-NAME-SZ    PIC S9(4) COMP-5 VALUE 8.
* AR Library Name
 77  SQL-AR-SZ		       PIC S9(4) COMP-5 VALUE 8.

* Default DRDA accounting string.
 77  SQL-DFTDRDAACT-SZ	       PIC S9(4) COMP-5 VALUE 25.
* DCE Principal name
 77  SQL-DCEPRINCPL-SZ	       PIC S9(4) COMP-5 VALUE 256.
* Dir/Route Path/Obj Name
 77  SQL-DIR-NAME-SZ	       PIC S9(4) COMP-5 VALUE 255.
* Client Comm. Protocol
 77  SQL-CLIENT-COMM-SZ        PIC S9(4) COMP-5 VALUE 31.
* Sysadm Group name
 77  SQL-SYSADM-SZ	       PIC S9(4) COMP-5 VALUE 16.
* Netware fileserver name
 77  SQL-FILESERVER-SZ	       PIC S9(4) COMP-5 VALUE 48.
* Netware bindery name
 77  SQL-OBJECTNAME-SZ	       PIC S9(4) COMP-5 VALUE 48.
* Netware IPX socket
 77  SQL-IPXSOCKET-SZ	       PIC S9(4) COMP-5 VALUE 4.
* Netware userid
 77  SQL-NW-UID-SZ	       PIC S9(4) COMP-5 VALUE 48.
* Netware password
 77  SQL-NW-PSWD-SZ	       PIC S9(4) COMP-5 VALUE 128.
* Collate info size (256 + 4)
 77  SQL-COLLATE-INFO-SZ       PIC S9(4) COMP-5 VALUE 260.
* Max accounting string
 77  SQL-ACCOUNT-STR-SZ        PIC S9(4) COMP-5 VALUE 199.

* After an SQL CONNECT, the 5th token in the SQLCA identifies the DBMS
* an application has connected to.  The following are values returned
* from IBM DBMS.
 77  SQL-DBMS-ES10-OS2         PIC X(9) value "QOS/2 DBM".
 77  SQL-DBMS-DB2-OS2          PIC X(6) value "QDB2/2".
 77  SQL-DBMS-DB2-NT           PIC X(7) value "QDB2/NT".
 77  SQL-DBMS-DB2-95           PIC X(15) value "QDB2/Windows 95".
 77  SQL-DBMS-DB2-AIX          PIC X(9) value "QDB2/6000".
 77  SQL-DBMS-DB2-AIX-PE       PIC X(12) value "QDB2/6000 PE".
 77  SQL-DBMS-DB2-HPUX         PIC X(9) value "QDB2/HPUX".
 77  SQL-DBMS-DB2-SUN          PIC X(8) value "QDB2/SUN".
 77  SQL-DBMS-DB2-SNI          PIC X(8) value "QDB2/SNI".
 77  SQL-DBMS-DB2-SCO          PIC X(8) value "QDB2/SCO".
 77  SQL-DBMS-DB2-SGI          PIC X(8) value "QDB2/SGI".
 77  SQL-DBMS-DB2-MVS          PIC X(4) value "QDB2".
 77  SQL-DBMS-OS400            PIC X(3) value "QAS".
 77  SQL-DBMS-SQLDS-VM         PIC X(9) value "QSQLDS/VM".
 77  SQL-DBMS-SQLDS-VSE        PIC X(10) value "QSQLDS/VSE".
 77  SQL-DBMS-LU62-SPM         PIC X(8) value "QLU62SPM".

* Parameters for Entry Type in sqledinfo
* Database is DCE
 77  SQL-DCE                   PIC X(1) value "3".
* Database is Home
 77  SQL-HOME                  PIC X(1) value "2".
* Database is Remote
 77  SQL-REMOTE                PIC X(1) value "1".
* Database is Indirect
 77  SQL-INDIRECT              PIC X(1) value "0".

* Parameters for adapter number in sqlectnd
* Adapter number 0
 77  SQL-ADAPTER-0	       PIC S9(4) COMP-5 VALUE 0.
* Adapter number 1
 77  SQL-ADAPTER-1	       PIC S9(4) COMP-5 VALUE 1.
* Minimum adapter number
 77  SQL-ADAPTER-MIN	       PIC S9(4) COMP-5 VALUE 0.
* Maximum adapter number
 77  SQL-ADAPTER-MAX	       PIC S9(4) COMP-5 VALUE 15.

* Definitions of constants used for Structure IDs
* DCS directory entry id
 77  SQL-DCS-STR-ID	       PIC S9(4) COMP-5 VALUE 256.
* Catalog node struct id
 77  SQL-NODE-STR-ID	       PIC S9(4) COMP-5 VALUE 256.

* Parameters for protocol types in sqlectnd
* APPC
 77  SQL-PROTOCOL-APPC         PIC X VALUE x"00".
* NETBIOS
 77  SQL-PROTOCOL-NETB         PIC X VALUE x"01".
* APPN
 77  SQL-PROTOCOL-APPN         PIC X VALUE x"02".
* TCPIP
 77  SQL-PROTOCOL-TCPIP        PIC X VALUE x"03".
* APPC using CPIC
 77  SQL-PROTOCOL-CPIC         PIC X VALUE x"04".
* IPX/SPX
 77  SQL-PROTOCOL-IPXSPX       PIC X VALUE x"05".
* Local IPC
 77  SQL-PROTOCOL-LOCAL        PIC X VALUE x"06".
* Named Pipe
 77  SQL-PROTOCOL-NPIPE        PIC X VALUE x"07".
* TCPIP using SOCKS
 77  SQL-PROTOCOL-SOCKS        PIC X VALUE x"08".

* Security Type for APPC using CPIC
* None
 77  SQL-CPIC-SECURITY-NONE    PIC S9(4) COMP-5 VALUE 0.
* Same
 77  SQL-CPIC-SECURITY-SAME    PIC S9(4) COMP-5 VALUE 1.
* Program
 77  SQL-CPIC-SECURITY-PROGRAM PIC S9(4) COMP-5 VALUE 2.

* Security Type for TCPIP
* None
 77  SQL-TCPIP-SECURITY-NONE   PIC S9(4) COMP-5 VALUE 0.
* TCPIP SOCKS Support
 77  SQL-TCPIP-SECURITY-SOCKS  PIC S9(4) COMP-5 VALUE 1.

* Authentication Types
* Authenticate on Server
 77  SQL-AUTHENTICATION-SERVER PIC S9(4) COMP-5 VALUE 0.
* Authenticate on Client
 77  SQL-AUTHENTICATION-CLIENT PIC S9(4) COMP-5 VALUE 1.
* Authenticate via DDCS
 77  SQL-AUTHENTICATION-DCS    PIC S9(4) COMP-5 VALUE 2.
* Authentication Not Specified
 77  SQL-AUTHENTICATION-NOT-SPEC PIC S9(4) COMP-5 VALUE 255.

* Parameters for Create Database API Collating Sequences
* Coll. Seq. from System
 77  SQL-CS-SYSTEM	       PIC S9(4) COMP-5 VALUE 0.
* Coll. Seq. from User
 77  SQL-CS-USER	       PIC S9(4) COMP-5 VALUE -1.
* Coll. Seq. (None)
 77  SQL-CS-NONE	       PIC S9(4) COMP-5 VALUE -2.

* Parameters for indicating the stored procedure invocation was via
* the CALL statement
 77  SQL-CALLPROC              PIC X(8) value "$SQL$CAL".

* Default values for Segmented Tables parameters
* Default number of segments-nonOS2
 77  SQL-DEF-NUMSEGS	       PIC S9(4) COMP-5 VALUE 1.
* OBSOLETE: Default max pages per seg
 77  SQL-DEF-SEGPAGES	       PIC S9(9) COMP-5 VALUE 76800.
* default extent size
 77  SQL-DEF-EXTSIZE	       PIC S9(4) COMP-5 VALUE 32.

* DUOW Connection Setting types used by sqleqryc() and
* sqlesetc().Associated values are in sql.h, used in common with the
* precompiler.
* Connect type
 77  SQL-CONNECT-TYPE	       PIC S9(4) COMP-5 VALUE 1.
* Rules for changing connections
 77  SQL-RULES		       PIC S9(4) COMP-5 VALUE 2.
* Disconnect type at syncpoint
 77  SQL-DISCONNECT	       PIC S9(4) COMP-5 VALUE 3.
* Syncpoint type
 77  SQL-SYNCPOINT	       PIC S9(4) COMP-5 VALUE 4.
* Maximum concurrent connections
 77  SQL-MAX-NETBIOS-CONNECTIONS PIC S9(4) COMP-5 VALUE 5.
* Maximum concurrent connections
 77  SQL-DEFERRED-PREPARE      PIC S9(4) COMP-5 VALUE 6.

* A structure to identify an SQL statement.  The eyecatcher $SQL$CALL
* identifies this as an EXEC SQL CALL statement.
 01 SQLSTMTID.
     05 SQLCSTID	       PIC X(8).
     05 SQLUSER 	       PIC X(8).
     05 SQL-PKGNAME	       PIC X(8).
     05 SQL-CONTOKEN	       PIC X(8).
     05 SQL-SECTNUM	       PIC S9(4) COMP-5.
     05 SQL-WCHAR-INFO	       PIC X.
     05 SQL-F-CACHE-ROWS       PIC X.
     05 SQL-BUFFER	       PIC X(38).


*************************************************************************
* Database Description Block structure
**************************************************************************
* TableSpace types
 77  SQL-TBS-TYP-SMS           PIC X(1) value "S".
 77  SQL-TBS-TYP-DMS           PIC X(1) value "D".

* TableSpace container types
* path (directory)  SMS only
 77  SQL-TBSC-TYP-PATH         PIC X(1) value "P".
* device (raw disk) DMS only
 77  SQL-TBSC-TYP-DEV          PIC X(1) value "D".
* file (cooked file) DMS only
 77  SQL-TBSC-TYP-FILE         PIC X(1) value "F".

* version 2 database descriptor
 77  SQLE-DBDESC-2             PIC X(8) value "SQLDBD02".
* version 2 tableSpace descriptor
 77  SQLE-DBTSDESC-1           PIC X(8) value "SQLTS001".

* Initial TableSpace names
* system catalogs
 77  SQLCATTS-NAME             PIC X(11) value "SYSCATSPACE".
* user tables
 77  SQLUSRTS-NAME             PIC X(10) value "USERSPACE1".
* temp tables
 77  SQLTMPTS-NAME             PIC X(10) value "TEMPSPACE1".

* tableSpace container descriptor
 01 SQLETSCDESC.
     05 SQLCTYPE	       PIC X.
     05 SQL-PAD1	       PIC X(3).
     05 SQLCSIZE	       PIC S9(9) COMP-5.
     05 SQLCLEN 	       PIC S9(4) COMP-5.
     05 SQLCONTR	       PIC X(256).
     05 SQL-PAD2	       PIC X(2).


 01 SQLEDBDESC.
     05 SQLDBDID	       PIC X(8).
     05 SQLDBCCP	       PIC S9(9) COMP-5.
     05 SQLDBCSS	       PIC S9(9) COMP-5.
     05 SQLDBUDC	       PIC X(256).
     05 SQLDBCMT	       PIC X(30).
     05 FILLER		       PIC X.
     05 SQL-PAD 	       PIC X(1).
     05 SQLDBSGP	       PIC 9(9) COMP-5.
     05 SQLDBNSG	       PIC S9(4) COMP-5.
     05 SQL-PAD2	       PIC X(2).
     05 SQLTSEXT	       PIC S9(9) COMP-5.
     05 SQLCATTS	       USAGE IS POINTER.
     05 SQLUSRTS	       USAGE IS POINTER.
     05 SQLTMPTS	       USAGE IS POINTER.


* Database Directory Scan data structure
 01 SQLEDINFO.
     05 SQL-ALIAS	       PIC X(8).
     05 SQL-DBNAME	       PIC X(8).
     05 SQL-DRIVE	       PIC X(12).
     05 SQL-INTNAME	       PIC X(8).
     05 SQL-NODENAME	       PIC X(8).
     05 SQL-DBTYPE	       PIC X(20).
     05 SQL-COMMENT	       PIC X(30).
     05 SQL-COM-CODEPAGE       PIC S9(4) COMP-5.
     05 SQL-TYPE	       PIC X.
     05 FILLER		       PIC X(1).
     05 SQL-AUTHENTICATION     PIC 9(4) COMP-5.
     05 SQL-GLBDBNAME	       PIC X(255).
     05 FILLER		       PIC X(1).

* Node Directory Scan data structure
 01 SQLENINFO.
     05 SQL-NODE-NAME	       PIC X(8).
     05 SQL-LOCAL-LU	       PIC X(8).
     05 SQL-PARTNER-LU	       PIC X(8).
     05 SQL-MODE	       PIC X(8).
     05 SQL-COMMENT	       PIC X(30).
     05 SQL-COM-CODEPAGE       PIC 9(4) COMP-5.
     05 SQL-ADAPTER	       PIC 9(4) COMP-5.
     05 SQL-NETWORKID	       PIC X(8).
     05 SQL-PROTOCOL	       PIC X.
     05 SQL-SYM-DEST-NAME      PIC X(8).
     05 FILLER		       PIC X(1).
     05 SQL-SECURITY-TYPE      PIC 9(4) COMP-5.
     05 SQL-HOSTNAME	       PIC X(255).
     05 SQL-SERVICE-NAME       PIC X(14).
     05 SQL-FILESERVER	       PIC X(48).
     05 SQL-OBJECTNAME	       PIC X(48).
     05 SQL-INSTANCE-NAME      PIC X(8).
     05 FILLER		       PIC X(1).

* General Catalog Node structures and defines

 01 SQL-NODE-STRUCT.
     05 STRUCT-ID	       PIC 9(4) COMP-5.
     05 CODEPAGE	       PIC 9(4) COMP-5.
     05 COMMENT 	       PIC X(30).
     05 FILLER		       PIC X.
     05 NODENAME	       PIC X(8).
     05 FILLER		       PIC X.
     05 PROTOCOL	       PIC X.
     05 FILLER		       PIC X(1).

* For APPC protocol
 01 SQL-NODE-APPC.
     05 LOCAL-LU	       PIC X(8).
     05 FILLER		       PIC X.
     05 PARTNER-LU	       PIC X(8).
     05 FILLER		       PIC X.
     05 TRANS-MODE	       PIC X(8).
     05 FILLER		       PIC X.

* For NetBIOS Protocol
 01 SQL-NODE-NETB.
     05 ADAPTER 	       PIC 9(4) COMP-5.
     05 REMOTE-NNAME	       PIC X(8).
     05 FILLER		       PIC X.
     05 FILLER		       PIC X(1).

* For APPN protocol
 01 SQL-NODE-APPN.
     05 NETWORKID	       PIC X(8).
     05 FILLER		       PIC X.
     05 REMOTE-LU	       PIC X(8).
     05 FILLER		       PIC X.
     05 LOCAL-LU	       PIC X(8).
     05 FILLER		       PIC X.
     05 TRANS-MODE	       PIC X(8).
     05 FILLER		       PIC X.

* For TCPIP protocol
 01 SQL-NODE-TCPIP.
     05 HOSTNAME	       PIC X(255).
     05 FILLER		       PIC X.
     05 SERVICE-NAME	       PIC X(14).
     05 FILLER		       PIC X.

* For LOCAL protocol
 01 SQL-NODE-LOCAL.
     05 SQL-INSTANCE-NAME      PIC X(8).
     05 FILLER		       PIC X.

* For APPC using CPIC protocol
 01 SQL-NODE-CPIC.
     05 SYM-DEST-NAME	       PIC X(8).
     05 FILLER		       PIC X.
     05 FILLER		       PIC X(1).
     05 SECURITY-TYPE	       PIC 9(4) COMP-5.

* For IPX/SPX protocol
 01 SQL-NODE-IPXSPX.
     05 SQL-FILESERVER	       PIC X(48).
     05 FILLER		       PIC X.
     05 SQL-OBJECTNAME	       PIC X(48).
     05 FILLER		       PIC X.

* Values for sqlefrce
* Force Mode (Asynchronous)
 77  SQL-ASYNCH 	       PIC S9(4) COMP-5 VALUE 0.
* Force Count (All Users)
 77  SQL-ALL-USERS	       PIC S9(4) COMP-5 VALUE -1.

* Product name
 77  SQL-PRODNAME-SZ	       PIC S9(4) COMP-5 VALUE 30.
* DDCS Directory Entry Data Structure
 01 SQL-DIR-ENTRY.
     05 STRUCT-ID	       PIC 9(4) COMP-5.
     05 RELEASE-LVL	       PIC 9(4) COMP-5.
     05 CODEPAGE	       PIC 9(4) COMP-5.
     05 COMMENT 	       PIC X(30).
     05 FILLER		       PIC X.
     05 LDB		       PIC X(8).
     05 FILLER		       PIC X.
     05 TDB		       PIC X(18).
     05 FILLER		       PIC X.
     05 AR		       PIC X(8).
     05 FILLER		       PIC X.
     05 PARM		       PIC X(512).
     05 FILLER		       PIC X.
     05 FILLER		       PIC X(1).

*************************************************************************
* Database Codepage and Country code info structures
**************************************************************************

 01 SQLEDBCINFO.
     05 SQLDBCP 	       PIC X(9).
     05 FILLER		       PIC X.
     05 SQLDBCC 	       PIC X(5).
     05 FILLER		       PIC X.

*************************************************************************
* V2 Database Codepage and Country code info structure
**************************************************************************

 01 SQLEDBCOUNTRYINFO.
     05 SQLDBCODESET	       PIC X(9).
     05 FILLER		       PIC X.
     05 SQLDBLOCALE	       PIC X(5).
     05 FILLER		       PIC X.

* Connection setting structure for use with distributed
* unit of work

 01 SQLE-CONN-SETTING.
     05 SQLE-CONN-SETTING-ITEM occurs 5 times.
       10 SQLE-CONN-TYPE  pic s9(4) comp-5.
       10 SQLE-CONN-VALUE pic s9(4) comp-5.

*************************************************************************
* Register/Deregister constants and data structures
**************************************************************************

* Defines for LOCATION TO REGISTER parameter
 77  SQL-NWBINDERY	       PIC S9(4) COMP-5 VALUE 0.

* Register/deregister info. for NW bindery data structure
 01 SQLE-REG-NWBINDERY.
     05 SQL-UID 	       PIC X(48).
     05 FILLER		       PIC X.
     05 FILLER		       PIC X(1).
     05 SQL-UID-LEN	       PIC 9(4) COMP-5.
     05 SQL-PSWD	       PIC X(128).
     05 FILLER		       PIC X.
     05 FILLER		       PIC X(1).
     05 SQL-PSWD-LEN	       PIC 9(4) COMP-5.

* GENERIC INTERFACES

* SQL Return Codes in SQLCODE for Environment Commands

* Request is still executing
 77  SQLE-RC-STILL-EXECUTING   PIC S9(4) COMP-5 VALUE 16.
* Connect to other DB not allowed
 77  SQLE-RC-INLUW	       PIC S9(4) COMP-5 VALUE -752.
* Only SBCS data allowed
 77  SQLE-RC-W863	       PIC S9(4) COMP-5 VALUE 863.

* Agent heap too small
 77  SQLE-RC-E953	       PIC S9(4) COMP-5 VALUE -953.
* Requestor comm heap too small
 77  SQLE-RC-E957	       PIC S9(4) COMP-5 VALUE -957.
* Server comm heap too small
 77  SQLE-RC-E959	       PIC S9(4) COMP-5 VALUE -959.
* Rqstr remote svcs heap too small
 77  SQLE-RC-E961	       PIC S9(4) COMP-5 VALUE -961.
* Svr remote svcs heap too small
 77  SQLE-RC-E962	       PIC S9(4) COMP-5 VALUE -962.

* New log path is invalid
 77  SQLE-RC-INVNEWLOGP        PIC S9(4) COMP-5 VALUE 993.
* Current log path is invalid
 77  SQLE-RC-INVLOGP	       PIC S9(4) COMP-5 VALUE 995.

* Invalid alias
 77  SQLE-RC-INVALIAS	       PIC S9(4) COMP-5 VALUE -1000.
* Invalid database name
 77  SQLE-RC-INVDBNAME	       PIC S9(4) COMP-5 VALUE -1001.
* Invalid drive
 77  SQLE-RC-INVDRIVE	       PIC S9(4) COMP-5 VALUE -1002.

* Invalid password - OS/2
 77  SQLE-RC-INVPSW-DB2OS2     PIC S9(4) COMP-5 VALUE -1003.
* Invalid password - NT
 77  SQLE-RC-INVPSW-DB2NT      PIC S9(4) COMP-5 VALUE -1003.
* Invalid password - DOS
 77  SQLE-RC-INVPSW-DB2DOS     PIC S9(4) COMP-5 VALUE -1003.
* Invalid password - Windows
 77  SQLE-RC-INVPSW-DB2WIN     PIC S9(4) COMP-5 VALUE -1003.
* Invalid password - Mac
 77  SQLE-RC-INVPSW-DB2MAC     PIC S9(4) COMP-5 VALUE -1003.
* Invalid password - AIX
 77  SQLE-RC-INVPSW-DB2AIX     PIC S9(9) COMP-5 VALUE -10002.

 77  SQLE-RC-INVPSW	       PIC S9(4) COMP-5 VALUE -1003.

* Insuf storage on file system
 77  SQLE-RC-INSSTOR	       PIC S9(4) COMP-5 VALUE -1004.
* Duplicate alias
 77  SQLE-RC-DUPALIAS	       PIC S9(4) COMP-5 VALUE -1005.
* Appl code page does not match db
 77  SQLE-RC-WRONGCODEPG       PIC S9(4) COMP-5 VALUE -1006.
* Invalid new password
 77  SQLE-RC-INV-NEWPSW        PIC S9(4) COMP-5 VALUE -1008.
* Invalid remote command
 77  SQLE-RC-INVREMOTE	       PIC S9(4) COMP-5 VALUE -1009.

* Invalid type
 77  SQLE-RC-INVTYPE	       PIC S9(4) COMP-5 VALUE -1010.
* No drive for indirect entry
 77  SQLE-RC-NODRIVE	       PIC S9(4) COMP-5 VALUE -1011.
* No nodename for remote entry
 77  SQLE-RC-NONODE	       PIC S9(4) COMP-5 VALUE -1012.
* Alias or database name not found
 77  SQLE-RC-NODB	       PIC S9(4) COMP-5 VALUE -1013.
* No more entries
 77  SQLE-RC-NOMORE	       PIC S9(4) COMP-5 VALUE 1014.
* Database needs restart
 77  SQLE-RC-DB-RESTART        PIC S9(4) COMP-5 VALUE -1015.
* Invalid local_lu alias
 77  SQLE-RC-INVLLU	       PIC S9(4) COMP-5 VALUE -1016.
* Invalid mode
 77  SQLE-RC-INVMODE	       PIC S9(4) COMP-5 VALUE -1017.
* Duplicate node name
 77  SQLE-RC-DUPNODE	       PIC S9(4) COMP-5 VALUE -1018.
* Invalid node name
 77  SQLE-RC-INVNODE	       PIC S9(4) COMP-5 VALUE -1019.

* Node could not be cataloged
 77  SQLE-RC-MAXNODE	       PIC S9(4) COMP-5 VALUE -1020.
* Nodename not found
 77  SQLE-RC-NOTNODE	       PIC S9(4) COMP-5 VALUE -1021.

* Insuf system resources - OS/2
 77  SQLE-RC-INSSYS-DB2OS2     PIC S9(4) COMP-5 VALUE -1022.
* Insuf system resources - NT
 77  SQLE-RC-INSSYS-DB2NT      PIC S9(4) COMP-5 VALUE -1022.
* Insuf system resources - DOS
 77  SQLE-RC-INSSYS-DB2DOS     PIC S9(4) COMP-5 VALUE -1022.
* Insuf system resources - Windows
 77  SQLE-RC-INSSYS-DB2WIN     PIC S9(4) COMP-5 VALUE -1022.
* Insuf system resources - Macintosh
 77  SQLE-RC-INSSYS-DB2MAC     PIC S9(4) COMP-5 VALUE -1022.
* Insuf system resources - AIX
 77  SQLE-RC-INSSYS-DB2AIX     PIC S9(9) COMP-5 VALUE -10003.

 77  SQLE-RC-INSSYS	       PIC S9(4) COMP-5 VALUE -1022.

* Communication conversation failed
 77  SQLE-RC-NOCONV	       PIC S9(4) COMP-5 VALUE -1023.
* No database connection exists
 77  SQLE-RC-NOSUDB	       PIC S9(4) COMP-5 VALUE -1024.
* Databases are active
 77  SQLE-RC-DBACT	       PIC S9(4) COMP-5 VALUE -1025.
* Database manager already started
 77  SQLE-RC-INVSTRT	       PIC S9(4) COMP-5 VALUE -1026.
* Node directory not found
 77  SQLE-RC-NONODEDIR	       PIC S9(4) COMP-5 VALUE -1027.
* Partner lu not specified
 77  SQLE-RC-INVRLU	       PIC S9(4) COMP-5 VALUE -1029.

* Database directory is full
 77  SQLE-RC-MAXDB	       PIC S9(4) COMP-5 VALUE -1030.
* Database directory not found
 77  SQLE-RC-NODBDIR	       PIC S9(4) COMP-5 VALUE -1031.
* Database manager not started
 77  SQLE-RC-NOSTARTG	       PIC S9(4) COMP-5 VALUE -1032.
* Database directory being updated
 77  SQLE-RC-DIRBUSY	       PIC S9(4) COMP-5 VALUE -1033.
* Database is damaged
 77  SQLE-RC-DBBAD	       PIC S9(4) COMP-5 VALUE -1034.
* Database already in use
 77  SQLE-RC-DB-INUSE	       PIC S9(4) COMP-5 VALUE -1035.
* Database file error
 77  SQLE-RC-FILEDB	       PIC S9(4) COMP-5 VALUE -1036.
* No entry in Node directory
 77  SQLE-RC-NODE-DIR-EMPTY    PIC S9(4) COMP-5 VALUE 1037.
* Node directory file error
 77  SQLE-RC-FILENODE	       PIC S9(4) COMP-5 VALUE -1038.

* Directory file error - OS/2
 77  SQLE-RC-FILEDIR-DB2OS2    PIC S9(4) COMP-5 VALUE -1039.
* Directory file error - NT
 77  SQLE-RC-FILEDIR-DB2NT     PIC S9(4) COMP-5 VALUE -1039.
* Directory file error - DOS
 77  SQLE-RC-FILEDIR-DB2DOS    PIC S9(4) COMP-5 VALUE -1039.
* Directory file error - Windows
 77  SQLE-RC-FILEDIR-DB2WIN    PIC S9(4) COMP-5 VALUE -1039.
* Directory file error - Mac
 77  SQLE-RC-FILEDIR-DB2MAC    PIC S9(4) COMP-5 VALUE -1039.
* Directory file error - AIX
 77  SQLE-RC-FILEDIR-DB2AIX    PIC S9(9) COMP-5 VALUE -10004.

 77  SQLE-RC-FILEDIR	       PIC S9(4) COMP-5 VALUE -1039.

* Max number of applications reached
 77  SQLE-RC-MAXAPPLS	       PIC S9(4) COMP-5 VALUE -1040.
* Max number of databases started
 77  SQLE-RC-MAXDBS	       PIC S9(4) COMP-5 VALUE -1041.
* System error
 77  SQLE-RC-SYSERR	       PIC S9(4) COMP-5 VALUE -1042.
* Catalog bootstrap failure
 77  SQLE-RC-CATBOOT	       PIC S9(4) COMP-5 VALUE -1043.
* Request interrupted by ctrl+break
 77  SQLE-RC-INTRRPT	       PIC S9(4) COMP-5 VALUE -1044.
* Invalid level of indirection
 77  SQLE-RC-INVINDIR	       PIC S9(4) COMP-5 VALUE -1045.
* Invalid userid
 77  SQLE-RC-INVAUTHID	       PIC S9(4) COMP-5 VALUE -1046.
* Appl already connect to another db
 77  SQLE-RC-APCONN	       PIC S9(4) COMP-5 VALUE -1047.

* Invalid use specified - OS/2
 77  SQLE-RC-USEINVALID-DB2OS2 PIC S9(4) COMP-5 VALUE -1048.
* Invalid use specified - NT
 77  SQLE-RC-USEINVALID-DB2NT  PIC S9(4) COMP-5 VALUE -1048.
* Invalid use specified - DOS
 77  SQLE-RC-USEINVALID-DB2DOS PIC S9(4) COMP-5 VALUE -1048.
* Invalid use specified - Windows
 77  SQLE-RC-USEINVALID-DB2WIN PIC S9(4) COMP-5 VALUE -1048.
* Invalid use specified - MacOS
 77  SQLE-RC-USEINVALID-DB2MAC PIC S9(4) COMP-5 VALUE -1048.
* Invalid use specified - AIX
 77  SQLE-RC-USEINVALID-DB2AIX PIC S9(9) COMP-5 VALUE -10005.

 77  SQLE-RC-USEINVALID        PIC S9(4) COMP-5 VALUE -1048.

* Appl state in error
 77  SQLE-RC-APPSERR	       PIC S9(4) COMP-5 VALUE -900.

* Cannot uncatalog 'Home' database
 77  SQLE-RC-UNCHOME	       PIC S9(4) COMP-5 VALUE -1050.
* Db direct. drive does not exist
 77  SQLE-RC-NODIRDRV	       PIC S9(4) COMP-5 VALUE -1051.
* Database drive does not exist
 77  SQLE-RC-NODBDRV	       PIC S9(4) COMP-5 VALUE -1052.
* Interrupt already in progress
 77  SQLE-RC-INTBUSY	       PIC S9(4) COMP-5 VALUE -1053.
* Commit in progress - no int's
 77  SQLE-RC-COMMINP	       PIC S9(4) COMP-5 VALUE -1054.
* Rollback in progress - no int's
 77  SQLE-RC-ROLLINP	       PIC S9(4) COMP-5 VALUE -1055.
* Cannot be interrupted - no int's
 77  SQLE-RC-NOINTER	       PIC S9(4) COMP-5 VALUE -1360.
* Windows Client Execution Timeout
 77  SQLE-RC-TIMEOUT	       PIC S9(4) COMP-5 VALUE 1361.
* Maximum allowable scans exceeded
 77  SQLE-RC-MAXSCAN	       PIC S9(4) COMP-5 VALUE -1056.
* No entries in directory
 77  SQLE-RC-NODENTRY	       PIC S9(4) COMP-5 VALUE 1057.
* Invalid input handle
 77  SQLE-RC-INVHAND	       PIC S9(4) COMP-5 VALUE -1058.
* Open scan not issued
 77  SQLE-RC-NOSCAN	       PIC S9(4) COMP-5 VALUE -1059.

* User lacks connect privilege
 77  SQLE-RC-NOCONNECT	       PIC S9(4) COMP-5 VALUE -1060.
* RESTART was successful, but indoubt transactions exist
 77  SQLE-RC-RESTART-WITH-INDOUBTS PIC S9(4) COMP-5 VALUE 1061.
* Database path not found
 77  SQLE-RC-BADPATH	       PIC S9(4) COMP-5 VALUE -1062.
* Database manager started OK
 77  SQLE-RC-START-OK	       PIC S9(4) COMP-5 VALUE -1063.
* Database manager stopped OK
 77  SQLE-RC-STOP-OK	       PIC S9(4) COMP-5 VALUE -1064.
* N utilities not bound
 77  SQLE-RC-DB-BADBINDS       PIC S9(4) COMP-5 VALUE 1065.

* Message file not found - OS/2
 77  SQLE-RC-NOMSG-DB2OS2      PIC S9(4) COMP-5 VALUE -1068.
* Message file not found - NT
 77  SQLE-RC-NOMSG-DB2NT       PIC S9(4) COMP-5 VALUE -1068.
* Message file not found - DOS
 77  SQLE-RC-NOMSG-DB2DOS      PIC S9(4) COMP-5 VALUE -1068.
* Message file not found - Windows
 77  SQLE-RC-NOMSG-DB2WIN      PIC S9(4) COMP-5 VALUE -1068.
* Message file not found - MacOS
 77  SQLE-RC-NOMSG-DB2MAC      PIC S9(4) COMP-5 VALUE -1068.
* Message file not found - AIX
 77  SQLE-RC-NOMSG-DB2AIX      PIC S9(9) COMP-5 VALUE -10007.

 77  SQLE-RC-NOMSG	       PIC S9(4) COMP-5 VALUE -1068.

* DB invalid type for Drop
 77  SQLE-RC-INVDROP	       PIC S9(4) COMP-5 VALUE -1069.

* Invalid Database Name pointer
 77  SQLE-RC-INVDBNAME-PTR     PIC S9(4) COMP-5 VALUE -1070.
* Invalid Alias pointer
 77  SQLE-RC-INVALIAS-PTR      PIC S9(4) COMP-5 VALUE -1071.
* Resources in inconsistent state
 77  SQLE-RC-RESOURCE-ERROR    PIC S9(4) COMP-5 VALUE -1072.
* Invalid Node Directory release
 77  SQLE-RC-BAD-ND-REL        PIC S9(4) COMP-5 VALUE -1073.
* Invalid Password pointer
 77  SQLE-RC-INVPSW-PTR        PIC S9(4) COMP-5 VALUE -1074.
* Invalid Comment pointer
 77  SQLE-RC-INVCOMM-PTR       PIC S9(4) COMP-5 VALUE -1075.
* Invalid Count pointer
 77  SQLE-RC-INVCNT-PTR        PIC S9(4) COMP-5 VALUE -1076.
* Invalid Handle pointer
 77  SQLE-RC-INVHAND-PTR       PIC S9(4) COMP-5 VALUE -1077.
* Invalid Buffer pointer
 77  SQLE-RC-INVBUFF-PTR       PIC S9(4) COMP-5 VALUE -1078.
* Invalid Node pointer
 77  SQLE-RC-INVNODE-PTR       PIC S9(4) COMP-5 VALUE -1079.
* Invalid Userid pointer
 77  SQLE-RC-INVUSERID-PTR     PIC S9(4) COMP-5 VALUE -1150.

* Invalid Local Lu pointer
 77  SQLE-RC-INVLLU-PTR        PIC S9(4) COMP-5 VALUE -1080.
* Invalid Remote Lu pointer
 77  SQLE-RC-INVRLU-PTR        PIC S9(4) COMP-5 VALUE -1081.
* Invalid Mode pointer
 77  SQLE-RC-INVMODE-PTR       PIC S9(4) COMP-5 VALUE -1082.
* Bad Database Description Block
 77  SQLE-RC-BAD-DBDB	       PIC S9(4) COMP-5 VALUE -1083.
* Cannot Allocate Kernel Segments
 77  SQLE-RC-KSEGSFAIL	       PIC S9(4) COMP-5 VALUE -1084.
* Cannot Allocate Application heap
 77  SQLE-RC-APPHEAPFAIL       PIC S9(4) COMP-5 VALUE -1085.
* Unexpected OS/2 error
 77  SQLE-RC-OS2ERROR	       PIC S9(4) COMP-5 VALUE -1086.
* Bind list could not be opened
 77  SQLE-RC-BIND-LIST	       PIC S9(4) COMP-5 VALUE 1087.
* Error occurred during bind
 77  SQLE-RC-BIND-ERROR        PIC S9(4) COMP-5 VALUE 1088.
* Binding was interrupted
 77  SQLE-RC-BIND-INTRRPT      PIC S9(4) COMP-5 VALUE 1089.

* Release number of appl is invalid
 77  SQLE-RC-BAD-APP-REL       PIC S9(4) COMP-5 VALUE -1090.
* Release number of database bad
 77  SQLE-RC-BAD-DB-REL        PIC S9(4) COMP-5 VALUE -1091.

* Authorization error
 77  SQLE-RC-INSAUTH	       PIC S9(4) COMP-5 VALUE -1092.
* User not logged on
 77  SQLE-RC-NOLOGON	       PIC S9(4) COMP-5 VALUE -1093.
* Node directory being updated
 77  SQLE-RC-NDBUSY	       PIC S9(4) COMP-5 VALUE -1094.
* Max node scans open
 77  SQLE-RC-MAX-NDSCAN        PIC S9(4) COMP-5 VALUE -1095.
* Invalid type for requester node
 77  SQLE-RC-REQTYPE	       PIC S9(4) COMP-5 VALUE -1096.
* Node not found for remote db
 77  SQLE-RC-NODERR	       PIC S9(4) COMP-5 VALUE -1097.
* Appl is already connected to db
 77  SQLE-RC-APCONN-SAME       PIC S9(4) COMP-5 VALUE -1098.

* Write protect error on diskette
 77  SQLE-RC-WRPROT-ERR-DB2OS2 PIC S9(4) COMP-5 VALUE -1099.
* Write protect error on diskette
 77  SQLE-RC-WRPROT-ERR-DB2NT  PIC S9(4) COMP-5 VALUE -1099.
* Write protect error on diskette
 77  SQLE-RC-WRPROT-ERR-DB2DOS PIC S9(4) COMP-5 VALUE -1099.
* Write protect error on diskette
 77  SQLE-RC-WRPROT-ERR-DB2WIN PIC S9(4) COMP-5 VALUE -1099.
* Write protect error on diskette
 77  SQLE-RC-WRPROT-ERR-DB2MAC PIC S9(4) COMP-5 VALUE -1099.
* Write protect error on filesystem
 77  SQLE-RC-WRPROT-ERR-DB2AIX PIC S9(9) COMP-5 VALUE -10021.

 77  SQLE-RC-WRPROT-ERR        PIC S9(4) COMP-5 VALUE -1099.

* Node not cataloged for database
 77  SQLE-RC-NODE-WARN	       PIC S9(4) COMP-5 VALUE 1100.
* Remote communications error
 77  SQLE-RC-REMCONN-ERR       PIC S9(4) COMP-5 VALUE -1101.
* No database name provided in call
 77  SQLE-RC-MIG-NODB	       PIC S9(4) COMP-5 VALUE -1102.
* Migration was successful
 77  SQLE-RC-MIG-OK	       PIC S9(4) COMP-5 VALUE 1103.
* Invalid program name pointer
 77  SQLE-RC-INVPROG-PTR       PIC S9(4) COMP-5 VALUE -1104.

* Invalid disconnect from database
 77  SQLE-RC-INV-SPDB-DB2OS2   PIC S9(4) COMP-5 VALUE -1105.
* Invalid disconnect from database
 77  SQLE-RC-INV-SPDB-DB2NT    PIC S9(4) COMP-5 VALUE -1105.
* Invalid disconnect from database
 77  SQLE-RC-INV-SPDB-DB2DOS   PIC S9(4) COMP-5 VALUE -1105.
* Invalid disconnect from database
 77  SQLE-RC-INV-SPDB-DB2WIN   PIC S9(4) COMP-5 VALUE -1105.
* Invalid disconnect from database
 77  SQLE-RC-INV-SPDB-DB2MAC   PIC S9(4) COMP-5 VALUE -1105.
* Invalid disconnect from database
 77  SQLE-RC-INV-SPDB-DB2AIX   PIC S9(9) COMP-5 VALUE -10017.

 77  SQLE-RC-INV-SPDB	       PIC S9(4) COMP-5 VALUE -1105.

* Function could not be executed
 77  SQLE-RC-INVALID-PROC-DB2OS2 PIC S9(4) COMP-5 VALUE -1106.
* Function could not be executed
 77  SQLE-RC-INVALID-PROC-DB2NT PIC S9(4) COMP-5 VALUE -1106.
* Function could not be executed
 77  SQLE-RC-INVALID-PROC-DB2DOS PIC S9(4) COMP-5 VALUE -1106.
* Function could not be executed
 77  SQLE-RC-INVALID-PROC-DB2WIN PIC S9(4) COMP-5 VALUE -1106.
* Function could not be executed
 77  SQLE-RC-INVALID-PROC-DB2MAC PIC S9(4) COMP-5 VALUE -1106.
* Function could not be executed
 77  SQLE-RC-INVALID-PROC-DB2AIX PIC S9(9) COMP-5 VALUE -10010.

 77  SQLE-RC-INVALID-PROC      PIC S9(4) COMP-5 VALUE -1106.

* Program interrupted - OS/2
 77  SQLE-RC-INTRP-PROC-DB2OS2 PIC S9(4) COMP-5 VALUE -1107.
* Program interrupted - NT
 77  SQLE-RC-INTRP-PROC-DB2NT  PIC S9(4) COMP-5 VALUE -1107.
* Program interrupted - DOS
 77  SQLE-RC-INTRP-PROC-DB2DOS PIC S9(4) COMP-5 VALUE -1107.
* Program interrupted - Windows
 77  SQLE-RC-INTRP-PROC-DB2WIN PIC S9(4) COMP-5 VALUE -1107.
* Program interrupted - MacOS
 77  SQLE-RC-INTRP-PROC-DB2MAC PIC S9(4) COMP-5 VALUE -1107.
* Program interrupted - AIX
 77  SQLE-RC-INTRP-PROC-DB2AIX PIC S9(9) COMP-5 VALUE -10011.

 77  SQLE-RC-INTRP-PROC        PIC S9(4) COMP-5 VALUE -1106.

* System error on library load
 77  SQLE-RC-SYSERR-PROC-DB2OS2 PIC S9(4) COMP-5 VALUE -1108.
* System error on library load
 77  SQLE-RC-SYSERR-PROC-DB2NT PIC S9(4) COMP-5 VALUE -1108.
* System error on library load
 77  SQLE-RC-SYSERR-PROC-DB2DOS PIC S9(4) COMP-5 VALUE -1108.
* System error on library load
 77  SQLE-RC-SYSERR-PROC-DB2WIN PIC S9(4) COMP-5 VALUE -1108.
* System error on library load
 77  SQLE-RC-SYSERR-PROC-DB2MAC PIC S9(4) COMP-5 VALUE -1108.
* System error on library load
 77  SQLE-RC-SYSERR-PROC-DB2AIX PIC S9(9) COMP-5 VALUE -10012.

 77  SQLE-RC-SYSERR-PROC       PIC S9(4) COMP-5 VALUE -1108.

* Library could not be loaded
 77  SQLE-RC-NOFILE-PROC-DB2OS2 PIC S9(4) COMP-5 VALUE -1109.
* Library could not be loaded
 77  SQLE-RC-NOFILE-PROC-DB2NT PIC S9(4) COMP-5 VALUE -1109.
* Library could not be loaded
 77  SQLE-RC-NOFILE-PROC-DB2DOS PIC S9(4) COMP-5 VALUE -1109.
* Library could not be loaded
 77  SQLE-RC-NOFILE-PROC-DB2WIN PIC S9(4) COMP-5 VALUE -1109.
* Library could not be loaded
 77  SQLE-RC-NOFILE-PROC-DB2MAC PIC S9(4) COMP-5 VALUE -1109.
* Library could not be loaded
 77  SQLE-RC-NOFILE-PROC-DB2AIX PIC S9(9) COMP-5 VALUE -10013.

 77  SQLE-RC-NOFILE-PROC       PIC S9(4) COMP-5 VALUE -1109.

* Program error
 77  SQLE-RC-ERROR-PROC        PIC S9(4) COMP-5 VALUE -1110.

* Invalid DARI prog name format
 77  SQLE-RC-BADPGN-PROC-DB2OS2 PIC S9(4) COMP-5 VALUE -1111.
* Invalid DARI prog name format
 77  SQLE-RC-BADPGN-PROC-DB2NT PIC S9(4) COMP-5 VALUE -1111.
* Invalid DARI prog name format
 77  SQLE-RC-BADPGN-PROC-DB2DOS PIC S9(4) COMP-5 VALUE -1111.
* Invalid DARI prog name format
 77  SQLE-RC-BADPGN-PROC-DB2WIN PIC S9(4) COMP-5 VALUE -1111.
* Invalid DARI prog name format
 77  SQLE-RC-BADPGN-PROC-DB2MAC PIC S9(4) COMP-5 VALUE -1111.
* Invalid DARI prog name format
 77  SQLE-RC-BADPGN-PROC-DB2AIX PIC S9(9) COMP-5 VALUE -10014.

 77  SQLE-RC-BADPGN-PROC       PIC S9(4) COMP-5 VALUE -1111.

* Insuf memory to load lib
 77  SQLE-RC-INSMEM-PROC-DB2OS2 PIC S9(4) COMP-5 VALUE -1112.
* Insuf memory to load lib
 77  SQLE-RC-INSMEM-PROC-DB2NT PIC S9(4) COMP-5 VALUE -1112.
* Insuf memory to load lib
 77  SQLE-RC-INSMEM-PROC-DB2DOS PIC S9(4) COMP-5 VALUE -1112.
* Insuf memory to load lib
 77  SQLE-RC-INSMEM-PROC-DB2WIN PIC S9(4) COMP-5 VALUE -1112.
* Insuf memory to load lib
 77  SQLE-RC-INSMEM-PROC-DB2MAC PIC S9(4) COMP-5 VALUE -1112.
* Insuf memory to load lib
 77  SQLE-RC-INSMEM-PROC-DB2AIX PIC S9(9) COMP-5 VALUE -10015.

 77  SQLE-RC-INSMEM-PROC       PIC S9(4) COMP-5 VALUE -1112.

* Data type in output SQLDA changed
 77  SQLE-RC-SQLDA-DATATYPE    PIC S9(4) COMP-5 VALUE -1113.
* Data length in output SQLDA changed
 77  SQLE-RC-SQLDA-LENGTH      PIC S9(4) COMP-5 VALUE -1114.
* Num of sqlvars changed in SQLDA
 77  SQLE-RC-SQLDA-VARS        PIC S9(4) COMP-5 VALUE -1115.
* Backup pending
 77  SQLE-RC-BKP-PEND	       PIC S9(4) COMP-5 VALUE -1116.
* Roll forward pending
 77  SQLE-RC-ROLLFWD-PEND      PIC S9(4) COMP-5 VALUE -1117.
* Need to rerun the Backup process
 77  SQLE-RC-BKP-INPROG        PIC S9(4) COMP-5 VALUE -1118.
* Need to rerun the Restore process
 77  SQLE-RC-RST-INPROG        PIC S9(4) COMP-5 VALUE -1119.
* Need to rerun either Backup or Restore process
 77  SQLE-RC-BR-INPROG	       PIC S9(4) COMP-5 VALUE -1120.

* Invalid Node structure pointer
 77  SQLE-RC-INVNODESTR-PTR    PIC S9(4) COMP-5 VALUE -1121.
* Invalid Protocol structure pointer
 77  SQLE-RC-INVPROTOCOL-PTR   PIC S9(4) COMP-5 VALUE -1122.
* Invalid protocol type
 77  SQLE-RC-INVPROTOCOL       PIC S9(4) COMP-5 VALUE -1123.
* Invalid remote workstation name
 77  SQLE-RC-INVRNNAME	       PIC S9(4) COMP-5 VALUE -1124.
* Invalid adapter number
 77  SQLE-RC-INVADAPTER        PIC S9(4) COMP-5 VALUE -1125.
* Invalid network id
 77  SQLE-RC-INVNETID	       PIC S9(4) COMP-5 VALUE -1126.
* Invalid real partner LU name
 77  SQLE-RC-INVPLU	       PIC S9(4) COMP-5 VALUE -1127.

* Insuf system resources for DARI
 77  SQLE-RC-DARI-INSSYS       PIC S9(4) COMP-5 VALUE -1129.
* Max DARI process limit reached
 77  SQLE-RC-DARI-MAXDARI      PIC S9(4) COMP-5 VALUE -1130.
* DARI process abnormally terminated
 77  SQLE-RC-DARI-ABEND        PIC S9(4) COMP-5 VALUE -1131.
* Invalid DB2 request in DARI
 77  SQLE-RC-DARI-INV-RQST     PIC S9(4) COMP-5 VALUE -1132.
* SQLVAR's sqldata or sqlind ptrs were altered
 77  SQLE-RC-DARI-VAR-POINTER-CHG PIC S9(4) COMP-5 VALUE -1133.
* DB2 request is not allowed when DB auth is client
 77  SQLE-RC-DARI-RQST-AUTH-ERR PIC S9(4) COMP-5 VALUE -1134.
* Invalid numsegs on create db
 77  SQLE-RC-BAD-NUMSEGS       PIC S9(4) COMP-5 VALUE -1135.
* Invalid extSize on create db
 77  SQLE-RC-BAD-EXTSIZE       PIC S9(4) COMP-5 VALUE -1136.
* Mounted Segment Directories on a drop database request
 77  SQLE-RC-MOUNTED-SEGS      PIC S9(4) COMP-5 VALUE -1137.

* Invalid object specified
 77  SQLE-RC-INVOS-OBJ	       PIC S9(4) COMP-5 VALUE -1200.
* Invalid status specified
 77  SQLE-RC-INVOS-STAT        PIC S9(4) COMP-5 VALUE -1201.
* Status has not been collected
 77  SQLE-RC-INVOS-NOSTAT      PIC S9(4) COMP-5 VALUE -1202.
* No users connected to database
 77  SQLE-RC-INVOS-NOUSER      PIC S9(4) COMP-5 VALUE -1203.
* Active codepage is not supported
 77  SQLE-RC-UNSUPP-CODEPG     PIC S9(4) COMP-5 VALUE -1204.

* Invalid country information
 77  SQLE-RC-INV-CNTRYINFO-DB2OS2 PIC S9(4) COMP-5 VALUE -1205.
* Invalid country information
 77  SQLE-RC-INV-CNTRYINFO-DB2NT PIC S9(4) COMP-5 VALUE -1205.
* Invalid country information
 77  SQLE-RC-INV-CNTRYINFO-DB2DOS PIC S9(4) COMP-5 VALUE -1205.
* Invalid country information
 77  SQLE-RC-INV-CNTRYINFO-DB2WIN PIC S9(4) COMP-5 VALUE -1205.
* Invalid country information
 77  SQLE-RC-INV-CNTRYINFO-DB2MAC PIC S9(4) COMP-5 VALUE -1205.
* Invalid country information
 77  SQLE-RC-INV-CNTRYINFO-DB2AIX PIC S9(9) COMP-5 VALUE -10009.

 77  SQLE-RC-INV-CNTRYINFO     PIC S9(4) COMP-5 VALUE -1205.

* DB2 Shared Memory Set alloc failed
 77  SQLE-RC-NO-SHRD-SEG       PIC S9(4) COMP-5 VALUE -1220.
* ASL heap cannot be allocated
 77  SQLE-RC-NO-ASL-HEAP       PIC S9(4) COMP-5 VALUE -1221.
* ASL heap is too small
 77  SQLE-RC-ASL-TOO-SMALL     PIC S9(4) COMP-5 VALUE -1222.
* No more agents available
 77  SQLE-RC-NO-AGENT-AVAIL    PIC S9(4) COMP-5 VALUE -1223.
* DB2 agent not active
 77  SQLE-RC-AGENT-GONE        PIC S9(4) COMP-5 VALUE -1224.
* Op. Sys. couldn't spawn a process
 77  SQLE-RC-PROC-LIMIT        PIC S9(4) COMP-5 VALUE -1225.

* At least one agent not forced
 77  SQLE-RC-AGENT-NOT-FORCED  PIC S9(4) COMP-5 VALUE 1230.
* Invalid Force Users count
 77  SQLE-RC-INVCOUNT	       PIC S9(4) COMP-5 VALUE -1231.
* Invalid Force Users mode
 77  SQLE-RC-INVFRCE-MODE      PIC S9(4) COMP-5 VALUE -1232.

* Invalid TableSpace descriptor
 77  SQLE-RC-INV-TBS-DESC      PIC S9(4) COMP-5 VALUE -1241.

* Cannot set connection options - existing connections
 77  SQLE-RC-NO-SETCONNOPT     PIC S9(4) COMP-5 VALUE -1246.

* db2uexit file not found
 77  SQLE-RC-NOUEXIT	       PIC S9(4) COMP-5 VALUE -1267.

 77  SQLC-RC-NPIPE-BROKEN      PIC S9(4) COMP-5 VALUE -1281.
 77  SQLC-RC-NPIPE-BUSY        PIC S9(4) COMP-5 VALUE -1282.
 77  SQLC-RC-NPIPE-PIPE-INUSE  PIC S9(4) COMP-5 VALUE -1283.
 77  SQLC-RC-NPIPE-PIPE-NOT-FOUND PIC S9(4) COMP-5 VALUE -1284.
 77  SQLC-RC-NPIPE-INVALID-NAME PIC S9(4) COMP-5 VALUE -1285.
 77  SQLC-RC-NPIPE-NO-RESOURCE PIC S9(4) COMP-5 VALUE -1286.
 77  SQLC-RC-NPIPE-INST-NOT-FOUND PIC S9(4) COMP-5 VALUE -1287.

* Directory Services failed
 77  SQLE-RC-DS-FAILED	       PIC S9(4) COMP-5 VALUE -1291.
* Bad global name
 77  SQLE-RC-DS-BAD-GLB-NAME   PIC S9(4) COMP-5 VALUE -1292.
* Bad global directory entry
 77  SQLE-RC-DS-BAD-GLB-DIR-ENTRY PIC S9(4) COMP-5 VALUE -1293.
* Bad DIR_PATH_NAME
 77  SQLE-RC-DS-BAD-DIR-PATH-NAME PIC S9(4) COMP-5 VALUE -1294.
* Bad ROUTE_OBJ_NAME
 77  SQLE-RC-DS-BAD-ROUTE-NAME PIC S9(4) COMP-5 VALUE -1295.
* Command not supported
 77  SQLE-RC-DS-UNSUPPORTED-CMD PIC S9(4) COMP-5 VALUE -1297.

* DCS Directory file access error
 77  SQLE-RC-FILEDCS	       PIC S9(4) COMP-5 VALUE -1310.
* DCS Directory not found
 77  SQLE-RC-DCSDIR-NF	       PIC S9(4) COMP-5 VALUE -1311.
* DCS Directory is empty
 77  SQLE-RC-NO-ENTRY	       PIC S9(4) COMP-5 VALUE 1312.
* DCS Directory is full
 77  SQLE-RC-MAX-ENTRY	       PIC S9(4) COMP-5 VALUE -1313.
* Entry parameter pointer invalid
 77  SQLE-RC-INVENTRY-PTR      PIC S9(4) COMP-5 VALUE -1314.
* Local DB name has invalid chars
 77  SQLE-RC-INVLDB	       PIC S9(4) COMP-5 VALUE -1315.
* DCS Directory entry not found
 77  SQLE-RC-LDB-NF	       PIC S9(4) COMP-5 VALUE -1316.
* DCS Directory duplicate entry
 77  SQLE-RC-DUPLDB	       PIC S9(4) COMP-5 VALUE -1317.
* Invalid element length
 77  SQLE-RC-INVLENGTH	       PIC S9(4) COMP-5 VALUE -1318.
* Entries have not been collected
 77  SQLE-RC-ENTRYNOT-COL      PIC S9(4) COMP-5 VALUE -1319.

* Cannot access DCS Dir at this time
 77  SQLE-RC-GDBUSY	       PIC S9(4) COMP-5 VALUE -1320.
* Invalid structure ID
 77  SQLE-RC-INVSTRUCT-ID      PIC S9(4) COMP-5 VALUE -1321.
* Remote function not supported
 77  SQLE-RC-DRDANSP	       PIC S9(4) COMP-5 VALUE -1325.
* File or directory access denied
 77  SQLE-RC-ACCD	       PIC S9(4) COMP-5 VALUE -1326.
* Implicit connect - invalid dbname
 77  SQLE-RC-IMPLCONN-INVDB    PIC S9(4) COMP-5 VALUE -1327.
* Implicit connect - alias not found
 77  SQLE-RC-IMPLCONN-NODB     PIC S9(4) COMP-5 VALUE -1328.
* Input path too long
 77  SQLE-RC-PATH-TOO-LONG     PIC S9(4) COMP-5 VALUE -1329.

* Invalid symbolic destination name
 77  SQLE-RC-INVSDNAME	       PIC S9(4) COMP-5 VALUE -1330.
* Invalid CPIC security type
 77  SQLE-RC-INVSTYPE	       PIC S9(4) COMP-5 VALUE -1331.
* Invalid Host Name
 77  SQLE-RC-INV-HOSTNAME      PIC S9(4) COMP-5 VALUE -1332.
* Invalid Service Name
 77  SQLE-RC-INV-SERNAME       PIC S9(4) COMP-5 VALUE -1333.

* Double-hops not allowed
 77  SQLE-RC-DOUBLE-REMOTE     PIC S9(4) COMP-5 VALUE -1334.
* AR name has invalid chars
 77  SQLE-RC-INVAR	       PIC S9(4) COMP-5 VALUE -1335.

* File server is unknown
 77  SQLE-RC-UNKNOWN-FILESERVER PIC S9(4) COMP-5 VALUE -1340.
* Invalid File Server
 77  SQLE-RC-INV-FSERVER       PIC S9(4) COMP-5 VALUE -1342.
* Invalid Object Name
 77  SQLE-RC-INV-OBJNAME       PIC S9(4) COMP-5 VALUE -1343.

* Backup or Restore is active
 77  SQLE-RC-BR-ACTIVE	       PIC S9(4) COMP-5 VALUE -1350.

* Invalid Instance Name
 77  SQLE-RC-INV-INSTANCE      PIC S9(4) COMP-5 VALUE -1390.
* Another Instance is using the DB
 77  SQLE-RC-INSTANCE-USING    PIC S9(4) COMP-5 VALUE -1391.
* Invalid DB2 Path Name
 77  SQLE-RC-INV-DB2PATH       PIC S9(4) COMP-5 VALUE -1393.

* Unsupported authentication type
 77  SQLE-RC-BAD-AUTH	       PIC S9(4) COMP-5 VALUE -1400.
* Authentication types do not match
 77  SQLE-RC-DIFF-AUTH	       PIC S9(4) COMP-5 VALUE -1401.
* Authentication failed due to unexpected error
 77  SQLE-RC-AUTH-ERR	       PIC S9(4) COMP-5 VALUE -1402.
* Invalid user name and/or password
 77  SQLE-RC-AUTH-FAILURE      PIC S9(4) COMP-5 VALUE -1403.
* Password has expired
 77  SQLE-RC-PASSWORD-EXPIRED  PIC S9(4) COMP-5 VALUE -1404.
* Password without userid
 77  SQLE-RC-PASSWD-WITHOUT-USERID PIC S9(4) COMP-5 VALUE -1425.
* Error getting DB2INSTDFT
 77  SQLE-RC-DB2INSTDFT-ERROR  PIC S9(4) COMP-5 VALUE -1426.
* No current attachment
 77  SQLE-RC-NOT-INSTANCE-ATTACHED PIC S9(4) COMP-5 VALUE -1427.
* Attached to wrong instance
 77  SQLE-RC-WRONG-ATTACH      PIC S9(4) COMP-5 VALUE -1428.
* Relative path not allowed
 77  SQLE-RC-RELPATH-NOT-ALLOWED PIC S9(4) COMP-5 VALUE -1431.
* Connected to wrong database
 77  SQLE-RC-WRONG-CONNECT     PIC S9(4) COMP-5 VALUE -1433.

* Ctx parm invalid
 77  SQLE-RC-CTX-INV-PARM      PIC S9(4) COMP-5 VALUE -1441.
* App Ctx not in use
 77  SQLE-RC-CTX-NOTINUSE      PIC S9(4) COMP-5 VALUE -1442.
* Already using Ctx
 77  SQLE-RC-CTX-USING	       PIC S9(4) COMP-5 VALUE -1443.
* App Ctx in use
 77  SQLE-RC-CTX-INUSE	       PIC S9(4) COMP-5 VALUE -1444.
* Thread does not have context
 77  SQLE-RC-CTX-NO-CTX        PIC S9(4) COMP-5 VALUE -1445.

* Invalid registration info. ptr.
 77  SQLE-RC-INVREGINFO-PTR    PIC S9(4) COMP-5 VALUE -1450.
* Reg. issued from invalid node
 77  SQLE-RC-REG-INVNODE       PIC S9(4) COMP-5 VALUE -1451.
* Invalid registration location
 77  SQLE-RC-INVREGLOC	       PIC S9(4) COMP-5 VALUE -1452.
* Invalid file server in DBM cfg.
 77  SQLE-RC-INVCFG-FSNAME     PIC S9(4) COMP-5 VALUE -1453.
* Invalid object name in DBM cfg.
 77  SQLE-RC-INVCFG-OBJNAME    PIC S9(4) COMP-5 VALUE -1454.
* Invalid IPX socket in DBM cfg.
 77  SQLE-RC-INVCFG-IPXSOCKET  PIC S9(4) COMP-5 VALUE -1455.
* Object name already exists
 77  SQLE-RC-DUPLICATE-OBJNAME PIC S9(4) COMP-5 VALUE -1456.
* NWDS connection exists, cannot log into NW fileserver
 77  SQLE-RC-NWDS-CONNEXISTS   PIC S9(4) COMP-5 VALUE -1457.
* DB2 server reg./dereg. not needed
 77  SQLE-RC-REG-NOT-NEEDED    PIC S9(4) COMP-5 VALUE -1458.
* Invalid TCPIP Security
 77  SQLE-RC-INVSTYPE-TCP      PIC S9(4) COMP-5 VALUE -1461.

* Function is no longer supported
 77  SQLE-RC-UNSUPP-FUNCTION   PIC S9(4) COMP-5 VALUE -1650.

* Invalid Schema name found
 77  SQLE-RC-INV-SCHEMA        PIC S9(4) COMP-5 VALUE -1700.
* DB cannot be migrated
 77  SQLE-RC-DB-NOT-MIGR       PIC S9(4) COMP-5 VALUE -1701.
* Fail to create db2event dir
 77  SQLE-RC-CRT-EVENT-FAIL    PIC S9(4) COMP-5 VALUE -1703.
* DB migration failed
 77  SQLE-RC-DB-MIG-FAIL       PIC S9(4) COMP-5 VALUE -1704.
* Fail to update directory entry
 77  SQLE-RC-UPDATE-DIR-FAIL   PIC S9(4) COMP-5 VALUE 1705.

* DB is already activated
 77  SQLE-RC-DB-ACTIVATED      PIC S9(4) COMP-5 VALUE 1490.
* DB is still active
 77  SQLE-RC-DB-NOT-STOPPED    PIC S9(4) COMP-5 VALUE -1491.
* DB is not active
 77  SQLE-RC-DB-NOT-ACTIVATED  PIC S9(4) COMP-5 VALUE -1492.
* Application is connected to a database
 77  SQLE-RC-APP-IS-CONNECTED  PIC S9(4) COMP-5 VALUE -1493.
* Communications support failed
 77  SQLE-RC-COMM-FAILED       PIC S9(4) COMP-5 VALUE 5043.

* No DB2/6000 license
 77  SQLE-RC-DB2-SERVER-LICENSE PIC S9(4) COMP-5 VALUE -8000.
* Out of DB2 client licenses
 77  SQLE-RC-DB2-LICENSE       PIC S9(4) COMP-5 VALUE -8001.
* Out of DDCS clients
 77  SQLE-RC-DDCS-LICENSE      PIC S9(4) COMP-5 VALUE -8002.
* Evaluation period initiated
 77  SQLE-RC-TRYBUY-STARTED    PIC S9(4) COMP-5 VALUE -8006.
* n days left in evaluation period
 77  SQLE-RC-TRYBUY	       PIC S9(4) COMP-5 VALUE -8007.

* Java not installed or not supported on this platform
 77  SQLE-RC-JAVA-NOTSUPP      PIC S9(4) COMP-5 VALUE -4300.
* Java interpreter startup/communication/shutdown failure
 77  SQLE-RC-JAVA-INTERP-FAIL  PIC S9(4) COMP-5 VALUE -4301.
* Java STP/UDF <name>: unclassified exception: <msg>
 77  SQLE-RC-JAVA-UNCLASSIFIED PIC S9(4) COMP-5 VALUE -4302.
* Java STP/UDF <name>: cannot parse class!method in <path>
 77  SQLE-RC-JAVA-PATH-PARSE   PIC S9(4) COMP-5 VALUE -4303.
* Java STP/UDF <name>: cannot load/instantiate Java class <name>
 77  SQLE-RC-JAVA-LOAD-CLASS   PIC S9(4) COMP-5 VALUE -4304.
* Java STP/UDF <name>: internal error code <id>
 77  SQLE-RC-JAVA-INTERNAL     PIC S9(4) COMP-5 VALUE -4305.
* Java STP/UDF <name>: cannot find matching Java method <name>
 77  SQLE-RC-JAVA-METHODLOOKUP PIC S9(4) COMP-5 VALUE -4306.
* Java STP/UDF <name>: argument problems: reason code <num>
 77  SQLE-RC-JAVA-ARGS	       PIC S9(4) COMP-5 VALUE -4307.
* DB2CLI.PROCEDURES structure has been modified
 77  SQLE-RC-DARI-TABLE-MODIFIED PIC S9(4) COMP-5 VALUE -4308.

*************************************************************************
*
* The following functions and symbols are obsolete and may not be supporte
* in future releases. The obsolete functions are provided for backward com
* and exported from DB2API.LIB. All applications should be migrated to use
* Note: Some of the function parameters may be NO-OP.
*	Some structures are larger (eg. SQLEDINFO) in V2.
*
**************************************************************************
* Authentication Not Specified
 77  SQL-AUTHENTICATION-UNDEF  PIC S9(4) COMP-5 VALUE 255.
* Invalid numsegs on create db
 77  SQLE-RC-BAD-SEGPAGES      PIC S9(4) COMP-5 VALUE -1136.

* No CS/6000 license
 77  SQLE-RC-CS-LICENSE        PIC S9(4) COMP-5 VALUE -8003.
* No SNA/6000 license
 77  SQLE-RC-SNA-LICENSE       PIC S9(4) COMP-5 VALUE -8004.

* Authentication Undefined
 77  SQL-AUTHENTICATION-UNDEF  PIC S9(4) COMP-5 VALUE 255.

*************************************************************************
*
* End of obsolete functions and symbols
*
**************************************************************************