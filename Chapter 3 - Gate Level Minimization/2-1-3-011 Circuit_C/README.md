# Circuit_C

## 1. Overview
This project demonstrates different ways to describe combinational logic in Verilog.
The circuit has two inputs (`a`, `b`) and three outputs (`y1`, `y2`, `y3`).

Each output is implemented using a different Verilog description style.

---

## 2. File Description

### Circuit_C.v
Top-level Verilog module implementing simple combinational logic.

- `y1` : Implemented using the logical OR operator (`||`)
- `y2` : Implemented using an AND gate primitive
- `y3` : Implemented using the logical AND operator (`&&`)

### Circuit_C_tb.v
Testbench file for functional verification.

- Applies all possible input combinations of `a` and `b`
- Observes outputs `y1`, `y2`, and `y3` through waveform simulation
- Used only for simulation (not synthesized)

---

## 3. Functional Description

Truth table of the circuit:

| a | b | y1 (a || b) | y2 (AND gate) | y3 (a && b) |
|---|---|-------------|---------------|-------------|
| 0 | 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 0 | 0 |
| 1 | 0 | 1 | 0 | 0 |
| 1 | 1 | 1 | 1 | 1 |

---

## 4. Simulation Result
Simulation waveforms show that:

- `y1` correctly performs the OR operation
- `y2` correctly performs the AND operation using a gate primitive
- `y3` correctly performs the AND operation using a logical operator

All outputs match the expected truth table.

---

## 5. Notes

- Logical operators (`||`, `&&`) evaluate expressions as boolean values
- Gate primitives (`and`, `or`, etc.) describe explicit hardware gates
- For single-bit signals, both approaches produce identical results
- Differences become important when dealing with multi-bit signals

---

## 6. Conclusion
This project illustrates:

- Multiple ways to describe combinational logic in Verilog
- The difference between logical operators and gate-level modeling
- How Verilog code behaves during simulation and synthesis
