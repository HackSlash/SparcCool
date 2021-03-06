// vim:set shiftwidth=3 softtabstop=3 expandtab:
/**
 * MIPS
 * basic (static) branch prediction: don't expect jumps. Possible later upgrade to saturating counter.
 * pipeline
 * OoO?
 */

`define BYTESIZE 8
`define WORDSIZE 4
`define BITNESS 32

//`include "alu.v"

module fpu(); //floating point optimised alu
endmodule

module instr_cache(); // cache instructions
endmodule

module instr_fetch(pc,ram,instr);
	/**
	 * Load instruction and throw into pipeline
	*/
	inout pc;
	input [64000:0]ram; // fake RAM
	output instr;
	assign instr = ram[pc];
	assign pc = pc+4;
endmodule

module core(out1,out2,a1,a2,b1,b2,instr1,instr2,c);
	output[64:0] out1, out2;
	input[64:0] a1,a2,b1,b2;
	input[8:0] instr1, instr2;
	input c;
	int_alu alu1(.out(out1), .a(a1), .b(b1), .instr(instr1), .c(c));
	int_alu alu2(.out(out2), .a(a2), .b(b2), .instr(instr2), .c(c));
endmodule

module SparCool(inout clock);										// Top module
	instr_fetch IF(.pc(program_counter), .ram(memory));	// main IF
	
	core core1(.c(clock));											// First "core", passing clock to c
	core core2(.c(clock));											// Second "core"
	core core3(.c(clock));											// Third core
	core core4(.c(clock));											// Fourth core
	assign clock=~clock;												// No clock delay
endmodule