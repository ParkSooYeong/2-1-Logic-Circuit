`timescale 1ns/1ps

module t_Design_Unit();

    // Declare stimulus (input) signals
    reg t_A, t_B, t_select;

    // Declare response (output) signal
    wire t_m_out;

    // Instantiate the Unit Under Test (UUT)
    Design_Unit UUT (
        .A(t_A),
        .B(t_B),
        .select(t_select),
        .m_out(t_m_out)
    );

    // Generate waveform dump file
    initial begin
        $dumpfile("wave.vcd");      // Specify VCD file name
        $dumpvars(0, t_Design_Unit); // Dump all variables in testbench
    end

    // Apply input stimulus
    initial begin
        // Initialize inputs
        t_A = 0;
        t_B = 0;
        t_select = 0;

        // Apply test cases
        #10 t_A = 1; t_B = 0;
        #10 t_A = 0; t_B = 1;
        #10 t_A = 1; t_B = 1;

        // End simulation
        #20 $finish;
    end

    // Toggle select signal periodically
    initial begin
        forever #10 t_select = ~t_select;
    end

    // Monitor signal changes
    initial begin
        $monitor("time=%0t | A=%b B=%b select=%b | out=%b",
                  $time, t_A, t_B, t_select, t_m_out);
    end

endmodule
