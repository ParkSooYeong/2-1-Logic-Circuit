# Circuit_B Verilog Practice

## Description
This project implements a combinational logic circuit using basic Verilog gate primitives  
(`and`, `or`, `not`, `xor`, `xnor`, `nor`).

The circuit generates three outputs (`F1`, `F2`, `F3`) based on four inputs (`A0`, `A1`, `B0`, `B1`).
The internal logic is composed of multiple intermediate wires and wide logic gates, demonstrating
hierarchical signal interaction and compound Boolean expressions.

## Files
- `Circuit_B.v`  
  RTL design written using Verilog gate-level primitives.

- `Circuit_B_tb.v`  
  Testbench that applies all possible input combinations to verify functional correctness.

- `Circuit_B.pdf`  
  Exported PDF containing:
  - Synthesized logic schematic
  - Simulation waveform results

## Tools
- Quartus Prime Lite (Analysis & Synthesis)
- ModelSim-Altera (Functional Simulation)

## Result
Simulation waveforms confirm correct combinational behavior for all input combinations.
The outputs `F1`, `F2`, and `F3` respond immediately to input changes as expected for a purely
combinational circuit.

This project serves as practice for understanding gate-level modeling, signal flow,
and verification using exhaustive testbench stimulus.
