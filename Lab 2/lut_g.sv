// lookup table for get instruction
// lets us access values to help with computing addresses
module lut_g(
  input [2:0] ptr,
  output logic[7:0] dm_adr);

always_comb case (ptr)
  3'b000: dm_adr = 0;
  3'b001: dm_adr = 1;
  3'b010: dm_adr = 200;
  3'b011: dm_adr = 204;
  3'b100: dm_adr = 4;
  3'b101: dm_adr = 3;
  3'b110: dm_adr = 128;
  3'b111: dm_adr = 32;  
  default: dm_adr = 255;
endcase

endmodule