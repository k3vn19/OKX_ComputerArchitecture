module control(
  input [8:0]         inst,
  input [7:0]			    reg_in,                     // special register for ALU result
  output logic        pc_src,
			                alu_src, 
                      reg_write,
							        mem_read,
                      mem_write,  
							        jmp,
  output logic[1:0]   wb_src,
  output logic[2:0]   alu_op
);

  always_comb begin
    // set default values, and then update as needed in the case statement below
    alu_src = 0;
    reg_write = 1;
    mem_read = 0;
    mem_write = 0;
    jmp = 0;
    wb_src = 0;
    alu_op = 0;

    casez(inst)
      9'b000??????: begin	//load
		  mem_read = 1;
      wb_src = 2'b10;
      end
      9'b001??????: begin	// store
      mem_write = 1;
		  reg_write = 0;
      end
      9'b010??????: begin	//XOR
      alu_op = 3'b011;
      end
      9'b100??????: begin	//JZ
      if (reg_in != 0) jmp = 1;
      reg_write = 0;
      end
      9'b101??????: begin		//Jnz
      if (reg_in == 0) jmp = 1;
      reg_write = 0;
      end
      9'b110??????: begin		//get
      wb_src = 2'b01;
      end
      9'b111???1??: begin		//right shft
      alu_src = 1;
      alu_op = 3'b010;
      end
      9'b111???0??: begin		//left shft
      alu_src = 1;
      alu_op = 3'b001;
      end
      9'b011??????: begin	//ADD
      alu_op = 3'b000;
      end
    endcase // end of casez

    pc_src = jmp;
  
  end // end of always block

endmodule