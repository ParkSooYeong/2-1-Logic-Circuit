module Prob5_30 (
    input A,
    input B,
    input C,
    input clk,
    output reg E,
    output reg Q
);

    always @(posedge clk)
    begin
        E <= A | B;
        Q <= E & C;
    end

endmodule
