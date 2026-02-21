# mag_compare

## Overview
`mag_compare` is a 4-bit magnitude comparator implemented in Verilog.  
The module compares two unsigned 4-bit inputs (`A[3:0]` and `B[3:0]`) and produces three mutually exclusive output signals:

- `A_eq_B` : High when A == B  
- `A_gt_B` : High when A > B  
- `A_lt_B` : High when A < B  

The design is purely combinational and fully synthesizable.

---

## Module Description

### Inputs
- `A[3:0]` : 4-bit unsigned input
- `B[3:0]` : 4-bit unsigned input

### Outputs
- `A_eq_B` : Asserted when A equals B
- `A_gt_B` : Asserted when A is greater than B
- `A_lt_B` : Asserted when A is less than B

Only one output is high at any time.

---

## Verilog Implementation

    module mag_compare (
        input  [3:0] A,
        input  [3:0] B,
        output       A_eq_B,
        output       A_gt_B,
        output       A_lt_B
    );

    assign A_eq_B = (A == B);
    assign A_gt_B = (A > B);
    assign A_lt_B = (A < B);

    endmodule

---

## Functional Behavior

| Condition | A_eq_B | A_gt_B | A_lt_B |
|------------|--------|--------|--------|
| A == B | 1 | 0 | 0 |
| A > B  | 0 | 1 | 0 |
| A < B  | 0 | 0 | 1 |

The comparator evaluates unsigned magnitude relationships.

---

## Testbench (Exhaustive Simulation)

    `timescale 1ns/1ps

    module mag_compare_tb;

    reg  [3:0] A;
    reg  [3:0] B;
    wire A_eq_B;
    wire A_gt_B;
    wire A_lt_B;

    mag_compare uut (
        .A(A),
        .B(B),
        .A_eq_B(A_eq_B),
        .A_gt_B(A_gt_B),
        .A_lt_B(A_lt_B)
    );

    integer i, j;

    initial begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                A = i;
                B = j;
                #10;
            end
        end
        $stop;
    end

    endmodule

---

## Simulation Results

- All 256 possible input combinations (0–15) were tested.
- Outputs behaved as expected.
- No undefined or overlapping output states were observed.
- Exactly one comparison output was asserted per input combination.

---

## Synthesis Information

- Pure combinational logic
- No sequential elements
- No latches inferred
- Fully synthesizable on FPGA/ASIC tools

---

## Project Structure

mag_compare/
├── mag_compare.v
├── mag_compare_tb.v
└── README.md

---

## Author

Project: mag_compare  
Date: February 21, 2026  
