module Control(
  input [5:0] Instr_i,
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
  6'b000000: begin	//load
	MemtoReg = 2'b10;
  end
  6'b000001: begin	 // store
	MemWrite = 1;
	RegWrite = 0;
	MemRead = 0;
  end
  6'b000010: begin	//XOR
	ALUOp = 3'b011;
  end
  6'b000011: begin	//JZ
   Jz = 1;
	RegWrite = 0;
  end
  6'b000100: begin		//Jnz
   Jnz = 1;
	RegWrite = 0;
  end
  6'b000101: begin		//get
	MemtoReg = 2'b01;
  end
  6'b000110: begin		//right shft
	ALUSrc = 1;
	ALUOp = 3'b010;
  end
  6'b000111: begin		//left shft
	ALUSrc = 1;
	ALUOp = 3'b001;
  end
  6'b001000: begin	//ADD
	ALUOp = 3'b000;
  end

endcase



end


endmodule
