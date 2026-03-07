`timescale 1ns / 1ps

module mux_2x1_beh_tb;

// Testbench signals
reg A;
reg B;
reg select;
wire m_out;

// Instantiate the DUT (Device Under Test)
mux_2x1_beh uut (
    .A(A),
    .B(B),
    .select(select),
    .m_out(m_out)
);

// Stimulus
initial begin

    // Initialize inputs
    A = 0;
    B = 0;
    select = 0;

    #10 A = 0; B = 0; select = 0;
    #10 A = 0; B = 1; select = 0;
    #10 A = 1; B = 0; select = 0;
    #10 A = 1; B = 1; select = 0;

    #10 A = 0; B = 0; select = 1;
    #10 A = 0; B = 1; select = 1;
    #10 A = 1; B = 0; select = 1;
    #10 A = 1; B = 1; select = 1;

    #10 $finish;

end

endmodule
