* Constants used for decoding the `st-mode' field of statrec
 01  filler.
* To evaluate the equivalent of the S_IS??? macros, use
*	 call 'mli_and' using st-mode s-ifmt temp.
*	 if temp = s-if???
     05  s-ifmt      value H'F000'          pic 9(4) binary.
     05  s-ifreg     value H'8000'          pic 9(4) binary.
     05  s-ifblk     value H'0000'          pic 9(4) binary.
     05  s-ifchr     value H'2000'          pic 9(4) binary.
     05  s-ifdir     value H'4000'          pic 9(4) binary.
     05  s-ififo     value H'1000'          pic 9(4) binary.
* To check any of the remaining flags, use the following
*	 call 'mli_and' using st-mode s-??? temp.
*	 if temp not = 0
     05  s-isuid     value H'0000'          pic 9(4) binary.
     05  s-isgid     value H'0000'          pic 9(4) binary.
     05  s-irwxu     value H'01C0'          pic 9(4) binary.
     05  s-irusr     value H'0100'          pic 9(4) binary.
     05  s-iwusr     value H'0080'          pic 9(4) binary.
     05  s-ixusr     value H'0040'          pic 9(4) binary.
     05  s-irwxg     value H'01C0'          pic 9(4) binary.
     05  s-irgrp     value H'0100'          pic 9(4) binary.
     05  s-iwgrp     value H'0080'          pic 9(4) binary.
     05  s-ixgrp     value H'0040'          pic 9(4) binary.
     05  s-irwxo     value H'01C0'          pic 9(4) binary.
     05  s-iroth     value H'0100'          pic 9(4) binary.
     05  s-iwoth     value H'0080'          pic 9(4) binary.
     05  s-ixoth     value H'0040'          pic 9(4) binary.
* Some synonyms used historically
     05  s-iread     value H'0100'          pic 9(4) binary.
     05  s-iwrite    value H'0080'          pic 9(4) binary.
     05  s-iexec     value H'0040'          pic 9(4) binary.
