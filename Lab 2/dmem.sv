module dmem(
  input      clk,					    // for writes only
				 mem_read,
             mem_write,				// write enable
  //Control wire Read Mem     // TODO - is this needed?
  input[7:0] addr,					  // address pointer for read or write
  input[7:0] di,					    // data value to be written	to data memory
  output logic[7:0] dout		  // data read out of memory
);

  logic[7:0] core[256];				// the 2-D memory array itself
  always_ff @(posedge clk) if (mem_write)	// clocked writes, only if we=1
    core[addr] <= di;

  always_comb						// unclocked (continuous) reads
    dout = core[addr];

endmodule