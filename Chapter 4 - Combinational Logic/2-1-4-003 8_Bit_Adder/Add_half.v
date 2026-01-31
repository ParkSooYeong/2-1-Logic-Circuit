module Add_half (input a, b, output c_out, sum);
	xor G1(sum, a, b); // Gate instance names are opional
	and G2(c_out, a, b);
endmodule
