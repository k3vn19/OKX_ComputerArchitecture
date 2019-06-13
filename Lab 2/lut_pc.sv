// CSE141L Winter 2018
// in-class demo -- program counter lookup table
// tells PC what do do on an absolute or a relative jump/branch
//Leave blank for now, need to hardcode label values from assembly code
module lut_pc(
  input[5:0] index,					  // lookup table's incoming address pointer
  input jmp,
  output logic[10:0] out);

  logic[10:0] offset = 11'd350;

  always_comb case (index)
	6'b000000:	out = 11'd1;	//0, prog 1
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
	6'b011111:	out = 11'd877;//31, end of prog 2
	6'b100000:  out = 11'd23 + offset;//32
    6'b100001:  out = 11'd33 + offset;//33
    6'b100010:  out = 11'd43 + offset;//34
    6'b100011:  out = 11'd53 + offset;//35
    6'b100100:  out = 11'd64 + offset;//36
    6'b100101:  out = 11'd9 + offset;//37
    6'b100110:  out = 11'd106 + offset;//38
    6'b100111:  out = 11'd121 + offset;//39
    6'b101000:  out = 11'd137 + offset;//40
    6'b101001:  out = 11'd84 + offset;//41
    6'b101010:  out = 11'd69 + offset;//42

	default: out = 16'h0;
  endcase

endmodule