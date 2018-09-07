vlib work
vmap work work
vcom fir_filter_shared_package.vhdl
vcom fir_generic_transposed_filter.vhdl
vcom testbench.vhdl
vsim work.fir_generic_transposed_filter(fir_rtl_arch)

vsim -voptargs=+acc work.fir_generic_transposed_filter(fir_rtl_arch)

vsim -gui work.fir_generic_transposed_filter(fir_rtl_arch)

add wave -position end  sim:/fir_generic_transposed_filter/clk
add wave -position end  sim:/fir_generic_transposed_filter/rst
add wave -position end  sim:/fir_generic_transposed_filter/coeff_cnt
add wave -position end  sim:/fir_generic_transposed_filter/coeff_cnt_next
add wave -position end  sim:/fir_generic_transposed_filter/valid_h_in
add wave -position end  sim:/fir_generic_transposed_filter/ready_h_out
add wave -position end  sim:/fir_generic_transposed_filter/valid_x_in
add wave -position end  sim:/fir_generic_transposed_filter/ready_x_out
add wave -position end  sim:/fir_generic_transposed_filter/h_data_in
add wave -position end  sim:/fir_generic_transposed_filter/coefficient_mem_array
add wave -position end  sim:/fir_generic_transposed_filter/x_data_in
add wave -position end  sim:/fir_generic_transposed_filter/input_sample_mem
add wave -position end  sim:/fir_generic_transposed_filter/multiplier_sigs
add wave -position end  sim:/fir_generic_transposed_filter/adder_mem_array
add wave -position end  sim:/fir_generic_transposed_filter/valid_out_reg
add wave -position end  sim:/fir_generic_transposed_filter/y_data_out
add wave -position 15  sim:/fir_generic_transposed_filter/valid_out
add wave -position 5  sim:/fir_generic_transposed_filter/ready_h_out_reg
add wave -position 8  sim:/fir_generic_transposed_filter/ready_x_out_reg

force -freeze sim:/fir_generic_transposed_filter/clk 1 0, 0 {50 ns} -r 100
force -freeze sim:/fir_generic_transposed_filter/rst 0 0
force -freeze sim:/fir_generic_transposed_filter/valid_h_in X 0
force -freeze sim:/fir_generic_transposed_filter/valid_x_in X 0
force -freeze sim:/fir_generic_transposed_filter/h_data_in 16'hXXXX 0
force -freeze sim:/fir_generic_transposed_filter/x_data_in 16'hXXXX 0
run

force -freeze sim:/fir_generic_transposed_filter/rst 1 0
run

force -freeze sim:/fir_generic_transposed_filter/rst 0 0
force -freeze sim:/fir_generic_transposed_filter/valid_h_in 1 0
force -freeze sim:/fir_generic_transposed_filter/h_data_in 16'h0001 0
run
run
run
run
run

force -freeze sim:/fir_generic_transposed_filter/valid_h_in X 0
force -freeze sim:/fir_generic_transposed_filter/h_data_in 16'hXXXX 0
force -freeze sim:/fir_generic_transposed_filter/valid_x_in 1 0
force -freeze sim:/fir_generic_transposed_filter/x_data_in 16'h0001 0
run
run
run
run
run
run
run
run

force -freeze sim:/fir_generic_transposed_filter/x_data_in 16'hFFFF 0
run
run
run
run




force -freeze sim:/fir_generic_transposed_filter/clk 1 0, 0 {50 ns} -r 100
force -freeze sim:/fir_generic_transposed_filter/rst 0 0
force -freeze sim:/fir_generic_transposed_filter/valid_h_in 0 0
force -freeze sim:/fir_generic_transposed_filter/valid_x_in 0 0
run
force -freeze sim:/fir_generic_transposed_filter/rst 1 0
run
force -freeze sim:/fir_generic_transposed_filter/rst 0 0
force -freeze sim:/fir_generic_transposed_filter/valid_h_in 1 0
run
run
run
run