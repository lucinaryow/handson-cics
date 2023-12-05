*************************************************************************
*
* Source File Name: SQL
*
* (C) COPYRIGHT International Business Machines Corp. 1987, 1995
* All Rights Reserved
* Licensed Materials - Property of IBM
*
* US Government Users Restricted Rights - Use, duplication or
* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*
* Function = Include File defining:
*	       System Constants
*	       National Language Support Information
*	       SQLCA / SQLDA Constants
*	       Interface to BINDER and PRECOMPILER
*	       Error Message Retrieval Interface
*	       Authorization Constants
*
* Operating System:  Windows NT
*
**************************************************************************
* System Constants

* successful execution
 77  SQL-RC-OK		       PIC S9(4) COMP-5 VALUE 0.

* Maximum nbr of key parts in Index
 77  SQL-KEYPMAX	       PIC S9(4) COMP-5 VALUE 16.
* Maximum key length
 77  SQL-KEYLMAX	       PIC S9(4) COMP-5 VALUE 255.
* Maximum size of field for sort
 77  SQL-SORTFLDLMT	       PIC S9(4) COMP-5 VALUE 254.
* Maximum record length
 77  SQL-MAXRECL	       PIC S9(4) COMP-5 VALUE 4005.
* Maximum nbr of tables in a SELECT
 77  SQL-MAXTABLES	       PIC S9(4) COMP-5 VALUE 15.
* Maximum nbr of items in a SELECT
 77  SQL-MAXSEL-ITEMS	       PIC S9(4) COMP-5 VALUE 255.
* Maximum nbr of Host Vars per stmt
 77  SQL-MAXVARS-STMT	       PIC S9(9) COMP-5 VALUE 32767.
* Maximum nbr of columns in a table
 77  SQL-MAXCOLS	       PIC S9(4) COMP-5 VALUE 255.
* Maximum nbr of parms in a function
 77  SQL-MAXPARMS	       PIC S9(4) COMP-5 VALUE 90.
* Maximum statement size
 77  SQL-MAX-STMT-SIZ	       PIC S9(9) COMP-5 VALUE 32765.

* Size of a SMALLINT
 77  SQL-SMALL-LENGTH	       PIC S9(4) COMP-5 VALUE 2.
* Maximum value of a SMALLINT
 77  SQL-MAXSMALLVAL	       PIC S9(9) COMP-5 VALUE 32767.
* Minimum value of a SMALLINT
 77  SQL-MINSMALLVAL	       PIC S9(9) COMP-5 VALUE -32768.
* Size of an INTEGER
 77  SQL-INT-LENGTH	       PIC S9(4) COMP-5 VALUE 4.
* Maximum value of an INTEGER
* Value of SQL-MAXINTVAL is 2147483647
 01  SQL-MAXINTVAL-INIT PIC X(4) VALUE x"7FFFFFFF".
 01  SQL-MAXINTVAL REDEFINES
     SQL-MAXINTVAL-INIT PIC S9(9) COMP-5.
* Minimum value of an INTEGER
* Value of SQL-MININTVAL is -2147483648
 01  SQL-MININTVAL-INIT PIC X(4) VALUE x"80000000".
 01  SQL-MININTVAL REDEFINES
     SQL-MININTVAL-INIT PIC S9(9) COMP-5.
* Size of a FLOAT
 77  SQL-FLOAT-LENGTH	       PIC S9(4) COMP-5 VALUE 8.
* Default precision for DECIMAL
 77  SQL-DEFDEC-PRECISION      PIC S9(4) COMP-5 VALUE 5.
* Default scale for DECIMAL
 77  SQL-DEFDEC-SCALE	       PIC S9(4) COMP-5 VALUE 0.
* Maximum scale/prec. for DECIMAL
 77  SQL-MAXDECIMAL	       PIC S9(4) COMP-5 VALUE 31.
* Default length for a CHAR
 77  SQL-DEFCHAR	       PIC S9(4) COMP-5 VALUE 1.
* Default length for a graphic
 77  SQL-DEFWCHAR	       PIC S9(4) COMP-5 VALUE 1.
* Maximum length of a CHAR
 77  SQL-MAXCHAR	       PIC S9(4) COMP-5 VALUE 254.
* Maximum length of an LSTRING
 77  SQL-MAXLSTR	       PIC S9(4) COMP-5 VALUE 255.
* Maximum length of a VARCHAR
 77  SQL-MAXVCHAR	       PIC S9(4) COMP-5 VALUE 4000.
* Maximum length of a VARGRAPHIC
 77  SQL-MAXVGRAPH	       PIC S9(4) COMP-5 VALUE 2000.
* Max. length of a BLOB host var
* Value of SQL-MAXBLOB is 2147483647
 01  SQL-MAXBLOB-INIT PIC X(4) VALUE x"7FFFFFFF".
 01  SQL-MAXBLOB REDEFINES
     SQL-MAXBLOB-INIT PIC S9(9) COMP-5.
* Max. length of a CLOB host var
* Value of SQL-MAXCLOB is 2147483647
 01  SQL-MAXCLOB-INIT PIC X(4) VALUE x"7FFFFFFF".
 01  SQL-MAXCLOB REDEFINES
     SQL-MAXCLOB-INIT PIC S9(9) COMP-5.
* Max. length of an DBCLOB host var
* Value of SQL-MAXDBCLOB is 1073741823
 01  SQL-MAXDBCLOB-INIT PIC X(4) VALUE x"3FFFFFFF".
 01  SQL-MAXDBCLOB REDEFINES
     SQL-MAXDBCLOB-INIT PIC S9(9) COMP-5.
* Length of a LOB locator host var
 77  SQL-LOBLOCATOR-LEN        PIC S9(4) COMP-5 VALUE 4.
* Length of a LOB file host var
 77  SQL-LOBFILE-LEN	       PIC S9(4) COMP-5 VALUE 267.
* Overhead for VARCHAR in record
 77  SQL-VCHAROH	       PIC S9(4) COMP-5 VALUE 4.
* Maximum length of a LONG VARCHAR
 77  SQL-LONGMAX	       PIC S9(9) COMP-5 VALUE 32700.
* Max. length of a LONG VARGRAPHIC
 77  SQL-LONGGRMAX	       PIC S9(9) COMP-5 VALUE 16350.
* Overhead for LONG VARCHAR in record
 77  SQL-LVCHAROH	       PIC S9(4) COMP-5 VALUE 24.
* Overhead for LOB in record
 77  SQL-LOBCHAROH	       PIC S9(4) COMP-5 VALUE 312.
* BLOB maximum length, in bytes
* Value of SQL-BLOB-MAXLEN is 2147483647
 01  SQL-BLOB-MAXLEN-INIT PIC X(4) VALUE x"7FFFFFFF".
 01  SQL-BLOB-MAXLEN REDEFINES
     SQL-BLOB-MAXLEN-INIT PIC S9(9) COMP-5.
* CLOB maximum length, in chars
* Value of SQL-CLOB-MAXLEN is 2147483647
 01  SQL-CLOB-MAXLEN-INIT PIC X(4) VALUE x"7FFFFFFF".
 01  SQL-CLOB-MAXLEN REDEFINES
     SQL-CLOB-MAXLEN-INIT PIC S9(9) COMP-5.
* maxlen for dbcs lobs
* Value of SQL-DBCLOB-MAXLEN is 1073741823
 01  SQL-DBCLOB-MAXLEN-INIT PIC X(4) VALUE x"3FFFFFFF".
 01  SQL-DBCLOB-MAXLEN REDEFINES
     SQL-DBCLOB-MAXLEN-INIT PIC S9(9) COMP-5.
* Size of a TIME field
 77  SQL-TIME-LENGTH	       PIC S9(4) COMP-5 VALUE 3.
* Size of a TIME field output
 77  SQL-TIME-STRLEN	       PIC S9(4) COMP-5 VALUE 8.
* Size of a non-USA TIME field output without seconds
 77  SQL-TIME-MINSTRLEN        PIC S9(4) COMP-5 VALUE 5.
* Size of a DATE field
 77  SQL-DATE-LENGTH	       PIC S9(4) COMP-5 VALUE 4.
* Size of a DATE field output
 77  SQL-DATE-STRLEN	       PIC S9(4) COMP-5 VALUE 10.
* Size of a TIMESTAMP field
 77  SQL-STAMP-LENGTH	       PIC S9(4) COMP-5 VALUE 10.
* Size of a TIMESTAMP field output
 77  SQL-STAMP-STRLEN	       PIC S9(4) COMP-5 VALUE 26.
* Size of a TIMESTAMP field output without microseconds
 77  SQL-STAMP-MINSTRLEN       PIC S9(4) COMP-5 VALUE 19.
* Size of a BOOLEAN field
 77  SQL-BOOLEAN-LENGTH        PIC S9(4) COMP-5 VALUE 1.
* Size of an indicator value
 77  SQL-IND-LENGTH	       PIC S9(4) COMP-5 VALUE 2.

* Max size of Stored Proc Name
 77  SQL-MAX-PNAME-LENGTH      PIC S9(4) COMP-5 VALUE 254.
