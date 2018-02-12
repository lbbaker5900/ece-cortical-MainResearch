#!/usr/bin/env python



#----------------------------------------------------------------------------------------------------
# Main instructions

#       val2     opt2     val1     opt1      val0     opt0       OP    dcntl  icntl
a = '00000000_00000000__00000000_00000000__00000000_00000000____00100___11_____11'
#                                01000000  00000000 00000000    00100   11     11

a = []
#            val2     opt2     val1     opt1      val0     opt0       OP    dcntl  icntl
a.append('00000000_00000000__00000001_00000110__00000001_00000101____00001___01_____01')
a.append('00000000_00000000__11100001_00000000__00000000_00001000____00001___00_____00')
a.append('00000000_00000000__11100001_00000000__00000000_00001001____00001___10_____00')
a.append('00100000_00000100__00000000_00000011__00000000_00000010____00010___01_____00')
a.append('00000000_00000000__00000000_00000000__00000000_00000111____00010___10_____00')
a.append('00100000_00000100__00000001_00000011__00000001_00000010____00010___01_____00')
a.append('00000000_00000000__00000001_00000000__00000000_00000111____00010___10_____00')
a.append('00100000_00000100__00000001_00000011__00000010_00000001____00011___01_____00')
a.append('00000000_00000000__00000010_00000000__00000000_00000111____00011___00_____00')
a.append('00000000_00000000__11100001_00000000__00000000_00001010____00011___10_____10')
print  '// Normal compute op'
for i in a:
  print  hex(int(i.replace('_',''),2)).split('x')[1]

#       val2     opt2     val1     opt1      val0     opt0       OP    dcntl  icntl
a = '00000000_00000000__00000000_00000000__00000000_00000000____00100___11_____11'
#                                01000000  00000000 00000000    00100   11     11

a = []
#           val2     opt2     val1     opt1      val0     opt0       OP    dcntl  icntl
a.append('00000000_00000000__00000001_00000110__00000010_00000101____00001___01_____01')
a.append('00000000_00000000__11100001_00000000__00000000_00001000____00001___00_____00')
a.append('00000000_00000000__11100001_00000000__00000000_00001001____00001___10_____00')
a.append('00100000_00000100__00000000_00000011__00000000_00000010____00010___01_____00')
a.append('00000000_00000000__00000000_00000000__00000000_00000111____00010___10_____00')
a.append('00100000_00000100__00000001_00000011__00000001_00000010____00010___01_____00')
a.append('00000000_00000000__00000001_00000000__00000000_00000111____00010___10_____00')
a.append('00100000_00000100__00000001_00000011__00000010_00000001____00011___01_____00')
a.append('00000000_00000000__00000010_00000000__00000000_00000111____00011___00_____00')
a.append('00000000_00000000__11100001_00000000__00000000_00001010____00011___10_____10')
print  '// Normal compute op with stOp ptr = 2'
for i in a:
  print  hex(int(i.replace('_',''),2)).split('x')[1]



#                       7      0  15    8   24     16                                                     
#                                                                                                    
#----------------------------------------------------------------------------------------------------
# Mode registers
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

# Mode reg = dnld 
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

print  '// Download'
for i in a:
  print  hex(int(i.replace('_',''),2)).split('x')[1]


#----------------------------------------------------------------------------------------------------
# SIMD instructions

a = []
#          save  save  stage   stage   stage   stage    SIMD    Act 
#           idx   inc    3       2       1       0       EN     Fn       PC
a.append('_00000___1____0000____0110____0100____0001______1_____10____0000000010')
             
#                               sum/
#                       send     save    Exp     ReLu
a.append('_00000___1____1000____0011____0100____0001______1_____10____0000000010')

#                        inc     clr
#                        idx     idx    send     nop
a.append('_00000___1____1101____1100____1000____0000______1_____10____0000000010')

#                        inc     clr    send
#                        idx     idx    null     nop
a.append('_00000___1____0000____0000____1001____0000______1_____10____0000000010')

#                        sum/
#                        save    Exp     ReLu  send
a.append('_00000___1_____0011____0100____0001___1000___1_____10____0000000010')

#                        sum/
#                        save    Exp     ReLu  send
a.append('_00000___1_____0011____0100____0001___1000___1_____10____0000000010')

#                                        sum/                                                            
#                                        save
#                        NOP     Recip   comm   send
a.append('_00000___1_____0000____0110____0011___1000___1_____10____0000000010')

print  '// SIMD Option Memory'

for i in a:
  print  hex(int(i.replace('_',''),2)).split('x')[1]

print  '// send - ReLu - Exp - Sum/save'
print  hex(int(a[4].replace('_',''),2)).split('x')[1]
print  '// send - Div - NOP - Sum/save'
print  hex(int(a[5].replace('_',''),2)).split('x')[1]
print  '// send - Sum/save common - recip - NOP'
print  hex(int(a[6].replace('_',''),2)).split('x')[1]

#----------------------------------------------------------------------------------------------------
# PE control operations
#                                                                                                    
a = []
operand = []
#                      num   num           strm  strm  strm  strm 
#                      dest  src             1     0     1     0   
#                     strms strms  opcode  dest  dest   src   src    
operation =      '______01____10____00010___000___001___010___010___'

#                                                                            src   dest                                                       src   dest       Number          
#                                                                            type  type                                                       type  type         of        
#                           source address 0         destination address 0     0     0       source address 1         destination address 1     1     1        operands                                                                             
a.append(operation + '___000000000000010000000000__000000000000010000000000__0100__0100___000000000000010000000000__000000000000010000000000__0100__1111___0000000011100001')

print  '// STD, STD FP MAC to MEM/REG '
print  hex(int(a[0].replace('_',''),2)).split('x')[1]


a = []
operand = []
#                      num   num           strm  strm  strm  strm 
#                      dest  src             1     0     1     0   
#                     strms strms  opcode  dest  dest   src   src    
operation =      '______01____10____00010___000___001___010___001___'

#                                                                            src   dest                                                       src   dest       Number          
#                                                                            type  type                                                       type  type         of        
#                           source address 0         destination address 0     0     0       source address 1         destination address 1     1     1        operands                                                                             
a.append(operation + '___000000000000010000000000__000000000000010000000000__0100__0100___000000000000010000000000__000000000000010000000000__0100__1111___0000000011100001')

print  '// MEM, STD FP MAC to MEM/REG '
print  hex(int(a[0].replace('_',''),2)).split('x')[1]


a = []
operand = []
#                      num   num           strm  strm  strm  strm 
#                      dest  src             1     0     1     0   
#                     strms strms  opcode  dest  dest   src   src    
operation =      '______01____10____01000___000___001___010___100___'

#                                                                            src   dest                                                       src   dest       Number          
#                                                                            type  type                                                       type  type         of        
#                           source address 0         destination address 0     0     0       source address 1         destination address 1     1     1        operands                                                                             
a.append(operation + '___000000000000010000000000__000000000000010000000000__0100__0100___000000000000010000000000__000000000000010000000000__0100__1111___0000000011100001')

print  '// SIMD, STD MULT to MEM/REG '
print  hex(int(a[0].replace('_',''),2)).split('x')[1]



