#ifndef _INC_CARFSAPI
#define _INC_CARFSAPI

/*---------------------------------------------------------------------------*/
/*                                                                           */
/*                   C A - R e a l i a   C O B O L                           */
/*                                                                           */
/*                          Run Time Library                                 */
/*                                                                           */
/*            CA-Realia COBOL Callable File System C Header File             */
/*                                                                           */
/*                             CARFSAPI.H                                    */
/*                                                                           */
/*                            Version 2.0                                    */
/*                                                                           */
/*     Copyright (c) 1992, 1995 Computer Associates International, Inc.      */
/*                                                                           */
/*---------------------------------------------------------------------------*/

#ifdef  __cplusplus
extern "C" {
#endif

/*---------------------------------------------------------------------------*/
/* Include OpneRealia applications programming interface header file (ORAPI) */
/*---------------------------------------------------------------------------*/
#include <carcor.h>

/*---------------------------------------------------------------------------*/
/* RFSAPI parameter block structure                                          */
/*---------------------------------------------------------------------------*/
struct rfsparm {
   long  rec_len;                       /* file record length                */
   long  min_rec_len;                   /* file minimum record length        */
   short code_system;                   /* file code system                  */
   short organization;                  /* file organization                 */
   short open_mode;                     /* file open mode                    */
   short access_mode;                   /* file access mode                  */
   short lock_mode;                     /* file lock mode                    */
   short dynamic_file;                  /* dynamic file specification flag   */
   short num_keys;                      /* number of keys                    */
   short reserved;                      /* reserved area                     */
};

/*---------------------------------------------------------------------------*/
/* RFSAPI key descriptor block structure                                     */
/*---------------------------------------------------------------------------*/
struct rfskey {
   long  start;                         /* key start position relative to 1  */
   long  length;                        /* key length                        */
   short type;                          /* key type                          */
   short dup;                           /* duplicate keys permitted flag     */
   short null;                          /* null key type                     */
   short reserved;                      /* reserved area                     */
};

/*---------------------------------------------------------------------------*/
/* RFSAPI key date and time structure                                        */
/*---------------------------------------------------------------------------*/
struct rfsdatetime {
   short date_yy;                       /* files date year                   */
   short date_mm;                       /* files date month                  */
   short date_dd;                       /* files date day                    */
   short time_hh;                       /* files time hour                   */
   short time_mm;                       /* files time minutes                */
   short time_ss;                       /* files time seconds                */
};

/*---------------------------------------------------------------------------*/
/* RFSAPI parameter block constants                                          */
/*---------------------------------------------------------------------------*/
#define RFSPARM_CODE_ASCII       0       /* run mode ASCII                   */
#define RFSPARM_CODE_EBCDIC      1       /* run mode EBCDIC                  */

#define RFSPARM_ORG_SEQUENTIAL   0       /* organization is sequential       */
#define RFSPARM_ORG_RELATIVE     1       /* organization is relative         */
#define RFSPARM_ORG_INDEXED      2       /* organization is indexed          */

#define RFSPARM_OPEN_INPUT       0       /* open input                       */
#define RFSPARM_OPEN_INPUT_REV   1       /* open input reversed              */
#define RFSPARM_OPEN_INPUT_NRW   2       /* open input no rewind             */
#define RFSPARM_OPEN_OUTPUT      3       /* open output                      */
#define RFSPARM_OPEN_OUTPUT_NRW  4       /* open output no rewind            */
#define RFSPARM_OPEN_IO          5       /* open i/o (random access)         */
#define RFSPARM_OPEN_EXTEND      6       /* open extend                      */

#define RFSPARM_ACC_SEQUENTIAL   0       /* access mode is sequential        */
#define RFSPARM_ACC_RANDOM       1       /* access mode is random            */
#define RFSPARM_ACC_DYNAMIC      2       /* access mode is dynamic           */

#define RFSPARM_LOCK_NONE        0       /* lock mode none                   */
#define RFSPARM_LOCK_EXCLUSIVE   1       /* lock mode is exclusive           */
#define RFSPARM_LOCK_MANUAL      2       /* lock mode is manual              */
#define RFSPARM_LOCK_AUTOMATIC   3       /* lock mode is automatic           */

#define RFSPARM_DYN_NONE         0       /* dynamic assignment not present   */
#define RFSPARM_DYN_ASSIGN       1       /* dynamic assignment present       */

/*---------------------------------------------------------------------------*/
/* Reserved area constants                                                   */
/*---------------------------------------------------------------------------*/
#define RFSPARM_NOFCREATE        1       /* NOFCREATE flag                   */
#define RFSPARM_REALIA_READPRIOR 2       /* CA-REALIA COBOL read prior flag  */
#define RFSPARM_OPEN_OPTIONAL    4       /* OPEN OPTIONAL flag               */

/*---------------------------------------------------------------------------*/
/* RFSAPI key descriptor block constants                                     */
/*---------------------------------------------------------------------------*/
#define RFSKEY_ALPHA            0        /* key type is alphanumeric         */
#define RFSKEY_INTEGER          1        /* key type is integer              */
#define RFSKEY_PACKED           2        /* key type is packed               */
#define RFSKEY_FLOAT            3        /* key type is floating point       */

#define RFSKEY_DUP_NO           0        /* duplicate keys not permitted     */
#define RFSKEY_DUP_YES          1        /* duplicate keys permitted         */

#define RFSKEY_NULL_NO          0        /* null keys are not suppressed     */
#define RFSKEY_NULL_SPACES      1        /* null key character is spaces     */
#define RFSKEY_NULL_ZEROES      2        /* null key character is zeroes     */
#define RFSKEY_NULL_LOWVALUES   3        /* null key character is low values */

/*---------------------------------------------------------------------------*/
/* RFSAPI close mode constants                                               */
/*---------------------------------------------------------------------------*/
#define RFSCLOSE_STANDARD       0        /* standard file close mode         */
#define RFSCLOSE_WITH_LOCK      1        /* close with lock                  */
#define RFSCLOSE_NO_REWIND      2        /* close with no rewind             */

/*---------------------------------------------------------------------------*/
/* RFSAPI start type constants                                               */
/*---------------------------------------------------------------------------*/
#define RFSSTART_EQ             0        /* start equal to                   */
#define RFSSTART_GT             1        /* start greater than               */
#define RFSSTART_GE             2        /* greater than or equal to         */

/*---------------------------------------------------------------------------*/
/* RFSAPI record lock constants                                              */
/*---------------------------------------------------------------------------*/
#define RFSLOCK_NO              0        /* do not lock record               */
#define RFSLOCK_YES             1        /* lock record                      */

/*---------------------------------------------------------------------------*/
/* RFSAPI advancing type constants                                           */
/*---------------------------------------------------------------------------*/
#define RFSADVTYPE_NONE         0        /* no advancing                     */
#define RFSADVTYPE_BEFORE_PAGE  1        /* before advancing page            */
#define RFSADVTYPE_AFTER_PAGE   2        /* after advancing page             */
#define RFSADVTYPE_BEFORE_LINE  3        /* before advancing count line(s)   */
#define RFSADVTYPE_AFTER_LINE   4        /* after advancing count line(s)    */

/*---------------------------------------------------------------------------*/
/* RFSAPI advancing info constants                                           */
/*---------------------------------------------------------------------------*/
#define RFSADVINFO_NONE         0        /* no advancing information         */
#define RFSADVINFO_LF           0        /* advancing line feed              */
#define RFSADVINFO_FF           1        /* advancing form feed              */
#define RFSADVINFO_CR           2        /* advancing carriage return        */

/*---------------------------------------------------------------------------*/
/* RFSAPI function prototypes                                                */
/*                                                                           */
/* Close file                                                                */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSClose(long  ORPTR handle,
                          short       close_mode);

/*---------------------------------------------------------------------------*/
/* Commit file                                                               */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSCommit(long ORPTR handle);

/*---------------------------------------------------------------------------*/
/* Delete record                                                             */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSDelete(long ORPTR handle);

/*---------------------------------------------------------------------------*/
/* Get file information                                                      */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSFileInfo(char           ORPTR filespec,
                             struct rfsparm ORPTR parm_ptr,
                             char           ORPTR filetype);

/*---------------------------------------------------------------------------*/
/* Get files date and time                                                   */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSGetDateTime(char           ORPTR filespec,
                                struct rfsparm ORPTR rfsdatetime);

/*---------------------------------------------------------------------------*/
/* Get files date and time                                                   */
/*---------------------------------------------------------------------------*/
long ORAPI RealiaFSGetPosition(long           ORPTR handle);

/*---------------------------------------------------------------------------*/
/* Get file key information                                                  */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSKeyInfo(char           ORPTR filespec,
                            struct rfsparm ORPTR parm_ptr,
                            struct rfskey  ORPTR keyptr);

/*---------------------------------------------------------------------------*/
/* Open file                                                                 */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSOpen(long           ORPTR handle,
                         char           ORPTR filespec,
                         struct rfsparm ORPTR parm_ptr,
                         struct rfskey  ORPTR key_ptr,
                         void           ORPTR recarea);

/*---------------------------------------------------------------------------*/
/* Read next record with advancing information                               */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSReadAdv(long  ORPTR handle,
                            short       lock,
                            long  ORPTR bytes_read,
                            short ORPTR adv_info);

/*---------------------------------------------------------------------------*/
/* Read record by key                                                        */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSReadKey(long  ORPTR handle,
                            short       key_num,
                            void  ORPTR key,
                            short       lock,
                            long  ORPTR bytes_read);

/*---------------------------------------------------------------------------*/
/* Read next record                                                          */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSReadNext(long  ORPTR handle,
                             short       lock,
                             long  ORPTR bytes_read);

/*---------------------------------------------------------------------------*/
/* Read prior record                                                         */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSReadPrior(long  ORPTR handle,
                              short       lock,
                              long  ORPTR bytes_read);

/*---------------------------------------------------------------------------*/
/* Rewrite record                                                            */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSReWrite(long ORPTR handle,
                            long       rec_len);

/*---------------------------------------------------------------------------*/
/* Set critical error handler                                                */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSSetCEH(long ORPTR handle);

/*---------------------------------------------------------------------------*/
/* Reset critical error handler                                              */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSResetCEH(long ORPTR handle);

/*---------------------------------------------------------------------------*/
/* Set file start position                                                   */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSStart(long  ORPTR handle,
                          short       key_num,
                          long        key_len,
                          void  ORPTR key,
                          short       start_type,
                          short       lock);

/*---------------------------------------------------------------------------*/
/* Unlock file                                                               */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSUnlock(long ORPTR handle);

/*---------------------------------------------------------------------------*/
/* Write record                                                              */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSWrite(long ORPTR handle,
                          long       rec_len);

/*---------------------------------------------------------------------------*/
/* Write advancing                                                           */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSWriteAdv(long  ORPTR handle,
                             short       adv_type,
                             long        adv_count,
                             long        rec_len);

/*---------------------------------------------------------------------------*/
/* Write relative record                                                     */
/*---------------------------------------------------------------------------*/
short ORAPI RealiaFSWriteRel(long ORPTR handle,
                             long       rec_num,
                             long       rec_len);

#ifdef  __cplusplus
}
#endif  /* __cplusplus */

#endif  /* _INC_CARFSAPI */
