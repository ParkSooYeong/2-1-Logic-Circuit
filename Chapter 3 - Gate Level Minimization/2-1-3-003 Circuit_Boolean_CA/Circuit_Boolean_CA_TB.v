`timescale 1ns/1ps

module Circuit_Boolean_CA_TB;

    reg A, B, C, D;
    wire E, F;

    // DUT (Device Under Test)
    Circuit_Boolean_CA dut (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .E(E),
        .F(F)
    );

    initial begin
        // Index
        A = 0; B = 0; C = 0; D = 0;
        #10;

        // All Input Combination Test (16)
        A=0; B=0; C=0; D=1; #10;
        A=0; B=0; C=1; D=0; #10;
        A=0; B=0; C=1; D=1; #10;

        A=0; B=1; C=0; D=0; #10;
        A=0; B=1; C=0; D=1; #10;
        A=0; B=1; C=1; D=0; #10;
        A=0; B=1; C=1; D=1; #10;

        A=1; B=0; C=0; D=0; #10;
        A=1; B=0; C=0; D=1; #10;
        A=1; B=0; C=1; D=0; #10;
        A=1; B=0; C=1; D=1; #10;

        A=1; B=1; C=0; D=0; #10;
        A=1; B=1; C=0; D=1; #10;
        A=1; B=1; C=1; D=0; #10;
        A=1; B=1; C=1; D=1; #10;

        #10;
        $stop;
    end

endmodule
