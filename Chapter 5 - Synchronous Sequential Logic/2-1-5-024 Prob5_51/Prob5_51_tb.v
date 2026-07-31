`timescale 1ns/1ps

module Prob5_51_tb;

    reg x_in;
    reg clk;
    reg reset;

    wire y_out;

    // DUT
    Prob5_51 DUT (
        .x_in(x_in),
        .clk(clk),
        .reset(reset),
        .y_out(y_out)
    );

    // Clock Generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin

        reset = 0;
        x_in  = 0;

        #8;
        reset = 1;

        #10 x_in = 1;
        #20 x_in = 0;
        #20 x_in = 1;
        #10 x_in = 0;
        #10 x_in = 1;
        #20 x_in = 0;
        #20 x_in = 1;
        #20 x_in = 0;

        #20;
        reset = 0;

        #10;
        reset = 1;

        #20 x_in = 1;
        #20 x_in = 0;
        #20 x_in = 1;

        #40;
        $finish;
    end

endmodule
