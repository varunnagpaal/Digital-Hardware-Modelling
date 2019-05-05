vmap -del sandbox
vlib sandbox
vmap sandbox sandbox
vcom -work sandbox -check_synthesis -source -2008 fir_moving_avg_time_mux_multiple.vhdl

vsim -novopt sandbox.fir(rtl)

add wave -position end sim:/fir/clk
add wave -position end sim:/fir/reset_n
add wave -position end sim:/fir/fir_en
add wave -position end sim:/fir/fir_rdy
add wave -position end -decimal sim:/fir/fir_in
add wave -position end -decimal sim:/fir/fir_out
add wave -position end -decimal sim:/fir/reg_x
add wave -position end -decimal sim:/fir/sig_array_mux_in_x
add wave -position end -unsigned sim:/fir/sig_mux_sel_cnt
add wave -position end -unsigned sim:/fir/sig_mux_sel_cnt_next
add wave -position end -decimal sim:/fir/sig_array_mux_out_x
add wave -position end -decimal sim:/fir/sig_array_signed_adders
add wave -position end -decimal sim:/fir/sig_y_sum
add wave -position end -decimal sim:/fir/reg_y_sum
add wave -position end -decimal sim:/fir/sig_y_out

restart -f
force -freeze sim:/fir/clk 0 0, 1 {5 ns} -r 10
force -freeze sim:/fir/reset_n 0 0
force -freeze sim:/fir/fir_en 0 0
force -freeze sim:/fir/fir_in 16'h0000 0
run 13ns
force -freeze sim:/fir/reset_n 1 0
run 37ns
force -freeze sim:/fir/fir_en 1 0
run 2.5 ns
force -freeze sim:/fir/fir_in 16'h0001 0
run 2.5 ns
run 35ns
force -freeze sim:/fir/fir_in 16'h0002 0
run 40ns
force -freeze sim:/fir/fir_in 16'h0003 0
run 40ns
force -freeze sim:/fir/fir_in 16'h0004 0
run 40ns
force -freeze sim:/fir/fir_in 16'h0005 0
run 40ns
force -freeze sim:/fir/fir_in 16'h0006 0
run 40ns
force -freeze sim:/fir/fir_in 16'h0007 0
run 40ns
force -freeze sim:/fir/fir_in 16'h0008 0
run 40ns
force -freeze sim:/fir/fir_in 16'h0009 0
run 40ns
force -freeze sim:/fir/fir_in 16'h000A 0
run 40ns
force -freeze sim:/fir/fir_in 16'h000B 0
run 40ns
force -freeze sim:/fir/fir_in 16'h000C 0
run 40ns
force -freeze sim:/fir/fir_in 16'h000D 0
run 40ns
force -freeze sim:/fir/fir_in 16'h000E 0
run 40ns
force -freeze sim:/fir/fir_in 16'h000F 0
run 40ns
force -freeze sim:/fir/fir_in 16'h0010 0
run 40ns

echo "To stop and save the simulation execute command: \"do save.do\". To remove sandbox and quit modelsim execute command: \"do clean.do\""