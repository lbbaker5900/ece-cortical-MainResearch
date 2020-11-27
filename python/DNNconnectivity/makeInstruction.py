#!/usr/bin/env python



#----------------------------------------------------------------------------------------------------
# Main instructions
'''
typedef enum logic [3 :0] { 
                   PY_WU_INST_OPT_TYPE_NOP                                    =  0, 
                   PY_WU_INST_OPT_TYPE_SRC                                    =  1, 
                   PY_WU_INST_OPT_TYPE_TGT                                    =  2, 
                   PY_WU_INST_OPT_TYPE_TXFER                                  =  3, 
                   PY_WU_INST_OPT_TYPE_NUM_OF_LANES                               =  4, 
                   PY_WU_INST_OPT_TYPE_STOP                                   =  5, 
                   PY_WU_INST_OPT_TYPE_SIMDOP                                 =  6, 
                   PY_WU_INST_OPT_TYPE_MEMORY                                 =  7, 
                   PY_WU_INST_OPT_TYPE_NUM_OF_ARG0_OPERANDS                               =  8, 
                   PY_WU_INST_OPT_TYPE_NUM_OF_ARG1_OPERANDS                               =  9, 
                   PY_WU_INST_OPT_TYPE_NUM_OF_RETURN_PKTS                               = 10, 
                   PY_WU_INST_OPT_TYPE_CFG_SYNC                               = 11, 
                   PY_WU_INST_OPT_TYPE_CFG_DATA                               = 12, 
                   PY_WU_INST_OPT_TYPE_STATUS                                 = 13 
} python_option_type ; 
'''


#       val2     opt2     val1     opt1      val0     opt0       OP    dcntl  icntl
a = '00000000_00000000__00000000_00000000__00000000_00000000____00100___11_____11'
#                                01000000  00000000 00000000    00100   11     11

a = []
#            val2     opt2     val1     opt1      val0     opt0       OP    dcntl  icntl
a.append('00000000_00000000__00000001_00000110__00000001_00000101____00001___01_____01')
a.append('00000000_00000000__11100001_00000000__00000000_00001000____00001___00_____00')
a.append('00000000_00000000__11100001_00000000__00000000_00001001____00001___10_____00')
a.append('00001000_00000100__00000000_00000011__00000000_00000010____00010___01_____00')
a.append('00000000_00000000__00000000_00000000__00000000_00000111____00010___10_____00')
a.append('00001000_00000100__00000001_00000011__00000001_00000010____00010___01_____00')
a.append('00000000_00000000__00000001_00000000__00000000_00000111____00010___10_____00')
a.append('00001000_00000100__00000001_00000011__00000010_00000001____00011___01_____00')
a.append('00000000_00000000__00000010_00000000__00000000_00000111____00011___00_____00')
a.append('00000000_00000000__11100001_00000000__00000000_00001010____00011___10_____10')
print  '// Normal compute op'
for i in a:
  print  '{0:0>15}'.format(hex(int(i.replace('_',''),2)).split('x')[1])

#       val2     opt2     val1     opt1      val0     opt0       OP    dcntl  icntl
a = '00000000_00000000__00000000_00000000__00000000_00000000____00100___11_____11'
#                                01000000  00000000 00000000    00100   11     11

a = []
#           val2     opt2     val1     opt1      val0     opt0       OP    dcntl  icntl
a.append('00000000_00000000__00000011_00000110__00000010_00000101____00001___01_____01')
a.append('00000000_00000000__11100001_00000000__00000000_00001000____00001___00_____00')
a.append('00000000_00000000__11100001_00000000__00000000_00001001____00001___10_____00')
a.append('00100000_00000100__00000000_00000011__00000000_00000010____00010___01_____00')
a.append('00000000_00000000__00000000_00000000__00000000_00000111____00010___10_____00')
a.append('00100000_00000100__00000001_00000011__00000001_00000010____00010___01_____00')
a.append('00000000_00000000__00000001_00000000__00000000_00000111____00010___10_____00')
a.append('00100000_00000100__00000001_00000011__00000010_00000001____00011___01_____00')
a.append('00000000_00000000__00000010_00000000__00000000_00000111____00011___00_____00')
a.append('00000000_00000000__11100001_00000000__00000000_00001010____00011___10_____10')
print  '// Normal compute op with stOp ptr = 2, simd ptr = 3'
for i in a:
  print  '{0:0>15}'.format(hex(int(i.replace('_',''),2)).split('x')[1])



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
  print  '{0:0>15}'.format(hex(int(i.replace('_',''),2)).split('x')[1])



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
  print  '{0:0>15}'.format(hex(int(i.replace('_',''),2)).split('x')[1])

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
  print  '{0:0>15}'.format(hex(int(i.replace('_',''),2)).split('x')[1])


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
#                        save
#                        comm    NOP     Div    send
a.append('_00000___1_____0011____0000____0101___1000___1_____10____0000000010')

