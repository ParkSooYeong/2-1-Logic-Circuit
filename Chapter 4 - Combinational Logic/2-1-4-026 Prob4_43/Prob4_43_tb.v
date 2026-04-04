`timescale 1ns/1ps

module Prob4_43_tb;

    // Declare stimulus signals
    reg [1:0] t_A, t_B;
    reg t_S, t_E;

    // Declare response signal
    wire [1:0] t_Q;

    // Instantiate Unit Under Test (UUT)
    Prob4_43 UUT (
        .A(t_A),
        .B(t_B),
        .S(t_S),
        .E(t_E),
        .Q(t_Q)
    );

    // Generate waveform dump
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, Prob4_43_tb);
    end

    // Apply stimulus
    initial begin
        // Initialize inputs
        t_A = 2'b00;
        t_B = 2'b11;
        t_S = 0;
        t_E = 0;

        // Case 1: Enable = 0 → Output should be Z
        #10 t_E = 0; t_S = 0;
        #10 t_E = 0; t_S = 1;

        // Case 2: Enable = 1, select B
        #10 t_E = 1; t_S = 0;

        // Change inputs
        #10 t_A = 2'b10; t_B = 2'b01;

        // Case 3: Enable = 1, select A
        #10 t_S = 1;

        // Case 4: Disable again → Z
        #10 t_E = 0;

        // Finish simulation
        #20 $finish;
    end

    // Monitor signals (including high-impedance state)
    initial begin
        $monitor("time=%0t | E=%b S=%b | A=%b B=%b | Q=%b",
                  $time, t_E, t_S, t_A, t_B, t_Q);
    end

endmodule
