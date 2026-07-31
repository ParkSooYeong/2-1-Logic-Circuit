module Prob5_51(
    input x_in,
    input clk,
    input reset,
    output reg y_out
);

    parameter s0 = 2'b00,
              s1 = 2'b01,
              s2 = 2'b10,
              s3 = 2'b11;

    reg [1:0] state, next_state;

    // State Register
    always @(posedge clk, negedge reset) begin
        if (!reset)
            state <= s0;
        else
            state <= next_state;
    end

    // Next State Logic & Output Logic
    always @(*) begin

        y_out = 1'b0;
        next_state = s0;

        case(state)

            s0: begin
                y_out = 1'b0;
                if (x_in)
                    next_state = s1;
                else
                    next_state = s0;
            end

            s1: begin
                y_out = 1'b0;
                if (x_in)
                    next_state = s2;
                else
                    next_state = s1;
            end

            s2: begin
                y_out = 1'b1;
                if (x_in)
                    next_state = s3;
                else
                    next_state = s2;
            end

            s3: begin
                y_out = 1'b1;
                if (x_in)
                    next_state = s0;
                else
                    next_state = s3;
            end

            default: begin
                y_out = 1'b0;
                next_state = s0;
            end

        endcase
    end

endmodule
