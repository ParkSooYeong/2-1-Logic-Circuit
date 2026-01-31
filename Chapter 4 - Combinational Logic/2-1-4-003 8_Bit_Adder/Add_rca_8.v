module Add_rca_8 (input [7:0] a, b, input c_in, output c_out, output [7:0] sum);
	wire c_in4;
	Add_rca_4 M0 (a[3:0], b[3:0], c_in, c_in4, sum[3:0]);
	Add_rca_4 M1 (a[7:4], b[7:4], c_in4, c_out, sum[7:4]);
endmodule
