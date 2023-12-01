#ifndef  _CAWBPREP_H_
#define  _CAWBPREP_H_
/**************************************************************************
*
* Full Archive Name    - ^[Archive:r:\xwb\arch\cmnhdr\cawbprep.h  ]
* Author of Last Mod   - ^[Author:kepro01m(ee88)]
* Latest Revision      - ^[Revision:1.0  ]
* Base Revision        - ^[BaseRev:None ]
* Work File Date/Time  - ^[Timestamp:Tue May 13 18:34:12 1997]
* Date/Time of checkin - ^[Date:Thu May 15 09:53:34 1997]
*
*        CCCCCCCCCCC                                                       *
*      CCCCCCCCCCCC       -------------------------------------------      *
*     CCCCC                C A - R E A L I A  I I  W O R K B E N C H       *
*    CCCC                 -------------------------------------------      *
*   CCCC      AAAAAA                                                       *
*   CCCC     AAAAAAA                                                       *
*   CCCC    AAAAAAAA      (c) 1997 COMPUTER ASSOCIATES INTERNATIONAL, INC. *
*    CCCC  AAAA AAAA                                                       *
*     CCC AAAA  AAAA                                                       *
*       CCCCCCCCCCCC          COMPUTER ASSOCIATES INTERNATIONAL, INC.      *
*      AACCCCCCCCCCC                                                       *
*     AAAA      AAAA              Software Superior By Design.             *
*    AAAA       AAAA                                                       *
*   AAAA        AAAA                                                       *
***************************************************************************/
//
//Modification Log - ^[Mods:// ]
// 
// Tue May 13 18:34:12 1997, Rev 1.0, kepro01m(ee88)
//  base revision
// 

#ifdef __cplusplus
     extern "C" {
#endif

#pragma pack(push,4)

typedef struct _WBPrepDlgData
{
  unsigned short  cb;
  char            szSection[64];          // Name of preprocessor section
  char            szFileName[_MAX_PATH];  // Name of options file
  BOOL            bReadOnly;              // Read-only state of options file
} WB_DLGDATA;

#pragma pack(pop)

#ifdef __cplusplus
     }
#endif

#endif
