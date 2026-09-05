module Binary_Counter_4_Par_Load (
    input Count,
    input Load,
    input clk,
    input clr,
    input [3:0] Data_in,
    output C_out,
    output reg [3:0] A_count
);

    // Carry-out is asserted when counting is enabled,
    // parallel loading is disabled, and the counter is at 15.
    assign C_out = Count && !Load && (A_count == 4'b1111);

    // 4-bit binary counter with asynchronous active-low clear.
    always @(posedge clk or negedge clr)
    begin
        if (!clr)
            A_count <= 4'b0000;

        else if (Load)
            A_count <= Data_in;

        else if (Count)
            A_count <= A_count + 4'b0001;

        else
            A_count <= A_count;
    end

endmodule
