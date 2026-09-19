`timescale 1ns/100ps

module memory (
    input Enable,
    input ReadWrite,
    input [5:0] Address,
    input [3:0] DataIn,
    output reg [3:0] DataOut
);

    reg [3:0] Mem [0:63];

    // Asynchronous Read / Write Memory
    always @(*) begin

        // Default: High impedance
        DataOut = 4'bz;

        if (Enable) begin

            if (ReadWrite) begin
                // Read
                DataOut = Mem[Address];
            end
            else begin
                // Write
                Mem[Address] = DataIn;
            end

        end
    end

endmodule
