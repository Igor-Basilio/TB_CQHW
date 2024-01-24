
# Load the design
vsim work.tb

# Add signals to the wave window
add wave -position insertpoint sim:/tb/*

# Zoom range
wave zoom range 0ns 50ns

# Run the simulation
run -all
