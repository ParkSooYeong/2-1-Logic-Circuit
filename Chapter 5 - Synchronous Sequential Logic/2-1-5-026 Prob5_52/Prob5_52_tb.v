`timescale 1ns/1ps

module Prob5_52_tb;

    reg x_in;
    reg clk;
    reg reset_b;

    wire y_out;

    Prob5_52 DUT (
        .x_in(x_in),
        .clk(clk),
        .reset_b(reset_b),
        .y_out(y_out)
    );

    // 10 ns clock
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Input stimulus
    initial begin
        x_in    = 1'b0;
        reset_b = 1'b0;

        // Reset
        #10 reset_b = 1'b1;

        // 10 ~ 60 ns
        #10 x_in = 1'b1;
        #10 x_in = 1'b1;
        #10 x_in = 1'b0;
        #10 x_in = 1'b0;
        #10 x_in = 1'b1;

        // 60 ~ 110 ns
        #10 x_in = 1'b1;
        #10 x_in = 1'b0;
        #10 x_in = 1'b0;
        #10 x_in = 1'b1;
        #10 x_in = 1'b1;

        // 110 ~ 150 ns
        #10 x_in = 1'b1;
        #10 x_in = 1'b0;
        #10 x_in = 1'b1;
        #10 x_in = 1'b0;

        // Test asynchronous active-low reset
        #5 reset_b = 1'b0;
        #5 reset_b = 1'b1;

        // Stop exactly at 160 ns
        #10 $finish;
    end

endmodule
