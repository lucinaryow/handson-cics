/****************************************************************************/
/* Program name: FINFO.C                                                    */
/*                                                                          */
/* Purpose: This program uses the CA-Realia callable file system            */
/*          to get the file and key information from a CA-Realia            */
/*          COBOL indexed file.                                             */
/*                                                                          */
/* Note: You must create the data file IXF1 with the program                */
/*       IWRITE.C before running this program.                              */
/****************************************************************************/

#include <stdio.h>                      /* standard C I/O header file      */
#include <string.h>                     /* standard C string header file   */
#include <stdlib.h>                     /* standard C library header file  */

#include <carfsapi.h>                   /* RFSAPI header file              */

#define FILESPEC         "IXF1"         /* file specification              */

void main(void)
{
   short rc;                            /* function return code             */
   char filetype;                       /* CA-Realia COBOL file type        */
   struct rfsparm *parm_ptr;            /* RFSAPI parameter block pointer   */
   struct rfskey *key_ptr;              /* RFSAPI key desc block pointer    */

                                        /* allocate the parameter block     */
   parm_ptr = calloc(1, sizeof(struct rfsparm));
                                        /* allocate the key desc block      */
   key_ptr = calloc(1, sizeof(struct rfskey));

   /*************************************************************************/
   /* Get the file information                                              */
   /*************************************************************************/
   rc = RealiaFSFileInfo(FILESPEC, parm_ptr, &filetype);
   if(rc)
   {
      printf("File info failed, rc = %d\n", rc);
      exit(1);
   }
   rc = RealiaFSKeyInfo(FILESPEC, parm_ptr, key_ptr);
   if(rc)
   {
      printf("Key info failed, rc = %d\n", rc);
      exit(1);
   }
   printf("File type ............ %c\n", filetype);
   printf("File organization .... %d\n", parm_ptr->organization);
   printf("File record length ... %ld\n", parm_ptr->rec_len);
   printf("File code system ..... %d\n", parm_ptr->code_system);
   printf("Number of keys ....... %d\n", parm_ptr->num_keys);
   printf("\n");
   printf("Key start ............ %ld\n", key_ptr->start);
   printf("Key length ........... %ld\n", key_ptr->length);
   printf("Key type ............. %d\n", key_ptr->type);
   printf("Duplicates allowed ... %d\n", key_ptr->dup);
   printf("Null key type ........ %d\n", key_ptr->null);
}
