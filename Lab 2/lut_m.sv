// CSE141L Winter 2018 in class demo
// lookup table for data memory addressing
// lets us access dm_adr pointer values 3, 4, and 5
//   (could be ANY desired others, including 64, 65, 128, etc.)
//   using only a 2-bit selector
module lut_m(
  input [2:0] ptr,
  output logic[7:0] dm_adr);

always_comb case (ptr)		//values stored in data mem 200-205
  3'b000: dm_adr = 200;	      //30
  3'b001: dm_adr = 201;			//31
  3'b010: dm_adr = 202;			//64
  3'b011: dm_adr = 203;			//65
  3'b100: dm_adr = 204;			//124
  3'b101: dm_adr = 205;			//16
  default: dm_adr = 255;
endcase

endmodule