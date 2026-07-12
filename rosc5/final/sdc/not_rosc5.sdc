###############################################################################
# Created by write_sdc
###############################################################################
current_design not_rosc5
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk_i -period 50.0000 
set_clock_uncertainty 0.2500 clk_i
set_input_delay 10.0000 -clock [get_clocks {clk_i}] -add_delay [get_ports {rosc_enable}]
set_output_delay 10.0000 -clock [get_clocks {clk_i}] -add_delay [get_ports {rosc_out}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0729 [get_ports {rosc_out}]
set_driving_cell -lib_cell gf180mcu_fd_sc_mcu7t5v0__inv_1 -pin {ZN} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {rosc_enable}]
###############################################################################
# Design Rules
###############################################################################
set_max_transition 3.0000 [current_design]
set_max_capacitance 0.2000 [current_design]
set_max_fanout 10.0000 [current_design]
