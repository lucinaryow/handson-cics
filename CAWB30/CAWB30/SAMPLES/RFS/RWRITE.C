/****************************************************************************/
/* Program name: RWRITE.C                                                   */
/*                                                                          */
/* Purpose: This program uses the CA-Realia callable file system            */
/*          to create a relative file with 1000 records.                    */
/*                                                                          */
/*          The file is opened as follows:                                  */
/*                                                                          */
/*            Record length ................ 50                             */
/*            Code system .................. ASCII                          */
/*            Open mode .................... OUTPUT                         */
/*            Access mode .................. SEQUENTIAL                     */
/*            Lock mode   .................. NONE                           */
/*            Dynamic file specification ... NO                             */
/*            Number of keys ............... 0                              */
/*                                                                          */
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
   long handle;                         /* RFSAPI file handle               */
   long recnum;                         /* relative record number           */
   struct rfsparm *parm_ptr;            /* RFSAPI parameter block pointer   */
   struct rfskey *key_ptr;              /* RFSAPI key desc block pointer    */
   struct recarea *rec_ptr;             /* record area pointer              */

   rec_ptr = malloc(FILE_REC_LEN);      /* allocate the record area         */
                                        /* initialize record area header    */
   strncpy(rec_ptr->header, "RECORD ", 7);
                                        /* initialize record area trailer   */
   strncpy(rec_ptr->trailer, " XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 39);
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
   parm_ptr->open_mode = RFSPARM_OPEN_OUTPUT;
   parm_ptr->access_mode = RFSPARM_ACC_SEQUENTIAL;
   parm_ptr->lock_mode = RFSPARM_LOCK_NONE;
   parm_ptr->dynamic_file = RFSPARM_DYN_NONE;
   parm_ptr->num_keys = 0;

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
   printf("Writing 1000 records, key = 1 -> 1000\n");
   for(recnum = 1; recnum <= 1000; recnum++)
   {
       sprintf(rec_ptr->recnum, "%.4d", recnum);
       strncpy(rec_ptr->trailer, " ", 1);
       rc = RealiaFSWrite(&handle, FILE_REC_LEN);
       if(rc)
       {
          printf("Write failed, rc = %d\n", rc);
          exit(1);
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