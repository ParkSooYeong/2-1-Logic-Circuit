# Verilog Tri-State 2:1 Multiplexer – Simulation & Analysis

## 📌 Overview

This project implements and verifies a **2-bit 2-to-1 multiplexer with enable control** using Verilog.
The design includes a **tri-state output**, allowing the output to enter a high-impedance (`Z`) state when disabled.

---

## 🧱 Design Description

### 🔹 Module: `Prob4_43`

```verilog
assign Q = E ? (S ? A : B) : 'bz;
```

---

## 📥 Inputs

* `A [1:0]` : 2-bit input A
* `B [1:0]` : 2-bit input B
* `S` : Select signal
* `E` : Enable signal

---

## 📤 Output

* `Q [1:0]` : 2-bit output (supports tri-state)

---

## ⚙️ Functionality

| Enable (E) | Select (S) | Output (Q) |
| ---------- | ---------- | ---------- |
| 0          | X          | Z (High-Z) |
| 1          | 0          | B          |
| 1          | 1          | A          |

---

## 🧪 Testbench Description

The testbench verifies:

* MUX selection behavior
* Enable/disable functionality
* Tri-state (`Z`) output condition
* Dynamic input changes

---

## 🔄 Stimulus Summary

* Initial:

  * `A = 00`, `B = 11`
* Various combinations of:

  * `E` toggling (enable/disable)
  * `S` toggling (select A/B)
* Input values updated during simulation

---

## 📊 Simulation Results

### 🔹 Waveform Analysis

From the simulation waveform:

1. **Enable = 0 (Disabled State)**

   * Output `Q = ZZ`
   * Confirms correct tri-state behavior

2. **Enable = 1, Select = 0**

   * Output follows `B`
   * Example: `B = 11 → Q = 11`

3. **Enable = 1, Select = 1**

   * Output follows `A`
   * Example: `A = 10 → Q = 10`

4. **Input Change Reflection**

   * When `A` and `B` values change, output updates correctly depending on `S`

---

## 🧠 Circuit Interpretation

### 🔹 Structure (Based on Schematic)

The synthesized circuit consists of:

* A **2-to-1 multiplexer**

  * Controlled by `S`
  * Selects between `A` and `B`

* A **tri-state buffer**

  * Controlled by `E`
  * Outputs:

    * Data when enabled
    * High impedance (`Z`) when disabled

👉 This matches the expected hardware implementation:

```
MUX → Tri-State Buffer → Output
```

---

## ⚠️ Important Notes

* `'bz` represents **high-impedance state**

* Tri-state outputs are commonly used in:

  * Shared buses
  * I/O pins

* Simulation-only constructs used in testbench:

  * `initial`
  * `#delay`
  * `$monitor`
  * `$dumpvars`

---

## 🎯 Purpose

This project is intended for:

* Understanding **tri-state logic in Verilog**
* Learning **conditional assignment**
* Verifying **multi-bit signal behavior**
* Practicing **waveform analysis**

---

## 🚀 How to Run

1. Compile:

   * `Prob4_43`
   * Testbench module
2. Run simulation using:

   * ModelSim / QuestaSim / Vivado Simulator
3. Observe:

   * Waveform (`Q = ZZ` when disabled)
   * Console output

---

## 📎 Conclusion

This project successfully demonstrates:

* Correct implementation of a **2-bit multiplexer**
* Proper handling of **enable-controlled tri-state output**
* Accurate simulation results matching expected logic behavior
