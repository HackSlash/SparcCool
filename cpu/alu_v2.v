module alu(out,a,b,sel)			// 64 bit integer ALU
input[64:0]a,b;					// 64 bit input registers
input[3:0]sel;					// 4 bit instruction register
output[64:0]out;				// 64 bit output register
reg[64:0]out;
always @(sel) begin 			// only execute with command
	case(sel)
		4'b0000:	out=a+b;	// 4'b0000 = addition			(64bit)
		4'b0001:	out=a-b;	// 4'b0001 = subtraction		(64bit)
		4'b0010:	out=a*b;		// 4'b0010 = multiplication 	(64bit)
		4'b0011:	out=a/b;	// 4'b0011 = division			(64bit)
		4'b0100:	out=a%b;	// 4'b0100 = modulo				(64bit)
		4'b0101:	out=a&&b;	// 4'b0101 = logical and		(64bit)
		4'b0110:	out=a||b;	// 4'b0110 = logical or			(64bit)
		4'b0111:	out=!a;		// 4'b0111 = logical negation	(64bit)
		4'b1000:	out=~a;		// 4'b1000 = bitwise negation	(64bit)
		4'b1001:	out=a&b;	// 4'b1001 = bitwise and 		(64bit)
		4'b1010:	out=a|b;	// 4'b1010 = bitwise or			(64bit)
		4'b1011:	out=a^b;	// 4'b1011 = bitwise xor		(64bit)
		4'b1100:	out=a<<b;	// 4'b1100 = left shit			(64bit)
		4'b1101:	out=a>>b;	// 4'b1101 = right shift		(64bit)
		4'b1110:	out=a+1;	// 4'b1110 = increment			(64bit)
		4'b1111:	out=a-1;	// 4'b1111 = decrement			(64bit)
	endcase
end
endmodule