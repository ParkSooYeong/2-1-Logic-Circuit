# UDP Primitive Practice (Verilog)

## Description
This project demonstrates the use of a **User Defined Primitive (UDP)** in Verilog.
A custom combinational primitive is defined using a truth table and instantiated in a higher-level circuit.

The design consists of:
- A UDP (`UDP_02467`) that generates output `e` based on inputs `a`, `b`, and `c`
- An additional AND gate that generates output `f = e AND d`

## Logic Function

### UDP Truth Table
The UDP defines output `e` as a function of inputs `a`, `b`, and `c`.

| A | B | C | e |
|---|---|---|---|
| 0 | 0 | 0 | 1 |
| 0 | 0 | 1 | 0 |
| 0 | 1 | 0 | 1 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 1 |
| 1 | 0 | 1 | 0 |
| 1 | 1 | 0 | 1 |
| 1 | 1 | 1 | 1 |

Additional logic:
- `f = e AND d`

## Files
- `UDP_02467.v`  
  User Defined Primitive described using a truth table

- `Circuit_with_UDP_02467.v`  
  Top-level circuit that instantiates the UDP and an AND gate

- `Circuit_with_UDP_02467_tb.v`  
  Testbench for functional simulation of the circuit

- `Primitive.pdf`  
  Logic schematic and simulation waveform exported from Quartus / ModelSim

## Tools
- Quartus Prime Lite 15.1
- ModelSim-Altera

## Simulation
The testbench applies all possible input combinations for `a`, `b`, `c`, and `d`.
Simulation waveforms confirm:
- Correct evaluation of the UDP truth table
- Correct AND operation for output `f`

## Result
Functional simulation verifies that the UDP and the surrounding logic operate as intended.
This example demonstrates how custom primitives can be defined and used in Verilog designs.
