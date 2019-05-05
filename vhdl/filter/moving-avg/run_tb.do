vmap -del sandbox
vlib sandbox
vmap sandbox sandbox
vcom -work sandbox -check_synthesis -source -2008 fir_moving_avg_time_mux_multiple.vhdl
vcom -work sandbox -source -2008 tb_fir_moving_avg_time_mux_multiple.vhdl
vsim -novopt sandbox.fir(rtl) sandbox.testbench(test)

add wave -position end sim:/testbench/DUT/clk
add wave -position end sim:/testbench/DUT/reset_n
add wave -position end sim:/testbench/DUT/fir_en
add wave -position end sim:/testbench/DUT/fir_rdy
add wave -position end -decimal sim:/testbench/DUT/fir_in
add wave -position end -decimal sim:/testbench/DUT/reg_x
add wave -position end -decimal sim:/testbench/DUT/sig_array_mux_in_x
add wave -position end -decimal sim:/testbench/DUT/sig_array_mux_out_x
add wave -position end -unsigned sim:/testbench/DUT/sig_mux_sel_cnt
add wave -position end -unsigned sim:/testbench/DUT/sig_mux_sel_cnt_next
add wave -position end -decimal sim:/testbench/DUT/sig_array_signed_adders
add wave -position end -decimal sim:/testbench/DUT/sig_y_sum
add wave -position end -decimal sim:/testbench/DUT/reg_y_sum
add wave -position end -decimal sim:/testbench/DUT/sig_y_out
add wave -position end -decimal sim:/testbench/DUT/fir_out

run -all

echo "To stop and save the simulation execute command: \"do save.do\". To remove sandbox and quit modelsim execute command: \"do clean.do\""