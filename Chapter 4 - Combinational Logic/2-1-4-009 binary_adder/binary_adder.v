// Dataflow description of four-bit adder
// Verilog 2001, 2005 module port syntax

module binary_adder(
	input [3:0] A, B,
	input C_in,
	output [3:0] sum,
	output C_out
);

	assign {sum, C_out} = A + B + C_in; // Continuous assignment statement

endmodule
