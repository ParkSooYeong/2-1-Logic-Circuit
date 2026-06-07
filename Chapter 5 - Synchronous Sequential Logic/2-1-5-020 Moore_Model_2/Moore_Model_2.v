module Moore_Model_2 (
    input x_in,
    input clock,
    input reset,
    output y_out
);

    reg [1:0] state;

    parameter S0 = 2'b00,
              S1 = 2'b01,
              S2 = 2'b10,
              S3 = 2'b11;

    always @(posedge clock or negedge reset)
    begin
        if (!reset)
            state <= S0;
        else
            case (state)
                S0 : if (x_in) state <= S1; else state <= S0;
                S1 : if (x_in) state <= S2; else state <= S1;
                S2 : if (x_in) state <= S3; else state <= S2;
                S3 : if (x_in) state <= S0; else state <= S3;
            endcase
    end

    assign y_out = (state == S3);

endmodule


module Moore_Model_2_STR (
    input x_in,
    input clock,
    input reset,
    output y_out,
    output A,
    output B
);

    wire TA;
    wire TB;

    // Flip-Flop Inputs
    assign TA = x_in & B;
    assign TB = x_in;

    // Moore Output
    assign y_out = A & B;

    Toggle_Flip_Flop M_A (
        .Q(A),
        .T(TA),
        .clock(clock),
        .reset(reset)
    );

    Toggle_Flip_Flop M_B (
        .Q(B),
        .T(TB),
        .clock(clock),
        .reset(reset)
    );

endmodule


module Toggle_Flip_Flop (
    output reg Q,
    input T,
    input clock,
    input reset
);

    always @(posedge clock or negedge reset)
    begin
        if (!reset)
            Q <= 1'b0;
        else
            Q <= Q ^ T;
    end

endmodule
