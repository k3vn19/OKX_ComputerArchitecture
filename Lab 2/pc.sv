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
      halt <= 1;
    end
    else if (req) begin
      pc_out <= pc_in;
      halt <= 0;
    end
    else if (pc_in>1000) halt <= 1;
    else if (pc_in == 349) halt <= 1; // prog 1
    else if (pc_in == 350) halt <= 1; // prog 2
    else if (pc_in == 500) halt <= 1; // prog 3
    else
      pc_out <= pc_in;
  end
endmodule