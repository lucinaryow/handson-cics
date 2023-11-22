* Definition of time record used by ANSI file routines
*struct tm {
*  int tm_sec;	   /* seconds after the minute - [0,59] */
*  int tm_min;	   /* minutes after the hour - [0,59] */
*  int tm_hour;    /* hours since midnight - [0,23] */
*  int tm_mday;    /* day of the month - [1,31] */
*  int tm_mon;	   /* months since January - [0,11] */
*  int tm_year;    /* years since 1900 */
*  int tm_wday;    /* days since Sunday - [0,6] */
*  int tm_yday;    /* days since January 1 - [0,365] */
*  int tm_isdst;   /* daylight savings time flag */
*  };
     05  tm-sec 		       pic s9(9) binary.
     05  tm-min 		       pic s9(9) binary.
     05  tm-hour		       pic s9(9) binary.
     05  tm-mday		       pic s9(9) binary.
     05  tm-mon 		       pic s9(9) binary.
     05  tm-year		       pic s9(9) binary.
     05  tm-wday		       pic s9(9) binary.
     05  tm-yday		       pic s9(9) binary.
     05  tm-isdst		       pic s9(9) binary.
