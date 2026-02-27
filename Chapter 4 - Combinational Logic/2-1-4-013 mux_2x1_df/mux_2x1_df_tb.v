`timescale 1ns/1ps

module mux_2x1_df_tb;

    reg A;
    reg B;
    reg select;
    wire m_out;

    // DUT 인스턴스
    mux_2x1_df uut (
        .A(A),
        .B(B),
        .select(select),
        .m_out(m_out)
    );

    integer i;

    initial begin
        $display("A B S | OUT");
        $display("------------");

        // 3비트 조합 전수 테스트 (A,B,select)
        for (i = 0; i < 8; i = i + 1) begin
            {A, B, select} = i;
            #10;
            $display("%b %b %b |  %b", A, B, select, m_out);
        end

        $display("Test completed.");
        $finish;
    end

endmodule
