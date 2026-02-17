`timescale 1ns/1ps

module binary_adder_tb;

    // Test signals
    reg  [3:0] A, B;
    reg        C_in;
    wire [3:0] sum;
    wire       C_out;

    // DUT instantiation
    binary_adder uut (
        .A(A),
        .B(B),
        .C_in(C_in),
        .sum(sum),
        .C_out(C_out)
    );

    initial begin
        $display("Time\tA\tB\tC_in\t| C_out Sum");
        $monitor("%0dns\t%b\t%b\t%b\t| %b     %b",
                 $time, A, B, C_in, C_out, sum);

        // Test case 1
        A = 4'b0000; B = 4'b0000; C_in = 0; #10;

        // Test case 2
        A = 4'b0101; B = 4'b0011; C_in = 0; #10;

        // Test case 3
        A = 4'b0101; B = 4'b0011; C_in = 1; #10;

        // Test case 4 (overflow case)
        A = 4'b1111; B = 4'b0001; C_in = 0; #10;

        // Test case 5
        A = 4'b1010; B = 4'b0101; C_in = 1; #10;

        // Test case 6 (maximum case)
        A = 4'b1111; B = 4'b1111; C_in = 1; #10;

        $stop;
    end

endmodule
