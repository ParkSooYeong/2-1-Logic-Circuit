`timescale 1ns / 1ps
// Testbench for Circuit_A

module Circuit_A_tb;

    // Inputs (reg type)
    reg A, B, C, D;

    // Output (wire type)
    wire F;

    // Instantiate the Unit Under Test (UUT)
    Circuit_A UUT (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .F(F)
    );

    // Test stimulus
    initial begin
        // Initialize inputs
        A = 0; B = 0; C = 0; D = 0;

        // Apply all input combinations (4-bit counter)
        #10 A = 0; B = 0; C = 0; D = 1;
        #10 A = 0; B = 0; C = 1; D = 0;
        #10 A = 0; B = 0; C = 1; D = 1;

        #10 A = 0; B = 1; C = 0; D = 0;
        #10 A = 0; B = 1; C = 0; D = 1;
        #10 A = 0; B = 1; C = 1; D = 0;
        #10 A = 0; B = 1; C = 1; D = 1;

        #10 A = 1; B = 0; C = 0; D = 0;
        #10 A = 1; B = 0; C = 0; D = 1;
        #10 A = 1; B = 0; C = 1; D = 0;
        #10 A = 1; B = 0; C = 1; D = 1;

        #10 A = 1; B = 1; C = 0; D = 0;
        #10 A = 1; B = 1; C = 0; D = 1;
        #10 A = 1; B = 1; C = 1; D = 0;
        #10 A = 1; B = 1; C = 1; D = 1;

        // End simulation
        #10 $finish;
    end

endmodule
