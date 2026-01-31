module Add_full (input a, b, c_in, output c_out, sum);
	wire w1, w2, w3; // w1 is c_out; w2 is sum
	Add_half M1 (a, b, w1, w2);
	Add_half M0 (w2, c_in, w3, sum);
	or (c_out, w1, w3);
endmodule
