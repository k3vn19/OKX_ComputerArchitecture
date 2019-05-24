// 2 to 1 MUX

module mux_2to1(
	output [7:0] Y,  
   input  [7:0] A, B,   
	input  [1:0] sel	
	);
   always @(A or B or sel)        
		if (sel == 1'b0)         
			Y = A;      
		else         
			Y = B;  
endmodule