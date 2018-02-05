#!/usr/bin/env python
#       val2     opt2     val1     opt1      val0     opt0       OP    dcntl  icntl
a = '00000000_00000000__00000000_00000000__00000000_00000000____00100___11_____11'
#                                01000000  00000000 00000000    00100   11     11

#                       7      0  15    8   24     16                                                     
#                                                                                                    
#                                                                                                    
a = []
# Mode reg = sync send 
#                            gggggg                                                                         
#                            PPPPPP   h                                                                     
#                            tttttt a o            iii                                                       
#                            rrrrrr l s         e  ddd nnnnn       sync=10     CFG                                                        
#                            543210 l t         n  210 aaaaa                                                   
a.append('00000000_00000000__000000_0_1__00000000__000_00000______00001010____00100___11_____11')
print  '// Sync send'
for i in a:
  print  hex(int(i.replace('_',''),2)).split('x')[1]



a = []

# Mode reg = upld 
#   upld:id=011
#                            cccccccc  cccccccc      ccccc                                                
#                            nnnnnnnn  nnnnnnnn      nnnnn                                                
#                            tttttttt  tttttttt  iii ttttt                                                 
#                            00000000  11111100  ddd 21111       data=11     CFG                                                        
#                            76543210  54321098  210 09876                                                   
a.append('00000000_00000000__01000001__00000000__011_00000______00001011____00100___01_____01')

#            2    Num lanes    Bcast   Txfer      NoC      tgt                                                                        
#           val2     opt2     val1     opt1      val0     opt0       CFG    dcntl  icntl
a.append('00000010_00000100__00000000_00000011__00000011_00000010____00100___00_____00')

#            NA      NOP    ptr[23:16]ptr[15:8] ptr[7:0]  mem                                                                        
#           val2     opt2     val1     opt1      val0     opt0       CFG    dcntl  icntl
a.append('00000000_00000000__00000000_00000000__00000000_00000111____00100___10_____10')

print  '// Upload'
for i in a:
  print  hex(int(i.replace('_',''),2)).split('x')[1]

a = []

# Mode reg = upld 
#   dnld:id=010
#                            cccccccc  cccccccc      ccccc                                                
#                            nnnnnnnn  nnnnnnnn      nnnnn                                                
#                            tttttttt  tttttttt  iii ttttt                                                 
#                            00000000  11111100  ddd 21111       data=11     CFG                                                        
#                            76543210  54321098  210 09876                                                   
a.append('00000000_00000000__01000001__00000000__010_00000______00001011____00100___01_____01')

#                    NOP                NOP       NoC      src                                                                        
#           val2     opt2     val1     opt1      val0     opt0       CFG    dcntl  icntl
a.append('00000000_00000000__00000000_00000000__00000011_00000001____00100___00_____00')

#            NA      NOP    ptr[23:16]ptr[15:8] ptr[7:0]  mem                                                                        
#           val2     opt2     val1     opt1      val0     opt0       CFG    dcntl  icntl
a.append('00000000_00000000__00000000_00000000__00000000_00000111____00100___10_____10')

print  '// SIMD Option Memory'
for i in a:
  print  hex(int(i.replace('_',''),2)).split('x')[1]

a = []
#          save  save  stage   stage   stage   stage    SIMD    Act 
#           idx   inc    3       2       1       0       EN     Fn       PC
a.append('_00000___1____0000____0110____0010____0001______1_____10____0000000010')
#                        inc     clr
#                        idx     idx    send     nop
a.append('_00000___1____1101____1100____1000____0000______1_____10____0000000010')

print  '// SIMD Option Memory'
for i in a:
  print  hex(int(i.replace('_',''),2)).split('x')[1]

