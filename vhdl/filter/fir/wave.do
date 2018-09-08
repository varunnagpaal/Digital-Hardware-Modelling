onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fir_generic_transposed_filter/clk
add wave -noupdate /fir_generic_transposed_filter/rst
add wave -noupdate /fir_generic_transposed_filter/valid_h_in
add wave -noupdate /fir_generic_transposed_filter/ready_h_out
add wave -noupdate /fir_generic_transposed_filter/ready_h_out_reg
add wave -noupdate /fir_generic_transposed_filter/valid_x_in
add wave -noupdate /fir_generic_transposed_filter/ready_x_out
add wave -noupdate /fir_generic_transposed_filter/ready_x_out_reg
add wave -noupdate /fir_generic_transposed_filter/coeff_cnt
add wave -noupdate /fir_generic_transposed_filter/coeff_cnt_next
add wave -noupdate -radix decimal /fir_generic_transposed_filter/h_data_in
add wave -noupdate -radix decimal -expand /fir_generic_transposed_filter/coefficient_mem_array
add wave -noupdate -radix decimal /fir_generic_transposed_filter/x_data_in
add wave -noupdate -radix decimal /fir_generic_transposed_filter/input_sample_mem
add wave -noupdate -radix decimal -childformat {{/fir_generic_transposed_filter/multiplier_sigs(0) -radix decimal} {/fir_generic_transposed_filter/multiplier_sigs(1) -radix decimal} {/fir_generic_transposed_filter/multiplier_sigs(2) -radix decimal} {/fir_generic_transposed_filter/multiplier_sigs(3) -radix decimal}} -expand -subitemconfig {/fir_generic_transposed_filter/multiplier_sigs(0) {-radix decimal} /fir_generic_transposed_filter/multiplier_sigs(1) {-radix decimal} /fir_generic_transposed_filter/multiplier_sigs(2) {-radix decimal} /fir_generic_transposed_filter/multiplier_sigs(3) {-radix decimal}} /fir_generic_transposed_filter/multiplier_sigs
add wave -noupdate -radix decimal -childformat {{/fir_generic_transposed_filter/adder_mem_array(0) -radix decimal} {/fir_generic_transposed_filter/adder_mem_array(1) -radix decimal} {/fir_generic_transposed_filter/adder_mem_array(2) -radix decimal} {/fir_generic_transposed_filter/adder_mem_array(3) -radix decimal}} -expand -subitemconfig {/fir_generic_transposed_filter/adder_mem_array(0) {-radix decimal} /fir_generic_transposed_filter/adder_mem_array(1) {-radix decimal} /fir_generic_transposed_filter/adder_mem_array(2) {-radix decimal} /fir_generic_transposed_filter/adder_mem_array(3) {-radix decimal}} /fir_generic_transposed_filter/adder_mem_array
add wave -noupdate /fir_generic_transposed_filter/valid_out
add wave -noupdate /fir_generic_transposed_filter/valid_out_reg
add wave -noupdate -radix decimal /fir_generic_transposed_filter/y_data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2200 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 353
configure wave -valuecolwidth 121
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {2415 ns}
