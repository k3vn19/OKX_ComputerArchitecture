// 3 to 8 MUX
//Used for get function

module mux_3to8(
  	input[2:0] sel,     
	output logic [7:0] out);
	  
	always_comb begin
		casez(sel)
			3'b000: begin
				out <= 8'd0;
			end
			3'b001: begin
				out <= 8'd1;
			end
			3'b010: begin
				out <= 8'd30;
			end
			3'b011: begin
				out <= 8'd124;
			end
			3'b100: begin
				out <= 8'd4;
			end
			3'b101: begin
				out <= 8'd3;
			end
			3'b110: begin
				out <= 8'd128;
			end
			3'b111: begin
				out <= 8'd32;
			end
		endcase
	end
		  
endmodule