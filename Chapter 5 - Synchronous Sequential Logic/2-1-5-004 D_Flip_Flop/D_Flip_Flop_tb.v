`timescale 1ns/1ps

module D_Flip_Flop_tb;

    // Declare stimulus signals
    reg t_D, t_clk;

    // Declare response signal
    wire t_Q;

    // Instantiate Unit Under Test (UUT)
    D_Flip_Flop UUT (
        .Q(t_Q),
        .D(t_D),
        .clk(t_clk)
    );

    // Generate clock (period = 20ns)
    initial begin
        t_clk = 0;
        forever #10 t_clk = ~t_clk;
    end

    // Generate waveform dump
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, D_Flip_Flop_tb);
    end

    // Apply stimulus
    initial begin
        // Initial state
        t_D = 0;

        // Change D before clock edge
        #5  t_D = 1;
        #10 t_D = 0;
        #10 t_D = 1;

        // Change D between edges (should not immediately affect Q)
        #7  t_D = 0;
        #6  t_D = 1;

        // More transitions
        #20 t_D = 0;
        #20 t_D = 1;

        // Finish simulation
        #40 $finish;
    end

    // Monitor signals
    initial begin
        $monitor("time=%0t | clk=%b D=%b | Q=%b",
                  $time, t_clk, t_D, t_Q);
    end

endmodule
