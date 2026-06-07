`timescale 1ns/1ps

module Moore_Model_2_tb;

    reg t_x_in;
    reg t_clock;
    reg t_reset;

    wire t_y_out_1;
    wire t_y_out_2;
    wire A;
    wire B;

    // Behavioral Model
    Moore_Model_2 U1 (
        .x_in(t_x_in),
        .clock(t_clock),
        .reset(t_reset),
        .y_out(t_y_out_1)
    );

    // Structural Model
    Moore_Model_2_STR U2 (
        .x_in(t_x_in),
        .clock(t_clock),
        .reset(t_reset),
        .y_out(t_y_out_2),
        .A(A),
        .B(B)
    );

    // Clock Generation (10ns Period)
    initial begin
        t_clock = 1'b0;
        forever #5 t_clock = ~t_clock;
    end

    // Stimulus
    initial begin
        t_reset = 1'b0;
        t_x_in  = 1'b0;

        // Reset Release
        #5  t_reset = 1'b1;

        // Input Pattern
        #10 t_x_in = 1'b1;
        #10 t_x_in = 1'b0;
        #10 t_x_in = 1'b1;
        #10 t_x_in = 1'b0;
        #10 t_x_in = 1'b1;
        #10 t_x_in = 1'b0;
        #10 t_x_in = 1'b1;
        #10 t_x_in = 1'b0;

        // Reset Test
        #20 t_reset = 1'b0;
        #10 t_reset = 1'b1;

        // Additional Pattern
        #10 t_x_in = 1'b1;
        #10 t_x_in = 1'b1;
        #10 t_x_in = 1'b1;
        #10 t_x_in = 1'b1;
        #10 t_x_in = 1'b0;

        #30 $finish;
    end

endmodule
