/****************************************************************************/
/* Program name: IDELETE.C                                                  *
/*                                                                          *
/* Purpose: This program deletes a record from the CA-Realia                *
/*          COBOL data file that was created by IWRITE.C                    *
/*                                                                          *
/*          The following operations are performed:                         *
/*                                                                          *
/*          1. The record with key 'DL' is read by key.                     *
/*          2. The record is deleted.                                       *
/*          3. The record is re-read to make sure that the                  *
/*             delete was successful.                                       *
/*                                                                          *
/* Note: The file is opened for I/O.                                        *
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


void main(void)
{
   short rc;                            /* function return code             */
   short count = 0;                     /* count of records read            */
   long handle;                         /* RFSAPI file handle               */
   long bytes_read;                     /* bytes read after reading record  */
   struct rfsparm *parm_ptr;            /* RFSAPI parameter block pointer   */
   struct rfskey *key_ptr;              /* RFSAPI key desc block pointer    */
   char *rec_buf;                       /* record area pointer              */

                                        /* allocate the record area with    */
                                        /* space for ASCIIZ                 */
   rec_buf = calloc(1, FILE_REC_LEN + 1);
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
   parm_ptr->open_mode = RFSPARM_OPEN_IO;
   parm_ptr->access_mode = RFSPARM_ACC_DYNAMIC;
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
   printf("Opening file for i/o\n");
   rc = RealiaFSOpen(&handle, FILESPEC, parm_ptr, key_ptr, rec_buf);
   if(rc)
   {
      printf("Open failed, rc = %d\n", rc);
      exit(1);
   }

   /*************************************************************************/
   /* Read the input file by key, key = "DL"                                */
   /*************************************************************************/
   printf("Reading by key, key = DL\n");
   rc = RealiaFSReadKey(&handle, 1, "DL", RFSLOCK_NO, &bytes_read);
   if(rc)
   {
      printf("Read by key failed, rc = %d\n", rc);
      exit(1);
   }
   printf("%s\n", rec_buf);

   /*************************************************************************/
   /* Delete the record                                                     */
   /*************************************************************************/
   printf("Deleting the record\n");
   rc = RealiaFSDelete(&handle);
   if(rc)
   {
      printf("Delete failed, rc = %d\n", rc);
      exit(1);
   }

   /*************************************************************************/
   /* Make sure the record is deleted                                       */
   /*************************************************************************/
   printf("Reading by key, key = DL\n");
   rc = RealiaFSReadKey(&handle, 1, "DL", RFSLOCK_NO, &bytes_read);
   if(rc != 23)
   {
      printf("Record was not deleted correctly, rc= %d\n", rc);
      exit(1);
   } else {
      printf("Record was deleted successfully\n");
   }

   /*************************************************************************/
   /* Close the file                                                        */
   /*************************************************************************/
   printf("Closing i/o file\n");
   rc = RealiaFSClose(&handle, RFSCLOSE_STANDARD);
   if(rc)
   {
      printf("Close failed, rc = %d\n", rc);
      exit(1);
   }
}
