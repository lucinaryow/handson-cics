/******************************************************************************
 *
 * Sample C main program for use with character-mode Realia COBOL main
 * programs.
 */

#include <stddef.h>
#include <string.h>
#include <ctype.h>
#include <malloc.h>

#include <windows.h>

extern int CARC__CobolModuleData;

__declspec (dllimport)
int WINAPI CARC__ApplicationMain (
   HANDLE hExeHandle,
   int *lpModuleData
   )
   ;

int main (
   int argc,
   char **argv
   )
   {
   int rc;

   /* Place any application specific initialization here.
    */

   /******/

   /* Now invoke the program via the normal startup sequence.
    */

   rc = CARC__ApplicationMain (GetModuleHandle (NULL), &CARC__CobolModuleData);

   /* Place any application specific termination here.
    */

   /******/

   /* Return to Windows.
    */

   return (rc);
   }
