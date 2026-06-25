`timescale 1ns / 1ps

module Prob5_30_tb;

    reg A;
    reg B;
    reg C;
    reg clk;

    wire E;
    wire Q;

    // DUT
    Prob5_30 DUT (
        .A(A),
        .B(B),
        .C(C),
        .clk(clk),
        .E(E),
        .Q(Q)
    );

    // Clock Generation
    // Clock Period = 10 ns
    initial
    begin
        clk = 1'b0;

        while ($time < 160)
        begin
            #5 clk = ~clk;
        end
    end

    // Stimulus
    initial
    begin
        A = 1'b0;
        B = 1'b0;
        C = 1'b0;

        #12;
        A = 1'b1;
        B = 1'b0;
        C = 1'b1;

        #20;
        A = 1'b0;
        B = 1'b1;
        C = 1'b1;

        #20;
        A = 1'b0;
        B = 1'b0;
        C = 1'b1;

        #20;
        A = 1'b1;
        B = 1'b1;
        C = 1'b0;

        #20;
        A = 1'b1;
        B = 1'b0;
        C = 1'b1;

        #20;
        A = 1'b0;
        B = 1'b0;
        C = 0;

        #30;

        $stop;
    end

endmodule
