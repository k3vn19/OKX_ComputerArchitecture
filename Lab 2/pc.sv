// CSE141L Winter 2018
// program counter for in class demo
import definitions::*;
module pc (
  input        [2:0] op, 		 // opcodes
//  input signed [7:0] bamt,		 // how far/where to jump or branch
  input              clk,	     // clk -- PC advances and memory/reg_file writes are clocked 
  input              reset,		 // overrides all else, forces PC to 0 (start of program)
  input			[7:0] do_a,			//condition, reg1
  input			[7:0]	dout,			//from LUT
  output logic [10:0] PC);		 // program count

  assign jz = ((op == 3'b100) && (do_a == 'b0));
  assign jnz = ((op == 3'b101) && (do_a != 'b0)); 
  //    assign brel = z && op==BZR;	 // do a relative branch iff ALU z flag is set on a BZR instruction
//    assign babs = z && op==BZA;	 // same for absolute branch

//	assign jamt = z && 

  always_ff @(posedge clk) 
    if(reset)					 // resetting to start=0
	  PC <= 'b0;
	else if (jz)               // relative branching
	  PC <= dout;
	else if (jnz)				 // relative branching
	  PC <= dout;
	else						 // normal/default operation
	  PC <= PC + 'b1;			 

endmodule