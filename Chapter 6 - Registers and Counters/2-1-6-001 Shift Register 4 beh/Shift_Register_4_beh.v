module Shift_Register_4_beh (
    input s0,
    input s1,
    input MSB_in,
    input LSB_in,
    input clk,
    input Clear_b,
    input [3:0] I_par,
    output reg [3:0] A_par
);

    always @(posedge clk or negedge Clear_b)
    begin
        if (Clear_b == 1'b0)
        begin
            A_par <= 4'b0000;
        end
        else
        begin
            case ({s0, s1})

                // Hold
                2'b00:
                    A_par <= A_par;

                // Shift Right
                // MSB_in enters A_par[3]
                2'b01:
                    A_par <= {MSB_in, A_par[3:1]};

                // Shift Left
                // LSB_in enters A_par[0]
                2'b10:
                    A_par <= {A_par[2:0], LSB_in};

                // Parallel Load
                2'b11:
                    A_par <= I_par;

                default:
                    A_par <= 4'b0000;

            endcase
        end
    end
	 
endmodule
