// ALU for class demo
// CSE141L Win 2018
import definitions::*;              // declares ALU opcodes 
module alu (			         
  input       [2:0] op,			    // opcode
  input       [7:0] in_a,		    // operands in
                    in_b,
  output logic[7:0] rslt);
  op_mne op_mnemonic;			    // type enum: used for convenient waveform viewing

  always_comb begin
	rslt  = 8'b0;
    case(op)						// selective override one or more defaults
	 kADD: {rslt} = in_a + in_b;
	 kLSH: {rslt} = in_a << in_b[1:0];
	 kRSH: {rslt} = in_a >> in_b[1:0];
	 kXOR: {rslt} = in_a ^ in_b;
	 
//     kLDR: rslt = in_a;		    // load reg_file from data_mem
//	  kACC: {co,rslt} = in_a+in_b+ci;  // add w/ carry in and out
//	  kACI: {co,rslt} = in_a-1+ci;	// decrement by 1 with carry in and out
//	  kBZR: z = !in_a;				// branch relative: if(in_a=0), set z flag=1
//	  kBZA: z = !in_a;				// branch absolute: same test in ALU
//	  kSTR: rslt = in_a;			// store in data_mem from reg_file
    endcase
  end
  assign  op_mnemonic = op_mne'(op);  // creates ALU opcode mnemonics in timing diagram

endmodule