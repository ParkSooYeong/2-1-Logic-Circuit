# 8_Bit_Adder (Gate-Level Ripple Carry Adder)

## 1. Project Overview

This project implements an **8-bit Ripple Carry Adder (RCA)** using **gate-level Verilog**.
The design is hierarchically constructed from basic building blocks:

- Half Adder
- Full Adder
- 4-bit Ripple Carry Adder
- 8-bit Ripple Carry Adder (Top-Level)

All modules are written structurally to clearly demonstrate **carry propagation behavior**.

---

## 2. File Structure

- `Add_half.v`  
  Gate-level Half Adder using XOR and AND gates

- `Add_full.v`  
  Full Adder constructed from two Half Adders and an OR gate

- `Add_rca_4.v`  
  4-bit Ripple Carry Adder built from four Full Adders

- `Add_rca_8.v`  
  **Top-Level Module**  
  8-bit Ripple Carry Adder built from two 4-bit RCAs

- `Add_rca_8_tb.v`  
  Testbench for functional simulation of the 8-bit adder

- `README.md`  
  Project documentation

---

## 3. Module Description

### 3.1 Half Adder (`Add_half`)

**Function**
- Adds two 1-bit inputs

**Logic**
- Sum = A ⊕ B
- Carry = A · B

**Ports**
- `a`, `b` : 1-bit inputs
- `sum`    : sum output
- `c_out`  : carry output

---

### 3.2 Full Adder (`Add_full`)

**Function**
- Adds two 1-bit inputs and a carry-in

**Structure**
- Two Half Adders
- One OR gate for carry combination

**Ports**
- `a`, `b`, `c_in` : inputs
- `sum`           : sum output
- `c_out`         : carry output

---

### 3.3 4-bit Ripple Carry Adder (`Add_rca_4`)

**Function**
- Adds two 4-bit numbers with carry propagation

**Structure**
- Four cascaded Full Adders
- Carry ripples from LSB to MSB

**Ports**
- `a[3:0]`, `b[3:0]` : inputs
- `c_in`             : carry input
- `sum[3:0]`         : sum output
- `c_out`            : carry output

---

### 3.4 8-bit Ripple Carry Adder (`Add_rca_8`) — Top-Level

**Function**
- Adds two 8-bit numbers

**Structure**
- Lower 4-bit RCA (bits 0–3)
- Upper 4-bit RCA (bits 4–7)
- Carry-out of lower RCA feeds carry-in of upper RCA

**Ports**
- `a[7:0]`, `b[7:0]` : inputs
- `c_in`             : carry input
- `sum[7:0]`         : sum output
- `c_out`            : final carry output

---

## 4. Top-Level Entity

The **Top-Level Entity** of this project is:`Add_rca_8`


### Quartus Settings
1. Open **Assignments → Settings**
2. Go to **General**
3. Set **Top-level entity** to:`Add_rca_8`

4. Apply and recompile

---

## 5. Simulation

### Testbench
- File: `Add_rca_8_tb.v`
- Applies multiple test vectors:
- Zero addition
- Normal addition
- Carry propagation cases
- Overflow cases
- Carry-in enabled cases

### Key Verification Points
- `sum = a + b + c_in`
- Proper carry propagation across all 8 bits
- Correct `c_out` assertion on overflow

---

## 6. Observations

- Carry propagation delay increases linearly with bit-width
- The waveform clearly shows ripple behavior from LSB to MSB
- Demonstrates the main limitation of Ripple Carry Adders in high-speed designs

---

## 7. Conclusion

This project provides a clear, gate-level implementation of an 8-bit Ripple Carry Adder.
It is well-suited for:

- Understanding hierarchical digital design
- Studying carry propagation
- Learning structural Verilog modeling
- Introductory FPGA and logic design experiments

---

## 8. Future Improvements

- Implement Carry Look-Ahead Adder (CLA)
- Compare timing performance with RCA
- Add parameterized N-bit adder
- Include post-synthesis timing simulation
