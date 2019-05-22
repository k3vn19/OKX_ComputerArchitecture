// CSE141L Winter 2018
// in-class demo -- program counter lookup table
// tells PC what do do on an absolute or a relative jump/branch
//Leave blank for now, need to hardcode label values from assembly code
module lut_pc(
  input[2:0] sel,					  // lookup table's incoming address pointer
  output logic[10:0] dout);	  // goes to input port on PC

  always_comb case (sel)
	3'b001: dout = 10'd8;				  // use for absolute jump to PC=8
	3'b010: dout = -10'd3;			  // for relative jump back by 3 instructions
	default: dout = 10'd1;			  // default: PC advances to next value (PC+4 in ARM or MIPS)
  endcase

endmodule