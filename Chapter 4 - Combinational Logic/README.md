# Ripple Carry Adder (RCA) VHDL Project

## Overview

This project implements and verifies **Ripple Carry Adders (RCA)** using VHDL.
Both **textbook-style structural designs** and **custom implementations** are included and automatically compared using exhaustive testbenches.

The project targets **Quartus Prime 15.1 (Lite Edition)** and is intended for educational purposes in digital logic and HDL design.

---

## Project Structure

```
.
├── and2_gate.vhd                 # 2-input AND gate (Boolean equation)
├── or2_gate.vhd                  # 2-input OR gate (Boolean equation)
├── xor2_gate.vhd                 # 2-input XOR gate (Boolean equation)
│
├── add_half_vhdl.vhd             # Half adder (structural)
├── add_full_vhdl.vhd             # Full adder (structural)
│
├── add_rca_4_vhdl.vhd            # 4-bit ripple carry adder (custom implementation)
├── add_rca_8_vhdl.vhd            # 8-bit ripple carry adder (custom implementation)
│
├── ripple_carry_4_bit_adder_vhdl.vhd   # 4-bit RCA (textbook implementation)
│
├── add_rca_4_compare_tb.vhd      # 4-bit RCA comparison testbench
├── add_rca_8_compare_tb.vhd      # 8-bit RCA comparison testbench
│
└── README.md
```

---

## Design Description

### Ripple Carry Adder (RCA)

A ripple carry adder is a binary adder constructed by cascading full adders.
The carry-out of each bit propagates (ripples) to the next higher bit.

**Characteristics:**

* Simple structure
* Easy to design and understand
* Slower for large bit-widths due to carry propagation delay

---

## Verification Strategy

### Exhaustive Comparison Testbench

Both 4-bit and 8-bit adders are verified using **automatic comparison testbenches**.

#### Key Features

* All possible input combinations are tested
* Reference results are calculated using `numeric_std`
* DUT outputs are compared against reference arithmetic
* Assertion-based error checking

#### Test Coverage

| Adder     | Inputs Tested                |
| --------- | ---------------------------- |
| 4-bit RCA | A, B ∈ [0..15], Cin ∈ {0,1}  |
| 8-bit RCA | A, B ∈ [0..255], Cin ∈ {0,1} |

Total test cases for 8-bit RCA:

```
256 × 256 × 2 = 131,072 cases
```

---

## Simulation Result

Example successful simulation output:

```
# ** Note: === TEST PASSED : Add_rca_8_vhdl ===
#    Time: 1441792 ns  Iteration: 0  Instance: /add_rca_8_compare_tb
```

This indicates:

* All test cases completed
* No assertion failures
* Functional equivalence confirmed

---

## How to Run

1. Open **Quartus Prime 15.1**
2. Create or open the project
3. Add all `.vhd` files to the project
4. Set the desired top-level entity (for synthesis or simulation)
5. Run **Analysis & Synthesis**
6. Run simulation using ModelSim (or equivalent)

---

## Notes

* The testbenches are for **simulation only** and should not be synthesized.
* `numeric_std` is used instead of non-standard arithmetic packages.
* Initial `X` values in waveforms are normal before signal initialization.

---

## Conclusion

This project demonstrates a complete VHDL workflow:

* Gate-level design
* Structural composition
* Hierarchical adder construction
* Exhaustive functional verification

The successful comparison results confirm the correctness of the custom RCA implementations.

---

## License

This project is intended for educational use only.
