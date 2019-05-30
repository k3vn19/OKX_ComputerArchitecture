// 2 to 4 MUX

module mux_2to4(
   input  [7:0] A, B, C, D,
	input	 [1:0] sel,
	output [7:0] out);
   
	always @(A or B or C or D or sel)        
		if (sel == 2'b00)
			out = A;
		else if(sel == 2'b01)        
			out = B;
		else if(sel == 2'b10)
			out = C;
		else
			out = D;

endmodule