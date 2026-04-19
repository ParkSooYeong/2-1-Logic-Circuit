`timescale 1ns/1ps

module D_latch_1_tb;

    // Declare stimulus signals
    reg t_D, t_enable;

    // Declare response signal
    wire t_Q;

    // Instantiate Unit Under Test (UUT)
    D_latch_1 UUT (
        .Q(t_Q),
        .D(t_D),
        .enable(t_enable)
    );

    // Generate waveform dump
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, D_latch_1_tb);
    end

    // Apply stimulus
    initial begin
        // Initial state
        t_D = 0;
        t_enable = 0;

        // Case 1: Enable = 1 → Q follows D
        #10 t_enable = 1; t_D = 0;
        #10 t_D = 1;
        #10 t_D = 0;

        // Case 2: Enable = 0 → Q holds value
        #10 t_enable = 0;
        #10 t_D = 1;  // Should NOT affect Q
        #10 t_D = 0;  // Should NOT affect Q

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
