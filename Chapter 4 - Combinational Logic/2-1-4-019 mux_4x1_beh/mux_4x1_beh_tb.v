`timescale 1ns/1ps

module mux_4x1_beh_tb;

    // Inputs
    reg in_0, in_1, in_2, in_3;
    reg [1:0] select;

    // Output
    wire m_out;

    // DUT (Device Under Test) instantiate턴스화
    mux_4x1_beh uut (
        .in_0(in_0),
        .in_1(in_1),
        .in_2(in_2),
        .in_3(in_3),
        .select(select),
        .m_out(m_out)
    );

    // Test scenario
    initial begin
        // Initial value settings
        in_0 = 0; in_1 = 0; in_2 = 0; in_3 = 0;
        select = 2'b00;

        // Set each Input separately
        #10 in_0 = 0; in_1 = 1; in_2 = 0; in_3 = 1;

        // Select change
        #10 select = 2'b00; // m_out = in_0
        #10 select = 2'b01; // m_out = in_1
        #10 select = 2'b10; // m_out = in_2
        #10 select = 2'b11; // m_out = in_3

        // Check again after changing the input value
        #10 in_0 = 1; in_1 = 0; in_2 = 1; in_3 = 0;

        #10 select = 2'b00;
        #10 select = 2'b01;
        #10 select = 2'b10;
        #10 select = 2'b11;

        // Various random tests
        #10 in_0 = 1; in_1 = 1; in_2 = 0; in_3 = 0;
        #10 select = 2'b00;
        #10 select = 2'b01;
        #10 select = 2'b10;
        #10 select = 2'b11;

        // Simulation ends
        #20 $stop;
    end

endmodule
