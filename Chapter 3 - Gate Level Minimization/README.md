# NOT_A_NOT_D VHDL Practice

## Description
Simple combinational logic example implemented in VHDL:

- D = (NOT A) OR B  
- F = (NOT D) AND C  

This design demonstrates basic NOT, OR, and AND logic operations using an intermediate signal.

## Files
- `NOT_A_NOT_D.vhd` : RTL design (VHDL)
- `NOT_A_NOT_D_TB.vhd` : Testbench for functional simulation
- `NOT_A_NOT_D.pdf` : Logic schematic and simulation waveform (exported as PDF)

## Tools
- Quartus Prime Lite
- ModelSim-Altera

## Result
Simulation waveform confirms correct logical behavior of the design.  
The output `F` responds correctly to all input combinations of `A`, `B`, and `C` according to the Boolean equations.
