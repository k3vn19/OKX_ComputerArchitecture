module Control(
  input [5:0] Instr_i,
  output logic      RegDist,
                    Jnz,
							Jz,
			        MemRead,
			        MemtoReg,
			        MemWrite,
			        ALUSrc,
			        Regwrite,
  output logic[2:0] ALUOp
);

always_comb begin
RegDist   = 0;
Jnz      = 0;
Jz			= 0;
//Branch    = 0;
MemRead   = 1;
MemtoReg  = 0;
MemWrite  = 0;
ALUSrc    = 0;
Regwrite  = 1;
ALUOp     = 0;
casez(Instr_i)
  6'b000000: begin	//load
	MemtoReg = 1;
  end
  6'b000001: begin	 // store
	MemWrite = 1;
  end
  6'b0000: begin
   
  end
endcase



end


endmodule