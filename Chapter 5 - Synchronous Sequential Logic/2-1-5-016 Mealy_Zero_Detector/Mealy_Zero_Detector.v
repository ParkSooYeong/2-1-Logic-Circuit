module Mealy_Zero_Detector (
    input x_in,
    input clock,
    input reset,
    output reg y_out
);

    reg [1:0] state, next_state;

    parameter S0 = 2'b00,
              S1 = 2'b01,
              S2 = 2'b10,
              S3 = 2'b11;

    //--------------------------------------------------
    // State Register
    //--------------------------------------------------
    always @ (posedge clock or negedge reset)
    begin

        if (!reset)
            state <= S0;

        else
            state <= next_state;

    end

    //--------------------------------------------------
    // Next State Logic
    //--------------------------------------------------
    always @ (state or x_in)
    begin

        case (state)

            S0 :
                if (x_in)
                    next_state = S1;
                else
                    next_state = S0;

            S1 :
                if (x_in)
                    next_state = S3;
                else
                    next_state = S0;

            S2 :
                if (!x_in)
                    next_state = S0;
                else
                    next_state = S2;

            S3 :
                if (x_in)
                    next_state = S2;
                else
                    next_state = S0;

            default :
                next_state = S0;

        endcase

    end

    //--------------------------------------------------
    // Output Logic
    //--------------------------------------------------
    always @ (state or x_in)
    begin

        case (state)

            S0 :
                y_out = 0;

            S1, S2, S3 :
                y_out = !x_in;

            default :
                y_out = 0;

        endcase

    end

endmodule
