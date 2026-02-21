// Dataflow description of a four-bit comparator
// V2001, 2005, SV syntax

module mag_compare(input [3:0] A, B, output A_lt_B, A_eq_B, A_gt_B);
	assign A_lt_B = (A < B); // Continuous assignment statements
	assign A_gt_B = (A > B);
	assign A_eq_B = (A == B);
endmodule
