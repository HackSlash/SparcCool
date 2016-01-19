// vim:set shiftwidth=3 softtabstop=3 expandtab:
module register_file (rsel, wsel, rdata, wdata, wen, rst, clk);
	input [5:0] rsel, wsel;
	output [32:0] rdata;
	input [32:0] wdata;
	input wen, rst, clk;
	
	register zero(.wen(wen), .rst(rst), .clk(clk));
	register at(.wen(wen), .rst(rst), .clk(clk));
	register v0(.wen(wen), .rst(rst), .clk(clk));
	register v1(.wen(wen), .rst(rst), .clk(clk));
	register a0(.wen(wen), .rst(rst), .clk(clk));
	register a1(.wen(wen), .rst(rst), .clk(clk));
	register a2(.wen(wen), .rst(rst), .clk(clk));
	register a3(.wen(wen), .rst(rst), .clk(clk));
	register t0(.wen(wen), .rst(rst), .clk(clk));
	register t1(.wen(wen), .rst(rst), .clk(clk));
	register t2(.wen(wen), .rst(rst), .clk(clk));
	register t3(.wen(wen), .rst(rst), .clk(clk));
	register t4(.wen(wen), .rst(rst), .clk(clk));
	register t5(.wen(wen), .rst(rst), .clk(clk));
	register t6(.wen(wen), .rst(rst), .clk(clk));
	register t7(.wen(wen), .rst(rst), .clk(clk));
	register s0(.wen(wen), .rst(rst), .clk(clk));
	register s1(.wen(wen), .rst(rst), .clk(clk));
	register s2(.wen(wen), .rst(rst), .clk(clk));
	register s3(.wen(wen), .rst(rst), .clk(clk));
	register s4(.wen(wen), .rst(rst), .clk(clk));
	register s5(.wen(wen), .rst(rst), .clk(clk));
	register s6(.wen(wen), .rst(rst), .clk(clk));
	register s7(.wen(wen), .rst(rst), .clk(clk));
	register t8(.wen(wen), .rst(rst), .clk(clk));
	register t9(.wen(wen), .rst(rst), .clk(clk));
	register k0(.wen(wen), .rst(rst), .clk(clk));
	register k1(.wen(wen), .rst(rst), .clk(clk));
	register gp(.wen(wen), .rst(rst), .clk(clk));
	register sp(.wen(wen), .rst(rst), .clk(clk));
	register fp(.wen(wen), .rst(rst), .clk(clk));
	register ra(.wen(wen), .rst(rst), .clk(clk));
	
	assign zero.in = 0;
	
	always @(posedge clk) begin
		if(wen) begin
			case(wsel)
				0:		zero.in	=		wdata;
				1:		at.in		=		wdata;
				2:		v0.in		=		wdata;
				3:		v1.in		=		wdata;
				4:		a0.in		=		wdata;
				5:		a1.in		=		wdata;
				6:		a2.in		=		wdata;
				7:		a3.in		=		wdata;
				8:		t0.in		=		wdata;
				9:		t1.in		=		wdata;
				10:	t2.in		=		wdata;
				11:	t3.in		=		wdata;
				12:	t4.in		=		wdata;
				13:	t5.in		=		wdata;
				14:	t6.in		=		wdata;
				15:	t7.in		=		wdata;
				16:	s0.in		=		wdata;
				17:	s1.in		=		wdata;
				18:	s2.in		=		wdata;
				19:	s3.in		=		wdata;
				20:	s4.in		=		wdata;
				21:	s5.in		=		wdata;
				22:	s6.in		=		wdata;
				23:	s7.in		=		wdata;
				24:	t8.in		=		wdata;
				25:	t9.in		=		wdata;
				26:	k0.in		=		wdata;
				27:	k1.in		=		wdata;
				28:	gp.in		=		wdata;
				29:	sp.in		=		wdata;
				30:	fp.in		=		wdata;
				31:	ra.in		=		wdata;
			endcase
		end else begin
			case(rsel)
				0:		rdata		=		zero.out;
				1:		rdata		=		at.out;
				2:		rdata		=		v0.out;
				3:		rdata		=		v1.out;
				4:		rdata		=		a0.out;
				5:		rdata		=		a1.out;
				6:		rdata		=		a2.out;
				7:		rdata		=		a3.out;
				8:		rdata		=		t0.out;
				9:		rdata		=		t1.out;
				10:	rdata		=		t2.out;
				11:	rdata		=		t3.out;
				12:	rdata		=		t4.out;
				13:	rdata		=		t5.out;
				14:	rdata		=		t6.out;
				15:	rdata		=		t7.out;
				16:	rdata		=		s0.out;
				17:	rdata		=		s1.out;
				18:	rdata		=		s2.out;
				19:	rdata		=		s3.out;
				20:	rdata		=		s4.out;
				21:	rdata		=		s5.out;
				22:	rdata		=		s6.out;
				23:	rdata		=		s7.out;
				24:	rdata		=		t8.out;
				25:	rdata		=		t9.out;
				26:	rdata		=		k0.out;
				27:	rdata		=		k1.out;
				28:	rdata		=		gp.out;
				29:	rdata		=		sp.out;
				30:	rdata		=		fp.out;
				31:	rdata		=		ra.out;
			endcase
		end
	end
endmodule 