// Top-level design connects all pieces together for OKX.
import definitions::*;
module top(
  input        clk,
               reset,
  output logic done);

  // list of interconnecting wires/buses w/ respective bit widths 
  wire signed[7:0] 			bamt;	    		// PC jump branch amount
  wire[10:0] 						PC;				    // program counter
  wire[8:0] 						inst;			    // machine code assembly instruction
  																		// === control wires ===
	wire 									jnz,					
												jz;
												ALUSrc,				// select signal for 1:2 mux before ALU in_b
												RegWrite;			// signal for write enable for register file
												MemWrite,			// signal for write enable of data mem
  wire[1:0]  						MemtoReg,			// select signal for 2:4 mux 
  wire[2:0] 						ALUOp;				// signal for ALU operation
																			// === data mem ===		
	wire[7:0] 						dm_out,			  // output of data memory, input to 2:4 mux
            						dm_in,			  // input data for data mem 
            						dm_adr;				// address to read or write of data mem
																			// === ALU ===
	wire[7:0] 						in_a,			    // first input for ALU, comes from reg file first output
            						in_b,			   	// second input for ALU, comes from 1:2 mux
												rslt,         // alu output
																			// === register file ===
            						do_a,	        // reg file output, goes to in_a
			   								do_b;			   	// reg file output, used as first input to 1:2 mux
  wire[7:0] 						rf_din;	      // reg file input data to be written
  wire[2:0] 						op;	          // TODO - what is this again?
  wire[1:0] 						ptr_a,			  // ref_file pointer inputs, come from instruction
            						ptr_b;			  
																			// === mux outputs === 
  wire[15:0]						m1_out,				
												m2_out,
												m3_out;
 


	// Module wire/bus connections

  
  mux_2to4 mux1(
		.A (rslt),												// output of ALU
		.B (m2_out),											// output of 3:8 mux
		.C (dm_out),											// output of data mem
		.D (8'b0),												// dummy value, isn't ever used
		.sel (MemtoReg),
		.Y (m1_out)
  );
  
  mux_3to8 mux2(
		.sel (inst[2:0]),
		.out (m2_out)
  );

  mux_2to1 mux3(
		.A(do_b),
		.B(inst[7:0]),										// this is the shamt, but we pass in 8 bits to sign extend. 
																			// only the lowest 2 bits will actually be used
		.sel(ALUSrc),
		.Y(in_b)
  );
						
  pc pc1(						 									// program counter
  	.clk (clk) ,
		.reset, 
		.op,						     							// from inst_mem
//	.bamt (bamt),			         				// from lut_pc
		.do_a,														// reg 1
		.dout(bamt),											// from LUT
		.PC 															// to PC module
	);					     

  imem im1(					     							// instruction memory
    .PC,				     									// pointer in = PC
	 	.inst				     									// output = 7-bit (yours is 9) machine code
	);

//  assign done = inst[6:4]==kSTR; // store result & hit done flag // TODO - why is this here?

	Control ctr(
		.inst,
		.jz,
		.jnz,
		.MemtoReg,
		.MemWrite,
		.ALUSrc,
		.RegWrite,
		.ALUOp
	);

  rf rf1(						 									// === register file ===
    .clk,
		.di   (m1_out),			 							// data to be written in
		.we   (RegWrite),		 							// write enable
		.ptr_a(inst[5:3]),								// read pointers 
		.ptr_b(inst[2:0]),								// write/read pointer
		.do_a,        										// output going to first input of ALU
		.do_b  						 								// output going to first input of 1:2 mux
  );

  alu au1(						 								// === ALU unit ====
		.op (ALUOp),						 					// ALU operation from control unit
		.in_a(do_a) ,								 			// alu input from register file
		.in_b(m3_out) ,										// alu input from 1:2 mux
		.rslt						 									// alu output, used as input for 2:4 mux
	);		

	dmem dm1(						 								// === data memory ===
   	//.ReadMem(1'b1),
		.clk,
		.memWrite  (MemWrite),					 	// only time to write = store 
		.addr(m3_out),				 						// from LUT
		.di  (do_a) ,				 							// data to store (from reg_file)
		.dout(dm_out)				 							// data out (for loads)
	);				 											

	// TODO
  lut_m lm1(					 								// lookup table for data mem address
    .ptr(inst[7:0]),			 						// select one of up to eight addresses
		.dm_adr						 								// send this (8-bit) address to data mem
  );

	// TODO
  lut_pc lp1(				     							// maps 2 bits to 8
    .ptr  (lutpc_ptr),		    
		.dout (bamt)	             			// branch distance in PC
	);

endmodule