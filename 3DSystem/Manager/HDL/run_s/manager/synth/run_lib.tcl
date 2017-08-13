# Note: path to lib file is under tt1p2v25c

# Memories
if {$tech == "65nm"} {

  set libList [glob dw_memories/compout/views/sass*/tt1p2v25c/*.lib]

} elseif {$tech == "28nm"} {

  set libList [glob arm_memories/lib/*.lib]

}

foreach libFile $libList {
  set lName [file tail [file rootname $libFile]]
  #append dbName $lName _lib.db
  if {$tech == "65nm"} {
    set dbName ${lName}_lib
  } elseif {$tech == "28nm"} {
    set dbName ${lName}
  }
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
if {$tech == "65nm"} {

  set libList [glob dw_memories/compout/views/asdr*/tt1p2v25c/*.lib]

} elseif {$tech == "28nm"} {

  unset libList
  #set libList [glob arm_memories/lib/*.lib]

}

if {[info exists libList]}  {
  foreach libFile $libList {
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
}


exit

# For info
# firefox dw_memories/compout/views/*/*.html

