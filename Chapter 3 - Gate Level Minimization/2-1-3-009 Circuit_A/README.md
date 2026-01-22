# Circuit_A Verilog Practice

## Description
This project demonstrates a combinational logic circuit implemented using
basic Verilog gate-level modeling.

The circuit consists of:
- NOT gates for input inversion
- AND gates for intermediate logic generation
- OR gates for final output combination

The design is intended to practice:
- Structural (gate-level) Verilog modeling
- Signal flow analysis using intermediate wires
- Functional verification through simulation

## Logic Overview
Internal signals are defined as follows:

- a = NOT A  
- d = NOT D  
- y = a AND C  
- z = y AND A  
- w = z AND B  
- x = B OR C OR d  
- F = x OR w  

## Files
- `Circuit_A.v` : Gate-level RTL design
- `Circuit_A_tb.v` : Testbench for functional simulation
- `Circuit_A.pdf` : Logic schematic and simulation waveform

## Tools
- Quartus Prime Lite
- ModelSim-Altera

## Result
Simulation waveform confirms that output **F** responds correctly
to all combinations of inputs **A, B, C, D** based on the intended logic.

All 16 input combinations were applied in the testbench,
and the resulting output behavior matches the expected logic function.