* Maximum length of Long Identifer
 77  SQL-LG-IDENT	       PIC S9(4) COMP-5 VALUE 18.
* Maximum length of Short Identifer
 77  SQL-SH-IDENT	       PIC S9(4) COMP-5 VALUE 8.
* Minimum length of Identifiers
 77  SQL-MN-IDENT	       PIC S9(4) COMP-5 VALUE 1.
* Max size of Host Variable Name
 77  SQL-MAX-VAR-NAME	       PIC S9(4) COMP-5 VALUE 30.
* # of bytes in a kilobyte
 77  SQL-KILO-VALUE	       PIC S9(4) COMP-5 VALUE 1024.
* # of bytes in a megabyte
 77  SQL-MEGA-VALUE	       PIC S9(9) COMP-5 VALUE 1048576.
* # of bytes in a gigabyte
* Value of SQL-GIGA-VALUE is 1073741824
 01  SQL-GIGA-VALUE-INIT PIC X(4) VALUE x"40000000".
 01  SQL-GIGA-VALUE REDEFINES
     SQL-GIGA-VALUE-INIT PIC S9(9) COMP-5.

* size of container name for api's (includes 1 byte for C NULL
* terminator)
 77  SQLB-MAX-CONTAIN-NAME-SZ  PIC S9(4) COMP-5 VALUE 256.

* Codepages
* Codepage 367 - EUC single byte
 77  SQL-CP-367 	       PIC S9(4) COMP-5 VALUE 367.
* Codepage 437 - US, Europe
 77  SQL-CP-437 	       PIC S9(4) COMP-5 VALUE 437.
* Codepage 813 - AIX Greece
 77  SQL-CP-813 	       PIC S9(4) COMP-5 VALUE 813.
* Codepage 819 - ISO 8859-1
 77  SQL-CP-819 	       PIC S9(4) COMP-5 VALUE 819.
* Codepage 850 - International PC
 77  SQL-CP-850 	       PIC S9(4) COMP-5 VALUE 850.
* Codepage 855 - OS2 Cyrillic
 77  SQL-CP-855 	       PIC S9(4) COMP-5 VALUE 855.
* Codepage 852 - OS2 Latin2
 77  SQL-CP-852 	       PIC S9(4) COMP-5 VALUE 852.
* Codepage 857 - OS2 Turkey
 77  SQL-CP-857 	       PIC S9(4) COMP-5 VALUE 857.
* Codepage 860 - Portuguese
 77  SQL-CP-860 	       PIC S9(4) COMP-5 VALUE 860.
* Codepage 862 - OS2 Hebrew
 77  SQL-CP-862 	       PIC S9(4) COMP-5 VALUE 862.
* Codepage 863 - Canadian-French
 77  SQL-CP-863 	       PIC S9(4) COMP-5 VALUE 863.
* Codepage 863 - OS2 Arabic
 77  SQL-CP-864 	       PIC S9(4) COMP-5 VALUE 864.
* Codepage 865 - Norway, Denmark
 77  SQL-CP-865 	       PIC S9(4) COMP-5 VALUE 865.
* Codepage 866 - Russia
 77  SQL-CP-866 	       PIC S9(4) COMP-5 VALUE 866.
* Codepage 869 - OS2 Greece
 77  SQL-CP-869 	       PIC S9(4) COMP-5 VALUE 869.
* Codepage 874 - OS2/AIX Thailand
 77  SQL-CP-874 	       PIC S9(4) COMP-5 VALUE 874.
* Codepage 891 - Korean
 77  SQL-CP-891 	       PIC S9(4) COMP-5 VALUE 891.
* Codepage 897 - Japanese
 77  SQL-CP-897 	       PIC S9(4) COMP-5 VALUE 897.
* Codepage 903 - Chinese
 77  SQL-CP-903 	       PIC S9(4) COMP-5 VALUE 903.
* Codepage 904 - Taiwan
 77  SQL-CP-904 	       PIC S9(4) COMP-5 VALUE 904.
* Codepage 912 - AIX Latin2
 77  SQL-CP-912 	       PIC S9(4) COMP-5 VALUE 912.
* Codepage 915 - AIX Cyrillic
 77  SQL-CP-915 	       PIC S9(4) COMP-5 VALUE 915.
* Codepage 916 - AIX Hebrew
 77  SQL-CP-916 	       PIC S9(4) COMP-5 VALUE 916.
* Codepage 920 - AIX Turkey
 77  SQL-CP-920 	       PIC S9(4) COMP-5 VALUE 920.
* Codepage 921 - Latvia, Lithuania
 77  SQL-CP-921 	       PIC S9(4) COMP-5 VALUE 921.
* Codepage 922 - Estonia
 77  SQL-CP-922 	       PIC S9(4) COMP-5 VALUE 922.
* Codepage 1004 - MS-WINDOWS
 77  SQL-CP-1004	       PIC S9(4) COMP-5 VALUE 1004.
* Codepage 1040 - Extended Korean
 77  SQL-CP-1040	       PIC S9(4) COMP-5 VALUE 1040.
* Codepage 1041 - Extended Japanese
 77  SQL-CP-1041	       PIC S9(4) COMP-5 VALUE 1041.
* Codepage 1042 - Extended Chinese
 77  SQL-CP-1042	       PIC S9(4) COMP-5 VALUE 1042.
* Codepage 1043 - Extended Taiwan
 77  SQL-CP-1043	       PIC S9(4) COMP-5 VALUE 1043.
* Codepage 1046 - AIX Arabic
 77  SQL-CP-1046	       PIC S9(4) COMP-5 VALUE 1046.
* Codepage 1051 - HP Roman8
 77  SQL-CP-1051	       PIC S9(4) COMP-5 VALUE 1051.
* Codepage 1088 - Korea Std
 77  SQL-CP-1088	       PIC S9(4) COMP-5 VALUE 1088.
* Codepage 1089 - AIX Arabic
 77  SQL-CP-1089	       PIC S9(4) COMP-5 VALUE 1089.
* Codepage 1114 - Taiwan Big-5
 77  SQL-CP-1114	       PIC S9(4) COMP-5 VALUE 1114.
* Codepage 1115 - China GB
 77  SQL-CP-1115	       PIC S9(4) COMP-5 VALUE 1115.
* Codepage 1126 - Windows Korean Std
 77  SQL-CP-1126	       PIC S9(4) COMP-5 VALUE 1126.
* Codepage 1250 - Windows Latin-2
 77  SQL-CP-1250	       PIC S9(4) COMP-5 VALUE 1250.
* Codepage 1251 - Windows Cyrillic
 77  SQL-CP-1251	       PIC S9(4) COMP-5 VALUE 1251.
* Codepage 1252 - Windows Latin-1
 77  SQL-CP-1252	       PIC S9(4) COMP-5 VALUE 1252.
* Codepage 1253 - Windows Greek
 77  SQL-CP-1253	       PIC S9(4) COMP-5 VALUE 1253.
* Codepage 1254 - Windows Turkish
 77  SQL-CP-1254	       PIC S9(4) COMP-5 VALUE 1254.
* Codepage 1255 - Windows Hebrew
 77  SQL-CP-1255	       PIC S9(4) COMP-5 VALUE 1255.
* Codepage 1256 - Windows Arabic
 77  SQL-CP-1256	       PIC S9(4) COMP-5 VALUE 1256.
* Codepage 1275 - Mac Latin-1
 77  SQL-CP-1275	       PIC S9(4) COMP-5 VALUE 1275.
* Codepage 1280 - Mac Greek
 77  SQL-CP-1280	       PIC S9(4) COMP-5 VALUE 1280.
* Codepage 1281 - Mac Turkish
 77  SQL-CP-1281	       PIC S9(4) COMP-5 VALUE 1281.
* Codepage 1282 - Mac Latin-2
 77  SQL-CP-1282	       PIC S9(4) COMP-5 VALUE 1282.
* Codepage 1283 - Mac Cyrillic
 77  SQL-CP-1283	       PIC S9(4) COMP-5 VALUE 1283.

* DBCS Codepages
* Codepage 926 - Korean
 77  SQL-CP-926 	       PIC S9(4) COMP-5 VALUE 926.
* Codepage 951 - New Korean
 77  SQL-CP-951 	       PIC S9(4) COMP-5 VALUE 951.
* Codepage 301 - Japanese
 77  SQL-CP-301 	       PIC S9(4) COMP-5 VALUE 301.
* Codepage 928 - Chinese
 77  SQL-CP-928 	       PIC S9(4) COMP-5 VALUE 928.
* Codepage 927 - Taiwan
 77  SQL-CP-927 	       PIC S9(4) COMP-5 VALUE 927.
* Codepage 941 - Japanese
 77  SQL-CP-941 	       PIC S9(4) COMP-5 VALUE 941.
* Codepage 947 - Taiwan Big-5
 77  SQL-CP-947 	       PIC S9(4) COMP-5 VALUE 947.
* Codepage 971 - Korean 5601
 77  SQL-CP-971 	       PIC S9(4) COMP-5 VALUE 971.
