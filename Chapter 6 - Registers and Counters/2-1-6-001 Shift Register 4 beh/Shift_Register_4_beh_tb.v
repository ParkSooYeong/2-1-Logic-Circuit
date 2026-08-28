`timescale 1ns / 1ps

module Shift_Register_4_beh_tb;

    reg s0;
    reg s1;
    reg MSB_in;
    reg LSB_in;
    reg clk;
    reg Clear_b;
    reg [3:0] I_par;

    wire [3:0] A_par;

    // DUT
    Shift_Register_4_beh DUT (
        .s0(s0),
        .s1(s1),
        .MSB_in(MSB_in),
        .LSB_in(LSB_in),
        .clk(clk),
        .Clear_b(Clear_b),
        .I_par(I_par),
        .A_par(A_par)
    );

    // Clock Generation
    // Clock Period = 10 ns
    initial
    begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial
    begin

        // Initial values
        s0     = 1'b0;
        s1     = 1'b0;
        MSB_in = 1'b0;
        LSB_in = 1'b0;
        I_par  = 4'b0000;
        Clear_b = 1'b0;

        // Asynchronous Clear
        #5;
        Clear_b = 1'b1;

        // Parallel Load: A_par = 1010
        #5;
        s0 = 1'b1;
        s1 = 1'b1;
        I_par = 4'b1010;

        // Hold
        #10;
        s0 = 1'b0;
        s1 = 1'b0;

        // Shift Right
        // 1010 -> 0101 when MSB_in = 0
        #10;
        s0 = 1'b0;
        s1 = 1'b1;
        MSB_in = 1'b0;

        // Shift Right
        // 0101 -> 1010 when MSB_in = 1
        #10;
        MSB_in = 1'b1;

        // Parallel Load: A_par = 1100
        #10;
        s0 = 1'b1;
        s1 = 1'b1;
        I_par = 4'b1100;

        // Shift Left
        // 1100 -> 1001 when LSB_in = 1
        #10;
        s0 = 1'b1;
        s1 = 1'b0;
        LSB_in = 1'b1;

        // Shift Left
        // 1001 -> 0010 when LSB_in = 0
        #10;
        LSB_in = 1'b0;

        // Hold
        #10;
        s0 = 1'b0;
        s1 = 1'b0;

        // Asynchronous Clear
        #5;
        Clear_b = 1'b0;

        #5;
        Clear_b = 1'b1;

        // Additional Parallel Load
        #10;
        s0 = 1'b1;
        s1 = 1'b1;
        I_par = 4'b0110;

        // End simulation before 160 ns
        #5;
        $finish;

    end

endmodule
