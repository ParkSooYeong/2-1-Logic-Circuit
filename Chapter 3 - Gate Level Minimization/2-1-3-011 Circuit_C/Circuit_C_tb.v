// Testbench for Circuit_C
`timescale 1ns / 1ps

module Circuit_C_tb;

	// Inputs
	reg a;
	reg b;

	// Outputs
	wire y1;
	wire y2;
	wire y3;

	// Instantiate the Unit Under Test (UUT)
	Circuit_C UUT (
		.y1(y1),
		.y2(y2),
		.y3(y3),
		.a(a),
		.b(b)
	);

	// Stimulus process
	initial begin
		// Initial values
		a = 0; b = 0;
		#20;

		a = 0; b = 1;
		#20;

		a = 1; b = 0;
		#20;

		a = 1; b = 1;
		#20;

		// End simulation
		$finish;
	end

endmodule