* Codepage 1351 - Japanese
 77  SQL-CP-1351	       PIC S9(4) COMP-5 VALUE 1351.
* Codepage 1362 - Korean Windows
 77  SQL-CP-1362	       PIC S9(4) COMP-5 VALUE 1362.
* Codepage1380 - China GB
 77  SQL-CP-1380	       PIC S9(4) COMP-5 VALUE 1380.
* Codepage1382 - Simp Chinese GB
 77  SQL-CP-1382	       PIC S9(4) COMP-5 VALUE 1382.
* Codepage13488 - UCS-2
 77  SQL-CP-13488	       PIC S9(9) COMP-5 VALUE 13488.

* Combined Codepages
* Codepage 891 + 926 - Korean
 77  SQL-CP-934 	       PIC S9(4) COMP-5 VALUE 934.
* CP 1088 + 951 - Korean Std
 77  SQL-CP-949 	       PIC S9(4) COMP-5 VALUE 949.
* Codepage 897 + 301 - Japanese
 77  SQL-CP-932 	       PIC S9(4) COMP-5 VALUE 932.
* Codepage 903 + 928 - Chinese
 77  SQL-CP-936 	       PIC S9(4) COMP-5 VALUE 936.
* Codepage 904 + 927 - Taiwan
 77  SQL-CP-938 	       PIC S9(4) COMP-5 VALUE 938.
* Codepage 1040 + 926 - Ext.Korean
 77  SQL-CP-944 	       PIC S9(4) COMP-5 VALUE 944.
* Codepage 1041 + 301 - Ext.Japanese
 77  SQL-CP-942 	       PIC S9(4) COMP-5 VALUE 942.
* Codepage  897 + 941 - Ext.Japanese
 77  SQL-CP-943 	       PIC S9(4) COMP-5 VALUE 943.
* Codepage 1042 + 928 - Ext.Chinese
 77  SQL-CP-946 	       PIC S9(4) COMP-5 VALUE 946.
* Codepage 1043 + 927 - Ext.Taiwan
 77  SQL-CP-948 	       PIC S9(4) COMP-5 VALUE 948.
* Codepage 1114 + 947 - Taiwan Big5
 77  SQL-CP-950 	       PIC S9(4) COMP-5 VALUE 950.
* Codepage 954 + 13488 - euc Japan
 77  SQL-CP-954 	       PIC S9(4) COMP-5 VALUE 954.
* Codepage 964 + 13488 - euc Taiwan
 77  SQL-CP-964 	       PIC S9(4) COMP-5 VALUE 964.
* Codepage  367 + 971 - Korean 5601
 77  SQL-CP-970 	       PIC S9(4) COMP-5 VALUE 970.
* Codepage 1363 - Korean Windows
 77  SQL-CP-1363	       PIC S9(4) COMP-5 VALUE 1363.
* Codepage 1115 +1380 - China GB
 77  SQL-CP-1381	       PIC S9(4) COMP-5 VALUE 1381.
* Codepage  367 +1382 - Chinese GB
 77  SQL-CP-1383	       PIC S9(4) COMP-5 VALUE 1383.

* Codepage  1041 + 1351 - Japanese
 77  SQL-CP-5039	       PIC S9(4) COMP-5 VALUE 5039.
* Datastream Types
* Single byte PC
 77  SQL-SBC-PC 	       PIC S9(4) COMP-5 VALUE 0.
* Japanese-PC
 77  SQL-JPN-PC 	       PIC S9(4) COMP-5 VALUE 1.
* Chinese-PC
 77  SQL-CHN-PC 	       PIC S9(4) COMP-5 VALUE 2.
* Korean-PC
 77  SQL-KOR-PC 	       PIC S9(4) COMP-5 VALUE 3.
* New Korean-PC
 77  SQL-KSC-PC 	       PIC S9(4) COMP-5 VALUE 4.
* Korean 5601
 77  SQL-KR5-PC 	       PIC S9(4) COMP-5 VALUE 5.
* Taiwan Big-5
 77  SQL-TWN-PC 	       PIC S9(4) COMP-5 VALUE 6.
* China GB
 77  SQL-CGB-PC 	       PIC S9(4) COMP-5 VALUE 7.
* China GB on AIX
 77  SQL-CGBA-PC	       PIC S9(4) COMP-5 VALUE 8.
* Japan euc
 77  SQL-EUCJP-PC	       PIC S9(4) COMP-5 VALUE 9.
* Taiwan euc
 77  SQL-EUCTW-PC	       PIC S9(4) COMP-5 VALUE 10.
* UCS-2
 77  SQL-UCS2-PC	       PIC S9(4) COMP-5 VALUE 11.
* Korean Windows
 77  SQL-KSC2-PC	       PIC S9(4) COMP-5 VALUE 12.
* Unknown
 77  SQL-UNKN-PC	       PIC S9(4) COMP-5 VALUE 255.

* AIX codeset & locale lengths
 77  SQL-CODESET-LEN	       PIC S9(4) COMP-5 VALUE 9.
 77  SQL-LOCALE-LEN	       PIC S9(4) COMP-5 VALUE 5.

* SQLCA Constants
* Invalid SQLCA address
 77  SQL-RC-INVALID-SQLCA      PIC S9(4) COMP-5 VALUE -1.

* Size of SQLCA
 77  SQLCA-SIZE 	       PIC S9(4) COMP-5 VALUE 136.

* SQL Error message token delimiter
 77  SQL-ERRMC-PRES	       PIC S9(4) COMP-5 VALUE 255.

* Offset in SQLERRD - Diagnostic information
* return code
 77  SQL-ERRD-RC	       PIC S9(4) COMP-5 VALUE 0.
* reason code
 77  SQL-ERRD-REAS	       PIC S9(4) COMP-5 VALUE 1.
* nbr rows inserted/updated/deleted
 77  SQL-ERRD-CNT	       PIC S9(4) COMP-5 VALUE 2.
* optimizer estimate of # rows
 77  SQL-ERRD-OPT-CARD	       PIC S9(4) COMP-5 VALUE 2.
* obsolete -- do not use --
 77  SQL-ERRD-OPTM	       PIC S9(4) COMP-5 VALUE 3.
* optimzer estimate of total cost
 77  SQL-ERRD-OPT-TOTCOST      PIC S9(4) COMP-5 VALUE 3.
* nbr of cascaded deletes/updates
 77  SQL-ERRD-DCNT	       PIC S9(4) COMP-5 VALUE 4.
* line number for recompile error
 77  SQL-ERRD-LINE	       PIC S9(4) COMP-5 VALUE 4.
* diagnostics
 77  SQL-ERRD-DIAG	       PIC S9(4) COMP-5 VALUE 5.

* Indexes in SQLWARN - Warning flags
* composite - set if any warnings
 77  SQL-WARN-ANY	       PIC S9(4) COMP-5 VALUE 0.
* string column truncated
 77  SQL-WARN-TRUNC	       PIC S9(4) COMP-5 VALUE 1.
* null values eliminated
 77  SQL-WARN-NUL	       PIC S9(4) COMP-5 VALUE 2.
* nbr of columns/host vars mismatch
 77  SQL-WARN-MISM	       PIC S9(4) COMP-5 VALUE 3.
* no WHERE clause in update/delete
 77  SQL-WARN-ALLR	       PIC S9(4) COMP-5 VALUE 4.
* date has been truncated
 77  SQL-WARN-DATE	       PIC S9(4) COMP-5 VALUE 6.
* character conversion substitution
 77  SQL-WARN-SUB	       PIC S9(4) COMP-5 VALUE 8.
* SQLCA conversion error
 77  SQL-WARN-SQLCA	       PIC S9(4) COMP-5 VALUE 10.

* Values for Warning flags in SQLWARN
* warning indicator
 77  SQL-WARNING               PIC X(1) value "W".
* null terminator truncated warning
 77  SQL-NULL-TRN              PIC X(1) value "N".
* truncation warning with application context length returned in
* sqlind
 77  SQL-TRN-APP-LEN           PIC X(1) value "X".
* no warning indicator
 77  SQL-NO-WARN               PIC X(1) value " ".

* SQLDA Constants

* Increment for type with null indicator
 77  SQL-TYP-NULINC	       PIC S9(4) COMP-5 VALUE 1.

* Variable Types
* DATE
 77  SQL-TYP-DATE	       PIC S9(4) COMP-5 VALUE 384.
 77  SQL-TYP-NDATE	       PIC S9(4) COMP-5 VALUE 385.

* TIME
 77  SQL-TYP-TIME	       PIC S9(4) COMP-5 VALUE 388.
 77  SQL-TYP-NTIME	       PIC S9(4) COMP-5 VALUE 389.

* TIMESTAMP
 77  SQL-TYP-STAMP	       PIC S9(4) COMP-5 VALUE 392.
 77  SQL-TYP-NSTAMP	       PIC S9(4) COMP-5 VALUE 393.

