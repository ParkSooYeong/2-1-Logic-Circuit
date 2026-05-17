module My_DFF (
    output reg Q,
    input D,
    input clk,
    input rst
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            Q <= 1'b0;
        else
            Q <= D;
    end

endmodule


module T_Flip_Flop (
    input T,
    input clk,
    input rst,
    output Q
);

    wire DT;

    assign DT = Q ^ T;

    My_DFF TF1 (
        .Q(Q),
        .D(DT),
        .clk(clk),
        .rst(rst)
    );

endmodule
