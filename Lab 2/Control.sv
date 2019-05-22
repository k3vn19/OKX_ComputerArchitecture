module Control(
  input [8:0] Instr_i,
  output logic      Jnz,
							Jz,
			        MemRead,
  output logic[1:0]  MemtoReg,
			        MemWrite,
			        ALUSrc,
			        Regwrite,
  output logic[2:0] ALUOp
);

always_comb begin
//RegDist   = 0;
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
  9'b000??????: begin	//load
	MemtoReg = 2'b10;
  end
  9'b001??????: begin	 // store
	MemWrite = 1;
	Regwrite = 0;
	MemRead = 0;
  end
  9'b010??????: begin	//XOR
	ALUOp = 3'b011;
  end
  9'b100??????: begin	//JZ
   Jz = 1;
	Regwrite = 0;
  end
  9'b101??????: begin		//Jnz
   Jnz = 1;
	Regwrite = 0;
  end
  9'b110??????: begin		//get
	MemtoReg = 2'b01;
  end
  9'b111???1??: begin		//right shft
	ALUSrc = 1;
	ALUOp = 3'b010;
  end
  9'b111???0??: begin		//left shft
	ALUSrc = 1;
	ALUOp = 3'b001;
  end
  9'b011??????: begin	//ADD
	ALUOp = 3'b000;
  end

endcase



end


endmodule