* C NUL-terminated graphic str
 77  SQL-TYP-CGSTR	       PIC S9(4) COMP-5 VALUE 400.
 77  SQL-TYP-NCGSTR	       PIC S9(4) COMP-5 VALUE 401.

* BLOB - varying length string
 77  SQL-TYP-BLOB	       PIC S9(4) COMP-5 VALUE 404.
 77  SQL-TYP-NBLOB	       PIC S9(4) COMP-5 VALUE 405.

* CLOB - varying length string
 77  SQL-TYP-CLOB	       PIC S9(4) COMP-5 VALUE 408.
 77  SQL-TYP-NCLOB	       PIC S9(4) COMP-5 VALUE 409.

* DBCLOB - varying length string
 77  SQL-TYP-DBCLOB	       PIC S9(4) COMP-5 VALUE 412.
 77  SQL-TYP-NDBCLOB	       PIC S9(4) COMP-5 VALUE 413.

* VARCHAR(i) - varying length string (2 byte length)
 77  SQL-TYP-VARCHAR	       PIC S9(4) COMP-5 VALUE 448.
 77  SQL-TYP-NVARCHAR	       PIC S9(4) COMP-5 VALUE 449.

* CHAR(i) - fixed length string
 77  SQL-TYP-CHAR	       PIC S9(4) COMP-5 VALUE 452.
 77  SQL-TYP-NCHAR	       PIC S9(4) COMP-5 VALUE 453.

* LONG VARCHAR - varying length string
 77  SQL-TYP-LONG	       PIC S9(4) COMP-5 VALUE 456.
 77  SQL-TYP-NLONG	       PIC S9(4) COMP-5 VALUE 457.

* varying length string for C (null terminated)
 77  SQL-TYP-CSTR	       PIC S9(4) COMP-5 VALUE 460.
 77  SQL-TYP-NCSTR	       PIC S9(4) COMP-5 VALUE 461.

* VARGRAPHIC(i) - varying length graphic string (2 byte length)
 77  SQL-TYP-VARGRAPH	       PIC S9(4) COMP-5 VALUE 464.
 77  SQL-TYP-NVARGRAPH	       PIC S9(4) COMP-5 VALUE 465.

* GRAPHIC(i) - fixed length graphic string
 77  SQL-TYP-GRAPHIC	       PIC S9(4) COMP-5 VALUE 468.
 77  SQL-TYP-NGRAPHIC	       PIC S9(4) COMP-5 VALUE 469.

* LONG VARGRAPHIC(i) - varying length graphic string
 77  SQL-TYP-LONGRAPH	       PIC S9(4) COMP-5 VALUE 472.
 77  SQL-TYP-NLONGRAPH	       PIC S9(4) COMP-5 VALUE 473.

* varying length string for Pascal (1-byte length)
 77  SQL-TYP-LSTR	       PIC S9(4) COMP-5 VALUE 476.
 77  SQL-TYP-NLSTR	       PIC S9(4) COMP-5 VALUE 477.

* FLOAT - 8-byte floating point
 77  SQL-TYP-FLOAT	       PIC S9(4) COMP-5 VALUE 480.
 77  SQL-TYP-NFLOAT	       PIC S9(4) COMP-5 VALUE 481.

* DECIMAL (m,n)
 77  SQL-TYP-DECIMAL	       PIC S9(4) COMP-5 VALUE 484.
 77  SQL-TYP-NDECIMAL	       PIC S9(4) COMP-5 VALUE 485.

* Zoned Decimal -> DECIMAL (m,n)
 77  SQL-TYP-ZONED	       PIC S9(4) COMP-5 VALUE 488.
 77  SQL-TYP-NZONED	       PIC S9(4) COMP-5 VALUE 489.

* INTEGER - 4-byte signed integer
 77  SQL-TYP-INTEGER	       PIC S9(4) COMP-5 VALUE 496.
 77  SQL-TYP-NINTEGER	       PIC S9(4) COMP-5 VALUE 497.

* SMALLINT - 2-byte signed integer
 77  SQL-TYP-SMALL	       PIC S9(4) COMP-5 VALUE 500.
 77  SQL-TYP-NSMALL	       PIC S9(4) COMP-5 VALUE 501.

* NUMERIC -> DECIMAL (m,n)
 77  SQL-TYP-NUMERIC	       PIC S9(4) COMP-5 VALUE 504.
 77  SQL-TYP-NNUMERIC	       PIC S9(4) COMP-5 VALUE 505.

* BLOB File - Binary Large Object File
 77  SQL-TYP-BLOB-FILE	       PIC S9(4) COMP-5 VALUE 804.
 77  SQL-TYP-NBLOB-FILE        PIC S9(4) COMP-5 VALUE 805.

* CLOB File - Char Large Object File
 77  SQL-TYP-CLOB-FILE	       PIC S9(4) COMP-5 VALUE 808.
 77  SQL-TYP-NCLOB-FILE        PIC S9(4) COMP-5 VALUE 809.

* DBCLOB File - Double Byte Char Large Object File
 77  SQL-TYP-DBCLOB-FILE       PIC S9(4) COMP-5 VALUE 812.
 77  SQL-TYP-NDBCLOB-FILE      PIC S9(4) COMP-5 VALUE 813.

* BLOB locator
 77  SQL-TYP-BLOB-LOCATOR      PIC S9(4) COMP-5 VALUE 960.
 77  SQL-TYP-NBLOB-LOCATOR     PIC S9(4) COMP-5 VALUE 961.

* CLOB locator
 77  SQL-TYP-CLOB-LOCATOR      PIC S9(4) COMP-5 VALUE 964.
 77  SQL-TYP-NCLOB-LOCATOR     PIC S9(4) COMP-5 VALUE 965.

* DBCLOB locator
 77  SQL-TYP-DBCLOB-LOCATOR    PIC S9(4) COMP-5 VALUE 968.
 77  SQL-TYP-NDBCLOB-LOCATOR   PIC S9(4) COMP-5 VALUE 969.

 77  SQL-LOBTOKEN-LEN	       PIC S9(4) COMP-5 VALUE 4.
 77  SQL-TYP-BLOB-TOKEN        PIC S9(4) COMP-5 VALUE 960.
 77  SQL-TYP-NBLOB-TOKEN       PIC S9(4) COMP-5 VALUE 961.
 77  SQL-TYP-CLOB-TOKEN        PIC S9(4) COMP-5 VALUE 964.
 77  SQL-TYP-NCLOB-TOKEN       PIC S9(4) COMP-5 VALUE 965.
 77  SQL-TYP-DBCLOB-TOKEN      PIC S9(4) COMP-5 VALUE 968.
 77  SQL-TYP-NDBCLOB-TOKEN     PIC S9(4) COMP-5 VALUE 969.
 01  SQL-NCLOB-MAXLEN-INIT PIC X(4) VALUE x"3FFFFFFF".
 01  SQL-NCLOB-MAXLEN REDEFINES
     SQL-NCLOB-MAXLEN-INIT PIC S9(9) COMP-5.
 77  SQL-LOBHANDLE-LEN	       PIC S9(4) COMP-5 VALUE 4.
 77  SQL-TYP-BLOB-HANDLE       PIC S9(4) COMP-5 VALUE 960.
 77  SQL-TYP-NBLOB-HANDLE      PIC S9(4) COMP-5 VALUE 961.
 77  SQL-TYP-CLOB-HANDLE       PIC S9(4) COMP-5 VALUE 964.
 77  SQL-TYP-NCLOB-HANDLE      PIC S9(4) COMP-5 VALUE 965.
 77  SQL-TYP-DBCLOB-HANDLE     PIC S9(4) COMP-5 VALUE 968.
 77  SQL-TYP-NDBCLOB-HANDLE    PIC S9(4) COMP-5 VALUE 969.

* Return Codes for sqlabndx and sqlaprep
* The option(s) specified are not supported by the target  database
* and will be ignored
 77  SQLA-RC-OPT-IGNORED       PIC S9(4) COMP-5 VALUE 20.
* Bind execution succeeded with warnings.
 77  SQLA-RC-BINDWARN	       PIC S9(4) COMP-5 VALUE 25.
* Precompilation succeeded with warnings.
 77  SQLA-RC-PREPWARN	       PIC S9(4) COMP-5 VALUE 25.
* Bind execution failed
 77  SQLA-RC-BINDERROR	       PIC S9(4) COMP-5 VALUE -1.
* Precompilation failed
 77  SQLA-RC-PREPERROR	       PIC S9(4) COMP-5 VALUE -1.
* Invalid bind file
 77  SQLA-RC-BAD-BINDNAME      PIC S9(4) COMP-5 VALUE -2.
* Invalid database
 77  SQLA-RC-BAD-DBNAME        PIC S9(4) COMP-5 VALUE -3.
* Invalid message file
 77  SQLA-RC-BAD-MSGNAME       PIC S9(4) COMP-5 VALUE -5.
* Invalid format
 77  SQLA-RC-BAD-FORMAT        PIC S9(4) COMP-5 VALUE -6.
* Error opening list file
 77  SQLA-RC-OPEN-ERROR        PIC S9(4) COMP-5 VALUE -31.
