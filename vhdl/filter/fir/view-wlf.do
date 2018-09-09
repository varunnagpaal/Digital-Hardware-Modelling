vsim -view results/without-testbench/vsimresult.wlf
add wave -position insertpoint  \
vsimresult:/fir_generic_transposed_filter/clk \
vsimresult:/fir_generic_transposed_filter/rst \
vsimresult:/fir_generic_transposed_filter/valid_h_in \
vsimresult:/fir_generic_transposed_filter/ready_h_out \
vsimresult:/fir_generic_transposed_filter/ready_h_out_reg \
vsimresult:/fir_generic_transposed_filter/valid_x_in \
vsimresult:/fir_generic_transposed_filter/ready_x_out \
vsimresult:/fir_generic_transposed_filter/ready_x_out_reg \
vsimresult:/fir_generic_transposed_filter/coeff_cnt \
vsimresult:/fir_generic_transposed_filter/coeff_cnt_next \
vsimresult:/fir_generic_transposed_filter/h_data_in \
vsimresult:/fir_generic_transposed_filter/coefficient_mem_array \
vsimresult:/fir_generic_transposed_filter/x_data_in \
vsimresult:/fir_generic_transposed_filter/input_sample_mem \
vsimresult:/fir_generic_transposed_filter/multiplier_sigs \
vsimresult:/fir_generic_transposed_filter/adder_mem_array \
vsimresult:/fir_generic_transposed_filter/valid_out \
vsimresult:/fir_generic_transposed_filter/valid_out_reg \
vsimresult:/fir_generic_transposed_filter/y_data_out