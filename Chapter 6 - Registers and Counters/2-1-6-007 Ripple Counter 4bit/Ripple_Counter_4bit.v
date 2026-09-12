`timescale 1ns/100ps

module Ripple_Counter_4bit (
    output A0,
    output A1,
    output A2,
    output A3,
    input count,
    input reset
);

    Comp_D_flip_flop F0 (
        .Q(A0),
        .clk(count),
        .reset(reset)
    );

    Comp_D_flip_flop F1 (
        .Q(A1),
        .clk(A0),
        .reset(reset)
    );

    Comp_D_flip_flop F2 (
        .Q(A2),
        .clk(A1),
        .reset(reset)
    );

    Comp_D_flip_flop F3 (
        .Q(A3),
        .clk(A2),
        .reset(reset)
    );

endmodule


module Comp_D_flip_flop (
    output reg Q,
    input clk,
    input reset
);

    always @(negedge clk or posedge reset)
    begin
        if (reset)
            Q <= 1'b0;
        else
            Q <= #2 ~Q;
    end

endmodule
