# OKX Architecture 
## Introduction
In designing our architecture we first began by identifying exactly what instructions were going to be needed to run programs one through three. Once identified, we created a preliminary ISA by referencing the MIPS ISA and choosing to keep only the instructions we needed and modifying them to our liking. Examples of modifications include the 9 bit instruction length as opposed to 32 and the order of source and target registers being consist, unlike how MIPS flips the location of rt and rs in load and store instructions. We chose to base our architecture after MIPS as all members of our team have had experience with MIPS and we found a load-store architecture to be most fitting for the tasks we are trying to accomplish. In particular the specific goals we strived for were to create an architecture whose operations focus on bit manipulation in the most effective manner between registers and in which memory is only accessed through load and store operations on words. These goals follow directly from our philosophy for simplicity and familiarity with already existing architectures such that a new user could quickly adapt to our architecture. This philosophy and our goals for the architecture led us to a load-store architecture we will call OKX (read as “ox” and derived from our initials).

## Supported Instructions

| Instruction | Op Code | Reg 1            | Reg2/Imm | Instruction Type |
|-------------|---------|------------------|----------|------------------|
| ld          | 000     | src              | target   | R                |
| st          | 001     | src              |   target | R                |
| xor         | 010     | src1/destination | src2     | R                |
| add         | 011     | src1/dest        | src2     | R                |
| get         | 110     | src              | imm      | I                |

| Instruction | Op Code | Reg 1 | Direction         | Immediate      | Inst type |
|-------------|---------|-------|-------------------|----------------|-----------|
| shft      | 111     | src   | direction (1 bit) | shamt (2 bits) | I         |

| Instruction | Op Code | Reg 1 | Immediate      | Inst type |
|-------------|---------|-------|----------------|-----------|
| shft      | 111     | src   |  LUT index (6 bits) | I         |

As an example for the R type consider wanting to add XOR two bits. Assuming that the first bit is in register r0, the second bit is in the register r1 and the result is to be stored into register r0 the instruction would be “add r0 r1”. Then to convert to machine instructions reference the table below for the opcode of ADD, which is 011. The instruction would thus be 011000001.
As an example for the I type consider loading a word whose address is stored in r0 and is to be loaded into r1. The instruction would be “ld r0 r1” which would have the machine instruction of 000000100.

Below is the lookup table for the "get" instruction. In hardware it is implemented as a 3 to 8 mux with 
values hardcoded to the wires. These are simply the various constant values
that are used throughout the three programs. 

| get imm | Value |
|------|---------|
| 000 | 0   | 
| 001 | 1 | 
| 010 | 30  | 
| 011 | 124  | 
| 100 | 4  | 
| 101 |  3 | 
| 110 | 128  | 
| 111 |  32 | 

## Branch Support
Our machine only supports direct memory addressing. The two instructions for branching
are jnz and jz (jump not zero and jump zero). The way these instructions work are as follows.
If you want to use jnz and want the condition to be in r5, for example, all that
is required is to do the computation of the condition and put it into r5 and immediately after 
call "jnz [imm]" where [imm] is a decimal number that serves as an index in the PC lut 
and if the branch is taken then it will branch to the PC specified at index [imm] in the look up table.
 

## Usage
Our assembly code for programs 1 through 3 can be found either in Lab1/assembly or Lab3/src. The compiler
for the assembly is in Lab3.java. To compile the code all that must be done is put the assembly code in Lab3/src (as it already is)
and run Lab3.java. The output will be in machineX.txt and machineX_comments.txt. The second file
is for the sake of debugging while machineX.txt is the actual machine code used in the testbench.

For grading, the source code will already be compiled. 

## What Works
All three of the programs can be run contiuously and produce the correct output. When using the test bench provided on TED running prog123_tb.sv produces all the correct output and additionally during our demo the tutor tested three of his own test cases and the programs produced the correct output. 
