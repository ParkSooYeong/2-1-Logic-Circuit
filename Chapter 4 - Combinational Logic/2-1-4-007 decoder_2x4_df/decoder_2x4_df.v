// Dataflow description of two-to-four-line decoder
// The figure uses symbol E, but the
// Verilog model uses enable to clearly indicate functionality.

module decoder_2x4_df( // Verilog 2001, 2005 syntax
	input A, B, enable,
	output[0:3] D
);

	assign D[0] = !((!A) && (!B) && (!enable)),
		D[1] = !((!A) && B && (!enable)),
		D[2] = ((A) && (!B) && (!enable)),
		D[3] = !(A && B && (!enable));
endmodule
