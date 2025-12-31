module or_and
(
	input A, B, C,
	output E
);

	wire D;

	assign D = A || B; // || = OR
	assign E = C && D; // && = AND
	
	// = One Line
	/*
		= Multi Line
	*/
endmodule
