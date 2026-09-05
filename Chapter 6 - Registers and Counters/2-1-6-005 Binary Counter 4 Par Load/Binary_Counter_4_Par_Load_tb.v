`timescale 1ns / 1ps

module Binary_Counter_4_Par_Load_tb;

    reg Count;
    reg Load;
    reg clk;
    reg clr;
    reg [3:0] Data_in;

    wire C_out;
    wire [3:0] A_count;

    // DUT
    Binary_Counter_4_Par_Load DUT (
        .Count(Count),
        .Load(Load),
        .clk(clk),
        .clr(clr),
        .Data_in(Data_in),
        .C_out(C_out),
        .A_count(A_count)
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
        Count   = 1'b0;
        Load    = 1'b0;
        clr     = 1'b0;
        Data_in = 4'b0000;

        // Asynchronous Clear
        #5;
        clr = 1'b1;

        // Parallel Load: 1010
        #5;
        Load    = 1'b1;
        Data_in = 4'b1010;

        #10;

        // Hold
        Load  = 1'b0;
        Count = 1'b0;

        #10;

        // Count: 1010 -> 1011
        Count = 1'b1;

        #10;

        // Count: 1011 -> 1100
        #10;

        // Count: 1100 -> 1101
        #10;

        // Stop counting and Hold
        Count = 1'b0;

        #10;

        // Parallel Load: 1110
        Load    = 1'b1;
        Data_in = 4'b1110;

        #10;

        // Count: 1110 -> 1111
        Load  = 1'b0;
        Count = 1'b1;

        #10;

        // A_count = 1111
        // C_out should be 1 while Count=1 and Load=0
        #5;

        // Count: 1111 -> 0000
        #5;

        // Hold after overflow
        Count = 1'b0;

        #10;

        // Test Load priority over Count
        Load    = 1'b1;
        Count   = 1'b1;
        Data_in = 4'b0101;

        #10;

        // Hold
        Load  = 1'b0;
        Count = 1'b0;

        #10;

        // Asynchronous Clear test
        clr = 1'b0;

        #5;

        clr = 1'b1;

        #5;

        // Final Count operation
        Count = 1'b1;

        #10;

        $finish;
    end

endmodule
