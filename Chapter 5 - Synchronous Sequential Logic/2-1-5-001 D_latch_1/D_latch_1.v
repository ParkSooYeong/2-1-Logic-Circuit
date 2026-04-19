module D_latch_1 (Q, D, enable);
	input D, enable;
	output Q;
	reg Q;
	
	always @ (enable, D)
		if (enable) Q <= D; // if (enable == 1)
endmodule
