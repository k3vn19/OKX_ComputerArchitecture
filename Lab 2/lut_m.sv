// CSE141L Winter 2018 in class demo
// lookup table for data memory addressing

module lut_m(
  input [2:0] ptr,
  output logic[7:0] dm_adr);

always_comb case (ptr)		//values stored in data mem 200-205
  3'b000: dm_adr = 8'b11001000;	      //30
  3'b001: dm_adr = 8'b11001001;			//31
  3'b010: dm_adr = 8'b11001010;			//64
  3'b011: dm_adr = 8'b11001011;			//65
  3'b100: dm_adr = 8'b11001100;			//124
  3'b101: dm_adr = 8'b11001101;			//16
  default: dm_adr = 8'b11111111;			//255
endcase

endmodule