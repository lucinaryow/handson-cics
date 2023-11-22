/******************************************************************************
 *
 * Sample DLL initialization/termination exit for use with Realia COBOL.
 */

#include <windows.h>

extern int CARC__CobolModuleData;

__declspec(dllimport)
BOOL WINAPI CARC__LibraryMain (
   HANDLE hDllHandle,
   DWORD dwReason,
   int *lpModuleData
   )
   ;

BOOL WINAPI DllMain (
   HANDLE hDllHandle,
   DWORD dwReason,
   LPVOID lpreserved
   )
   {
   BOOL rc;
   /* Place any application specific processing that must be done here.
    */

   /*****/

   /* Pass the event to the Realia COBOL library.
    */

   rc = CARC__LibraryMain (hDllHandle, dwReason, &CARC__CobolModuleData);

   /* Place any further application specific processing that must be done here.
    */

   /*****/

   /* Return to Windows.
    */

   return (rc);
   }
