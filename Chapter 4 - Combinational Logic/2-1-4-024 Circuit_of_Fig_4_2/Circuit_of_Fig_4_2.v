// Gate-level description of circuit of Fig.4.2
module Circuit_of_Fig_4_2 (A, B, C, F1, F2);
	input A, B, C;
	output F1, F2;
	wire T1, T2, T3, F2_b, E1, E2, E3;
	or G1 (T1, A, B, C);
	and G2 (T2, A, B, C);
	and G3 (E1, A, B);
	and G4 (E2, A, C);
	and G5 (E3, B, C);
	or G6 (F2, E1, E2, E3);
	not G7 (F2_b, F2);
	and G8 (T3, T1, F2_b);
	or G9 (F1, T2, T3);
endmodule

// Stimulus to analyze the circuit

module test_circuit;
	reg [2:0] D;
	wire F1, F2;
	Circuit_of_Fig_4_2 UUT (D[2], D[1], D[0], F1, F2); // Instantiate UUT
	initial
		begin // Apply stimulus
			D = 3'b000;
			repeat (7) #10 D = D + 1'b1;
		end
	initial $monitor ("ABC = %b F1 = %b F2 = %b", D, F1, F2); // Observe response
endmodule

Simulation log:
ABC = 000 F1 = 0 F2 = 0
ABC = 001 F1 = 1 F2 = 0
ABC = 010 F1 = 1 F2 = 0
ABC = 011 F1 = 0 F2 = 1
ABC = 100 F1 = 1 F2 = 0
ABC = 101 F1 = 0 F2 = 1
ABC = 110 F1 = 0 F2 = 1
ABC = 111 F1 = 1 F2 = 1
