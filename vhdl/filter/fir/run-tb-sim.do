vlib sandbox
vmap sandbox sandbox

vcom -work sandbox -2008 -explicit -check_synthesis -source -vopt -stats=none -reportprogress 300 fir_filter_shared_package.vhdl
vcom -work sandbox -2008 -explicit -check_synthesis -source -vopt -stats=none -reportprogress 300 fir_generic_transposed_filter.vhdl
vcom -work sandbox -2008 -explicit -check_synthesis -source -vopt -stats=none -reportprogress 300 testbench.vhdl
vsim -novopt sandbox.fir_generic_transposed_filter(fir_rtl_arch) sandbox.testbench(test)

add wave -position end -group TestBench sim:/testbench/clk
add wave -position end -group TestBench sim:/testbench/rst
add wave -position end -group TestBench sim:/testbench/valid_h_out
add wave -position end -group TestBench sim:/testbench/ready_h_in
add wave -position end -group TestBench sim:/testbench/valid_x_out
add wave -position end -group TestBench sim:/testbench/ready_x_in
add wave -position end -group TestBench -decimal sim:/testbench/h_data_out
add wave -position end -group TestBench -decimal sim:/testbench/x_data_out
add wave -position end -group TestBench sim:/testbench/valid_in
add wave -position end -group TestBench -decimal sim:/testbench/y_data_in

add wave -position end -group DUT sim:/testbench/DUT/clk
add wave -position end -group DUT sim:/testbench/DUT/rst
add wave -position end -group DUT sim:/testbench/DUT/valid_h_in
add wave -position end -group DUT sim:/testbench/DUT/ready_h_out
add wave -position end -group DUT sim:/testbench/DUT/ready_h_out_reg
add wave -position end -group DUT sim:/testbench/DUT/valid_x_in
add wave -position end -group DUT sim:/testbench/DUT/ready_x_out
add wave -position end -group DUT sim:/testbench/DUT/ready_x_out_reg
add wave -position end -group DUT -decimal sim:/testbench/DUT/coeff_cnt
add wave -position end -group DUT -decimal sim:/testbench/DUT/coeff_cnt_next
add wave -position end -group DUT -decimal sim:/testbench/DUT/h_data_in
add wave -position end -group DUT -decimal sim:/testbench/DUT/coefficient_mem_array
add wave -position end -group DUT -decimal sim:/testbench/DUT/x_data_in
add wave -position end -group DUT -decimal sim:/testbench/DUT/input_sample_mem
add wave -position end -group DUT -decimal sim:/testbench/DUT/multiplier_sigs
add wave -position end -group DUT -decimal sim:/testbench/DUT/adder_mem_array
add wave -position end -group DUT sim:/testbench/DUT/valid_out
add wave -position end -group DUT sim:/testbench/DUT/valid_out_reg
add wave -position end -group DUT -decimal sim:/testbench/DUT/y_data_out

run -all

echo "When you are done examining the waveform, you may run following do script to stop the simulation, remove sandbox and quit modelsim: \"do stop-clean-quit-sim.do\""