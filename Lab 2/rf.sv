// CSE141L Win 2018  in-class demo
// 4-element reg_file (yours will have up to 16 elements)
module reg_file #(parameter W=8, D=3)(
  input           clk,
                  write_en,
  input  [ D-1:0] raddrA,
                  raddrB,
						waddr,
  input  [ W-1:0] data_in,
  output [ W-1:0] data_outA,
  output [ W-1:0] data_outB,
  output [ W-1:0] reg_prime_out
    );

// W bits wide [W-1:0] and 2**4 registers deep
logic [W-1:0] registers[2**D+1];	  // or just registers[16] if we know D=4 always

// combinational reads w/ blanking of address 0
assign data_outA = registers[raddrA];// : '0;	 // can't read from addr 0, just like MIPS
assign data_outB = registers[raddrB];
assign reg_prime_out = registers[2**D];

// sequential (clocked) writes	(likewise, can't write to addr 0)
always_ff @ (posedge clk)
  if (write_en)	// protected constant
	 registers[waddr] <= data_in;

endmodule
