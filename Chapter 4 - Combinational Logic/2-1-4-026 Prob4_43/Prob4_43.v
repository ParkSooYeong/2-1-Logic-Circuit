module Prob4_43 (A, B, S, E, Q);
	input [1:0] A, B;
	input S, E;
	output [1:0] Q;
	assign Q = E ? (S ? A : B) : 'bz;
endmodule
