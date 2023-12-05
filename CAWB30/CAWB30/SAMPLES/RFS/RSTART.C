/****************************************************************************/
/* Program name: RSTART.C                                                   */
/*                                                                          */
/* Purpose: This program uses the CA-Realia callable file system            */
/*          to set the file start position within the data file             */
/*          created by RWRITE.C                                             */
/*                                                                          */
/*          The following operations are performed:                         */
/*                                                                          */
/*          1. A START EQUAL operation is performed on the                  */
/*             record with key 500.                                         */
/*          2. The next record is read.                                     */
/*          3. The prior record is read.                                    */
/*          4. A START GREATER THAN operation is performed on               */
/*             the record with key 249.                                     */
/*          5. The next record is read.                                     */
/*          6. The prior record is read.                                    */
/*          7. A START GREATER THAN OR EQUAL TO operation is                */
/*             performed on the record with key 1000.                       */
/*          8. The next record is read.                                     */
/*          9. The prior record is read.                                    */
/*                                                                          */
/* Note: the file is opened for input only.                                 */
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
   short count = 0;                     /* count of records read            */
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
   parm_ptr->open_mode = RFSPARM_OPEN_INPUT;
   parm_ptr->access_mode = RFSPARM_ACC_DYNAMIC;
   parm_ptr->lock_mode = RFSPARM_LOCK_NONE;
   parm_ptr->dynamic_file = RFSPARM_DYN_NONE;
   parm_ptr->num_keys = 0;

   /*************************************************************************/
   /* Open the file                                                         */
   /*************************************************************************/
   printf("Opening file for input\n");
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
   /* Read the prior record                                                 */
   /*************************************************************************/
   printf("Reading prior record\n");
   rc = RealiaFSReadPrior(&handle, RFSLOCK_NO, &bytes_read);
   if(rc)
   {
      printf("Read prior failed, rc = %d\n", rc);
      exit(1);
   }
   printf("%s\n", rec_buf);

   /*************************************************************************/
   /* Start GT, key = 249                                                   */
   /*************************************************************************/
   printf("Start greater than, key = 249\n");
   recnum = 249;
   rc = RealiaFSStart(&handle, 0, 4, &recnum, RFSSTART_GT, RFSLOCK_NO);
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
   /* Read the prior record                                                 */
   /*************************************************************************/
   printf("Reading prior record\n");
   rc = RealiaFSReadPrior(&handle, RFSLOCK_NO, &bytes_read);
   if(rc)
   {
      printf("Read prior failed, rc = %d\n", rc);
      exit(1);
   }
   printf("%s\n", rec_buf);

   /*************************************************************************/
   /* Start GE, key = 1000                                                  */
   /*************************************************************************/
   printf("Start greater than or equal, key = 1000\n");
   recnum = 1000;
   rc = RealiaFSStart(&handle, 0, 4, &recnum, RFSSTART_GE, RFSLOCK_NO);
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
   /* Read the prior record                                                 */
   /*************************************************************************/
   printf("Reading prior record\n");
   rc = RealiaFSReadPrior(&handle, RFSLOCK_NO, &bytes_read);
   if(rc)
   {
      printf("Read prior failed, rc = %d\n", rc);
      exit(1);
   }
   printf("%s\n", rec_buf);

   /*************************************************************************/
   /* Close the file                                                        */
   /*************************************************************************/
   printf("Closing input file\n");
   rc = RealiaFSClose(&handle, RFSCLOSE_STANDARD);
   if(rc)
   {
      printf("Close failed, rc = %d\n", rc);
      exit(1);
   }
}
