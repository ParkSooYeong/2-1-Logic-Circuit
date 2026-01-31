module Add_rca_4 (input [3:0] a, b, input c_in, output c_out, output [3:0] sum);
	wire c_in1, c_in2, c_in3, c_in4; // Intermediate carries
	Add_full M0 (a[0], b[0], c_in, c_in1, sum[0]);
	Add_full M1 (a[1], b[1], c_in1, c_in2, sum[1]);
	Add_full M2 (a[2], b[2], c_in2, c_in3, sum[2]);
	Add_full M3 (a[3], b[3], c_in3, c_in4, sum[3]);
endmodule
