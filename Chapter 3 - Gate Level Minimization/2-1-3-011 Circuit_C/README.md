# Circuit_C

## 1. Overview
This project demonstrates different ways to describe combinational logic in Verilog.
The circuit has two inputs (`a`, `b`) and three outputs (`y1`, `y2`, `y3`).

Each output is implemented using a different Verilog description style.

---

## 2. File Description

### Circuit_C.v
Top-level Verilog module implementing simple combinational logic.

- y1 : Implemented using the logical OR operator (`||`)
- y2 : Implemented using an AND gate primitive
- y3 : Implemented using the logical AND operator (`&&`)

### Circuit_C_tb.v
Testbench file for functional verification.

- Applies all possible input combinations of `a` and `b`
- Observes outputs `y1`, `y2`, and `y3` through waveform simulation
- Used only for simulation (not synthesized)

---

## 3. Functional Description

Truth table of the circuit:

| a | b | y1 | y2 | y3 |
|---|---|----|----|----|
| 0 | 0 | 0  | 0  | 0  |
| 0 | 1 | 1  | 0  | 0  |
| 1 | 0 | 1  | 0  | 0  |
| 1 | 1 | 1  | 1  | 1  |

- y1 = a OR b  
- y2 = a AND b (gate-level primitive)  
- y3 = a AND b (logical operator)

---

## 4. Simulation Result
Simulation waveforms confirm that:

- y1 performs a correct OR operation
- y2 performs a correct AND operation using a gate primitive
- y3 performs a correct AND operation using a logical operator

All outputs match the expected truth table.

---

## 5. Notes

- Logical operators (`||`, `&&`) evaluate expressions as boolean values
- Gate primitives describe explicit hardware gates
- For single-bit signals, both methods produce identical logic
- Differences become important for multi-bit signals

---

## 6. Conclusion
This project demonstrates:

- Multiple Verilog modeling styles
- Logical vs gate-level description
- Correct functional behavior through simulation
