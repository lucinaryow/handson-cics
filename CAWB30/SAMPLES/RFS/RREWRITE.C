/****************************************************************************/
/* Program name: RREWRITE.C                                                 */
/*                                                                          */
/* Purpose: This program rewrites a record from the CA-Realia               */
/*          COBOL data file that was created by IWRITE.C                    */
/*                                                                          */
/*          The following operations are performed:                         */
/*                                                                          */
/*          1. The record with key 750 is read.                             */
/*          2. The record trailer is modified.                              */
/*          3. The record area is cleared.                                  */
/*          4. The record is re-read to make sure that the                  */
/*             rewrite was successful.                                      */
/*                                                                          */
/* Note: The file is opened for I/O.                                        */
/****************************************************************************/

#include <stdio.h>                      /* standard C I/O header file      */
#include <string.h>                     /* standard C string header file   */
#include <stdlib.h>                     /* standard C library header file  */

#include <carfsapi.h>                   /* RFSAPI header file              */

#define FILESPEC         "REL1"         /* file specification              */

#define FILE_REC_LEN        50          /* file record length              */
#define FILE_MIN_REC_LEN     0          /* file minimum record length      */

struct recarea {                        /* record area structure          */
   char header[7];                      /* record header                  */
   char recnum[4];                      /* record number                  */
   char trailer[39];                    /* record trailer                 */
};

void main(void)
{
   short rc;                            /* function return code             */
   short count = 0;                     /* count of records read            */
   long handle;                         /* RFSAPI file handle               */
   long recnum;                         /* relative record number           */
   long bytes_read;                     /* bytes read after reading record  */
   struct rfsparm *parm_ptr;            /* RFSAPI parameter block pointer   */
   struct rfskey *key_ptr;              /* RFSAPI key desc block pointer    */
   struct recarea *rec_ptr;             /* record area pointer (structure)  */
   char *rec_buf;                       /* record area pointer (string)     */

                                        /* allocate the record area with    */
                                        /* space for ASCIIZ                 */
   rec_buf = calloc(1, FILE_REC_LEN + 1);
   rec_ptr = (struct recarea *)rec_buf; /* record area structure pointer    */
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
   /* Start EQ, key = 750                                                   */
   /*************************************************************************/
   printf("Start equal, key = 750\n");
   recnum = 750;
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
   /* Modify the record trailer and re-write the record                     */
   /*************************************************************************/
   printf("Re-writing the record\n");
   strncpy(rec_ptr->trailer, " UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU", 39);
   rc = RealiaFSRewrite(&handle, FILE_REC_LEN);
   if(rc)
   {
      printf("Rewrite failed, rc = %d\n", rc);
      exit(1);
   }
   printf("%s\n", rec_buf);

   /*************************************************************************/
   /* Clear the record area and re-read the record                          */
   /*************************************************************************/
   memset(rec_buf, 0, FILE_REC_LEN);
   printf("Reading record, key = 750\n");
   rc = RealiaFSReadKey(&handle, 0, &recnum, RFSLOCK_NO, &bytes_read);
   if(rc)
   {
      printf("Read by key failed, rc = %d\n", rc);
      exit(1);
   }
   printf("%s\n", rec_buf);

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