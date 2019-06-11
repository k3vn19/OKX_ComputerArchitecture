// CSE141L Winter 2018
// in-class demo -- program counter lookup table
// tells PC what do do on an absolute or a relative jump/branch
//Leave blank for now, need to hardcode label values from assembly code
module lut_pc(
  input[5:0] index,					  // lookup table's incoming address pointer
  input jmp,
  output logic[10:0] out);

  always_comb case (index)
	6'b000000:	out = 11'd1;	//0
	6'b000001:	out = 11'd1;	//1
	6'b000010:	out = 11'd492;	//2
	6'b000011:	out = 11'd501;//3
	6'b000100:	out = 11'd518;//4
	6'b000101:	out = 11'd527;//5
	6'b000110:	out = 11'd544;//6
	6'b000111:	out = 11'd553;//7
	6'b001000:	out = 11'd570;//8
	6'b001001:	out = 11'd579;//9
	6'b001010:	out = 11'd596;//10
	6'b001011:	out = 11'd605;//11
	6'b001100:	out = 11'd622;//12
	6'b001101:	out = 11'd631;//13
	6'b001110:	out = 11'd648;//14
	6'b001111:	out = 11'd657;//15
	6'b010000:	out = 11'd674;//16
	6'b010001:	out = 11'd683;//17
	6'b010010:	out = 11'd711;//18
	6'b010011:	out = 11'd720;//19
	6'b010100:	out = 11'd737;//20
	6'b010101:	out = 11'd746;//21
	6'b010110:	out = 11'd763;//22
	6'b010111:	out = 11'd772;//23
	6'b011000:	out = 11'd789;//24
	6'b011001:	out = 11'd798;//25
	6'b011010:	out = 11'd815;//26
	6'b011011:	out = 11'd824;//27
	6'b011100:	out = 11'd841;//28
	6'b011101:	out = 11'd850;//29
	6'b011110:	out = 11'd867;//30
	6'b011111:	out = 11'd877;//31

	default: out = 16'h0;
  endcase

endmodule