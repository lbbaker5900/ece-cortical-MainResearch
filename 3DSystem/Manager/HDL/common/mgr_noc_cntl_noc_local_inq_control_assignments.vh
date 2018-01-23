
  always @(posedge clk)
    begin
      
      case(nc_local_inq_cntl_state)

        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER0:
          begin
            noc__locl__cp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].cntl_fromNoc; 
            noc__locl__dp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].cntl_fromNoc; 

            // Condition valid based on priority field
            noc__locl__cp_valid         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].valid_fromNoc & (Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE] == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP); 
            noc__locl__dp_valid         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].valid_fromNoc & (Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE] == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP); 

            // Latch fields valid only during this cycle
            local_inq_priority_fromNoc  <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE ]; 
            local_inq_mgr_fromNoc       <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE]; 

            // Fields valid during this cycle
            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE]; 
            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE]; 
            noc__locl__cp_data          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]; 
            noc__locl__dp_data          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]; 

            // Fields that arent valid 
            noc__locl__cp_type          <=  'd0    ; 
            noc__locl__dp_type          <=  'd0    ; 
            noc__locl__cp_ptype         <=  'd0    ; 
            noc__locl__dp_ptype         <=  'd0    ; 
            noc__locl__cp_pvalid        <=  'd0    ; 
            noc__locl__dp_pvalid        <=  'd0    ; 

          end

        // Type is only officially valud during the first tuple
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE0:
          begin
            noc__locl__cp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].cntl_fromNoc; 
            noc__locl__dp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].cntl_fromNoc; 

            // Condition valid based on priority field
            noc__locl__cp_valid         <= (reset_poweron ) ? 'd0 :  Port_from_NoC_Control[0].valid_fromNoc & (local_inq_priority_fromNoc == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP); 
            noc__locl__dp_valid         <= (reset_poweron ) ? 'd0 :  Port_from_NoC_Control[0].valid_fromNoc & (local_inq_priority_fromNoc == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP); 

            // Latch fields valid only during this cycle
            local_inq_type_fromNoc      <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PACKET_TYPE_RANGE]; 

            // Fields previously latched
            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc      ; 
            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc      ; 

            // Fields valid during this cycle
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PACKET_TYPE_RANGE   ]; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PACKET_TYPE_RANGE   ]; 
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE  ]; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE  ]; 
            noc__locl__cp_data          <= (reset_poweron ) ? 'd0 : {Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION1_RANGE       ],  
                                                                       Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE     ],  
                                                                       Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION0_RANGE       ],  
                                                                       Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE     ]};
            noc__locl__dp_data          <= (reset_poweron ) ? 'd0 : {Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION1_RANGE       ],  
                                                                       Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE     ],  
                                                                       Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION0_RANGE       ],  
                                                                       Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE     ]};
            noc__locl__cp_pvalid        <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE ]; 
            noc__locl__dp_pvalid        <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE ]; 
          end

        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD0:
          begin
            noc__locl__cp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].cntl_fromNoc; 
            noc__locl__dp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].cntl_fromNoc; 

            // Condition valid based on priority field
            noc__locl__cp_valid         <= (reset_poweron ) ? 'd0 :  Port_from_NoC_Control[0].valid_fromNoc & (local_inq_priority_fromNoc == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP); 
            noc__locl__dp_valid         <= (reset_poweron ) ? 'd0 :  Port_from_NoC_Control[0].valid_fromNoc & (local_inq_priority_fromNoc == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP); 

            // Latch fields valid only during this cycle

            // Fields previously latched
            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc      ; 
            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc      ; 
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PACKET_TYPE_RANGE   ]; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PACKET_TYPE_RANGE   ]; 
            //noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   local_inq_type_fromNoc     ; 
            //noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   local_inq_type_fromNoc     ; 

            // Fields valid during this cycle
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE]; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE]; 
            noc__locl__cp_data          <= (reset_poweron ) ? 'd0 : {Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD1_RANGE],         
                                                                       Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE]}      ; 
            noc__locl__dp_data          <= (reset_poweron ) ? 'd0 : {Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD1_RANGE],         
                                                                       Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE]}      ; 
            noc__locl__cp_pvalid        <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE ]; 
            noc__locl__dp_pvalid        <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[0].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE ]; 


          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER1:
          begin
            noc__locl__cp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].cntl_fromNoc; 
            noc__locl__dp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].cntl_fromNoc; 

            // Condition valid based on priority field
            noc__locl__cp_valid         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].valid_fromNoc & (Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE] == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP); 
            noc__locl__dp_valid         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].valid_fromNoc & (Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE] == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP); 

            // Latch fields valid only during this cycle
            local_inq_priority_fromNoc  <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE ]; 
            local_inq_mgr_fromNoc       <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE]; 

            // Fields valid during this cycle
            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE]; 
            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE]; 
            noc__locl__cp_data          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]; 
            noc__locl__dp_data          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]; 

            // Fields that arent valid 
            noc__locl__cp_type          <=  'd0    ; 
            noc__locl__dp_type          <=  'd0    ; 
            noc__locl__cp_ptype         <=  'd0    ; 
            noc__locl__dp_ptype         <=  'd0    ; 
            noc__locl__cp_pvalid        <=  'd0    ; 
            noc__locl__dp_pvalid        <=  'd0    ; 

          end

        // Type is only officially valud during the first tuple
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE1:
          begin
            noc__locl__cp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].cntl_fromNoc; 
            noc__locl__dp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].cntl_fromNoc; 

            // Condition valid based on priority field
            noc__locl__cp_valid         <= (reset_poweron ) ? 'd0 :  Port_from_NoC_Control[1].valid_fromNoc & (local_inq_priority_fromNoc == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP); 
            noc__locl__dp_valid         <= (reset_poweron ) ? 'd0 :  Port_from_NoC_Control[1].valid_fromNoc & (local_inq_priority_fromNoc == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP); 

            // Latch fields valid only during this cycle
            local_inq_type_fromNoc      <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PACKET_TYPE_RANGE]; 

            // Fields previously latched
            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc      ; 
            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc      ; 

            // Fields valid during this cycle
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PACKET_TYPE_RANGE   ]; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PACKET_TYPE_RANGE   ]; 
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE  ]; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE  ]; 
            noc__locl__cp_data          <= (reset_poweron ) ? 'd0 : {Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION1_RANGE       ],  
                                                                       Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE     ],  
                                                                       Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION0_RANGE       ],  
                                                                       Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE     ]};
            noc__locl__dp_data          <= (reset_poweron ) ? 'd0 : {Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION1_RANGE       ],  
                                                                       Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE     ],  
                                                                       Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION0_RANGE       ],  
                                                                       Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE     ]};
            noc__locl__cp_pvalid        <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE ]; 
            noc__locl__dp_pvalid        <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE ]; 
          end

        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD1:
          begin
            noc__locl__cp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].cntl_fromNoc; 
            noc__locl__dp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].cntl_fromNoc; 

            // Condition valid based on priority field
            noc__locl__cp_valid         <= (reset_poweron ) ? 'd0 :  Port_from_NoC_Control[1].valid_fromNoc & (local_inq_priority_fromNoc == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP); 
            noc__locl__dp_valid         <= (reset_poweron ) ? 'd0 :  Port_from_NoC_Control[1].valid_fromNoc & (local_inq_priority_fromNoc == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP); 

            // Latch fields valid only during this cycle

            // Fields previously latched
            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc      ; 
            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc      ; 
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PACKET_TYPE_RANGE   ]; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PACKET_TYPE_RANGE   ]; 
            //noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   local_inq_type_fromNoc     ; 
            //noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   local_inq_type_fromNoc     ; 

            // Fields valid during this cycle
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE]; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE]; 
            noc__locl__cp_data          <= (reset_poweron ) ? 'd0 : {Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD1_RANGE],         
                                                                       Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE]}      ; 
            noc__locl__dp_data          <= (reset_poweron ) ? 'd0 : {Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD1_RANGE],         
                                                                       Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE]}      ; 
            noc__locl__cp_pvalid        <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE ]; 
            noc__locl__dp_pvalid        <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[1].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE ]; 


          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER2:
          begin
            noc__locl__cp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].cntl_fromNoc; 
            noc__locl__dp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].cntl_fromNoc; 

            // Condition valid based on priority field
            noc__locl__cp_valid         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].valid_fromNoc & (Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE] == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP); 
            noc__locl__dp_valid         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].valid_fromNoc & (Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE] == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP); 

            // Latch fields valid only during this cycle
            local_inq_priority_fromNoc  <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE ]; 
            local_inq_mgr_fromNoc       <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE]; 

            // Fields valid during this cycle
            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE]; 
            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE]; 
            noc__locl__cp_data          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]; 
            noc__locl__dp_data          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]; 

            // Fields that arent valid 
            noc__locl__cp_type          <=  'd0    ; 
            noc__locl__dp_type          <=  'd0    ; 
            noc__locl__cp_ptype         <=  'd0    ; 
            noc__locl__dp_ptype         <=  'd0    ; 
            noc__locl__cp_pvalid        <=  'd0    ; 
            noc__locl__dp_pvalid        <=  'd0    ; 

          end

        // Type is only officially valud during the first tuple
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE2:
          begin
            noc__locl__cp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].cntl_fromNoc; 
            noc__locl__dp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].cntl_fromNoc; 

            // Condition valid based on priority field
            noc__locl__cp_valid         <= (reset_poweron ) ? 'd0 :  Port_from_NoC_Control[2].valid_fromNoc & (local_inq_priority_fromNoc == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP); 
            noc__locl__dp_valid         <= (reset_poweron ) ? 'd0 :  Port_from_NoC_Control[2].valid_fromNoc & (local_inq_priority_fromNoc == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP); 

            // Latch fields valid only during this cycle
            local_inq_type_fromNoc      <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PACKET_TYPE_RANGE]; 

            // Fields previously latched
            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc      ; 
            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc      ; 

            // Fields valid during this cycle
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PACKET_TYPE_RANGE   ]; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PACKET_TYPE_RANGE   ]; 
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE  ]; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE  ]; 
            noc__locl__cp_data          <= (reset_poweron ) ? 'd0 : {Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION1_RANGE       ],  
                                                                       Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE     ],  
                                                                       Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION0_RANGE       ],  
                                                                       Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE     ]};
            noc__locl__dp_data          <= (reset_poweron ) ? 'd0 : {Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION1_RANGE       ],  
                                                                       Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE     ],  
                                                                       Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION0_RANGE       ],  
                                                                       Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE     ]};
            noc__locl__cp_pvalid        <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE ]; 
            noc__locl__dp_pvalid        <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE ]; 
          end

        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD2:
          begin
            noc__locl__cp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].cntl_fromNoc; 
            noc__locl__dp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].cntl_fromNoc; 

            // Condition valid based on priority field
            noc__locl__cp_valid         <= (reset_poweron ) ? 'd0 :  Port_from_NoC_Control[2].valid_fromNoc & (local_inq_priority_fromNoc == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP); 
            noc__locl__dp_valid         <= (reset_poweron ) ? 'd0 :  Port_from_NoC_Control[2].valid_fromNoc & (local_inq_priority_fromNoc == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP); 

            // Latch fields valid only during this cycle

            // Fields previously latched
            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc      ; 
            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc      ; 
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PACKET_TYPE_RANGE   ]; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PACKET_TYPE_RANGE   ]; 
            //noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   local_inq_type_fromNoc     ; 
            //noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   local_inq_type_fromNoc     ; 

            // Fields valid during this cycle
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE]; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE]; 
            noc__locl__cp_data          <= (reset_poweron ) ? 'd0 : {Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD1_RANGE],         
                                                                       Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE]}      ; 
            noc__locl__dp_data          <= (reset_poweron ) ? 'd0 : {Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD1_RANGE],         
                                                                       Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE]}      ; 
            noc__locl__cp_pvalid        <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE ]; 
            noc__locl__dp_pvalid        <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[2].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE ]; 


          end
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER3:
          begin
            noc__locl__cp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].cntl_fromNoc; 
            noc__locl__dp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].cntl_fromNoc; 

            // Condition valid based on priority field
            noc__locl__cp_valid         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].valid_fromNoc & (Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE] == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP); 
            noc__locl__dp_valid         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].valid_fromNoc & (Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE] == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP); 

            // Latch fields valid only during this cycle
            local_inq_priority_fromNoc  <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_RANGE ]; 
            local_inq_mgr_fromNoc       <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE]; 

            // Fields valid during this cycle
            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE]; 
            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_SOURCE_PE_RANGE]; 
            noc__locl__cp_data          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]; 
            noc__locl__dp_data          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_HEADER_DESTINATION_ADDR_RANGE]; 

            // Fields that arent valid 
            noc__locl__cp_type          <=  'd0    ; 
            noc__locl__dp_type          <=  'd0    ; 
            noc__locl__cp_ptype         <=  'd0    ; 
            noc__locl__dp_ptype         <=  'd0    ; 
            noc__locl__cp_pvalid        <=  'd0    ; 
            noc__locl__dp_pvalid        <=  'd0    ; 

          end

        // Type is only officially valud during the first tuple
        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE3:
          begin
            noc__locl__cp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].cntl_fromNoc; 
            noc__locl__dp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].cntl_fromNoc; 

            // Condition valid based on priority field
            noc__locl__cp_valid         <= (reset_poweron ) ? 'd0 :  Port_from_NoC_Control[3].valid_fromNoc & (local_inq_priority_fromNoc == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP); 
            noc__locl__dp_valid         <= (reset_poweron ) ? 'd0 :  Port_from_NoC_Control[3].valid_fromNoc & (local_inq_priority_fromNoc == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP); 

            // Latch fields valid only during this cycle
            local_inq_type_fromNoc      <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PACKET_TYPE_RANGE]; 

            // Fields previously latched
            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc      ; 
            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc      ; 

            // Fields valid during this cycle
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PACKET_TYPE_RANGE   ]; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PACKET_TYPE_RANGE   ]; 
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE  ]; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE  ]; 
            noc__locl__cp_data          <= (reset_poweron ) ? 'd0 : {Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION1_RANGE       ],  
                                                                       Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE     ],  
                                                                       Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION0_RANGE       ],  
                                                                       Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE     ]};
            noc__locl__dp_data          <= (reset_poweron ) ? 'd0 : {Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION1_RANGE       ],  
                                                                       Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL1_RANGE     ],  
                                                                       Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_OPTION0_RANGE       ],  
                                                                       Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_EXTD_VAL0_RANGE     ]};
            noc__locl__cp_pvalid        <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE ]; 
            noc__locl__dp_pvalid        <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE ]; 
          end

        `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD3:
          begin
            noc__locl__cp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].cntl_fromNoc; 
            noc__locl__dp_cntl          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].cntl_fromNoc; 

            // Condition valid based on priority field
            noc__locl__cp_valid         <= (reset_poweron ) ? 'd0 :  Port_from_NoC_Control[3].valid_fromNoc & (local_inq_priority_fromNoc == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP); 
            noc__locl__dp_valid         <= (reset_poweron ) ? 'd0 :  Port_from_NoC_Control[3].valid_fromNoc & (local_inq_priority_fromNoc == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_DP); 

            // Latch fields valid only during this cycle

            // Fields previously latched
            noc__locl__cp_mgrId         <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc      ; 
            noc__locl__dp_mgrId         <= (reset_poweron ) ? 'd0 :   local_inq_mgr_fromNoc      ; 
            noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PACKET_TYPE_RANGE   ]; 
            noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_PACKET_TYPE_RANGE   ]; 
            //noc__locl__cp_type          <= (reset_poweron ) ? 'd0 :   local_inq_type_fromNoc     ; 
            //noc__locl__dp_type          <= (reset_poweron ) ? 'd0 :   local_inq_type_fromNoc     ; 

            // Fields valid during this cycle
            noc__locl__cp_ptype         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE]; 
            noc__locl__dp_ptype         <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_TYPE_RANGE]; 
            noc__locl__cp_data          <= (reset_poweron ) ? 'd0 : {Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD1_RANGE],         
                                                                       Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE]}      ; 
            noc__locl__dp_data          <= (reset_poweron ) ? 'd0 : {Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD1_RANGE],         
                                                                       Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_DATA_CYCLE_WORD0_RANGE]}      ; 
            noc__locl__cp_pvalid        <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE ]; 
            noc__locl__dp_pvalid        <= (reset_poweron ) ? 'd0 :   Port_from_NoC_Control[3].data_fromNoc[`MGR_NOC_CONT_EXTERNAL_TUPLE_CYCLE_PAYLOAD_VALID_RANGE ]; 


          end
        default:
          begin
            noc__locl__cp_valid         <=  'd0    ; 
            noc__locl__dp_valid         <=  'd0    ; 
            noc__locl__cp_cntl          <=  'd0    ; 
            noc__locl__dp_cntl          <=  'd0    ; 
            noc__locl__cp_type          <=  'd0    ; 
            noc__locl__dp_type          <=  'd0    ; 
            noc__locl__cp_ptype         <=  'd0    ; 
            noc__locl__dp_ptype         <=  'd0    ; 
            noc__locl__cp_mgrId         <=  'd0    ; 
            noc__locl__dp_mgrId         <=  'd0    ; 
            noc__locl__cp_data          <=  'd0    ; 
            noc__locl__dp_data          <=  'd0    ; 
            noc__locl__cp_pvalid        <=  'd0    ; 
            noc__locl__dp_pvalid        <=  'd0    ; 
          end

      endcase
    end

  // Mask request from Port with this PE's mask address
  assign port0_localInqReq      = Port_from_NoC_Control[0].destinationReq & |(Port_from_NoC_Control[0].destinationReqAddr & thisMgrBitMask)  ;
  // Grab the priority during the request when the packer header is present at the fifo output
  always @(posedge clk)
    port0_localInqPriority <= (port0_localInqReq) ? Port_from_NoC_Control[0].destinationPriority : port0_localInqPriority ;
  
  // Ack and ready back to source ports
  always @(posedge clk)
    local_port0_OutqAck   <= port0_localInqReq ;  // feed request directly back to ack
  assign local_port0_OutqReady = ((port0_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP) ? locl__noc__cp_ready_d1 : locl__noc__dp_ready_d1 ) &  // we will transfer the packet directly to the cntl block
                                   ((nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER0     ) | // only assert ready to source if currently selected for transfer
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE0         ) | 
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD0) );
  // Mask request from Port with this PE's mask address
  assign port1_localInqReq      = Port_from_NoC_Control[1].destinationReq & |(Port_from_NoC_Control[1].destinationReqAddr & thisMgrBitMask)  ;
  // Grab the priority during the request when the packer header is present at the fifo output
  always @(posedge clk)
    port1_localInqPriority <= (port1_localInqReq) ? Port_from_NoC_Control[1].destinationPriority : port1_localInqPriority ;
  
  // Ack and ready back to source ports
  always @(posedge clk)
    local_port1_OutqAck   <= port1_localInqReq ;  // feed request directly back to ack
  assign local_port1_OutqReady = ((port1_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP) ? locl__noc__cp_ready_d1 : locl__noc__dp_ready_d1 ) &  // we will transfer the packet directly to the cntl block
                                   ((nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER1     ) | // only assert ready to source if currently selected for transfer
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE1         ) | 
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD1) );
  // Mask request from Port with this PE's mask address
  assign port2_localInqReq      = Port_from_NoC_Control[2].destinationReq & |(Port_from_NoC_Control[2].destinationReqAddr & thisMgrBitMask)  ;
  // Grab the priority during the request when the packer header is present at the fifo output
  always @(posedge clk)
    port2_localInqPriority <= (port2_localInqReq) ? Port_from_NoC_Control[2].destinationPriority : port2_localInqPriority ;
  
  // Ack and ready back to source ports
  always @(posedge clk)
    local_port2_OutqAck   <= port2_localInqReq ;  // feed request directly back to ack
  assign local_port2_OutqReady = ((port2_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP) ? locl__noc__cp_ready_d1 : locl__noc__dp_ready_d1 ) &  // we will transfer the packet directly to the cntl block
                                   ((nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER2     ) | // only assert ready to source if currently selected for transfer
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE2         ) | 
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD2) );
  // Mask request from Port with this PE's mask address
  assign port3_localInqReq      = Port_from_NoC_Control[3].destinationReq & |(Port_from_NoC_Control[3].destinationReqAddr & thisMgrBitMask)  ;
  // Grab the priority during the request when the packer header is present at the fifo output
  always @(posedge clk)
    port3_localInqPriority <= (port3_localInqReq) ? Port_from_NoC_Control[3].destinationPriority : port3_localInqPriority ;
  
  // Ack and ready back to source ports
  always @(posedge clk)
    local_port3_OutqAck   <= port3_localInqReq ;  // feed request directly back to ack
  assign local_port3_OutqReady = ((port3_localInqPriority == `MGR_NOC_CONT_EXTERNAL_HEADER_PRIORITY_CP) ? locl__noc__cp_ready_d1 : locl__noc__dp_ready_d1 ) &  // we will transfer the packet directly to the cntl block
                                   ((nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_HEADER3     ) | // only assert ready to source if currently selected for transfer
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_TUPLE3         ) | 
                                    (nc_local_inq_cntl_state == `MGR_NOC_CONT_LOCAL_INQ_CNTL_TRANSFER_PAYLOAD3) );