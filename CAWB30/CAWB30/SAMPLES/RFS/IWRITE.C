/****************************************************************************/
/* Program name: IWRITE.C                                                   */
/*                                                                          */
/* Purpose: This program uses the CA-Realia callable file system            */
/*          to create an indexed file with 676 records of unique            */
/*          keys starting with values from 'AA' to 'ZZ'.                    */
/*                                                                          */
/*          The file is opened as follows:                                  */
/*                                                                          */
/*            Record length ................ 50                             */
/*            Code system .................. ASCII                          */
/*            Open mode .................... OUTPUT                         */
/*            Access mode .................. DYNAMIC                        */
/*            Lock mode   .................. NONE                           */
/*            Dynamic file specification ... NO                             */
/*            Number of keys ............... 1                              */
/*                                                                          */
/*          The record key is defined as follows:                           */
/*                                                                          */
/*            Key start position ........... 7                              */
/*            Key length ................... 2                              */
/*            Key type ..................... ALPHANUMERIC                   */
/*            Duplicate keys ............... NO                             */
/*            Null key character ........... NONE                           */
/*                                                                          */
/****************************************************************************/

#include <stdio.h>                      /* standard C I/O header file      */
#include <string.h>                     /* standard C string header file   */
#include <stdlib.h>                     /* standard C library header file  */

#include <carfsapi.h>                   /* RFSAPI header file              */

#define FILESPEC         "IXF1"         /* file specification              */

#define FILE_REC_LEN        50          /* file record length              */
#define FILE_MIN_REC_LEN     0          /* file minimum record length      */
#define FILE_NUM_KEYS        1          /* file number of keys             */

#define KEY_START            8          /* key start position              */
#define KEY_LENGTH           2          /* key length                      */

struct recarea {                        /* record area structure          */
   char header[7];                      /* record header                  */
   char key[2];                         /* record key                     */
   char trailer[41];                    /* record trailer                 */
};

void main(void)
{
   short rc;                            /* function return code             */
   long handle;                         /* RFSAPI file handle               */
   char keyidx1;                        /* index for building record keys   */
   char keyidx2;                        /* index for building record keys   */
   struct rfsparm *parm_ptr;            /* RFSAPI parameter block pointer   */
   struct rfskey *key_ptr;              /* RFSAPI key desc block pointer    */
   struct recarea *rec_ptr;             /* record area pointer              */

   rec_ptr = malloc(FILE_REC_LEN);      /* allocate the record area         */
                                        /* initialize record area header    */
   strncpy(rec_ptr->header, "RECORD ", 7);
                                        /* initialize record area trailer   */
   strncpy(rec_ptr->trailer, " XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 41);

                                        /* allocate the parameter block     */
   parm_ptr = malloc(sizeof(struct rfsparm));
                                        /* allocate the key desc block      */
   key_ptr = malloc(sizeof(struct rfskey));

   /*************************************************************************/
   /* Set up the RFSAPI file parameter block                                */
   /*************************************************************************/
   parm_ptr->rec_len = FILE_REC_LEN;
   parm_ptr->min_rec_len = FILE_MIN_REC_LEN;
   parm_ptr->code_system = RFSPARM_CODE_ASCII;
   parm_ptr->organization = RFSPARM_ORG_INDEXED;
   parm_ptr->open_mode = RFSPARM_OPEN_OUTPUT;
   parm_ptr->access_mode = RFSPARM_ACC_SEQUENTIAL;
   parm_ptr->lock_mode = RFSPARM_LOCK_NONE;
   parm_ptr->dynamic_file = RFSPARM_DYN_NONE;
   parm_ptr->num_keys = FILE_NUM_KEYS;

   /*************************************************************************/
   /* Set up the RFSAPI key descriptor block                                */
   /*************************************************************************/
   key_ptr->start = KEY_START;
   key_ptr->length = KEY_LENGTH;
   key_ptr->type = RFSKEY_ALPHA;
   key_ptr->dup = RFSKEY_DUP_NO;
   key_ptr->null = RFSKEY_NULL_NO;

   /*************************************************************************/
   /* Open the file                                                         */
   /*************************************************************************/
   printf("Opening file for output\n");
   rc = RealiaFSOpen(&handle, FILESPEC, parm_ptr, key_ptr, rec_ptr);
   if(rc)
   {
      printf("Open failed, rc = %d\n", rc);
      exit(1);
   }

   /*************************************************************************/
   /* Write the records to the file                                         */
   /*************************************************************************/
   printf("Writing 676 records, key = AA -> ZZ\n");
   for(keyidx1 = 65; keyidx1 <= 90; keyidx1++)
   {
      for(keyidx2 = 65; keyidx2 <= 90; keyidx2++)
      {
        rec_ptr->key[0] = keyidx1;
        rec_ptr->key[1] = keyidx2;
        rc = RealiaFSWrite(&handle, FILE_REC_LEN);
        if(rc)
        {
           printf("Write failed, rc = %d\n", rc);
           exit(1);
        }
      }
   }

   /*************************************************************************/
   /* Close the file                                                        */
   /*************************************************************************/
   printf("Closing output file\n");
   rc = RealiaFSClose(&handle, RFSCLOSE_STANDARD);
   if(rc)
   {
      printf("Close failed, rc = %d\n", rc);
      exit(1);
   }
}
