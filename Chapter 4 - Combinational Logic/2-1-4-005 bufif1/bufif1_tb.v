`timescale 1ns/1ps

module mux_tri_tb;

    // Testbench signals
    reg A;
    reg B;
    reg select;
    wire m_out;

    // Instantiate DUT
    mux_tri DUT (
        .m_out(m_out),
        .A(A),
        .B(B),
        .select(select)
    );

    // Stimulus
    initial begin
        $display("Time\tA B select | m_out");
        $monitor("%0t\t%b %b   %b    |  %b",
                 $time, A, B, select, m_out);

        // Test all combinations
        A = 0; B = 0; select = 0; #10;
        A = 0; B = 1; select = 0; #10;
        A = 1; B = 0; select = 0; #10;
        A = 1; B = 1; select = 0; #10;

        A = 0; B = 0; select = 1; #10;
        A = 0; B = 1; select = 1; #10;
        A = 1; B = 0; select = 1; #10;
        A = 1; B = 1; select = 1; #10;

        $finish;
    end

endmodule
