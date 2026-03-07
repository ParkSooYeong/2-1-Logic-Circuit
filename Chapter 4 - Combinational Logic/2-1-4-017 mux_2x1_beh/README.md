# 2x1 Multiplexer (Behavioral Verilog)

## Overview
This project implements a **2-to-1 Multiplexer (MUX)** using **behavioral modeling in Verilog**.

A multiplexer selects one of several input signals and forwards the selected input to a single output line.  
In this design, the **select signal determines whether input `A` or `B` is routed to the output `m_out`.**

- When `select = 0` → Output follows **B**
- When `select = 1` → Output follows **A**

The design was simulated to verify correct functionality.

---

## Block Diagram

Inputs
- A
- B
- select

Output
- m_out

The multiplexer selects between the two data inputs (`A`, `B`) based on the control signal (`select`).

---

## Truth Table

| select | A | B | m_out |
|------|------|------|------|
| 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 1 |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 0 |
| 1 | 1 | 0 | 1 |
| 1 | 1 | 1 | 1 |

Explanation

select = 0 → output = B  
select = 1 → output = A  

---

## Verilog Implementation

Behavioral description of the 2x1 multiplexer.

    // Behavioral description of two-to-one-line multiplexer
    module mux_2x1_beh (A, B, select, m_out);
        input A, B, select;
        output m_out;
        reg m_out;
        
        always @ (A or B or select)
        if (select == 1) m_out = A;
        else m_out = B;
    endmodule

---

## Testbench Concept

The testbench applies all possible combinations of:

- Input A
- Input B
- Select signal

This verifies that the multiplexer correctly switches between inputs.

Example stimulus sequence:

    A B select → m_out
    0 0 0 → 0
    0 1 0 → 1
    1 0 0 → 0
    1 1 0 → 1
    0 0 1 → 0
    0 1 1 → 0
    1 0 1 → 1
    1 1 1 → 1

---

## Simulation Result

The waveform simulation confirms correct multiplexer behavior.

Observed behavior:

- When `select = 0`, the output follows **B**
- When `select = 1`, the output follows **A**

This verifies the correct operation of the **2x1 multiplexer**.

---

## Project Structure

    mux_2x1_beh
    │
    ├── mux_2x1_beh.v
    ├── mux_2x1_beh_tb.v
    ├── waveform.png
    ├── schematic.png
    └── README.md

---

## Tools Used

- Verilog HDL
- Intel Quartus Prime
- ModelSim (simulation)
