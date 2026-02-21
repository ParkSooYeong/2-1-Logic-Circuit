`timescale 1ns/1ps

module mag_compare_tb;

    // Testbench signals
    reg  [3:0] A, B;
    wire A_lt_B, A_eq_B, A_gt_B;

    // DUT (Device Under Test) instantiation
    mag_compare uut (
        .A(A),
        .B(B),
        .A_lt_B(A_lt_B),
        .A_eq_B(A_eq_B),
        .A_gt_B(A_gt_B)
    );

    integer i, j;

    initial begin
        $display("Starting 4-bit Comparator Test...");
        $display(" A    B   | LT EQ GT ");
        $display("----------------------");

        // Test all possible combinations (0~15)
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                A = i;
                B = j;
                #10;

                // Display result
                $display("%2d   %2d   |  %b  %b  %b",
                          A, B, A_lt_B, A_eq_B, A_gt_B);

                // Self-checking condition
                if ((A < B && A_lt_B !== 1'b1) ||
                    (A > B && A_gt_B !== 1'b1) ||
                    (A == B && A_eq_B !== 1'b1)) begin
                        $display("ERROR at A=%d, B=%d", A, B);
                        $stop;
                end
            end
        end

        $display("All test cases passed successfully!");
        $finish;
    end

endmodule
