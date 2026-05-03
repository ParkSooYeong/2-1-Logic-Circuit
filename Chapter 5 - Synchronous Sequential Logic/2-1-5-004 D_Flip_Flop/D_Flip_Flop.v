module D_Flip_Flop (Q, D, clk);
	input D, clk;
	output Q;
	reg Q;
	
	always @ (posedge clk)
		Q <= D;
endmodule
