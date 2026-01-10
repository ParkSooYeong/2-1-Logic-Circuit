`timescale 1ns / 1ps			// 시간 단위 / 시간의 정밀도

module AND_OR_PROP_DELAY
(
	input A, B, C,
	output D, E
);

	wire w1;
	
	//	and G1 #30 (w1, A, B);	// 지연 시간 : 30ns
	//	not G2 #10 (E, C);		// 지연 시간 : 10ns
	//	or G3  #20 (D, w1, E);	// 지연 시간 : 20ns
	
	assign w1 = A & B;
	assign E  = ~C;
	assign D  = w1 | E;
endmodule
