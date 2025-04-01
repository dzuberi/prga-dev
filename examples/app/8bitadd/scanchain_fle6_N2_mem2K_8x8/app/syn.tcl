# bring yosys command into our script!
yosys -import

# read library cells
tcl /workspace/prga_physical/prga/examples/fpga/scanchain/fle6_N2_mem2K_8x8/syn/read_lib.tcl

# read verilog sources
read_verilog /workspace/prga_physical/prga/examples/app/8bitadd/src/adder.v

# pre-process
hierarchy -check -top adder

# synthesis
tcl /workspace/prga_physical/prga/examples/fpga/scanchain/fle6_N2_mem2K_8x8/syn/synth.tcl

# output
write_blif -conn -param syn.eblif

# simulateable Verilog output
zinit -all
yosys rename -top postsyn
write_verilog -norename -attr2comment postsyn.v