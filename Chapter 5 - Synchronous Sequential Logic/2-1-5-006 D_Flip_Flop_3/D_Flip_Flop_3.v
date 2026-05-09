module D_Flip_Flop_3 (
    input D,
    input clock,
    input reset,
    output reg Q
);

    always @ (negedge clock or negedge reset) begin
        if (!reset)
            Q <= 1'b0;
        else
            Q <= D;
    end
endmodule
