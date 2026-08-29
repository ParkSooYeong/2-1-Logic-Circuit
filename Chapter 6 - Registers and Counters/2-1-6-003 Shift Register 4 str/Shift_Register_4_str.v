module Shift_Register_4_str
(
    input s0,
    input s1,
    input MSB_in,
    input LSB_in,
    input clk,
    input Clear_b,
    input [3:0] I_par,
    output [3:0] A_par
);

    wire [1:0] select;

    assign select = {s0, s1};

    // Stage 0
    stage ST0 (
        .i0(LSB_in),
        .i1(A_par[1]),
        .i2(A_par[0]),
        .i3(I_par[0]),
        .Q(A_par[0]),
        .select(select),
        .clk(clk),
        .Clr_b(Clear_b)
    );

    // Stage 1
    stage ST1 (
        .i0(A_par[0]),
        .i1(A_par[2]),
        .i2(A_par[1]),
        .i3(I_par[1]),
        .Q(A_par[1]),
        .select(select),
        .clk(clk),
        .Clr_b(Clear_b)
    );

    // Stage 2
    stage ST2 (
        .i0(A_par[1]),
        .i1(A_par[3]),
        .i2(A_par[2]),
        .i3(I_par[2]),
        .Q(A_par[2]),
        .select(select),
        .clk(clk),
        .Clr_b(Clear_b)
    );

    // Stage 3
    stage ST3 (
        .i0(A_par[2]),
        .i1(MSB_in),
        .i2(A_par[3]),
        .i3(I_par[3]),
        .Q(A_par[3]),
        .select(select),
        .clk(clk),
        .Clr_b(Clear_b)
    );

endmodule


module stage (
    input i0,
    input i1,
    input i2,
    input i3,
    output Q,
    input [1:0] select,
    input clk,
    input Clr_b
);

    wire mux_out;
    wire Clr;

    assign Clr = ~Clr_b;

    Mux_4x1 M0 (
        .mux_out(mux_out),
        .i0(i0),
        .i1(i1),
        .i2(i2),
        .i3(i3),
        .select(select)
    );

    D_flip_flop M1 (
        .Q(Q),
        .D(mux_out),
        .clk(clk),
        .Clr(Clr)
    );

endmodule


module Mux_4x1 (
    output reg mux_out,
    input i0,
    input i1,
    input i2,
    input i3,
    input [1:0] select
);

    always @(*) begin
        case (select)
            2'b00: mux_out = i0;
            2'b01: mux_out = i1;
            2'b10: mux_out = i2;
            2'b11: mux_out = i3;
            default: mux_out = 1'b0;
        endcase
    end

endmodule


module D_flip_flop (
    output reg Q,
    input D,
    input clk,
    input Clr
);

    always @(posedge clk or posedge Clr) begin
        if (Clr)
            Q <= 1'b0;
        else
            Q <= D;
    end

endmodule
