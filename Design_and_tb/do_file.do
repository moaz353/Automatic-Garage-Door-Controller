quit -sim 
vlib work 
vlog Design.v TB.v 
vsim -voptargs=+acc Auto_Garage_Door_Ctrl_TB
add wave * 
add wave -position insertpoint  \
sim:/Auto_Garage_Door_Ctrl_TB/DUT/state \
sim:/Auto_Garage_Door_Ctrl_TB/DUT/next_state
run -all 