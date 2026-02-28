module decoder_2x4_df_beh( // Verilog 2001, 2005 syntax
	input A, B, enable,
	output reg [0:3] D
);

	always @(*) begin
		D[0] <= !((!A) && (!B) && (!enable));
		D[1] <= !((!A) && B && (!enable));
		D[2] <= !(A && (!B) && (!enable));
		D[3] <= !(A && B && (!enable));
	end
endmodule
