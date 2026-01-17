`timescale 1ns/1ps

// Testbench for Circuit_with_UDP_02467
module Circuit_with_UDP_02467_tb;

    // Input signals (driven by testbench)
    reg a;
    reg b;
    reg c;
    reg d;

    // Output signals (observed by testbench)
    wire e;
    wire f;

    // Instantiate the Design Under Test (DUT)
    Circuit_with_UDP_02467 dut (
        .e(e),
        .f(f),
        .a(a),
        .b(b),
        .c(c),
        .d(d)
    );

    // Stimulus generation
    initial begin
        // Initialize all inputs
        a = 0; b = 0; c = 0; d = 0;

        // Apply all possible input combinations
        #10 a=0; b=0; c=0; d=0;
        #10 a=0; b=0; c=0; d=1;

        #10 a=0; b=0; c=1; d=0;
        #10 a=0; b=0; c=1; d=1;

        #10 a=0; b=1; c=0; d=0;
        #10 a=0; b=1; c=0; d=1;

        #10 a=0; b=1; c=1; d=0;
        #10 a=0; b=1; c=1; d=1;

        #10 a=1; b=0; c=0; d=0;
        #10 a=1; b=0; c=0; d=1;

        #10 a=1; b=0; c=1; d=0;
        #10 a=1; b=0; c=1; d=1;

        #10 a=1; b=1; c=0; d=0;
        #10 a=1; b=1; c=0; d=1;

        #10 a=1; b=1; c=1; d=0;
        #10 a=1; b=1; c=1; d=1;

        // Stop simulation
        #20 $stop;
    end

endmodule
