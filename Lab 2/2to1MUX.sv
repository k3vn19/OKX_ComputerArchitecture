// 2 to 1 MUX

module mux_2to1(
	output [15:0] Y;  
   input  [15:0] A, B;   
	input  [1:0] sel;     
	reg    [15:0] Y; 	
	);
   always @(A or B or sel)        
		if (sel == 1'b0)         
			Y = A;      
		else         
			Y = B;  

endmodule