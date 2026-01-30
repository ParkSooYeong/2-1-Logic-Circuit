# 2-to-4 Decoder (Gate-Level VHDL)

## 1. Overview

This project implements a 2-to-4 line decoder using gate-level structural VHDL.
The design is constructed from basic logic components (inverter and 3-input NAND gate)
and follows a schematic-oriented modeling style.

The decoder operates with an active-low enable signal and produces active-low outputs.
Simulation and synthesis were performed using Quartus Prime.

---

## 2. File Structure

- `decoder_2x4_gates_vhdl.vhd`  
  Gate-level structural VHDL implementation of the 2-to-4 decoder

- `decoder_2x4_gates_vhdl_tb.vhd`  
  Testbench for functional simulation

- `README.md`  
  Project documentation

---

## 3. Functional Description

### 3.1 Inputs and Outputs

| Signal | Direction | Description |
|------|-----------|-------------|
| A | Input | Decoder input (MSB) |
| B | Input | Decoder input (LSB) |
| enable | Input | Active-low enable signal |
| D(0) | Output | Output line 0 (active-low) |
| D(1) | Output | Output line 1 (active-low) |
| D(2) | Output | Output line 2 (active-low) |
| D(3) | Output | Output line 3 (active-low) |

---

### 3.2 Truth Table

| enable | A | B | D(0) | D(1) | D(2) | D(3) |
|--------|---|---|------|------|------|------|
| 1 | X | X | 1 | 1 | 1 | 1 |
| 0 | 0 | 0 | 0 | 1 | 1 | 1 |
| 0 | 0 | 1 | 1 | 0 | 1 | 1 |
| 0 | 1 | 0 | 1 | 1 | 0 | 1 |
| 0 | 1 | 1 | 1 | 1 | 1 | 0 |

---

## 4. Design Architecture

### 4.1 Component Description

- **inv_gate**
  - Implements a NOT operation
  - Used to generate inverted inputs

- **nand3_gate**
  - Implements a 3-input NAND operation
  - Used to generate each decoder output

---

### 4.2 Structural Modeling

The decoder is implemented using structural VHDL.
Each component is instantiated explicitly and interconnected using internal signals.

Internal signals:
- A_not
- B_not
- enable_not

Each output D(i) is generated using a dedicated NAND gate instance.

---

## 5. Simulation

A dedicated testbench applies all possible input combinations for:
- A
- B
- enable

The waveform confirms correct decoder behavior for both enabled and disabled states.

---

## 6. Synthesis

- Tool: Quartus Prime Lite 15.1
- Top-Level Entity: decoder_2x4_gates_vhdl
- Synthesis Result: Successful
- No syntax or elaboration errors after corrections

---

## 7. Notes

- Outputs are active-low due to NAND-based implementation
- The design closely reflects a gate-level schematic
- Suitable for learning structural VHDL and component instantiation

---

## 8. Author

Created for digital logic and VHDL structural modeling practice.
