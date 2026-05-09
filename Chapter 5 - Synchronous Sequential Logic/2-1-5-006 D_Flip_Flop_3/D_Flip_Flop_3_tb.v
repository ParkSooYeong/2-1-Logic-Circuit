`timescale 1ns/1ps

module D_Flip_Flop_3_tb;

    // Stimulus signals
    reg t_D;
    reg t_clock;
    reg t_reset;

    // Response signal
    wire t_Q;

    // Instantiate UUT
    D_Flip_Flop_3 UUT (
        .D(t_D),
        .clock(t_clock),
        .reset(t_reset),
        .Q(t_Q)
    );

    // Clock generation (20ns period)
    initial begin
        t_clock = 1;
        forever #10 t_clock = ~t_clock;
    end

    // Waveform dump
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, D_Flip_Flop_3_tb);
    end

    // Stimulus generation
    initial begin

        // Initial state
        t_D     = 0;
        t_reset = 0;

        // Release reset
        #5 t_reset = 1;

        // Apply data
        #10 t_D = 1;
        #20 t_D = 0;
        #20 t_D = 1;

        // Async reset assertion
        #15 t_reset = 0;

        // Release reset again
        #10 t_reset = 1;

        // More input changes
        #10 t_D = 0;
        #20 t_D = 1;

        // Finish simulation
        #40 $finish;
    end

    // Monitor signals
    initial begin
        $monitor("time=%0t | clk=%b reset=%b D=%b | Q=%b",
                  $time, t_clock, t_reset, t_D, t_Q);
    end

endmodule
