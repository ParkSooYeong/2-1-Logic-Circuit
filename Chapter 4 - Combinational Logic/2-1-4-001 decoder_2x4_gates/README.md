# decoder_2x4_gates

## 1. Overview

This project implements a **2-to-4 decoder** using **gate-level Verilog primitives**.
The circuit is described using **structural modeling**, explicitly instantiating
basic logic gates such as `not` and `nand`.

When the `enable` signal is active, exactly one output among `D[0]` to `D[3]`
is asserted based on the input combination of `A` and `B`.

---

## 2. File Structure

- `decoder_2x4_gates.v`  
  Gate-level Verilog implementation of the 2-to-4 decoder

- `decoder_2x4_gates_tb.v`  
  Testbench for functional simulation

- `README.md`  
  Project documentation

---

## 3. Module Description

### Module Name
`decoder_2x4_gates`

### Port Description

| Port | Direction | Width | Description |
|------|----------|-------|-------------|
| D    | Output   | [0:3] | Decoder output lines |
| A    | Input    | 1     | Address input |
| B    | Input    | 1     | Address input |
| enable | Input | 1     | Enable control signal |

---

## 4. Functional Description

The decoder logic follows these rules:

- When `enable = 1`, all outputs remain inactive
- When `enable = 0`, one output line is asserted according to inputs `A` and `B`

| enable | A | B | D[3] | D[2] | D[1] | D[0] |
|--------|---|---|------|------|------|------|
| 0 | 0 | 0 | 0 | 0 | 0 | 1 |
| 0 | 0 | 1 | 0 | 0 | 1 | 0 |
| 0 | 1 | 0 | 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 1 | 0 | 0 | 0 |
| 1 | X | X | 0 | 0 | 0 | 0 |

---

## 5. Implementation Notes

- The design uses **primitive gate instantiation** (`not`, `nand`)
- Active-low enable behavior is implemented using NAND gates
- Structural modeling closely reflects the underlying hardware logic

---

## 6. Tools

- Quartus Prime Lite
- ModelSim-Altera

---

## 7. Result

Simulation waveforms confirm correct 2-to-4 decoding behavior with proper
enable control and gate-level operation.
