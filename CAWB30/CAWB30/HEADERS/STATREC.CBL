* Definition of stat record used by stat and fstat functions
     05  st-dev 			   pic	9(9) binary.
     05  st-ino 			   pic	9(4) binary.
     05  st-mode			   pic	9(4) binary.
     05  st-nlink			   pic s9(4) binary.
     05  st-uid 			   pic s9(4) binary.
     05  st-gid 			   pic s9(4) binary.
     05  filler 			   pic	9(4) binary.
     05  st-rdev			   pic	9(9) binary.
     05  st-size			   pic s9(9) binary.
     05  st-atime			   pic s9(9) binary.
     05  st-mtime			   pic s9(9) binary.
     05  st-ctime			   pic s9(9) binary.
