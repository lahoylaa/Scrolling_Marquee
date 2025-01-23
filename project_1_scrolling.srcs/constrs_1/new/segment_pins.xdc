# Mapping clk
set_property PACKAGE_PIN F14 [get_ports clk_100MHz]
set_property IOSTANDARD LVCMOS33 [get_ports clk_100MHz]

# Mapping Seven Segment
set_property PACKAGE_PIN D7 [get_ports {Seg_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg_out[0]}]

set_property PACKAGE_PIN C5 [get_ports {Seg_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg_out[1]}]

set_property PACKAGE_PIN A5 [get_ports {Seg_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg_out[2]}]

set_property PACKAGE_PIN B7 [get_ports {Seg_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg_out[3]}]

set_property PACKAGE_PIN A7 [get_ports {Seg_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg_out[4]}]

set_property PACKAGE_PIN D6 [get_ports {Seg_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg_out[5]}]

set_property PACKAGE_PIN B5 [get_ports {Seg_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Seg_out[6]}]

# Mapping Anodes
set_property PACKAGE_PIN A8 [get_ports {Anode_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode_out[0]}]

set_property PACKAGE_PIN C7 [get_ports {Anode_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode_out[1]}]

set_property PACKAGE_PIN C4 [get_ports {Anode_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode_out[2]}]

set_property PACKAGE_PIN D5 [get_ports {Anode_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Anode_out[3]}]

# Mapping for Right Switches
set_property PACKAGE_PIN V2 [get_ports {DipSwitchRight[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DipSwitchRight[0]}]

set_property PACKAGE_PIN U2 [get_ports {DipSwitchRight[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DipSwitchRight[1]}]

set_property PACKAGE_PIN U1 [get_ports {DipSwitchRight[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DipSwitchRight[2]}]

set_property PACKAGE_PIN T2 [get_ports {DipSwitchRight[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DipSwitchRight[3]}]

# Mapping for Left Switch
set_property PACKAGE_PIN T1 [get_ports {DipSwitchLeft[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DipSwitchLeft[0]}]

set_property PACKAGE_PIN R2 [get_ports {DipSwitchLeft[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DipSwitchLeft[1]}]

set_property PACKAGE_PIN R1 [get_ports {DipSwitchLeft[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DipSwitchLeft[2]}]

set_property PACKAGE_PIN P2 [get_ports {DipSwitchLeft[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DipSwitchLeft[3]}]

# Mapping Button
set_property PACKAGE_PIN J2 [get_ports btnU]
set_property IOSTANDARD LVCMOS33 [get_ports btnU]

set_property PACKAGE_PIN J5 [get_ports rst_btnC]
set_property IOSTANDARD LVCMOS33 [get_ports rst_btnC]