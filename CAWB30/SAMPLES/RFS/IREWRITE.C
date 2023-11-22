/****************************************************************************/
/* Program name: IREWRITE.C                                                 */
/*                                                                          */
/* Purpose: This program rewrites a record from the CA-Realia               */
/*          COBOL data file that was created by IWRITE.C                    */
/*                                                                          */
/*          The following operations are performed:                         */
/*                                                                          */
/*          1. The record with key 'UP' is read by key.                     */
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
   short count = 0;                     /* count of records read            */
   long handle;                         /* RFSAPI file handle               */
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
   /* Read the input file by key, key = "UP"                                */
   /*************************************************************************/
   printf("Reading by key, key = UP\n");
   rc = RealiaFSReadKey(&handle, 1, "UP", RFSLOCK_NO, &bytes_read);
   if(rc)
   {
      printf("Read by key failed, rc = %d\n", rc);
      exit(1);
   }
   printf("%s\n", rec_buf);

   /*************************************************************************/
   /* Modify the record trailer and re-write the record                     */
   /*************************************************************************/
   printf("Re-writing the record\n");
   strncpy(rec_ptr->trailer, " UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU", 41);
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
   printf("Reading by key, key = UP\n");
   rc = RealiaFSReadKey(&handle, 1, "UP", RFSLOCK_NO, &bytes_read);
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