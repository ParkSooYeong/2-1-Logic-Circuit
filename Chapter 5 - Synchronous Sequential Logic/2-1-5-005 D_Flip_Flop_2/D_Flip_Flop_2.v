module D_Flip_Flop_2 (input D, clk, rst, output reg Q);
	always @ (posedge clk, negedge rst)
		if (!rst) Q <= 1'b0; // = if (rst == 0)
		else Q <= D;
endmodule
