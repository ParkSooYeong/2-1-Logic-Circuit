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


module JK_Flip_Flop (
    input J,
    input K,
    input clk,
    input rst,
    output Q
);

    wire JK;

    // JK characteristic equation
    assign JK = (J & ~Q) | (~K & Q);

    My_DFF M0 (
        .Q(Q),
        .D(JK),
        .clk(clk),
        .rst(rst)
    );

endmodule
