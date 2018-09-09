vsim -view results/with-testbench/vsimresult_tb.wlf

add wave -position end -group TestBench vsimresult_tb:/testbench/clk
add wave -position end -group TestBench vsimresult_tb:/testbench/rst
add wave -position end -group TestBench vsimresult_tb:/testbench/valid_h_out
add wave -position end -group TestBench vsimresult_tb:/testbench/ready_h_in
add wave -position end -group TestBench vsimresult_tb:/testbench/valid_x_out
add wave -position end -group TestBench vsimresult_tb:/testbench/ready_x_in
add wave -position end -group TestBench -decimal vsimresult_tb:/testbench/h_data_out
add wave -position end -group TestBench -decimal vsimresult_tb:/testbench/x_data_out
add wave -position end -group TestBench vsimresult_tb:/testbench/valid_in
add wave -position end -group TestBench -decimal vsimresult_tb:/testbench/y_data_in

add wave -position end -group DUT vsimresult_tb:/testbench/DUT/clk
add wave -position end -group DUT vsimresult_tb:/testbench/DUT/rst
add wave -position end -group DUT vsimresult_tb:/testbench/DUT/valid_h_in
add wave -position end -group DUT vsimresult_tb:/testbench/DUT/ready_h_out
add wave -position end -group DUT vsimresult_tb:/testbench/DUT/ready_h_out_reg
add wave -position end -group DUT vsimresult_tb:/testbench/DUT/valid_x_in
add wave -position end -group DUT vsimresult_tb:/testbench/DUT/ready_x_out
add wave -position end -group DUT vsimresult_tb:/testbench/DUT/ready_x_out_reg
add wave -position end -group DUT -decimal vsimresult_tb:/testbench/DUT/coeff_cnt
add wave -position end -group DUT -decimal vsimresult_tb:/testbench/DUT/coeff_cnt_next
add wave -position end -group DUT -decimal vsimresult_tb:/testbench/DUT/h_data_in
add wave -position end -group DUT -decimal vsimresult_tb:/testbench/DUT/coefficient_mem_array
add wave -position end -group DUT -decimal vsimresult_tb:/testbench/DUT/x_data_in
add wave -position end -group DUT -decimal vsimresult_tb:/testbench/DUT/input_sample_mem
add wave -position end -group DUT -decimal vsimresult_tb:/testbench/DUT/multiplier_sigs
add wave -position end -group DUT -decimal vsimresult_tb:/testbench/DUT/adder_mem_array
add wave -position end -group DUT vsimresult_tb:/testbench/DUT/valid_out
add wave -position end -group DUT vsimresult_tb:/testbench/DUT/valid_out_reg
add wave -position end -group DUT -decimal vsimresult_tb:/testbench/DUT/y_data_out