// Top-level design connects all pieces together for OKX.
// ALL UNDERSCORE!!!!

module top(
  input        clk,
               reset,
               req,
  output logic halt);

  // list of interconnecting wires/buses w/ respective bit widths 
  wire signed[10:0]       lut_out;
  wire[10:0]              pc_in,
                          pc_out;	    // program counter
  wire[8:0]               inst;         // output of IF, instruction
  
                                        // === control wires ===
  wire                    pc_src,	    // input for muxpc
                          alu_src,		// select signal for 1:2 mux before ALU in_b
                          reg_write,	// signal for write enable for register file
                          mem_read,
                          mem_write,	// signal for write enable of data mem
                          alu_zero,
                          jmp;

  wire[1:0]               wb_src;		// writeback source for 2:4 mux 
  wire[2:0]               alu_op;	    // signal for ALU operation
                                                        
                                        // === data mem ===		
  wire[7:0]               dm_out,		// output of data memory, input to 2:4 mux
                          dm_in,		// input data for data mem 
                          dm_adr;		// address to read or write of data mem
                                                        
                                        // === ALU ===
  wire[7:0]               in_b,			// second input for ALU, comes from 1:2 mux
                          alu_out,      // alu output          
                                        // === register file ===
                          do_a,	        // reg file output, goes to in_a
                          do_b,			// reg file output, used as first input to 1:2 mux
                          reg_prime_out;
  wire[7:0]               rf_din;	    // reg file input data to be written
                                        // === mux outputs === 
  wire[7:0]               wb_res,	    // writeback
                          get_res;		// get res
 
  // Module wire/bus connections

  mux_2to1 #(11) mux_pc(				// mux for PC
        .A(pc_out + 11'd1),
        .B(lut_out),
        .sel(pc_src),
        .out(pc_in)
  );
  
  mux_2to1 mux_alusrc(					// mux for alu source
        .A(do_b),						// dataout b
        .B(inst[7:0]),					// contains shift amount (last 2 bits)
        .sel(alu_src),
        .out(in_b)
  );
  
  mux_2to4 mux_wb(						// mux for writeback
        .A(alu_out),					// output of ALU
        .B(get_res),					// output of 3:8 mux get func
        .C(dm_out),						// output of data mem
        .D(8'd0),						// not used
        .sel (wb_src),
        .out (wb_res)
  );
  
  mux_3to8 mux_get(						// mux for get func
        .sel (inst[2:0]),
        .out (get_res)
  );
                        
  pc prog_counter(						// program counter
        .clk (clk),
        .reset,
        .req,
        .pc_in,
        .pc_out,
        .halt
  );					     

  imem inst_mem(					    // instruction memory
        .PC(pc_out),				    // pointer in = PC
         .inst				     		// output = 7-bit (yours is 9) machine code
  );

  control ctr(
        .inst,							// instruction
        .reg_in(reg_prime_out),
        .pc_src,
        .alu_src,
        .wb_src,
        .reg_write,
        .mem_read,
        .mem_write,
        .jmp,
        .alu_op
  );

  reg_file rf(						 	// === register file ===
        .clk,
        .alu_zero,
        .write_en(reg_write),		 	// write enable
        .raddrA(inst[5:3]),				// read pointers 
        .raddrB(inst[2:0]),				// write/read pointer
        .waddr(inst[5:3]),				// write address
        .data_in(wb_res),			 	// data to be written in
        .data_outA(do_a),				// output going to first input of ALU
        .data_outB(do_b),				// output going to first input of 1:2 mux	 
        .reg_prime_out
  );

  alu ALU(						 		// === ALU unit ====
        .op (alu_op),					// ALU operation from control unit
        .in_a(do_a),					// alu input from register file
        .in_b,		          		    // alu input from 1:2 mux
        .rslt(alu_out),			 		// alu output, used as input for 2:4 mux
        .alu_zero
    );		

  dmem dm1(						 		// === data memory ===
        .clk,
        .mem_write,						// only time to write = store
        .mem_read,
        .addr(do_b),				 	// from LUT
        .di  (do_a),				 	// data to store (from reg_file)
        .dout(dm_out)				 	// data out (for loads)
  );				 											

  lut_pc lut(				     		// maps 2 bits to 8
        .index(inst[5:0]),
        .jmp,
        .out(lut_out)	                // branch distance in PC
  );
  
endmodule