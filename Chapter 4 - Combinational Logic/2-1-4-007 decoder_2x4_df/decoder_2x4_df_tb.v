`timescale 1ns/1ps

module decoder_2x4_df_tb;

    // Testbench signals
    reg A, B, enable;
    wire [0:3] D;

    // DUT (Device Under Test) instantiation
    decoder_2x4_df uut (
        .A(A),
        .B(B),
        .enable(enable),
        .D(D)
    );

    // Test procedure
    initial begin
        $display("A B enable | D[0] D[1] D[2] D[3]");
        $display("-----------------------------------");

        // enable = 0
        enable = 0;

        A = 0; B = 0; #10;
        $display("%b %b   %b   |  %b    %b    %b    %b",
                 A, B, enable, D[0], D[1], D[2], D[3]);

        A = 0; B = 1; #10;
        $display("%b %b   %b   |  %b    %b    %b    %b",
                 A, B, enable, D[0], D[1], D[2], D[3]);

        A = 1; B = 0; #10;
        $display("%b %b   %b   |  %b    %b    %b    %b",
                 A, B, enable, D[0], D[1], D[2], D[3]);

        A = 1; B = 1; #10;
        $display("%b %b   %b   |  %b    %b    %b    %b",
                 A, B, enable, D[0], D[1], D[2], D[3]);

        // enable = 1
        enable = 1;

        A = 0; B = 0; #10;
        $display("%b %b   %b   |  %b    %b    %b    %b",
                 A, B, enable, D[0], D[1], D[2], D[3]);

        A = 0; B = 1; #10;
        $display("%b %b   %b   |  %b    %b    %b    %b",
                 A, B, enable, D[0], D[1], D[2], D[3]);

        A = 1; B = 0; #10;
        $display("%b %b   %b   |  %b    %b    %b    %b",
                 A, B, enable, D[0], D[1], D[2], D[3]);

        A = 1; B = 1; #10;
        $display("%b %b   %b   |  %b    %b    %b    %b",
                 A, B, enable, D[0], D[1], D[2], D[3]);

        $finish;
    end

endmodule
