`timescale 1ns/1ps

module D_Flip_Flop_2_tb;

    // Stimulus signals
    reg t_D, t_clk, t_rst;

    // Response signal
    wire t_Q;

    // Instantiate UUT
    D_Flip_Flop_2 UUT (
        .D(t_D),
        .clk(t_clk),
        .rst(t_rst),
        .Q(t_Q)
    );

    // Clock generation (period = 20ns)
    initial begin
        t_clk = 0;
        forever #10 t_clk = ~t_clk;
    end

    // Dump waveform
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, D_Flip_Flop_2_tb);
    end

    // Stimulus
    initial begin
        // Initial state
        t_D   = 0;
        t_rst = 0;   // Reset active (active-low)

        #5  t_rst = 1;   // Release reset

        // Normal operation
        #10 t_D = 1;
        #20 t_D = 0;
        #20 t_D = 1;

        // Asynchronous reset during operation
        #7  t_rst = 0;   // Immediate reset (no clk needed)
        #10 t_rst = 1;   // Release reset

        // More data changes
        #15 t_D = 0;
        #20 t_D = 1;

        // Another async reset near clock edge
        #9  t_rst = 0;
        #6  t_rst = 1;

        // Finish simulation
        #40 $finish;
    end

    // Monitor
    initial begin
        $monitor("time=%0t | clk=%b rst=%b D=%b | Q=%b",
                  $time, t_clk, t_rst, t_D, t_Q);
    end

endmodule
