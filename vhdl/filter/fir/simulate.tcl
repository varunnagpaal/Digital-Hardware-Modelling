vlib work
vmap work work
vcom fir_filter_shared_package.vhdl
vcom fir_generic_transposed_filter.vhdl
vcom testbench.vhdl
vsim work.fir_generic_transposed_filter(fir_rtl_arch)

vsim -voptargs=+acc work.fir_generic_transposed_filter(fir_rtl_arch)
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