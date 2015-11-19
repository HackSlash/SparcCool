module alu(out,a,b,instr,c);				// 64 bit integer ALU
	input[64:0]a,b;							// 64 bit input registers
	input[32:0]instr;							// 32 bit instruction register
	output[64:0]out;							// 64 bit output register
	reg[64:0]out;
	
	reg[32:0]reg0 = 32'b0;
	reg[32:0]reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14,reg15,reg16,reg17,reg18,reg19,reg20,reg21,reg22,reg23,reg24,reg25,reg26,reg27,reg28,reg29,reg30,reg31,reg32;
	
	
	input c;										// clock
	always @(posedge c) begin				// Only execute with command
		case(instr)
			32:					out <= a+b;
			// 8'b00000000:	out<=a+b;		// addition					(64bit)
			// 8'b00000001:	out<=a-b;		// subtraction				(64bit)
			// 8'b00000010:	out<=a*b;		// multiplication 		(64bit)
			// 8'b00000011:	out<=a/b;		// division					(64bit)
			// 8'b00000100:	out<=a%b;		// modulo					(64bit)
			// 8'b00000101:	out<=a&&b;		// logical and				(64bit)
			// 8'b00000110:	out<=a||b;		// logical or				(64bit)
			// 8'b00000111:	out<=!a;			// logical negation		(64bit)
			// 8'b00001000:	out<=~a;			// bitwise negation		(64bit)
			// 8'b00001001:	out<=a&b;		// bitwise and 			(64bit)
			// 8'b00001010:	out<=a|b;		// bitwise or				(64bit)
			// 8'b00001011:	out<=a^b;		// bitwise xor				(64bit)
			// 8'b00001100:	out<=a<<b;		// left shit				(64bit)
			// 8'b00001101:	out<=a>>b;		// right shift				(64bit)
			// 8'b00001110:	out<=a+1;		// increment				(64bit)
			// 8'b00001111:	out<=a-1;		// decrement				(64bit)
			// 8'b10000000:	;					// noop						(64bit)
		endcase
	end
endmodule

module core(out1,out2,a1,a2,b1,b2,instr1,instr2,c);
	output[64:0] out1, out2;
	input[64:0] a1,a2,b1,b2;
	input[8:0] instr1, instr2;
	input c;
	alu alu1(.out(out1), .a(a1), .b(b1), .instr(instr1), .c(c));
	alu alu2(.out(out2), .a(a2), .b(b2), .instr(instr2), .c(c));
endmodule

module SparCool(output clock);				// Top module
	core core1(.c(clock));						// First "core", passing clock to c
	core core2(.c(clock));						// Second "core"
	core core3(.c(clock));						// Third core
	core core4(.c(clock));						// Fourth core
	assign clock=~clock;							// No clock delay
endmodule