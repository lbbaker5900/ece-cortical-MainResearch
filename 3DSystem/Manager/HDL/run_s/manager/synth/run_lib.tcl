# Note: path to lib file is under tt1p2v25c

# Memories
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

# Register Files
set libList [glob dw_memories/compout/views/asdr*/tt1p2v25c/*.lib]
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

  echo "Reading regfile .lib file " $libFile
  read_lib $libFile
  echo "Creating .db file " $dbFileName
  write_lib  $dbName   -format db   -output  $dbFileName
}


exit

# For info
# firefox readpath/compout/views/*/*.html

