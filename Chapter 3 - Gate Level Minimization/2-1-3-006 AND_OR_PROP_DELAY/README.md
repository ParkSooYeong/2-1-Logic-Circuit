# AND_OR_PROP_DELAY

## 1. Description
This project implements a gate-level combinational logic circuit using Verilog.
Propagation delays are explicitly modeled for each logic gate in order to observe
time-dependent behavior during simulation.

Logic equations:
- w1 = A AND B (30 ns delay)
- E  = NOT C (10 ns delay)
- D  = w1 OR E (20 ns delay)

## 2. Files
- `AND_OR_PROP_DELAY.v`  
  Verilog gate-level design with propagation delays

- `AND_OR_PROP_DELAY_TB.v`  
  Testbench for functional and timing simulation

- `AND_OR_PROP_DELAY.pdf`  
  Logic schematic and simulation waveform capture

## 3. Tools
- Quartus Prime Lite
- ModelSim-Altera

## 4. Simulation Result
The simulation confirms correct logical functionality and demonstrates propagation
delays through each gate. Output signals D and E transition only after the specified
gate delays, verifying the intended timing behavior.

## 5. Notes
- Gate delays (`#10`, `#20`, `#30`) are for simulation purposes only.
- These delays are ignored during synthesis.
- This example is intended for learning propagation delay concepts in Verilog.
