module NOT_NOR_AND
(
	input A, B, C,
	output Y
);

	wire D;
	
	assign D = !(!A || B); // ! = NOT
	assign Y = C && D; // Y = (!((!A)||B)) && C
	
endmodule