* Error opening message file
 77  SQLA-RC-MFILE-OPEN-ERR    PIC S9(4) COMP-5 VALUE -35.
* Source file name is invalid
 77  SQLA-RC-FILE-NAME-BAD     PIC S9(4) COMP-5 VALUE -36.
* Bind file corrupted
 77  SQLA-RC-BAD-BNDFILE       PIC S9(4) COMP-5 VALUE -39.
* Bind list errors
 77  SQLA-RC-LIST-ERROR        PIC S9(4) COMP-5 VALUE -40.
* Interrupt
 77  SQLA-RC-INTERRUPT	       PIC S9(4) COMP-5 VALUE -94.
* System error
 77  SQLA-RC-OSERROR	       PIC S9(4) COMP-5 VALUE -1086.
* Prep/Bind already in use
 77  SQLA-RC-PREP-BIND-BUSY    PIC S9(4) COMP-5 VALUE -1392.
* Invalid parm. length
 77  SQLA-RC-OPTION-LEN-BAD    PIC S9(4) COMP-5 VALUE -4903.
* Invalid parm. ptr
 77  SQLA-RC-OPTION-PTR-BAD    PIC S9(4) COMP-5 VALUE -4904.
* Invalid parm. size
 77  SQLA-RC-OPTION-SIZE-BAD   PIC S9(4) COMP-5 VALUE -4905.
* Invalid parm. data
 77  SQLA-RC-OPTION-DATA-BAD   PIC S9(4) COMP-5 VALUE -4917.
* Invalid option or option value
 77  SQLA-RC-OPTION-INVALID    PIC S9(4) COMP-5 VALUE -4930.
* No SDK/6000 license
 77  SQLA-RC-SDK-LICENSE       PIC S9(4) COMP-5 VALUE -8005.

* Values used for the date/time format parameter of sqlabind() **
* OBSOLETE **
* FORMAT = Default for Country Code
 77  SQL-FMT-DEF               PIC X(3) value "DEF".
* FORMAT = USA
 77  SQL-FMT-USA               PIC X(3) value "USA".
* FORMAT = EUR
 77  SQL-FMT-EUR               PIC X(3) value "EUR".
* FORMAT = ISO
 77  SQL-FMT-ISO               PIC X(3) value "ISO".
* FORMAT = JIS
 77  SQL-FMT-JIS               PIC X(3) value "JIS".
* FORMAT = LOCAL
 77  SQL-FMT-LOC               PIC X(3) value "LOC".

* The size of a date/time format buffer
 77  SQL-FMT-LENGTH	       PIC S9(4) COMP-5 VALUE 3.

* Structures used system wide


* File reference structure for LOBs
 01 SQLFILE.
     05 SQL-NAME-LENGTH        PIC 9(9) COMP-5.
     05 SQL-DATA-LENGTH        PIC 9(9) COMP-5.
     05 SQL-FILE-OPTIONS       PIC 9(9) COMP-5.
     05 SQL-NAME	       PIC X(255).
     05 FILLER		       PIC X(1).

* Values used for file_options in the sqlfile structure
* Input file to read from
 77  SQL-FILE-READ	       PIC S9(4) COMP-5 VALUE 2.
* Output file - new file to be created
 77  SQL-FILE-CREATE	       PIC S9(4) COMP-5 VALUE 8.
* Output file - overwrite existing file or create a new file if it
* doesn't exist
 77  SQL-FILE-OVERWRITE        PIC S9(4) COMP-5 VALUE 16.
* Output file - append to an existing file or create a new file if it
* doesn't exist
 77  SQL-FILE-APPEND	       PIC S9(4) COMP-5 VALUE 32.

* Structure used to store binder options when calling sqlabndr()
* or sqlabndx() or to store precompile options when calling
* sqlaprep().

* Assume maximum number of binder/precompiler options ranges
* between 1 and 50.

 01 SQLOPT.
     05 SQLOPTHEADER.
       10 ALLOCATED   PIC 9(9) COMP-5.
       10 USED	      PIC 9(9) COMP-5.
     05 SQLOPTIONS OCCURS 1 TO 50 DEPENDING ON ALLOCATED.
       10 SQLOPT-TYPE	     PIC 9(9) COMP-5.
       10 SQLOPT-VAL	     PIC 9(9) COMP-5.
       10 SQLOPT-VAL-PTR     REDEFINES SQLOPT-VAL
			     USAGE IS POINTER.

* Values used for option[n].type in the sqloptions structure
* of sqlabndx() and sqlaprep().
* Option for date/time format - bind and precompile option
 77  SQL-DATETIME-OPT	       PIC S9(4) COMP-5 VALUE 1.
* Option for standards level compliance - precompile option only
 77  SQL-STANDARDS-OPT	       PIC S9(4) COMP-5 VALUE 2.
* Option for isolation level - bind and precompile option
 77  SQL-ISO-OPT	       PIC S9(4) COMP-5 VALUE 4.
* Option for record blocking - bind and precompile option
 77  SQL-BLOCK-OPT	       PIC S9(4) COMP-5 VALUE 5.
* Option for granting privileges - bind option only
 77  SQL-GRANT-OPT	       PIC S9(4) COMP-5 VALUE 6.
* Option for the Flagger - precompile option only
 77  SQL-FLAG-OPT	       PIC S9(4) COMP-5 VALUE 8.
* Specifies whether one or multiple connections are allowed
* similtaneously within a unit of work.
 77  SQL-CONNECT-OPT	       PIC S9(4) COMP-5 VALUE 16.
* Specifies the set of rules used for connection to multiple databases
* within a single unit of work
 77  SQL-RULES-OPT	       PIC S9(4) COMP-5 VALUE 17.
* Specifies which of multiple databases connected to will be
* disconnected when a COMMIT or ROLLBACK is issued.
 77  SQL-DISCONNECT-OPT        PIC S9(4) COMP-5 VALUE 18.
* Specifies what syncpoint option (for example one phase or two phase)
* will be used
 77  SQL-SYNCPOINT-OPT	       PIC S9(4) COMP-5 VALUE 19.
* Option to create a bind file - precompile option only
 77  SQL-BIND-OPT	       PIC S9(4) COMP-5 VALUE 20.
* Option specifies SAA/non-SAA compatibility - FORTRAN precompile
* option only
 77  SQL-SAA-OPT	       PIC S9(4) COMP-5 VALUE 21.
* Option to create a package with a specific name - precompile option
* only
 77  SQL-PKG-OPT	       PIC S9(4) COMP-5 VALUE 23.
* Option to specify SQLDA optimization - precompile option only
 77  SQL-OPTIM-OPT	       PIC S9(4) COMP-5 VALUE 24.
* Option to not create a package or bind file - precompile option only
 77  SQL-SYNTAX-OPT	       PIC S9(4) COMP-5 VALUE 25.
* Indicates under what conditions a package will be be created - bind
* and precompile option
 77  SQL-SQLERROR-OPT	       PIC S9(4) COMP-5 VALUE 25.
* Option to suppress #line macro generation in modified source file -
* C precompile option only
 77  SQL-LINEMACRO-OPT	       PIC S9(4) COMP-5 VALUE 26.
* 'No-op' option - ignore this entry in the option array - bind and
* precompile option
 77  SQL-NO-OPT 	       PIC S9(4) COMP-5 VALUE 27.
* Level of a module - precompile option only
 77  SQL-LEVEL-OPT	       PIC S9(4) COMP-5 VALUE 30.
* Package collection identifier - precompile option only
 77  SQL-COLLECTION-OPT        PIC S9(4) COMP-5 VALUE 31.
* Package version identifier - precompile option only
 77  SQL-VERSION-OPT	       PIC S9(4) COMP-5 VALUE 32.
* Package owner authorization identifier - bind and precompile option
 77  SQL-OWNER-OPT	       PIC S9(4) COMP-5 VALUE 33.
* Synonym for owner - bind and precompile option
 77  SQL-SCHEMA-OPT	       PIC S9(4) COMP-5 VALUE 33.
* Authorization identifier that is to be used as a qualifier for
* unqualified objects - bind and precompile option
 77  SQL-QUALIFIER-OPT	       PIC S9(4) COMP-5 VALUE 34.
* Synonym for qualifier - bind and precompile option
 77  SQL-CATALOG-OPT	       PIC S9(4) COMP-5 VALUE 34.
* Package description - bind and precompile option
 77  SQL-TEXT-OPT	       PIC S9(4) COMP-5 VALUE 35.
* Indicates when object validation occurs - bind and precompile option
 77  SQL-VALIDATE-OPT	       PIC S9(4) COMP-5 VALUE 40.
* Determines whether information will be produced about how the SQL
* statements in a package will be executed - bind and precompile
* option
 77  SQL-EXPLAIN-OPT	       PIC S9(4) COMP-5 VALUE 41.
* Indicates whether a package is to be added or replaced - bind and
* precompile option
 77  SQL-ACTION-OPT	       PIC S9(4) COMP-5 VALUE 42.
