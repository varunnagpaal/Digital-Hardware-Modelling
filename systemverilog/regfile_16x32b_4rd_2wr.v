module regfile_16x32b_4rd_2wr(input   wire          clk,
                              input   wire          rst,
                              input   wire  [3:0]   rdport1_ctrl_add,
                              output  wire  [31:0]  rdport1_data_out,
                              input   wire  [3:0]   rdport2_ctrl_add,
                              output  wire  [31:0]  rdport2_data_out,
                              input   wire  [3:0]   rdport3_ctrl_add,
                              output  wire  [31:0]  rdport3_data_out,
                              input   wire  [3:0]   rdport4_ctrl_add,
                              output  wire  [31:0]  rdport4_data_out,
                              input   wire  [3:0]   wrport1_ctrl_add,
                              input   wire  [31:0]  wrport1_data_in,
                              input   wire          wrport1_wren,
                              input   wire  [3:0]   wrport2_ctrl_add,
                              input   wire  [31:0]  wrport2_data_in,
                              input   wire          wrport2_wren
                              );

  // 16 x 32b register file
  reg [31:0] regFile [15:0];

  // variables
  integer i = 0;
  
  // Read register file
  assign rdport1_data_out = regFile[rdport1_ctrl_add];
  assign rdport2_data_out = regFile[rdport2_ctrl_add];
  assign rdport3_data_out = regFile[rdport3_ctrl_add];
  assign rdport4_data_out = regFile[rdport4_ctrl_add];

  // Write register file
  always @ ( posedge clk )
  begin
    if( rst )
      begin
        for( i = 0; i<16; i = i+1 ) regFile[i] <= 0;
      end
    else
      if( wrport1_wren && wrport2_wren )
        begin
          if( wrport1_ctrl_add == wrport2_ctrl_add )
            begin
              // in case of write collision, we ignore write on second port
              regFile[wrport1_ctrl_add] <= wrport1_data_in;
            end
          else
            begin
              // there is no write collision and we can safely write to both wr ports
              regFile[wrport1_ctrl_add] <= wrport1_data_in;
              regFile[wrport2_ctrl_add] <= wrport2_data_in;
            end
          end
      else
        begin
          if ( wrport1_wren ) regFile[wrport1_ctrl_add] <= wrport1_data_in;
          if ( wrport2_wren ) regFile[wrport1_ctrl_add] <= wrport1_data_in;
        end
  end
endmodule // regfile_16x32b_4rd_2wr
