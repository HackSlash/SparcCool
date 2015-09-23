module alu(a,b,add,sub,mult,div,out)
input wire add, sub, mult, div;
input reg [31:0] a;
input reg [31:0] b;
output reg [31:0] out;

initial begin
	a = 0;
	b = 0;
	out = 0;
	add = 0;
	sub = 0;
	mult = 0;
	div = 0;
end

always @ (add)
begin
	out <= a + b;
end
always @ (sub)
begin
	out <= a - b;
end
always @ (mult)
begin
	out <= a * b;
end
always @ (div)
begin
	out <= a / b;
end
endmodule