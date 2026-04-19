`timescale 1ns/1ps

module D_latch_2_tb;

    // Declare stimulus signals
    reg t_enable, t_D;

    // Declare response signal
    wire t_Q;

    // Instantiate Unit Under Test (UUT)
    D_latch_2 UUT (
        .enable(t_enable),
        .D(t_D),
        .Q(t_Q)
    );

    // Dump waveform (optional)
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, D_latch_2_tb);
    end

    // Stimulus process
    initial begin
        // Initial values
        t_enable = 0;
        t_D = 0;

        // Case 1: Enable = 1 → Q follows D
        #10 t_enable = 1; t_D = 0;
        #10 t_D = 1;
        #10 t_D = 0;

        // Case 2: Enable = 0 → Q holds value
        #10 t_enable = 0;
        #10 t_D = 1; // Q should NOT change
        #10 t_D = 0; // Q should NOT change

        // Case 3: Enable = 1 again → Q updates
        #10 t_enable = 1;
        #10 t_D = 1;

        // Finish simulation
        #20 $finish;
    end

    // Monitor signals
    initial begin
        $monitor("time=%0t | enable=%b D=%b | Q=%b",
                  $time, t_enable, t_D, t_Q);
    end

endmodule
