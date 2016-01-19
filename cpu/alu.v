// vim:set shiftwidth=3 softtabstop=3 expandtab:
//`include "register.v"

module int_alu(out,a,b,instr,c);								// 32 bit integer ALU
	input[32:0]a,b;												// 32 bit input registers
	input[32:0]instr;												// 32 bit instruction register
	output[32:0]out;												// 32 bit output register
	reg[32:0]out;	
	inout register_file r;												// register file
	input c;															// clock
	
	function read;													// read from register file
		input[5:0] reg_addr;
		begin
			r.rsel=reg_addr;
			read=r.out;
		end
	endfunction
	
	function write;												// write to register file
		input[5:0] reg_addr;
		input[32:0] data;
		begin
			r.wsel=reg_addr;
			r.wen=1;
			r.wdata=data;
			write=1;
		end
	endfunction

	always @(posedge c) begin									// Only execute on clock signal
		case(instr)
			'b100000:			write(out,(read(a)+read(b))); 	//add
			'b100001:			r[out] = r[a]	+	r[b]; 	//addu
			'b001000:			r[out] = r[a]	+	b; 		//addi
			'b001001:			r[out] = r[a]	+	b; 		//addiu
			'b100100:			r[out] = r[a]	&&	r[b]; 	//and
			'b001100:			r[out] = r[a]	&&	b; 		//andi
			'b011010:			r[out] = r[a]	/	r[b]; 	//div TODO: remainder
			'b011011:			r[out] = r[a]	/	r[b]; 	//divu TODO: remainder
			'b011000:			r[out] = r[a]	*	r[b]; 	//mult TODO: overflow
			'b011001:			r[out] =	r[a]	*	r[b]; 	//multu TODO: overflow
			'b100111:			r[out] = !(r[a]||	r[b]); 	//nor
			'b100101:			r[out] = r[a]	||	r[b]; 	//or
			'b001101:			r[out] = r[a]	||	b; 		//ori
			'b000000:			r[out] = r[a]	<<	b; 		//sll
			'b000100:			r[out] = r[a]	<<	r[b]; 	//sllv
			'b000011:			r[out] = r[a]	>>	b; 		//sra
			'b000111:			r[out] = r[a]	>>	r[b];		//srav
			'b000010:			r[out] = r[a]	>>	b; 		//srl TODO: difference from sra?
			'b000110:			r[out] = r[a]	>>	r[b];		//srlv TODO: difference from srav?
			'b100010:			r[out] = r[a]	-	r[b]; 	//sub
			'b100011: 			r[out] = r[a]	-	r[b]; 	//subu
			'b100110:			r[out] = r[a]	^	r[b]; 	//xor
			'b001110:			r[out] = r[a]	^	b; 		//xori TODO: ZE(b)
		endcase
	end
endmodule
