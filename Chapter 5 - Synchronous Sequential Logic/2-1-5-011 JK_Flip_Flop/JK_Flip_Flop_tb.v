`timescale 1ns/1ps

module JK_Flip_Flop_tb;

    reg J;
    reg K;
    reg clk;
    reg rst;

    wire Q;

    // DUT
    JK_Flip_Flop uut (
        .J(J),
        .K(K),
        .clk(clk),
        .rst(rst),
        .Q(Q)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin

        // Initial state
        J = 0;
        K = 0;
        rst = 1;

        #10;
        rst = 0;

        // Hold (00)
        J = 0;
        K = 0;
        #20;

        // Reset (01)
        J = 0;
        K = 1;
        #20;

        // Set (10)
        J = 1;
        K = 0;
        #20;

        // Toggle (11)
        J = 1;
        K = 1;
        #40;

        // Hold again
        J = 0;
        K = 0;
        #20;

        // Reset again
        J = 0;
        K = 1;
        #20;

        // Set again
        J = 1;
        K = 0;
        #20;

        $stop;
    end

endmodule
