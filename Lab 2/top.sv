// CSE141L Win2018    in-class demo
// top-level design connects all pieces together
import definitions::*;
module top(
  input        clk,
               reset,
  output logic done);

  //may need to change # of bits for pc counter and jump
  // list of interconnecting wires/buses w/ respective bit widths 
  wire signed[7:0] bamt;	    // PC jump
  wire[9:0] PC;				    // program counter
  wire[8:0] inst;			    // machine code
  wire 		jnz,					//CONTROL wires
				jz;
  wire[1:0]  MemtoReg,
				MemWrite,
				ALUSrc,
				RegWrite;
  wire[2:0] ALUOp;
  wire[7:0] dm_out,			    // data memory
            dm_in,			   
            dm_adr;
  wire[7:0] in_a,			    // alu inputs
            in_b,			   
				rslt,               // alu output
            do_a,	            // reg_file outputs
			   do_b;			   
  wire[7:0] rf_din;	            // reg_file input
  wire[2:0] op;	                // opcode
  wire[1:0] ptr_a,			    // ref_file pointers
            ptr_b;			   
  

  wire[15:0]			m1_out,	// MUX 2 to 4
							m2_out;
 
	//TODO
  lut_pc lp1(				     // maps 2 bits to 8
    .ptr  (lutpc_ptr),		    
	.dout (bamt));	             // branch distance in PC
  
  mux_2to4 mux1(
	.A (rslt),					// output of ALU
	.B (m2_out),				//output of 3:8 mux
	.C (dm_out),				// output of data mem
	.D (8'b0),				// dummy value, isn't ever used
	.sel (MemtoReg),
	.Y (m1_out)
  );
  
  mux_3to8 mux2(
	.sel (inst[2:0]),
	.out (m2_out)
  );
  mux_2to1 mux3(
	.A(do_b),
	.B(inst[7:0]),			// this is the shamt, but we pass in 8 bits to sign extend. 
								// only the lowest 2 bits will actually be used
	.sel(ALUSrc),
	.Y(in_b)
  );
  
						
  pc pc1(						 // program counter
    .clk (clk) ,
	.reset, 
	.op   ,					     // from inst_mem
	.bamt (bamt) ,		         // from lut_pc
	.PC );					     // to PC module

  imem im1(					     // instruction memory
     .PC   ,				     // pointer in = PC
	 .inst);				     // output = 7-bit (yours is 9) machine code

  assign done = inst[6:4]==kSTR; // store result & hit done flag

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

  rf rf1(						 // reg file -- one write, two reads
    .clk             ,
	.di   (m1_out)   ,			 // data to be written in
	.we   (RegWrite)      ,		 // write enable
	.ptr_a(inst[5:3])   ,		 // read pointers 
	.ptr_b(inst[2:0])   ,			//write/read pointer
	.do_a               ,        // to ALU
	.do_b  						 // to ALU immediate input switch
  );

  alu au1(						 // execution (ALU) unit
	.op (ALUSrc),						 // ALU operation
	.in_a(do_a) ,						 // alu inputs
	.in_b(m3_out) ,
	.rslt						 // alu output
	  );						 // zero flag   in_a=0

  lut_m lm1(					 // lookup table for data mem address
    .ptr(inst[7:0]),			 // select one of up to eight addresses
	.dm_adr						 // send this (8-bit) address to data mem
  );

  dmem dm1(						 // data memory
   // .ReadMem(1'b1),
	 .clk         ,
	.memWrite  (MemWrite)   ,				 // only time to write = store 
	.addr(m3_out),				 // from LUT
	.di  (do_a) ,				 // data to store (from reg_file)
	.dout(dm_out));				 // data out (for loads)

endmodule