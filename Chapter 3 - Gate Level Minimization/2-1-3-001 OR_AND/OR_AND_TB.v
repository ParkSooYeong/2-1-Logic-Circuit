`timescale 1ns/1ps

module OR_AND_TB;

    // Testbench signals (reg → input, wire → output)
    reg A;
    reg B;
    reg C;
    wire E;

    // DUT (Device Under Test) instantiation
    or_and dut (
        .A(A),
        .B(B),
        .C(C),
        .E(E)
    );

    // Test stimulus
    initial begin
        // Print
        $monitor("Time=%0t | A=%b B=%b C=%b | E=%b", $time, A, B, C, E);

        // Index
        A = 0; B = 0; C = 0;
        #10;

        A = 0; B = 1; C = 0;
        #10;

        A = 1; B = 0; C = 0;
        #10;

        A = 1; B = 1; C = 0;
        #10;

        A = 0; B = 0; C = 1;
        #10;

        A = 0; B = 1; C = 1;
        #10;

        A = 1; B = 0; C = 1;
        #10;

        A = 1; B = 1; C = 1;
        #10;

        // Simulation End
        $finish;
    end

endmodule
