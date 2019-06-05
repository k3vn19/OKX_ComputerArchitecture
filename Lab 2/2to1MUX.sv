// 2 to 1 MUX

module mux_2to1 #(parameter W=8)(
   input  [W-1:0] A, B,   
	input  sel,
	output logic [W-1:0] out);
   always @(A or B or sel)        
		if (sel == 1'b0)         
			out <= A;      
		else         
			out <= B;  
endmodule