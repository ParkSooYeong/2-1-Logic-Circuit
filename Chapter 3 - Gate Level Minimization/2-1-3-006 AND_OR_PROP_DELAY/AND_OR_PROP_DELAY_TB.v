// AND_OR_PROP_DELAY Test Bench

`timescale 1ns / 1ps

module AND_OR_PROP_DELAY_TB;
	wire D, E;
	reg A, B, C;
	
	AND_OR_PROP_DELAY M_UUT (A, B, C, D, E); // 인스턴스 이름(M_UUT)이 필요함
	
	initial begin
		A = 1'b0; B = 1'b0; C = 1'b0;
		#100 A = 1'b1; B = 1'b1; C = 1'b1;
	end
	
	initial #200 $finish;
endmodule
