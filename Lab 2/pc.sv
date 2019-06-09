module pc (
  input               clk,	        		// clk -- PC advances and memory/reg_file writes are clocked 
  input               reset,		    	// overrides all else, forces PC to 0 (start of program)
  input[10:0]			    pc_in,
  input               req,
  output logic        halt,
  output logic [10:0] pc_out);			// program count

  always_ff @(posedge clk) begin
    if (reset) begin
      pc_out <= 'b0;
    end
    else if (pc_in>1000) halt <= 1;
    else if (pc_in == 348) halt <= 1;
    else
      pc_out <= pc_in;
  end
endmodule