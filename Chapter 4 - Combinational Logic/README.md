# mux_2x1_df

## Overview

`mux_2x1_df` is a 2-to-1 multiplexer implemented in Verilog using the Dataflow modeling style.  
The module selects one of two single-bit inputs (`A` or `B`) based on the value of the control signal `select`.

This design is purely combinational and fully synthesizable.

---

## Functional Description

A 2x1 multiplexer operates according to the following rule:

- If `select = 1` → output = `A`
- If `select = 0` → output = `B`

Mathematically:

m_out = select ? A : B

---

## Module Interface

### Inputs
- `A` : 1-bit data input
- `B` : 1-bit data input
- `select` : 1-bit control signal

### Output
- `m_out` : 1-bit selected output

---

## Verilog Implementation

    module mux_2x1_df (A, B, select, m_out);
        input A, B;
        input select;
        output m_out;
        
        assign m_out = (select) ? A : B; // Conditional Operator
    endmodule

---

## Truth Table

| select | A | B | m_out |
|--------|---|---|--------|
|   0    | X | 0 |   0    |
|   0    | X | 1 |   1    |
|   1    | 0 | X |   0    |
|   1    | 1 | X |   1    |

(X = don't care)

---

## Testbench Description

The testbench verifies all possible input combinations (2³ = 8 cases):

- A = 0 or 1  
- B = 0 or 1  
- select = 0 or 1  

All combinations are applied sequentially with time delay to observe waveform behavior.

---

## Example Testbench

    `timescale 1ns/1ps

    module mux_2x1_df_tb;

        reg A;
        reg B;
        reg select;
        wire m_out;

        mux_2x1_df uut (
            .A(A),
            .B(B),
            .select(select),
            .m_out(m_out)
        );

        integer i;

        initial begin
            for (i = 0; i < 8; i = i + 1) begin
                {A, B, select} = i;
                #10;
            end
            $stop;
        end

    endmodule

---

## Simulation Results

- All 8 input combinations verified
- Output correctly follows select control signal
- No glitches or undefined states observed
- Pure combinational response (no clock dependency)

Waveform confirms correct multiplexer behavior.

---

## Synthesis Characteristics

- Combinational logic only
- No registers or latches inferred
- Fully synthesizable in FPGA/ASIC tools
- Implemented using conditional operator (ternary operator)

---

## Project Structure

mux_2x1_df/
├── mux_2x1_df.v
├── mux_2x1_df_tb.v
└── README.md

---

## Author

Project: mux_2x1_df  
Date: February 27, 2026  
