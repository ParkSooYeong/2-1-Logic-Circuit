// Testbench for decoder_2x4_gates
// Verifies 2x4 decoder operation with enable signal

`timescale 1ns / 1ps

module decoder_2x4_gates_tb;

	// Testbench signals
	reg A;
	reg B;
	reg enable;
	wire [0:3] D;

	// Instantiate the Unit Under Test (UUT)
	decoder_2x4_gates UUT (
		.D(D),
		.A(A),
		.B(B),
		.enable(enable)
	);

	initial begin
		// Initialize inputs
		A = 0;
		B = 0;
		enable = 0;

		// Monitor signals
		$monitor("Time=%0t | enable=%b A=%b B=%b | D=%b",
		         $time, enable, A, B, D);

		// Test with enable = 0 (all outputs should be inactive)
		#10 A = 0; B = 0;
		#10 A = 0; B = 1;
		#10 A = 1; B = 0;
		#10 A = 1; B = 1;

		// Enable decoder
		#10 enable = 1;

		// Test all input combinations
		#10 A = 0; B = 0;
		#10 A = 0; B = 1;
		#10 A = 1; B = 0;
		#10 A = 1; B = 1;

		// Disable again
		#10 enable = 0;

		#20 $finish;
	end

endmodule
