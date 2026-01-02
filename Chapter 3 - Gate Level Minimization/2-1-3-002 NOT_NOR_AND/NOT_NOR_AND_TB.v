`timescale 1ns/1ps

module NOT_NOR_AND_TB;

    reg A;
    reg B;
    reg C;
    wire Y;

    // DUT instantiation
    NOT_NOR_AND dut (
        .A(A),
        .B(B),
        .C(C),
        .Y(Y)
    );

    initial begin
        // Index
        A = 0; B = 0; C = 0;
        #10;

        A = 0; B = 0; C = 1;
        #10;

        A = 0; B = 1; C = 0;
        #10;

        A = 0; B = 1; C = 1;
        #10;

        A = 1; B = 0; C = 0;
        #10;

        A = 1; B = 0; C = 1;
        #10;

        A = 1; B = 1; C = 0;
        #10;

        A = 1; B = 1; C = 1;
        #10;

        $finish;
    end

endmodule

