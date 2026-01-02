# Circuit_Boolean_CA Verilog Practice

## Overview
This project implements and verifies a combinational logic circuit described by Boolean expressions using Verilog HDL.  
The design includes two outputs (`E`, `F`) derived from four inputs (`A`, `B`, `C`, `D`).  
RTL design, synthesis, schematic inspection, and functional simulation were performed.

---

## Boolean Logic Description

### Output E
- E = A + (B · C) + (!B · D)

### Output F
- F = (!B · C) + (B · !C · !D)

---

## Files

- `Circuit_Boolean_CA.v`  
  Verilog RTL description of the combinational logic circuit.

- `Circuit_Boolean_CA_TB.v`  
  Testbench for functional verification.  
  All 16 possible input combinations (`A, B, C, D`) are applied sequentially.

- `Circuit_Boolean_CA.pdf`  
  Contains:
  - Synthesized logic schematic
  - ModelSim simulation waveform results

- `README.md`  
  Project documentation.

---

## Design Details

- Pure combinational logic (no clock or sequential elements)
- Boolean expressions directly implemented using Verilog `assign` statements
- NOT (`!`), AND (`&&`), and OR (`||`) operators used
- Verified using exhaustive input testing

---

## Simulation

- Simulator: ModelSim-Altera
- Method:
  - Testbench applies all input combinations
  - Outputs `E` and `F` are observed in waveform
- Result:
  - Simulation waveform matches expected Boolean logic behavior
  - Outputs change correctly according to input conditions

---

## Tools Used

- Quartus Prime Lite (RTL design & synthesis)
- ModelSim-Altera (functional simulation)

---

## Result

The synthesized schematic correctly reflects the Boolean logic structure, and the simulation waveform confirms that outputs `E` and `F` behave as defined by the Boolean expressions.

---

## Notes

This project serves as a basic practice for:
- Boolean logic to Verilog translation
- Combinational circuit modeling
- Testbench-based functional verification
- Documentation and version control using GitHub
