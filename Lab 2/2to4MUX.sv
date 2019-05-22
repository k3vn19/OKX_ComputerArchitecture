// 2 to 4 MUX

module mux_2to4(
	output [7:0] Y,  
   input  [7:0] A, B, C ,D,   
	input	 [1:0]  sel     
	);
   always @(A or B or C or D or sel)        
		if (sel == 2'b00)         
			Y = A;      
		else if(sel == 2'b01)        
			Y = B;
		else if(sel == 2'b10)
			Y = C;
		else
			Y = D;

endmodule