* Replaces a specific version of a package - bind and precompile
* option
 77  SQL-REPLVER-OPT	       PIC S9(4) COMP-5 VALUE 44.
* Indicates whether EXECUTE authorities are to be preserved when a
* package is replaced - bind and precompile option
 77  SQL-RETAIN-OPT	       PIC S9(4) COMP-5 VALUE 45.
* Indicates whether resources are released at each COMMIT or when the
* application  terminates - bind and precompile option
 77  SQL-RELEASE-OPT	       PIC S9(4) COMP-5 VALUE 46.
* Specifies whether or not the query is executed using I/O parallelism
* - bind and precompile option
 77  SQL-DEGREE-OPT	       PIC S9(4) COMP-5 VALUE 47.
* Designates whether an apostrophe or quote will be used as a string
* delimiter - bind and precompile option
 77  SQL-STRDEL-OPT	       PIC S9(4) COMP-5 VALUE 50.
* Designates whether a period or comma will be used as a decimal point
* indicator - bind and precompile option
 77  SQL-DECDEL-OPT	       PIC S9(4) COMP-5 VALUE 51.
* Designates default character subtype that is to be used for column
* definitions in the CREATE and ALTER TABLE SQL statements - bind and
* precompile option
 77  SQL-CHARSUB-OPT	       PIC S9(4) COMP-5 VALUE 55.
* Designates what CCSID will be used for single byte characters for
* character column definitions without a specific CCSID clause in the
* CREATE and ALTER TABLE SQL statements - bind and precompile option
 77  SQL-CCSIDS-OPT	       PIC S9(4) COMP-5 VALUE 56.
* Designates what CCSID will be used for mixed byte characters for
* character column definitions without a specific CCSID clause in the
* CREATE and ALTER TABLE SQL statements - bind and precompile option
 77  SQL-CCSIDM-OPT	       PIC S9(4) COMP-5 VALUE 57.
* Designates what CCSID will be used for double byte characters for
* character column definitions without a specific CCSID clause in the
* CREATE and ALTER TABLE SQL statements - bind and precompile option
 77  SQL-CCSIDG-OPT	       PIC S9(4) COMP-5 VALUE 58.
* Specifies maximum precision to be used in decimal arithmetic
* operations - bind and precompile option
 77  SQL-DEC-OPT	       PIC S9(4) COMP-5 VALUE 59.
* Specifies handling of graphic vars. - precompile only
 77  SQL-WCHAR-OPT	       PIC S9(4) COMP-5 VALUE 60.
* Specifies which authorization identifier to use when dynamic SQL in
* a package is executed. Owner of package or authid executing package
* - bind and precompile option
 77  SQL-DYNAMICRULES-OPT      PIC S9(4) COMP-5 VALUE 61.
* Buffers VALUE inserts - bind and precompile option for DB2/PE
* servers only
 77  SQL-INSERT-OPT	       PIC S9(4) COMP-5 VALUE 62.
* Capture explain snapshot - bind and precompile option
 77  SQL-EXPLSNAP-OPT	       PIC S9(4) COMP-5 VALUE 63.
* Path for user-defined function resolution - bind and precompile
* option
 77  SQL-FUNCTION-PATH	       PIC S9(4) COMP-5 VALUE 64.
* Disable prepare-time SQL warnings - bind and precompile option
 77  SQL-SQLWARN-OPT	       PIC S9(4) COMP-5 VALUE 65.
* Set query optimization class - bind and precompile option
 77  SQL-QUERYOPT-OPT	       PIC S9(4) COMP-5 VALUE 66.
* Target compiler - precompile option
 77  SQL-TARGET-OPT	       PIC S9(4) COMP-5 VALUE 67.
* Name of precompiler output file - precompile option
 77  SQL-PREP-OUTPUT-OPT       PIC S9(4) COMP-5 VALUE 68.

* Values used for option[n].val when option[n].type is
* SQL_DATETIME_OPT. These can also be used for the date/time
* format parameter of sqlabind().

* FORMAT = Default for Country Code
 77  SQL-DATETIME-DEF	       PIC S9(4) COMP-5 VALUE 48.
* FORMAT = USA
 77  SQL-DATETIME-USA	       PIC S9(4) COMP-5 VALUE 49.
* FORMAT = EUR
 77  SQL-DATETIME-EUR	       PIC S9(4) COMP-5 VALUE 50.
* FORMAT = ISO
 77  SQL-DATETIME-ISO	       PIC S9(4) COMP-5 VALUE 51.
* FORMAT = JIS
 77  SQL-DATETIME-JIS	       PIC S9(4) COMP-5 VALUE 52.
* FORMAT = LOCAL
 77  SQL-DATETIME-LOC	       PIC S9(4) COMP-5 VALUE 53.

* The following constants are here for backwards compatbility with
* earlier releases.

 77  SQL-FRMT-OPT	       PIC S9(4) COMP-5 VALUE 1.
 77  SQL-FMT-0		       PIC S9(4) COMP-5 VALUE 48.
 77  SQL-FMT-1		       PIC S9(4) COMP-5 VALUE 49.
 77  SQL-FMT-2		       PIC S9(4) COMP-5 VALUE 50.
 77  SQL-FMT-3		       PIC S9(4) COMP-5 VALUE 51.
 77  SQL-FMT-4		       PIC S9(4) COMP-5 VALUE 52.
 77  SQL-FMT-5		       PIC S9(4) COMP-5 VALUE 53.

* Values used for option[n].val when option[n].type is
* SQL_STANDARDS_OPT.
* SAA Level 1 Database CPI
 77  SQL-SAA-COMP	       PIC S9(4) COMP-5 VALUE 0.
* MIA
 77  SQL-MIA-COMP	       PIC S9(4) COMP-5 VALUE 1.

* Values used for option[n].val when option[n].type is SQL_ISO_OPT
* Repeatable read level
 77  SQL-REP-READ	       PIC S9(4) COMP-5 VALUE 0.
* Cursor stability level
 77  SQL-CURSOR-STAB	       PIC S9(4) COMP-5 VALUE 1.
* Uncommitted read level
 77  SQL-UNCOM-READ	       PIC S9(4) COMP-5 VALUE 2.
* Read stability level
 77  SQL-READ-STAB	       PIC S9(4) COMP-5 VALUE 3.
* No Commit level      l
 77  SQL-NO-COMMIT	       PIC S9(4) COMP-5 VALUE 4.

* Values used for option[n].val when option[n].type is SQL_BLOCK_OPT
* Block Unambiguous cursors
 77  SQL-BL-UNAMBIG	       PIC S9(4) COMP-5 VALUE 0.
* Block All cursors
 77  SQL-BL-ALL 	       PIC S9(4) COMP-5 VALUE 1.
* Block No cursors
 77  SQL-NO-BL		       PIC S9(4) COMP-5 VALUE 2.

* Values used for option[n].val when option[n].type is SQL_FLAG_OPT
* Flagger check against MVS
 77  SQL-MVSDB2V23-SYNTAX      PIC S9(4) COMP-5 VALUE 4.
* DB2 V2.3, V3.1 or V4.1 SQL
 77  SQL-MVSDB2V31-SYNTAX      PIC S9(4) COMP-5 VALUE 5.
* syntax
 77  SQL-MVSDB2V41-SYNTAX      PIC S9(4) COMP-5 VALUE 6.

* Values used for option[n].val when option[n].type is SQL_SAA_OPT.
* SQLCA definition not SAA compatible
 77  SQL-SAA-NO 	       PIC S9(4) COMP-5 VALUE 0.
* SQLCA definition is SAA compatible
 77  SQL-SAA-YES	       PIC S9(4) COMP-5 VALUE 1.

* Values used for option[n].val when option[n].type is SQL_OPTIM_OPT.
* Do not optimize SQLDA initialization
 77  SQL-DONT-OPTIMIZE	       PIC S9(4) COMP-5 VALUE 0.
* Optimize SQLDA initialization
 77  SQL-OPTIMIZE	       PIC S9(4) COMP-5 VALUE 1.

* Values used for option[n].val when option[n].type is SQL_SYNTAX_OPT.
* Create a package and/or a bind file
 77  SQL-NO-SYNTAX-CHECK       PIC S9(4) COMP-5 VALUE 0.
* Do not create a package or bind file
 77  SQL-SYNTAX-CHECK	       PIC S9(4) COMP-5 VALUE 1.

* Values used for option[n].val when option[n].type is
* SQL_LINEMACRO_OPT.
* Do not generate #line macros in modified source file
 77  SQL-NO-LINE-MACROS        PIC S9(4) COMP-5 VALUE 0.
* Generate #line macros in modified source file
 77  SQL-LINE-MACROS	       PIC S9(4) COMP-5 VALUE 1.

* Values used for option[n].val when option[n].type is SQL_WCHAR_OPT.
* graphic variable not converted
 77  SQL-WCHAR-NOCONVERT       PIC S9(4) COMP-5 VALUE 0.
* graphic variable converted
 77  SQL-WCHAR-CONVERT	       PIC S9(4) COMP-5 VALUE 1.

