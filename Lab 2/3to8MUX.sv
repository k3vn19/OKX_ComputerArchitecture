// 3 to 8 MUX

module decoder_3to8(
	  input[2:0] sel,     
	  output[15:0] out     
	  );
	  
	  casez(sel)
		3'b000: begin
			return 16'd0;
		end
	   3'b001: begin
			return 16'd1;
		end
		3'b010: begin
			return 16'd200;
		end
		3'b011: begin
			return 16'd204;
		end
		3'b100: begin
			return 16'd4;
		end
		3'b101: begin
			return 16'd3;
		end
		3'b110: begin
			return 16'd128;
		end
		default: begin
			return 16'd32;
		end
		
	  
	  endmodule