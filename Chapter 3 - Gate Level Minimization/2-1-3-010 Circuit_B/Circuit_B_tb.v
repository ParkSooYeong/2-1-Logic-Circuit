// Testbench for Circuit_B
// Applies all input combinations to verify combinational logic behavior

`timescale 1ns / 1ps

module Circuit_B_tb;

    // Testbench signals
    reg A0, A1, B0, B1;
    wire F1, F2, F3;

    // Instantiate the Device Under Test (DUT)
    Circuit_B DUT (
        .F1(F1),
        .F2(F2),
        .F3(F3),
        .A0(A0),
        .A1(A1),
        .B0(B0),
        .B1(B1)
    );

    // Stimulus process
    initial begin
        // Initialize inputs
        A0 = 0; A1 = 0; B0 = 0; B1 = 0;

        // Apply all input combinations
        #10 A0 = 0; A1 = 0; B0 = 0; B1 = 1;
        #10 A0 = 0; A1 = 0; B0 = 1; B1 = 0;
        #10 A0 = 0; A1 = 0; B0 = 1; B1 = 1;

        #10 A0 = 0; A1 = 1; B0 = 0; B1 = 0;
        #10 A0 = 0; A1 = 1; B0 = 0; B1 = 1;
        #10 A0 = 0; A1 = 1; B0 = 1; B1 = 0;
        #10 A0 = 0; A1 = 1; B0 = 1; B1 = 1;

        #10 A0 = 1; A1 = 0; B0 = 0; B1 = 0;
        #10 A0 = 1; A1 = 0; B0 = 0; B1 = 1;
        #10 A0 = 1; A1 = 0; B0 = 1; B1 = 0;
        #10 A0 = 1; A1 = 0; B0 = 1; B1 = 1;

        #10 A0 = 1; A1 = 1; B0 = 0; B1 = 0;
        #10 A0 = 1; A1 = 1; B0 = 0; B1 = 1;
        #10 A0 = 1; A1 = 1; B0 = 1; B1 = 0;
        #10 A0 = 1; A1 = 1; B0 = 1; B1 = 1;

        // End simulation
        #10 $finish;
    end

endmodule
