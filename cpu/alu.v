module int_alu(out,a,b,instr,c);				// 64 bit integer ALU
	input[64:0]a,b;							// 64 bit input registers
	input[32:0]instr;							// 32 bit instruction register
	output[64:0]out;							// 64 bit output register
	reg[64:0]out;
	
	//reg[32:0]reg0 = 32'b0;
	//reg[32:0]reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14,reg15,reg16,reg17,reg18,reg19,reg20,reg21,reg22,reg23,reg24,reg25,reg26,reg27,reg28,reg29,reg30,reg31,reg32;
	
	
	input c;										// clock
	always @(posedge c) begin				// Only execute on clock signal
		case(instr)
			'b100000:			out = a+b; //add
			'b100001:			out = a+b; //addu
			'b001000:			out = a+b; //addi TODO: integer literal
			'b001001:			out = a+b; //addiu TODO: integer literal
			'b100100:			out = a&&b; //and
			'b001100:			out = a&&b; //andi TODO: integer literal
			'b011010:			out = a/b; //div TODO: remainder
			'b011011:			out = a/b; //divu TODO: remainder
			'b011000:			out = a*b; //mult TODO: overflow
			'b011001:			out = a*b; //multu TODO: overflow
			'b100111:			out = !(a||b); //nor
			'b100101:			out = a||b; //or
			'b001101:			out = a||b; //ori TODO: integer literal
			'b000000:			out = a<<b; //sll TODO: literal
			'b000100:			out = a<<b; //sllv TODO: register
			'b000011:			out = a>>b; //sra TODO: literal
			'b000111:			out = a>>b;	//srav TODO: register
			'b000010:			out = a>>b; //srl TODO: literal; difference from sra?
			'b000110:			out = a>>b; //srlv TODO: register; difference from srav?
			'b100010:			out = a-b; //sub
			'b100011: 			out = a-b; //subu
			'b100110:			out = a^b; //xor
			'b001110:			out = a^b; //xori TODO: ZE(i)
		endcase
	end
endmodule
