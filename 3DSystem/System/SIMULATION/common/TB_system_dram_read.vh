
    case (mgr)
         0:
            begin
              case (chan)
                 0:
                    begin
                      status_read_data = diram.diram_port_arrays[0].diram_inst.ram_even.ram.mem[config_intf_word][config_burst][config_index]  ;
                    end
                 1:
                    begin
                      status_read_data = diram.diram_port_arrays[0].diram_inst.ram_odd.ram.mem[config_intf_word][config_burst][config_index]  ;
                    end
              endcase
            end
         1:
            begin
              case (chan)
                 0:
                    begin
                      status_read_data = diram.diram_port_arrays[1].diram_inst.ram_even.ram.mem[config_intf_word][config_burst][config_index]  ;
                    end
                 1:
                    begin
                      status_read_data = diram.diram_port_arrays[1].diram_inst.ram_odd.ram.mem[config_intf_word][config_burst][config_index]  ;
                    end
              endcase
            end
         2:
            begin
              case (chan)
                 0:
                    begin
                      status_read_data = diram.diram_port_arrays[2].diram_inst.ram_even.ram.mem[config_intf_word][config_burst][config_index]  ;
                    end
                 1:
                    begin
                      status_read_data = diram.diram_port_arrays[2].diram_inst.ram_odd.ram.mem[config_intf_word][config_burst][config_index]  ;
                    end
              endcase
            end
         3:
            begin
              case (chan)
                 0:
                    begin
                      status_read_data = diram.diram_port_arrays[3].diram_inst.ram_even.ram.mem[config_intf_word][config_burst][config_index]  ;
                    end
                 1:
                    begin
                      status_read_data = diram.diram_port_arrays[3].diram_inst.ram_odd.ram.mem[config_intf_word][config_burst][config_index]  ;
                    end
              endcase
            end
    endcase