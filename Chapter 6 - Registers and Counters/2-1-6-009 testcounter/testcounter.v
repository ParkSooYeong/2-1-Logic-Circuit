`timescale 1ns/100ps

module testcounter (
    input count,
    input load,
    input [3:0] Data_in,
    input clk,
    input clr,
    output reg [3:0] A_count,
    output C_out
);

    // Carry-out
    assign C_out = count && !load && (A_count == 4'b1111);

    // 4-bit Counter
    // Active-low asynchronous clear
    always @(posedge clk or negedge clr)
    begin
        if (!clr)
            A_count <= 4'b0000;

        else if (load)
            A_count <= Data_in;

        else if (count)
            A_count <= A_count + 4'b0001;

        else
            A_count <= A_count;
    end

endmodule
