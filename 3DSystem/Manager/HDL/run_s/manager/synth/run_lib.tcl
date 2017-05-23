# Note: path to lib file is under tt1p2v25c

set libList [glob dw_memories/compout/views/sass*/tt1p2v25c/*.lib]
foreach libFile $libList {
  #echo [file split $libFile]
  #echo [file rootname $libFile]
  #echo [file tail $libFile]
  #echo [file tail [file rootname $libFile]]
  set lName [file tail [file rootname $libFile]]
  #append dbName $lName _lib.db
  set dbName ${lName}_lib
  #append dbFileName $lName _lib.db
  set dbFileName ${lName}_lib.db
  echo $lName 
  echo $dbName
  echo $dbFileName
  #unset lName
  #unset dbName
  #unset dbFileName

  echo "Reading memory .lib file " $libFile
  read_lib $libFile
  echo "Creating .db file " $dbFileName
  write_lib  $dbName   -format db   -output  $dbFileName
}

#read_lib dw_memories/compout/views/sasslnpky2p16x117cm4sw0bk1ltlc1/tt1p2v25c/sasslnpky2p16x117cm4sw0bk1ltlc1.lib
#read_lib dw_memories/compout/views/sasslnpky2p16x118cm4sw0bk1ltlc1/tt1p2v25c/sasslnpky2p16x118cm4sw0bk1ltlc1.lib
#read_lib dw_memories/compout/views/sasslnpky2p256x8cm4sw0bk1ltlc1/tt1p2v25c/sasslnpky2p256x8cm4sw0bk1ltlc1.lib
#read_lib dw_memories/compout/views/sasslnpky2p512x160cm4sw0bk1ltlc1/tt1p2v25c/sasslnpky2p512x160cm4sw0bk1ltlc1.lib
#read_lib dw_memories/compout/views/sasslnpky2p64x35cm16sw0bk1ltlc1/tt1p2v25c/sasslnpky2p64x35cm16sw0bk1ltlc1.lib
#read_lib dw_memories/compout/views/sasslnpky2p16x116cm4sw0bk1ltlc1/tt1p2v25c/sasslnpky2p16x116cm4sw0bk1ltlc1.lib
#
#write_lib  sasslnpky2p16x117cm4sw0bk1ltlc1_lib   -format db   -output  sasslnpky2p16x117cm4sw0bk1ltlc1_lib.db
#write_lib  sasslnpky2p16x118cm4sw0bk1ltlc1_lib   -format db   -output  sasslnpky2p16x118cm4sw0bk1ltlc1_lib.db
#write_lib   sasslnpky2p256x8cm4sw0bk1ltlc1_lib   -format db   -output   sasslnpky2p256x8cm4sw0bk1ltlc1_lib.db
#write_lib sasslnpky2p512x160cm4sw0bk1ltlc1_lib   -format db   -output sasslnpky2p512x160cm4sw0bk1ltlc1_lib.db
#write_lib  sasslnpky2p64x35cm16sw0bk1ltlc1_lib   -format db   -output  sasslnpky2p64x35cm16sw0bk1ltlc1_lib.db
#write_lib  sasslnpky2p16x116cm4sw0bk1ltlc1_lib   -format db   -output  sasslnpky2p16x116cm4sw0bk1ltlc1_lib.db

exit

# For info
# firefox readpath/compout/views/*/*.html

