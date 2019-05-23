module Control(
  input [8:0] 			inst,
  output logic      jnz,
							jz,
			        MemRead,
  output logic[1:0]  MemtoReg,
			        MemWrite,
			        ALUSrc,
			        RegWrite,
  output logic[2:0] ALUOp
);

always_comb begin
//RegDist   = 0;
jnz      = 0;
jz			= 0;
//Branch    = 0;
MemRead   = 1;
MemtoReg  = 0;
MemWrite  = 0;
ALUSrc    = 0;
RegWrite  = 1;
ALUOp     = 0;
casez(inst)
  9'b000??????: begin	//load
	MemtoReg = 2'b10;
  end
  9'b001??????: begin	 // store
	MemWrite = 1;
	RegWrite = 0;
	MemRead = 0;
  end
  9'b010??????: begin	//XOR
	ALUOp = 3'b011;
  end
  9'b100??????: begin	//JZ
   jz = 1;
	RegWrite = 0;
  end
  9'b101??????: begin		//Jnz
   jnz = 1;
	RegWrite = 0;
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