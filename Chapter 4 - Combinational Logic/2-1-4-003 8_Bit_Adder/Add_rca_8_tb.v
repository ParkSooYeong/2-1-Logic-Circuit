`timescale 1ns / 1ps

// Testbench for 8-bit Ripple Carry Adder
module Add_rca_8_tb;

    // Testbench signals
    reg  [7:0] a;
    reg  [7:0] b;
    reg        c_in;
    wire [7:0] sum;
    wire       c_out;

    // Instantiate the DUT (Device Under Test)
    Add_rca_8 DUT (
        .a(a),
        .b(b),
        .c_in(c_in),
        .c_out(c_out),
        .sum(sum)
    );

    // Stimulus process
    initial begin
        // Initialize inputs
        a = 8'b00000000;
        b = 8'b00000000;
        c_in = 1'b0;
        #10;

        // Test case 1: 0 + 0
        a = 8'd0;
        b = 8'd0;
        c_in = 1'b0;
        #10;

        // Test case 2: 5 + 3
        a = 8'd5;
        b = 8'd3;
        c_in = 1'b0;
        #10;

        // Test case 3: 15 + 1
        a = 8'd15;
        b = 8'd1;
        c_in = 1'b0;
        #10;

        // Test case 4: 127 + 1 (carry propagation)
        a = 8'd127;
        b = 8'd1;
        c_in = 1'b0;
        #10;

        // Test case 5: 255 + 1 (overflow)
        a = 8'd255;
        b = 8'd1;
        c_in = 1'b0;
        #10;

        // Test case 6: Random values
        a = 8'd85;
        b = 8'd170;
        c_in = 1'b0;
        #10;

        // Test case 7: Carry-in enabled
        a = 8'd100;
        b = 8'd50;
        c_in = 1'b1;
        #10;

        // End simulation
        $stop;
    end

endmodule
