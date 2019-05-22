// 2 to 4 MUX

module mux_2to4(Y, A,B,C,D, sel);
	output [15:0] Y;  
   input  [15:0] A, B, C ,D;   
	input  sel;     
	reg    [15:0] Y; 	
	
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