* Maximum sqlchar length for option[n].val when option[n].type is
* SQL_LEVEL_OPT
 77  SQL-MAX-LEVEL	       PIC S9(4) COMP-5 VALUE 8.

* Values used for option[n].val when option[n].type is SQL_CONNECT_OPT
* Dynamic SQL statements will be chained.
 77  SQL-DEFERRED-PREPARE-YES  PIC S9(4) COMP-5 VALUE 1.
* Dynamic SQL statements will not be chained.
 77  SQL-DEFERRED-PREPARE-NO   PIC S9(4) COMP-5 VALUE 2.
* Dynamic SQL statements will be chained in all cases.	The
* application must not allocate host vars a FETCH SQLDA until after
* the OPEN statement for the cursor.
 77  SQL-DEFERRED-PREPARE-ALL  PIC S9(4) COMP-5 VALUE 3.

* Maximum sqlchar length for option[n].val when option[n].type is
* SQL_COLLECTION_OPT
 77  SQL-MAX-COLLECTION        PIC S9(4) COMP-5 VALUE 8.

* Maximum sqlchar length for option[n].val when option[n].type is
* SQL_VERSION_OPT
 77  SQL-MAX-VERSION	       PIC S9(4) COMP-5 VALUE 254.

* Maximum sqlchar length for option[n].val when option[n].type is
* SQL_OWNER_OPT
 77  SQL-MAX-OWNER	       PIC S9(4) COMP-5 VALUE 8.

* Maximum sqlchar length for option[n].val when option[n].type is
* SQL_SCHEMA_OPT
 77  SQL-MAX-SCHEMA	       PIC S9(4) COMP-5 VALUE 8.

* Maximum sqlchar length for option[n].val when option[n].type is
* SQL_QUALIFIER_OPT
 77  SQL-MAX-QUALIFIER	       PIC S9(4) COMP-5 VALUE 18.

* Maximum sqlchar length for option[n].val when option[n].type is
* SQL_CATALOG_OPT
 77  SQL-MAX-CATALOG	       PIC S9(4) COMP-5 VALUE 18.

* Maximum sqlchar length for option[n].val when option[n].type is
* SQL_TEXT_OPT
 77  SQL-MAX-TEXT	       PIC S9(4) COMP-5 VALUE 255.

* Values used for option[n].val when option[n].type is
* SQL_VALIDATE_OPT
* Validate objects during BIND
 77  SQL-VALIDATE-BIND	       PIC S9(4) COMP-5 VALUE 0.
* Validate objects during execution
 77  SQL-VALIDATE-RUN	       PIC S9(4) COMP-5 VALUE 1.

* Values used for option[n].val when option[n].type is SQL_EXPLAIN_OPT
* No Explain output saved
 77  SQL-EXPLAIN-NO	       PIC S9(4) COMP-5 VALUE 0.
* Explain output saved
 77  SQL-EXPLAIN-YES	       PIC S9(4) COMP-5 VALUE 1.
* Explain output saved for all static and dynamic statements
 77  SQL-EXPLAIN-ALL	       PIC S9(4) COMP-5 VALUE 2.

* Values used for option[n].val when option[n].type is SQL_ACTION_OPT
* Package is to be added
 77  SQL-ACTION-ADD	       PIC S9(4) COMP-5 VALUE 0.
* Package is to be replaced
 77  SQL-ACTION-REPLACE        PIC S9(4) COMP-5 VALUE 1.

* Maximum sqlchar length for option[n].val when option[n].type is
* SQL_REPLVER_OPT
 77  SQL-MAX-REPLVER	       PIC S9(4) COMP-5 VALUE 254.

* Values used for option[n].val when option[n].type is
* SQL_SQLERROR_OPT
* Do not create a package if errors are encountered
 77  SQL-SQLERROR-NOPACKAGE    PIC S9(4) COMP-5 VALUE 0.
* Do not create a package
 77  SQL-SQLERROR-CHECK        PIC S9(4) COMP-5 VALUE 1.
* Create a package even if errors are encountered
 77  SQL-SQLERROR-CONTINUE     PIC S9(4) COMP-5 VALUE 2.

* Values used for option[n].val when option[n].type is SQL_RETAIN_OPT
* Do not preserve EXECUTE authorities when a package is replaced
 77  SQL-RETAIN-NO	       PIC S9(4) COMP-5 VALUE 0.
* Preserve EXECUTE authorities when a package is replaced
 77  SQL-RETAIN-YES	       PIC S9(4) COMP-5 VALUE 1.

* Values used for option[n].val when option[n].type is SQL_RELEASE_OPT
* Release resources at COMMIT
 77  SQL-RELEASE-COMMIT        PIC S9(4) COMP-5 VALUE 0.
* Release resources when the program terminates
 77  SQL-RELEASE-DEALLOCATE    PIC S9(4) COMP-5 VALUE 1.

* Values used for option[n].val when option[n].type is SQL_STRDEL_OPT
* Apostrophe string delimiter
 77  SQL-STRDEL-APOSTROPHE     PIC S9(4) COMP-5 VALUE 0.
* Quote string delimiter
 77  SQL-STRDEL-QUOTE	       PIC S9(4) COMP-5 VALUE 1.

* Values used for option[n].val when option[n].type is SQL_DECDEL_OPT
* Period is used as a decimal point indicator in decimal and floating
* point literals
 77  SQL-DECDEL-PERIOD	       PIC S9(4) COMP-5 VALUE 0.
* Comma is used as a decimal point indicator in decimal and floating
* point literals
 77  SQL-DECDEL-COMMA	       PIC S9(4) COMP-5 VALUE 1.

* Values used for option[n].val when option[n].type is SQL_CHARSUB_OPT
* Use the target system defined default for all new character columns
* for which an explicit subtype is not specified
 77  SQL-CHARSUB-DEFAULT       PIC S9(4) COMP-5 VALUE 0.
* Use the BIT character subtype for all new character columns for
* which an explicit subtype is not specified
 77  SQL-CHARSUB-BIT	       PIC S9(4) COMP-5 VALUE 1.
* Use the SBCS character subtype for all new character columns for
* which an explicit subtype is not specified
 77  SQL-CHARSUB-SBCS	       PIC S9(4) COMP-5 VALUE 2.
* Use the mixed character subtype for all new character columns for
* which an explicit subtype is not specified
 77  SQL-CHARSUB-MIXED	       PIC S9(4) COMP-5 VALUE 3.

* Values used for option[n].val when option[n].type is SQL_DEC_OPT
* 15 bit precision is used in decimal arithmetic operations
 77  SQL-DEC-15 	       PIC S9(4) COMP-5 VALUE 15.
* 31 bit precision is used in decimal arithmetic operations
 77  SQL-DEC-31 	       PIC S9(4) COMP-5 VALUE 31.

* Values used for option[n].val when option[n].type is SQL_DEGREE_OPT
* Prohibits parallel I/O operations
 77  SQL-DEGREE-1	       PIC S9(4) COMP-5 VALUE 1.
* Allows the target database system to determine the degree of
* parallel I/O operations
 77  SQL-DEGREE-ANY	       PIC S9(4) COMP-5 VALUE 0.
* Maximum value
 77  SQL-MAX-DEGREE-VAL        PIC S9(9) COMP-5 VALUE 32767.

* The next four option values (for CONNECT type, SQLRULES, DISCONNECT
* and SYNCPOINT) are used not only by the precompiler but also by the
* sqlesetc and sqleqryc APIs.

* Values used for option[n].val when option[n].type is SQL_CONNECT_OPT
* Indicates that only one connection to a database can exist at any
* given time.
 77  SQL-CONNECT-1	       PIC S9(4) COMP-5 VALUE 1.
* Indicates that multiple connections can exist simultaneously, with
* one being active and the others dormant.
 77  SQL-CONNECT-2	       PIC S9(4) COMP-5 VALUE 2.

* Values used for option[n].val when option[n].type is SQL_RULES_OPT
* Indicates that CONNECT TO can be used to make a dormant connection
* the current connection.
 77  SQL-RULES-DB2	       PIC S9(4) COMP-5 VALUE 1.
* Indicates that CONNECT TO is not valid for making a dormant
* connection current, and SET CONNECTION must be used instead.
 77  SQL-RULES-STD	       PIC S9(4) COMP-5 VALUE 2.

* Values used for option[n].val when option[n].type is
* SQL_DISCONNECT_OPT
* Indicates that all connections marked by the RELEASE statement will
* be the only connections released when a COMMIT is issued.
 77  SQL-DISCONNECT-EXPL       PIC S9(4) COMP-5 VALUE 1.
* Indicates that all connections that do not have open WITH HOLD
* cursors will be the only connections released when a COMMIT is
* issued.
 77  SQL-DISCONNECT-COND       PIC S9(4) COMP-5 VALUE 2.
* Indicates that all connections will be released when a COMMIT is
* issued.
 77  SQL-DISCONNECT-AUTO       PIC S9(4) COMP-5 VALUE 3.

