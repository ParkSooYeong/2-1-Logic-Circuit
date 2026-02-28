`timescale 1ns/1ps

module decoder_2x4_df_beh_tb;

    reg A;
    reg B;
    reg enable;
    wire [0:3] D;

    decoder_2x4_df_beh uut (
        .A(A),
        .B(B),
        .enable(enable),
        .D(D)
    );

    integer i;

    initial begin
        $display("A B EN | D");
        $display("----------------");

        for (i = 0; i < 8; i = i + 1) begin
            {A, B, enable} = i;
            #10;
            $display("%b %b  %b | %b", A, B, enable, D);
        end

        $display("Test completed.");
        $finish;
    end

endmodule
