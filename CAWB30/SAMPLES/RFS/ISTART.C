/****************************************************************************/
/* Program name: ISTART.C                                                   */
/*                                                                          */
/* Purpose: This program sets the start position in a CA-Realia             */
/*          COBOL data file that was created by IWRITE.C                    */
/*                                                                          */
/*          The following operations are performed:                         */
/*                                                                          */
/*          1. A START EQUAL operation is performed on the                  */
/*             record with key 'EQ'.                                        */
/*          2. The next record is read.                                     */
/*          3. A START GREATER THAN operation is performed on               */
/*             the record with key 'GS'.                                    */
/*          4. The next record is read.                                     */
/*          5. A START GREATER THAN OR EQUAL TO operation is                */
/*             performed on the record with key 'GE'.                       */
/*          6. The next record is read.                                     */
/*                                                                          */
/* Note: The file is opened for input.                                      */
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
   parm_ptr->open_mode = RFSPARM_OPEN_INPUT;
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
   printf("Opening file for input\n");
   rc = RealiaFSOpen(&handle, FILESPEC, parm_ptr, key_ptr, rec_buf);
   if(rc)
   {
      printf("Open failed, rc = %d\n", rc);
      exit(1);
   }

   /*************************************************************************/
   /* Start EQ, key = "EQ"                                                  */
   /*************************************************************************/
   printf("Start equal, key = EQ\n");
   rc = RealiaFSStart(&handle, 1, 2, "EQ", RFSSTART_EQ, RFSLOCK_NO);
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
   /* Start GT, key = "GS"                                                  */
   /*************************************************************************/
   printf("Start greater than, key = GS\n");
   rc = RealiaFSStart(&handle, 1, 2, "GS", RFSSTART_GT, RFSLOCK_NO);
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
   /* Start GE, key = "GE"                                                  */
   /*************************************************************************/
   printf("Start greater than or equal to, key = GE\n");
   rc = RealiaFSStart(&handle, 1, 2, "GE", RFSSTART_GE, RFSLOCK_NO);
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