/****************************************************************************/
/* Program name: RDELETE.C                                                  *
/*                                                                          *
/* Purpose: This program deletes a record from the CA-Realia                *
/*          COBOL data file that was created by RWRITE.C                    *
/*                                                                          *
/*          The following operations are performed:                         *
/*                                                                          *
/*          1. A start operation on record number 500 is                    *
/*             performed.                                                   *
/*          2. The next record is read.                                     *
/*          3. The record is deleted.                                       *
/*          4. A start on record 500 is performed to make sure              *
/*             that the delete was successful.                              *
/*                                                                          *
/* Note: The file is opened for I/O.                                        *
/****************************************************************************/

#include <stdio.h>                      /* standard C I/O header file      */
#include <string.h>                     /* standard C string header file   */
#include <stdlib.h>                     /* standard C library header file  */

#include <carfsapi.h>                   /* RFSAPI header file              */

#define FILESPEC         "REL1"         /* file specification              */

#define FILE_REC_LEN        50          /* file record length              */
#define FILE_MIN_REC_LEN     0          /* file minimum record length      */

void main(void)
{
   short rc;                            /* function return code             */
   long handle;                         /* RFSAPI file handle               */
   long recnum;                         /* relative record number           */
   long bytes_read;                     /* bytes read after reading record  */
   struct rfsparm *parm_ptr;            /* RFSAPI parameter block pointer   */
   struct rfskey *key_ptr;              /* RFSAPI key desc block pointer    */
   char *rec_buf;                       /* record area pointer              */

                                        /* allocate the record area with    */
                                        /* space for ASCIIZ                 */
   rec_buf = calloc(1, FILE_REC_LEN + 1);
                                        /* allocate the parameter block     */
   parm_ptr = malloc(sizeof(struct rfsparm));
   key_ptr = NULL;                      /* no keys for relative record file */

   /*************************************************************************/
   /* Set up the RFSAPI file parameter block                                */
   /*************************************************************************/
   parm_ptr->rec_len = FILE_REC_LEN;
   parm_ptr->min_rec_len = FILE_MIN_REC_LEN;
   parm_ptr->code_system = RFSPARM_CODE_ASCII;
   parm_ptr->organization = RFSPARM_ORG_RELATIVE;
   parm_ptr->open_mode = RFSPARM_OPEN_IO;
   parm_ptr->access_mode = RFSPARM_ACC_DYNAMIC;
   parm_ptr->lock_mode = RFSPARM_LOCK_NONE;
   parm_ptr->dynamic_file = RFSPARM_DYN_NONE;
   parm_ptr->num_keys = 0;

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
   /* Start EQ, key = 500                                                   */
   /*************************************************************************/
   printf("Start equal, key = 500\n");
   recnum = 500;
   rc = RealiaFSStart(&handle, 0, 4, &recnum, RFSSTART_EQ, RFSLOCK_NO);
   if(rc)
   {
      printf("Start failed, rc = %d\n", rc);
      exit(1);
   }

   /*************************************************************************/
   /* Read the next record                                                  */
   /*************************************************************************/
   printf("Reading next record\n");
   rc = RealiaFSReadNext(&handle, RFSLOCK_NO, &bytes_read);
   if(rc)
   {
      printf("Read next failed, rc = %d\n", rc);
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
   /* Make sure that the record is deleted                                  */
   /*************************************************************************/
   printf("Start equal, key = 500\n");
   recnum = 500;
   rc = RealiaFSStart(&handle, 0, 4, &recnum, RFSSTART_EQ, RFSLOCK_NO);
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