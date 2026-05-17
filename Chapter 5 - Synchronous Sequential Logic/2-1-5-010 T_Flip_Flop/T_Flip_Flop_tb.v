`timescale 1ns/1ps

module T_Flip_Flop_tb;

    reg T;
    reg clk;
    reg rst;

    wire Q;

    // DUT
    T_Flip_Flop uut (
        .T(T),
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

        // Initial values
        T = 0;
        rst = 1;

        #10;
        rst = 0;

        // T = 0 -> Hold
        T = 0;
        #20;

        // T = 1 -> Toggle
        T = 1;
        #40;

        // T = 0 -> Hold
        T = 0;
        #20;

        // T = 1 -> Toggle again
        T = 1;
        #40;

        // Reset test
        rst = 1;
        #10;

        rst = 0;
        T = 1;
        #20;

        $stop;
    end

endmodule
