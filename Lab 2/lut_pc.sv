// CSE141L Winter 2018
// in-class demo -- program counter lookup table
// tells PC what do do on an absolute or a relative jump/branch
//Leave blank for now, need to hardcode label values from assembly code
module lut_pc(
  input[5:0] index,					  // lookup table's incoming address pointer
  input jmp,
  output logic[10:0] out);

  always_comb case (index)
	6'b000000:	out = 16'h0;
	default: out = 16'h0;
  endcase

endmodule