#                                        sum/                                                            
#                                        save
#                        NOP     Recip   comm   send
a.append('_00000___1_____0000____0110____0011___1000___1_____10____0000000010')

#  
#                        NOP     NOP     NOP    send
a.append('_00000___1_____0000____0000____0000___1000___1_____10____0000000010')

#                        NOP     NOP     Cmp    send
a.append('_00000___1_____0000____0000____0111___1000___1_____10____0000000010')

print  '// SIMD Option Memory'

for i in a:
  print  '{0:0>15}'.format(hex(int(i.replace('_',''),2)).split('x')[1])

print  '// nop - send - clrIdx - incIdx '
print  hex(int(a[2].replace('_',''),2)).split('x')[1]
print  '// send - ReLu - Exp - Sum/save'
print  hex(int(a[4].replace('_',''),2)).split('x')[1]
print  '// send - Div - NOP - Sum/save'
print  hex(int(a[5].replace('_',''),2)).split('x')[1]
print  '// send - Sum/save common - recip - NOP'
print  hex(int(a[6].replace('_',''),2)).split('x')[1]
print  '// send - nop - nop - nop'
print  hex(int(a[7].replace('_',''),2)).split('x')[1]
print  '// send - cmp - nop - nop'
print  hex(int(a[8].replace('_',''),2)).split('x')[1]

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
print  '{0:0>32}'.format(hex(int(a[0].replace('_',''),2)).split('x')[1])


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
print  '{0:0>32}'.format(hex(int(a[0].replace('_',''),2)).split('x')[1])


a = []
operand = []
#                      num   num           strm  strm  strm  strm 
#                      dest  src             1     0     1     0   
#                     strms strms  opcode  dest  dest   src   src    
operation =      '______01____10____01000___000___100___010___100___'

#                                                                            src   dest                                                       src   dest       Number          
#                                                                            type  type                                                       type  type         of        
#                           source address 0         destination address 0     0     0       source address 1         destination address 1     1     1        operands                                                                             
a.append(operation + '___000000000000010000000000__000000000000010000000000__0100__0100___000000000000010000000000__000000000000010000000000__0100__1111___0000000011100001')

print  '// SIMD, STD MULT to REG '
print  '{0:0>32}'.format(hex(int(a[0].replace('_',''),2)).split('x')[1])







#----------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------
a = []
#           val2     opt2     val1     opt1      val0     opt0       OP    dcntl  icntl
a.append('00000000_00000000__00000011_00000110__00000010_00000101____00001___01_____01')
a.append('00000000_00000000__00001111_00000000__00000000_00001001____00001___10_____00')
a.append('00100000_00000100__00000001_00000011__00000001_00000010____00010___01_____00')
a.append('00000000_00000000__11000010_00000011__00000000_00000111____00010___10_____00')
a.append('00100000_00000100__00000001_00000011__00000010_00000001____00011___01_____00')
a.append('00000000_00000000__00000010_00000000__00000000_00000111____00011___00_____00')
a.append('00000000_00000000__00001111_00000000__00000000_00001010____00011___10_____10')
print  '// Mult on stream 1 with stOp ptr = 2, simd ptr = 3'
for i in a:
  print  '{0:0>15}'.format(hex(int(i.replace('_',''),2)).split('x')[1])

#----------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------
# Storage Descriptors and Cons/Jump memory
#                                                                                                    
a = []
#                                                                       Cons/Jump      Access     
#                                             address                      Ptr         order
#a.append('___________________0_0000_0000_0000_0000_0000_0000_0000____0000_0000_0000____000');
a.append('____________________0_0000_0000_0000_0000_0000_0000_0000____1001_0111_1100____001');

# Using stream 1 as an example which used a storage ptr = 1
#                                c bank      page         byte                                                
#                                vv    vv             vv         v                                     
#                             0_0100_0100_0000_0000_0100_0111_0000____0000_0000_1010____000'
#0a005000049                  0_0001_0100_0000_0000_1010_0000_0000____0000_0000_1001____001

print  '// Storage Descriptor'
print  '{0:0>32}'.format(hex(int(a[0].replace('_',''),2)).split('x')[1])

#                                                       
#                               cntl        Cons/Jump   
# 16*32-1
a.append('_______________________11_____0000000000111111111__');

# Using stream 1 as an example which used a storage ptr = 1 point to Cons/Jump location 9
#   181c00                       11_____0000001110000000000      
a.append('_______________________11_____0000001110000000000');
# CONV2 with 8 lanes (235 x 8)-8
a.append('_______________________11_____0000000011101010000');

# EOD and Consequtive = 0000001110000000000      

#>>> int('0000001110000000000',2)
#7168
#>>> int('0000001110000000000',2)/32
#224
#>>> 

print  '// Cons Jump'
print  '{0:0>32}'.format(hex(int(a[3].replace('_',''),2)).split('x')[1])





