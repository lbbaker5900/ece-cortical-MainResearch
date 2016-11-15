
 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane0_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane0_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane0_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane0_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane0_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane0_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane0_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane0_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane0_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane0_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane0 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane0_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane0_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane0_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane0_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane0 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane0 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane0 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane0 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane0_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane0_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane0_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane0_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane0_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane0_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane0_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane0_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane0_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane0_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane0 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane0_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane0_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane0_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane0 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane0_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane0 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane0 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane0 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane0 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane0 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane0 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane0 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[0]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane1_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane1_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane1_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane1_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane1_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane1_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane1_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane1_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane1_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane1_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane1 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane1_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane1_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane1_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane1_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane1 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane1 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane1 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane1 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane1_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane1_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane1_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane1_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane1_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane1_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane1_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane1_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane1_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane1_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane1 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane1_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane1_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane1_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane1 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane1_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane1 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane1 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane1 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane1 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane1 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane1 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane1 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[1]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane2_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane2_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane2_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane2_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane2_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane2_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane2_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane2_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane2_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane2_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane2 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane2_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane2_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane2_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane2_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane2 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane2 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane2 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane2 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane2_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane2_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane2_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane2_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane2_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane2_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane2_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane2_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane2_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane2_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane2 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane2_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane2_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane2_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane2 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane2_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane2 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane2 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane2 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane2 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane2 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane2 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane2 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[2]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane3_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane3_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane3_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane3_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane3_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane3_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane3_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane3_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane3_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane3_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane3 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane3_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane3_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane3_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane3_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane3 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane3 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane3 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane3 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane3_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane3_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane3_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane3_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane3_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane3_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane3_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane3_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane3_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane3_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane3 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane3_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane3_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane3_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane3 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane3_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane3 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane3 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane3 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane3 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane3 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane3 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane3 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[3]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane4_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane4_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane4_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane4_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane4_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane4_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane4_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane4_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane4_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane4_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane4 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane4_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane4_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane4_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane4_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane4 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane4 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane4 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane4 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane4_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane4_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane4_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane4_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane4_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane4_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane4_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane4_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane4_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane4_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane4 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane4_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane4_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane4_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane4 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane4_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane4 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane4 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane4 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane4 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane4 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane4 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane4 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[4]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane5_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane5_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane5_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane5_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane5_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane5_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane5_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane5_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane5_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane5_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane5 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane5_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane5_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane5_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane5_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane5 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane5 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane5 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane5 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane5_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane5_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane5_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane5_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane5_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane5_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane5_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane5_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane5_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane5_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane5 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane5_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane5_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane5_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane5 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane5_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane5 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane5 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane5 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane5 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane5 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane5 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane5 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[5]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane6_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane6_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane6_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane6_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane6_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane6_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane6_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane6_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane6_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane6_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane6 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane6_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane6_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane6_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane6_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane6 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane6 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane6 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane6 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane6_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane6_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane6_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane6_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane6_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane6_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane6_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane6_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane6_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane6_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane6 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane6_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane6_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane6_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane6 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane6_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane6 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane6 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane6 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane6 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane6 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane6 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane6 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[6]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane7_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane7_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane7_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane7_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane7_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane7_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane7_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane7_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane7_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane7_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane7 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane7_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane7_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane7_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane7_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane7 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane7 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane7 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane7 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane7_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane7_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane7_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane7_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane7_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane7_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane7_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane7_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane7_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane7_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane7 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane7_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane7_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane7_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane7 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane7_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane7 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane7 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane7 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane7 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane7 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane7 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane7 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[7]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane8_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane8_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane8_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane8_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane8_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane8_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane8_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane8_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane8_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane8_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane8 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane8_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane8_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane8_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane8_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane8 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane8 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane8 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane8 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane8_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane8_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane8_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane8_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane8_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane8_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane8_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane8_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane8_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane8_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane8 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane8_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane8_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane8_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane8 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane8_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane8 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane8 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane8 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane8 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane8 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane8 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane8 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[8]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane9_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane9_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane9_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane9_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane9_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane9_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane9_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane9_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane9_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane9_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane9 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane9_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane9_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane9_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane9_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane9 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane9 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane9 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane9 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane9_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane9_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane9_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane9_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane9_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane9_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane9_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane9_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane9_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane9_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane9 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane9_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane9_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane9_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane9 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane9_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane9 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane9 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane9 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane9 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane9 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane9 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane9 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[9]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane10_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane10_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane10_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane10_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane10_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane10_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane10_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane10_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane10_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane10_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane10 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane10_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane10_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane10_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane10_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane10 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane10 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane10 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane10 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane10_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane10_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane10_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane10_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane10_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane10_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane10_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane10_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane10_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane10_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane10 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane10_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane10_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane10_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane10 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane10_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane10 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane10 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane10 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane10 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane10 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane10 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane10 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[10]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane11_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane11_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane11_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane11_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane11_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane11_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane11_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane11_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane11_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane11_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane11 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane11_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane11_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane11_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane11_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane11 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane11 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane11 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane11 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane11_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane11_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane11_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane11_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane11_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane11_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane11_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane11_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane11_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane11_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane11 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane11_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane11_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane11_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane11 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane11_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane11 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane11 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane11 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane11 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane11 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane11 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane11 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[11]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane12_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane12_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane12_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane12_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane12_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane12_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane12_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane12_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane12_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane12_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane12 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane12_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane12_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane12_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane12_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane12 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane12 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane12 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane12 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane12_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane12_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane12_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane12_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane12_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane12_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane12_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane12_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane12_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane12_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane12 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane12_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane12_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane12_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane12 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane12_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane12 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane12 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane12 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane12 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane12 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane12 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane12 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[12]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane13_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane13_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane13_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane13_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane13_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane13_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane13_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane13_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane13_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane13_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane13 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane13_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane13_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane13_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane13_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane13 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane13 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane13 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane13 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane13_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane13_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane13_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane13_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane13_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane13_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane13_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane13_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane13_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane13_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane13 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane13_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane13_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane13_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane13 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane13_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane13 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane13 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane13 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane13 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane13 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane13 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane13 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[13]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane14_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane14_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane14_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane14_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane14_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane14_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane14_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane14_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane14_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane14_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane14 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane14_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane14_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane14_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane14_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane14 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane14 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane14 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane14 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane14_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane14_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane14_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane14_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane14_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane14_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane14_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane14_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane14_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane14_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane14 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane14_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane14_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane14_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane14 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane14_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane14 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane14 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane14 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane14 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane14 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane14 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane14 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[14]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane15_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane15_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane15_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane15_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane15_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane15_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane15_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane15_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane15_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane15_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane15 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane15_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane15_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane15_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane15_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane15 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane15 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane15 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane15 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane15_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane15_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane15_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane15_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane15_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane15_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane15_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane15_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane15_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane15_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane15 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane15_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane15_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane15_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane15 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane15_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane15 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane15 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane15 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane15 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane15 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane15 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane15 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[15]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane16_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane16_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane16_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane16_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane16_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane16_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane16_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane16_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane16_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane16_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane16 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane16_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane16_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane16_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane16_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane16 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane16 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane16 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane16 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane16_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane16_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane16_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane16_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane16_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane16_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane16_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane16_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane16_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane16_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane16 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane16_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane16_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane16_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane16 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane16_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane16 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane16 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane16 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane16 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane16 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane16 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane16 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[16]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane17_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane17_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane17_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane17_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane17_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane17_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane17_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane17_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane17_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane17_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane17 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane17_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane17_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane17_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane17_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane17 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane17 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane17 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane17 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane17_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane17_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane17_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane17_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane17_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane17_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane17_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane17_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane17_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane17_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane17 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane17_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane17_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane17_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane17 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane17_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane17 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane17 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane17 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane17 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane17 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane17 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane17 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[17]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane18_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane18_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane18_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane18_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane18_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane18_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane18_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane18_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane18_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane18_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane18 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane18_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane18_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane18_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane18_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane18 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane18 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane18 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane18 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane18_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane18_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane18_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane18_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane18_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane18_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane18_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane18_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane18_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane18_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane18 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane18_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane18_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane18_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane18 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane18_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane18 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane18 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane18 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane18 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane18 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane18 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane18 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[18]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane19_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane19_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane19_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane19_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane19_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane19_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane19_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane19_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane19_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane19_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane19 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane19_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane19_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane19_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane19_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane19 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane19 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane19 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane19 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane19_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane19_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane19_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane19_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane19_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane19_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane19_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane19_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane19_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane19_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane19 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane19_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane19_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane19_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane19 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane19_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane19 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane19 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane19 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane19 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane19 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane19 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane19 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[19]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane20_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane20_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane20_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane20_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane20_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane20_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane20_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane20_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane20_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane20_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane20 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane20_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane20_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane20_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane20_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane20 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane20 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane20 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane20 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane20_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane20_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane20_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane20_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane20_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane20_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane20_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane20_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane20_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane20_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane20 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane20_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane20_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane20_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane20 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane20_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane20 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane20 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane20 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane20 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane20 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane20 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane20 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[20]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane21_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane21_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane21_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane21_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane21_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane21_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane21_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane21_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane21_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane21_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane21 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane21_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane21_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane21_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane21_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane21 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane21 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane21 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane21 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane21_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane21_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane21_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane21_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane21_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane21_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane21_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane21_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane21_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane21_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane21 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane21_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane21_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane21_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane21 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane21_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane21 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane21 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane21 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane21 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane21 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane21 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane21 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[21]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane22_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane22_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane22_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane22_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane22_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane22_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane22_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane22_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane22_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane22_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane22 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane22_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane22_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane22_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane22_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane22 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane22 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane22 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane22 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane22_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane22_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane22_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane22_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane22_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane22_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane22_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane22_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane22_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane22_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane22 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane22_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane22_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane22_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane22 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane22_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane22 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane22 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane22 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane22 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane22 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane22 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane22 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[22]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane23_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane23_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane23_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane23_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane23_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane23_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane23_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane23_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane23_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane23_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane23 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane23_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane23_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane23_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane23_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane23 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane23 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane23 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane23 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane23_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane23_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane23_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane23_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane23_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane23_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane23_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane23_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane23_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane23_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane23 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane23_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane23_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane23_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane23 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane23_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane23 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane23 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane23 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane23 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane23 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane23 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane23 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[23]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane24_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane24_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane24_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane24_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane24_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane24_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane24_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane24_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane24_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane24_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane24 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane24_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane24_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane24_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane24_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane24 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane24 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane24 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane24 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane24_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane24_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane24_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane24_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane24_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane24_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane24_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane24_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane24_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane24_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane24 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane24_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane24_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane24_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane24 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane24_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane24 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane24 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane24 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane24 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane24 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane24 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane24 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[24]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane25_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane25_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane25_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane25_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane25_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane25_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane25_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane25_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane25_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane25_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane25 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane25_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane25_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane25_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane25_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane25 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane25 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane25 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane25 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane25_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane25_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane25_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane25_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane25_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane25_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane25_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane25_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane25_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane25_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane25 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane25_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane25_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane25_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane25 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane25_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane25 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane25 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane25 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane25 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane25 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane25 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane25 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[25]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane26_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane26_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane26_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane26_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane26_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane26_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane26_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane26_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane26_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane26_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane26 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane26_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane26_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane26_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane26_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane26 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane26 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane26 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane26 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane26_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane26_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane26_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane26_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane26_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane26_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane26_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane26_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane26_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane26_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane26 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane26_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane26_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane26_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane26 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane26_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane26 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane26 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane26 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane26 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane26 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane26 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane26 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[26]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane27_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane27_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane27_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane27_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane27_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane27_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane27_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane27_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane27_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane27_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane27 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane27_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane27_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane27_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane27_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane27 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane27 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane27 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane27 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane27_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane27_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane27_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane27_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane27_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane27_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane27_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane27_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane27_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane27_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane27 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane27_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane27_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane27_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane27 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane27_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane27 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane27 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane27 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane27 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane27 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane27 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane27 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[27]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane28_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane28_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane28_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane28_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane28_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane28_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane28_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane28_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane28_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane28_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane28 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane28_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane28_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane28_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane28_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane28 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane28 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane28 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane28 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane28_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane28_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane28_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane28_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane28_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane28_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane28_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane28_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane28_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane28_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane28 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane28_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane28_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane28_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane28 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane28_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane28 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane28 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane28 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane28 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane28 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane28 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane28 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[28]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane29_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane29_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane29_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane29_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane29_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane29_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane29_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane29_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane29_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane29_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane29 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane29_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane29_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane29_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane29_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane29 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane29 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane29 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane29 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane29_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane29_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane29_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane29_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane29_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane29_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane29_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane29_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane29_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane29_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane29 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane29_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane29_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane29_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane29 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane29_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane29 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane29 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane29 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane29 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane29 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane29 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane29 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[29]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane30_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane30_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane30_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane30_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane30_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane30_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane30_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane30_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane30_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane30_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane30 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane30_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane30_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane30_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane30_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane30 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane30 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane30 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane30 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane30_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane30_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane30_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane30_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane30_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane30_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane30_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane30_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane30_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane30_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane30 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane30_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane30_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane30_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane30 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane30_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane30 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane30 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane30 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane30 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane30 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane30 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane30 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[30]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane31_strm0_write_enable}
 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane31_strm0_write_ready}
 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane31_strm0_write_complete}
 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane31_strm0_read_enable}
 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane31_strm0_read_ready}
 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane31_strm0_read_complete}
 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane31_strm0_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane31_strm0_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane31_strm0_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane31_strm0_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane31 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane31_strm0_data      }
 add wave -noupdate -expand -group ExtToStOpLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane31_strm0_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane31_strm0_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane31_strm0_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/dma__memc__read_address0}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/dma__memc__read_valid0}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/memc__dma__read_ready0}     

 add wave -noupdate -expand -group DmaWriteToMemcLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/dma__memc__write_address0}  
 add wave -noupdate -expand -group DmaWriteToMemcLane31 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/dma__memc__write_data0}     
 add wave -noupdate -expand -group DmaWriteToMemcLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/dma__memc__write_valid0}    
 add wave -noupdate -expand -group DmaWriteToMemcLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/memc__dma__write_ready0}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane31 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/memc__dma__read_data0}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid0}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/dma__memc__read_pause0}     

 add wave -noupdate -expand -group DmaToStOpLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/dma__stOp__strm0_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data}      
 add wave -noupdate -expand -group DmaToStOpLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane31 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/dma__stOp__strm0_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/stOp__dma__strm0_ready}     

 add wave -noupdate -expand -group StOpToDmaLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/stOp__dma__strm0_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane31 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data}      
 add wave -noupdate -expand -group StOpToDmaLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/stOp__dma__strm0_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/dma__stOp__strm0_ready}     

 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane31_strm1_write_enable}
 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane31_strm1_write_ready}
 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane31_strm1_write_complete}
 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane31_strm1_read_enable}
 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane31_strm1_read_ready}
 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane31_strm1_read_complete}
 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/cntl__sdp__lane31_strm1_stOp_enable}
 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane31_strm1_stOp_ready}
 add wave -noupdate -expand -group StreamControlLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/streamingOps_cntl/sdp__cntl__lane31_strm1_stOp_complete}

 add wave -noupdate -expand -group ExtToStOpLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane31_strm1_cntl      }
 add wave -noupdate -expand -group ExtToStOpLane31 -position insertpoint -radix float32      {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane31_strm1_data      }
 add wave -noupdate -expand -group ExtToStOpLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane31_strm1_data_mask }
 add wave -noupdate -expand -group ExtToStOpLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/std__pe0__lane31_strm1_data_valid}
 add wave -noupdate -expand -group ExtToStOpLane31 -position insertpoint -radix hexadecimal  {sim:/test_fixture/pe_array_inst.pe_inst[0]/pe/pe0__std__lane31_strm1_ready}

 add wave -noupdate -expand -group DmaReadRequestToMemcLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/dma__memc__read_address1}   
 add wave -noupdate -expand -group DmaReadRequestToMemcLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/dma__memc__read_valid1}     
 add wave -noupdate -expand -group DmaReadRequestToMemcLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/memc__dma__read_ready1}     

 add wave -noupdate -expand -group DmaWriteToMemcLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/dma__memc__write_address1}  
 add wave -noupdate -expand -group DmaWriteToMemcLane31 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/dma__memc__write_data1}     
 add wave -noupdate -expand -group DmaWriteToMemcLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/dma__memc__write_valid1}    
 add wave -noupdate -expand -group DmaWriteToMemcLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/memc__dma__write_ready1}    

 add wave -noupdate -expand -group DmaReadResponseFromMemcLane31 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/memc__dma__read_data1}      
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/memc__dma__read_data_valid1}
 add wave -noupdate -expand -group DmaReadResponseFromMemcLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/dma_cont/dma__memc__read_pause1}     

 add wave -noupdate -expand -group DmaToStOpLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/dma__stOp__strm1_cntl}      
 add wave -noupdate -expand -group DmaToStOpLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data}      
 add wave -noupdate -expand -group DmaToStOpLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_mask} 
 add wave -noupdate -expand -group DmaToStOpLane31 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/dma__stOp__strm1_data_valid}
 add wave -noupdate -expand -group DmaToStOpLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/stOp__dma__strm1_ready}     

 add wave -noupdate -expand -group StOpToDmaLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/stOp__dma__strm1_cntl}      
 add wave -noupdate -expand -group StOpToDmaLane31 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data}      
 add wave -noupdate -expand -group StOpToDmaLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_mask} 
 add wave -noupdate -expand -group StOpToDmaLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/stOp__dma__strm1_data_valid}
 add wave -noupdate -expand -group StOpToDmaLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/dma__stOp__strm1_ready}     

 add wave -noupdate -expand -group StOpToNocLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/stOp__noc__strm_cntl}      
 add wave -noupdate -expand -group StOpToNocLane31 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/stOp__noc__strm_data}      
 add wave -noupdate -expand -group StOpToNocLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_mask} 
 add wave -noupdate -expand -group StOpToNocLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/stOp__noc__strm_data_valid}
 add wave -noupdate -expand -group StOpToNocLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/stOp__noc__strm_id}        
 add wave -noupdate -expand -group StOpToNocLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/stOp__noc__strm_ready}     

 add wave -noupdate -expand -group NocToStOpLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/noc__stOp__strm_cntl}      
 add wave -noupdate -expand -group NocToStOpLane31 -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/noc__stOp__strm_data}      
 add wave -noupdate -expand -group NocToStOpLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_mask} 
 add wave -noupdate -expand -group NocToStOpLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/noc__stOp__strm_data_valid}
 add wave -noupdate -expand -group NocToStOpLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/noc__stOp__strm_id}        
 add wave -noupdate -expand -group NocToStOpLane31 -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/stOp_lane[31]/streamingOps_datapath/streamingOps/noc__stOp__strm_ready}     

 add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__cp_cntl}  
 add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__cp_laneId}
 add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__cp_strmId}
 add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__cp_type}  
 add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__cp_data}  
 add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__cp_valid} 
 add wave -noupdate -expand -group CntlToNocControl -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__cp_ready} 

 add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__cp_cntl}  
 add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__cp_laneId}
 add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__cp_peId}  
 add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__cp_strmId}
 add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__cp_type}  
 add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__cp_data}  
 add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__cp_valid} 
 add wave -noupdate -expand -group NocToCntlControl -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__cp_ready} 

 add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__dp_cntl}  
 add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__dp_laneId}
 add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__dp_peId}  
 add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__dp_strmId}
 add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__dp_type}  
 add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__dp_data}  
 add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__dp_valid} 
 add wave -noupdate -expand -group CntlToNocData -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__dp_ready} 
 add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__dp_cntl}  
 add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__dp_laneId}
 add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__dp_strmId}
 add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__dp_type}  
 add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix float32      {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__dp_data}  
 add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/noc__cntl__dp_valid} 
 add wave -noupdate -expand -group NocToCntlData -position insertpoint -radix hexadecimal  {/test_fixture/pe_array_inst.pe_inst[0]/pe/noc_cntl/cntl__noc__dp_ready} 
