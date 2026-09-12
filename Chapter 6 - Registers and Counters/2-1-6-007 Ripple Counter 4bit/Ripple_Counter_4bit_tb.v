`timescale 1ns/100ps

module Ripple_Counter_4bit_tb;

    reg count;
    reg reset;

    wire A0;
    wire A1;
    wire A2;
    wire A3;

    // DUT
    Ripple_Counter_4bit DUT (
        .A0(A0),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .count(count),
        .reset(reset)
    );

    // Count Clock Generation
    // Clock Period = 10 ns
    initial
    begin
        count = 1'b0;

        forever #5 count = ~count;
    end

    // Stimulus
    initial
    begin
        // Initial values
        reset = 1'b0;

        // Asynchronous Reset
        #2;
        reset = 1'b1;

        #3;
        reset = 1'b0;

        // Count operation
        #120;

        // Reset during counting
        reset = 1'b1;

        #3;
        reset = 1'b0;

        // Count again
        #30;

        // End simulation
        $finish;
    end

endmodule
