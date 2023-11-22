/******************************************************************************
 *
 * Sample function for obtaining the value of `errno' for use with Realia
 * COBOL. Use as
 *
 *    77  ERRNO    PIC S9(9) BINARY.
 *    ...
 *    CALL 'C_Get_errno' GIVING ERRNO.
 */

#include <errno.h>

int Get_errno (void)
   {
   return (errno);
   }
