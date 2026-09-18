`timescale 1ns/100ps

module testcounter_tb;

    reg t_count;
    reg t_load;
    reg t_clk;
    reg t_clr;
    reg [3:0] t_in;

    wire t_C0;
    wire [3:0] t_A;

    // DUT
    testcounter cnt (
        .count(t_count),
        .load(t_load),
        .Data_in(t_in),
        .clk(t_clk),
        .clr(t_clr),
        .A_count(t_A),
        .C_out(t_C0)
    );

    // Clock Generation
    // Clock Period = 10 ns
    initial begin
        t_clk = 1'b0;
        forever #5 t_clk = ~t_clk;
    end

    // Stimulus
    initial begin

        // Initial values
        t_count = 1'b0;
        t_load  = 1'b0;
        t_in    = 4'b0000;
        t_clr   = 1'b1;

        // Asynchronous Clear
        #2;
        t_clr = 1'b0;

        #3;
        t_clr = 1'b1;

        // Enable counting
        #5;
        t_count = 1'b1;

        // Count for 40 ns
        #40;

        // Parallel Load
        t_count = 1'b0;
        t_load  = 1'b1;
        t_in    = 4'b1001;

        #10;

        // Count from 1001
        t_load  = 1'b0;
        t_count = 1'b1;

        #30;

        // Hold
        t_count = 1'b0;

        #10;

        // Test asynchronous clear
        t_clr = 1'b0;

        #5;

        t_clr = 1'b1;

        // Count again
        t_count = 1'b1;

        #10;

        $finish;

    end

endmodule
