sh mkdir WORK
define_design_lib WORK -path ./WORK
analyze -library WORK -format vhdl {fir_filter_shared_package.vhdl fir_generic_transposed_filter.vhdl}
elaborate FIR_GENERIC_TRANSPOSED_FILTER -architecture FIR_RTL_ARCH -library WORK
compile -exact_map -ungroup_all -auto_ungroup area -only_design_rule

define_design_lib WORK -path ./WORK
set target_library library.db
set link_library library.db
analyze -library WORK -work WORK -format vhdl {fir_filter_shared_package.vhdl fir_generic_transposed_filter.vhdl}
elaborate FIR_GENERIC_TRANSPOSED_FILTER -architecture FIR_RTL_ARCH -library WORK
check_design 
compile -exact_map -ungroup_all -auto_ungroup area -only_design_rule
report_cell > CellReport.txt
write -hierarchy -format vhdl -output fir_generic_transposed_filter_syn.vhdl
exit