* Values used for option[n].val when option[n].type is
* SQL_SYNCPOINT_OPT
* Do not use a transaction manager to perform two phase commit, but
* enforce that there is only one database is updated when multiple
* databases are accessed within a single transaction.
 77  SQL-SYNC-ONEPHASE	       PIC S9(4) COMP-5 VALUE 1.
* Use a transaction manager to coordinate two phase commit.
 77  SQL-SYNC-TWOPHASE	       PIC S9(4) COMP-5 VALUE 2.
* No update enforcement or two phase commit protocol will be used.
 77  SQL-SYNC-NONE	       PIC S9(4) COMP-5 VALUE 0.

* Values used for option[n].val when option[n].type is
* SQL_DYNAMICRULES_OPT
* Dynamic SQL in package will use authid of person running the package
 77  SQL-DYNAMICRULES-RUN      PIC S9(4) COMP-5 VALUE 0.
* Dynamic SQL in package will use authid of person who owns the
* package
 77  SQL-DYNAMICRULES-BIND     PIC S9(4) COMP-5 VALUE 1.

* Values used for option[n].val when option[n].type is SQL_INSERT_OPT
* Do not buffer VALUE inserts
 77  SQL-INSERT-DEF	       PIC S9(4) COMP-5 VALUE 0.
* Buffer VALUE inserts
 77  SQL-INSERT-BUF	       PIC S9(4) COMP-5 VALUE 1.

* Values used for option[n].val when option[n].type is
* SQL_EXPLSNAP_OPT
* No Explain snapshot saved
 77  SQL-EXPLSNAP-NO	       PIC S9(4) COMP-5 VALUE 0.
* Explain snapshot saved
 77  SQL-EXPLSNAP-YES	       PIC S9(4) COMP-5 VALUE 1.
* Explain snapshot saved for all static and dynamic statements
 77  SQL-EXPLSNAP-ALL	       PIC S9(4) COMP-5 VALUE 2.

* Maximum sqlchar length for option[n].val when option[n].type is
* SQL_FUNCTION_PATH
 77  SQL-MAX-FUNCPATH	       PIC S9(4) COMP-5 VALUE 254.

* Values used for option[n].val when option[n].type is SQL_SQLWARN_OPT
* Suppress prepare-time warning SQLCODEs
 77  SQL-SQLWARN-NO	       PIC S9(4) COMP-5 VALUE 0.
* Permit prepare-time warning SQLCODEs
 77  SQL-SQLWARN-YES	       PIC S9(4) COMP-5 VALUE 1.

* Values used for option[n].val when option[n].type is
* SQL_QUERYOPT_OPT
* Class 0 query optimization
 77  SQL-QUERYOPT-0	       PIC S9(4) COMP-5 VALUE 0.
* Class 1 query optimization
 77  SQL-QUERYOPT-1	       PIC S9(4) COMP-5 VALUE 1.
* Class 3 query optimization
 77  SQL-QUERYOPT-3	       PIC S9(4) COMP-5 VALUE 3.
* Class 5 query optimization
 77  SQL-QUERYOPT-5	       PIC S9(4) COMP-5 VALUE 5.
* Class 9 query optimization
 77  SQL-QUERYOPT-9	       PIC S9(4) COMP-5 VALUE 9.

* Maximum sqlchar length for option[n].val when option[n].type is
* SQL_TARGET_OPT
 77  SQL-MAX-TARGET-LEN        PIC S9(4) COMP-5 VALUE 32.

* Binder Interface Parameters/Return Codes


* serial access
 77  SQL-CTX-ORIGINAL	       PIC S9(4) COMP-5 VALUE 0.
* concurrent access
 77  SQL-CTX-MULTI-MANUAL      PIC S9(4) COMP-5 VALUE 1.
* create & attach
 77  SQL-CTX-BEGIN-ALL	       PIC S9(4) COMP-5 VALUE 0.
* create only
 77  SQL-CTX-CREATE-ONLY       PIC S9(4) COMP-5 VALUE 1.
* detach & free
 77  SQL-CTX-END-ALL	       PIC S9(4) COMP-5 VALUE 0.
* free only
 77  SQL-CTX-FREE-ONLY	       PIC S9(4) COMP-5 VALUE 1.
* Return Codes for sqlaintp/sqlogstt
* insufficient memory for msg file
 77  SQLA-ERR-BADCC	       PIC S9(4) COMP-5 VALUE -1.
* no error code in SQLCA
 77  SQLA-ERR-NOCOD	       PIC S9(4) COMP-5 VALUE -2.
* message file inaccessible or incorrect
 77  SQLA-ERR-NOMSG	       PIC S9(4) COMP-5 VALUE -3.
* specified line length negative
 77  SQLA-ERR-BADLL	       PIC S9(4) COMP-5 VALUE -4.
* invalid sqlca/buffer addr/length
 77  SQLA-ERR-BADCA	       PIC S9(4) COMP-5 VALUE -5.

* Administrative/Database Authorizations returned from Get
* Administrative Authorizations function
* Authorizations granted explicitly to user
* SYSADM Authority
 77  SQL-SYSADM 	       PIC S9(4) COMP-5 VALUE 1.
* DBADM Authority
 77  SQL-DBADM		       PIC S9(4) COMP-5 VALUE 2.
* CREATETAB Privilege
 77  SQL-CREATETAB	       PIC S9(4) COMP-5 VALUE 4.
* BINDADD Privilege
 77  SQL-BINDADD	       PIC S9(4) COMP-5 VALUE 8.
* CONNECT Privilege
 77  SQL-CONNECT	       PIC S9(4) COMP-5 VALUE 16.
* CREATE_NOT_FENCED Privilege
 77  SQL-CREATE-NOT-FENC       PIC S9(4) COMP-5 VALUE 32.
* SYSCTRL Authority
 77  SQL-SYSCTRL	       PIC S9(4) COMP-5 VALUE 64.
* SYSMAINT Authority
 77  SQL-SYSMAINT	       PIC S9(4) COMP-5 VALUE 128.

* Composite of authorizations granted explicitly to user, to groups of
* which user is a member, and to PUBLIC
 77  SQL-SYSADM-GRP	       PIC S9(4) COMP-5 VALUE 256.
 77  SQL-DBADM-GRP	       PIC S9(4) COMP-5 VALUE 512.
 77  SQL-CREATETAB-GRP	       PIC S9(4) COMP-5 VALUE 1024.
 77  SQL-BINDADD-GRP	       PIC S9(4) COMP-5 VALUE 2048.
 77  SQL-CONNECT-GRP	       PIC S9(4) COMP-5 VALUE 4096.
 77  SQL-CREATE-NOT-FENC-GRP   PIC S9(4) COMP-5 VALUE 8192.
 77  SQL-SYSCTRL-GRP	       PIC S9(9) COMP-5 VALUE 16384.
 77  SQL-SYSMAINT-GRP	       PIC S9(9) COMP-5 VALUE 32768.

* Table/View Authorizations/Dependencies Bit definitions in
* SYSTABAUTH.TABAUTH and SYSPLANDEP.TABAUTH
* Control Authority
 77  SQL-TAB-CTL	       PIC S9(4) COMP-5 VALUE 1.
* Alter Privilege
 77  SQL-TAB-ALT	       PIC S9(4) COMP-5 VALUE 2.
* Delete Privilege/Dependency
 77  SQL-TAB-DEL	       PIC S9(4) COMP-5 VALUE 4.
* Index Privilege
 77  SQL-TAB-IDX	       PIC S9(4) COMP-5 VALUE 8.
* Insert Privilege/Dependency
 77  SQL-TAB-INS	       PIC S9(4) COMP-5 VALUE 16.
* Select Privilege/Dependency
 77  SQL-TAB-SEL	       PIC S9(4) COMP-5 VALUE 32.
* Update Privilege/Dependency
 77  SQL-TAB-UPD	       PIC S9(4) COMP-5 VALUE 64.
* Reference Privilege
 77  SQL-TAB-REF	       PIC S9(4) COMP-5 VALUE 128.
* Key Dependency
 77  SQL-TAB-KEY	       PIC S9(4) COMP-5 VALUE 8192.
* Cascade Dependency
 77  SQL-TAB-CAS	       PIC S9(9) COMP-5 VALUE 16384.

* Definitions for application remote interface
* Unload Progam
 77  SQLZ-DISCONNECT-PROC      PIC S9(4) COMP-5 VALUE 1.
* Keep program loaded
 77  SQLZ-HOLD-PROC	       PIC S9(4) COMP-5 VALUE 2.
*************************************************************************
*
* The following functions and symbols are obsolete and may not be
* supported in future releases. The obsolete functions are provided
* for backward compatibility and exported from DB2API.LIB. All
* applications should be migrated to use new APIs.
**************************************************************************
* Invalid password
 77  SQLA-RC-BAD-PASSWD        PIC S9(4) COMP-5 VALUE -4.
* Maximum statements (see SQL reference)
 77  SQL-MAXSTMTS	       PIC S9(9) COMP-5 VALUE 32767.
* Maximum host variables per precompile unit (see SQL reference)
 77  SQL-MAXVARS	       PIC S9(9) COMP-5 VALUE 32767.