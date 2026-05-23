module JK_Flip_Flop_2 (input J, K, clk, output reg Q, output Q_b);
	assign Q_b = ~Q;
	always @ (posedge clk)
		case ({J, K})
			2'b00 : Q <= Q;
			2'b01 : Q <= 1'b0;
			2'b10 : Q <= 1'b1;
			2'b11 : Q <= !Q;
		endcase
endmodule
