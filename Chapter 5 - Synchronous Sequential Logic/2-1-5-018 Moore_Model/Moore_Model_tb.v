`timescale 1ns / 1ps

module Moore_Model_tb;

	reg x_in;
	reg clock;
	reg reset;
	wire [1:0] y_out;

	// DUT Instantiation
	Moore_Model UUT (
		.x_in(x_in),
		.clock(clock),
		.reset(reset),
		.y_out(y_out)
	);

	// Clock Generation (10 ns period)
	initial begin
		clock = 0;
		forever #5 clock = ~clock;
	end

	// Stimulus
	initial begin
		// Initialize
		x_in = 1'b0;
		reset = 1'b0;

		// Reset pulse
		#2  reset = 1'b1;

		// State transition test
		#10 x_in = 1'b0;
		#20 x_in = 1'b1;
		#20 x_in = 1'b0;
		#20 x_in = 1'b1;
		#20 x_in = 1'b0;
		#20 x_in = 1'b1;
		#20 x_in = 1'b0;

		// Reset test
		#20 reset = 1'b0;
		#2  reset = 1'b1;

		// Additional transitions
		#20 x_in = 1'b1;
		#20 x_in = 1'b0;
		#20 x_in = 1'b1;

		#24 $finish;
	end

endmodule
