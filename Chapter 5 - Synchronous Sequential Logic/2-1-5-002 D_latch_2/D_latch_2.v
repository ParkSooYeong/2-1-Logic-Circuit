module D_latch_2 (input enable, D, output reg Q);
	always @ (enable, D)
		if (enable) Q <= D;
endmodule
