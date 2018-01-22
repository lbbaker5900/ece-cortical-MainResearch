#!/usr/bin/env python
#       val2     opt2     val1     opt1      val0     opt0       OP    dcntl  icntl
a = '00000000_00000000__00000000_00000000__00000000_00000000____00100___11_____11'
#                                01000000  00000000 00000000    00100   11     11

#                       7      0  15    8   24     16                                                     
#                                                                                                    
#                                                                                                    
#                       gggggg                                                                         
#                       PPPPPP   h                                                                     
#                       tttttt a o            iii                                                       
# Mode reg              rrrrrr l s         e  ddd nnnnn       sync=10     CFG                                                        
#                       543210 l t         n  210 aaaaa                                                   
a = '00000000_00000000__000000_0_1__00000000__000_00000______00001010____00100___11_____11'


a = []

# Mode reg = upld 
#                            cccccccc  cccccccc      ccccc                                                
#                            nnnnnnnn  nnnnnnnn      nnnnn                                                
#                            tttttttt  tttttttt  iii ttttt                                                 
#                            00000000  11111100  ddd 21111       upld=11     CFG                                                        
#                            76543210  54321098  210 09876                                                   
a.append('00000000_00000000__00000000__00000000__011_01000______00001011____00100___01_____01')

#           val2     opt2     val1     opt1      val0     opt0       OP    dcntl  icntl
a.append('00000010_00000100__00000000_00000011__00000011_00000010____00100___00_____00')
a.append('00000000_00000000__00000000_00000000__00000000_00000111____00100___10_____10')

for i in a:
  print  hex(int(i.replace('_',''),2)).split('x')[1]

