// CSE141L Winter 2018  
// in class demo -- instruction memory ROM
// This is the case statement (if ... else if ... else if ...) version;
//   good for small lookup tables and arrays, awkward for larger ones, perhaps
module imem #(parameter A=11, W=9) (
  input       [A-1:0] PC,
  output logic[W-1:0] inst);
  
  logic[W-1:0] inst_rom[2**(A)];
  
  always_comb inst = inst_rom[PC];
 
  initial begin
  	$readmemb("machine_code.txt",inst_rom);
  end 
  
endmodule
