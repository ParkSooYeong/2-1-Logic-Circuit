module Prob5_52 (
    input x_in,
    input clk,
    input reset_b,
    output reg y_out
);

    parameter s0 = 2'b00,
              s1 = 2'b01,
              s2 = 2'b10,
              s3 = 2'b11;

    reg [1:0] state, next_state;

    // State Register
    always @ (posedge clk, negedge reset_b) begin
        if (!reset_b)
            state <= s0;
        else
            state <= next_state;
    end

    // Next-State and Output Logic
    always @ (state, x_in) begin
        y_out = 1'b0;
        next_state = s0;

        case (state)
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
                if (x_in) begin
                    next_state = s3;
                    y_out = 1'b0;
                end
                else begin
                    next_state = s2;
                    y_out = 1'b1;
                end
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
