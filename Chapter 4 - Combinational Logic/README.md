# Verilog Gate-Level Circuit – Simulation & Testbench

## 📌 Overview

This project demonstrates the design and verification of a **combinational logic circuit** using **gate-level modeling in Verilog**.
A testbench is used to apply all possible input combinations and observe the corresponding outputs.

---

## 🧱 Design Description

### 🔹 Module: `Circuit_of_Fig_4_2`

This module is implemented using **basic logic gates** such as:

* `AND`
* `OR`
* `NOT`

### 📥 Inputs

* `A`, `B`, `C` : 3-bit input signals

### 📤 Outputs

* `F1`, `F2` : Output signals

---

### ⚙️ Internal Logic

#### Intermediate Signals

* `T1 = A OR B OR C`
* `T2 = A AND B AND C`
* `E1 = A AND B`
* `E2 = A AND C`
* `E3 = B AND C`
* `F2 = E1 OR E2 OR E3`
* `F2_b = NOT(F2)`
* `T3 = T1 AND F2_b`
* `F1 = T2 OR T3`

---

## 🧪 Testbench Description

### 🔹 Module: `test_circuit`

The testbench performs:

* Exhaustive input testing (all possible combinations)
* Automatic input generation using binary counting
* Output monitoring using `$monitor`

---

## 🔄 Stimulus Method

```verilog
D = 3'b000;
repeat (7) #10 D = D + 1'b1;
```

* Starts from `000`
* Increments input every **10 ns**
* Covers all **8 possible combinations (000 ~ 111)**

---

## 📊 Simulation Results

### 📝 Simulation Log

```text
ABC = 000 F1 = 0 F2 = 0
ABC = 001 F1 = 1 F2 = 0
ABC = 010 F1 = 1 F2 = 0
ABC = 011 F1 = 0 F2 = 1
ABC = 100 F1 = 1 F2 = 0
ABC = 101 F1 = 0 F2 = 1
ABC = 110 F1 = 0 F2 = 1
ABC = 111 F1 = 1 F2 = 1
```

---

## ✅ Result Analysis

### 🔹 Output `F2`

* `F2 = 1` when **at least two inputs are 1**
* Equivalent to a **majority function**

---

### 🔹 Output `F1`

* `F1 = 1` when:

  * all inputs are `1` (`111`), or
  * only one input is `1` (`001`, `010`, `100`)
* `F1 = 0` when exactly two inputs are `1`

👉 This creates a complementary behavior relative to `F2` in certain cases.

---

## ⚠️ Important Notes

* The testbench uses simulation-only constructs:

  * `initial`
  * `#delay`
  * `$monitor`
* These are **not synthesizable** and are only used for verification

---

## 🎯 Purpose

This project is intended for:

* Understanding **gate-level modeling in Verilog**
* Practicing **exhaustive testing**
* Analyzing **combinational logic behavior**
* Learning how to interpret simulation results

---

## 🚀 How to Run

1. Compile:

   * `Circuit_of_Fig_4_2`
   * `test_circuit`
2. Run simulation using:

   * ModelSim / QuestaSim / Vivado Simulator
3. Observe:

   * Console output (`$monitor`)
   * Waveform (optional)

---

## 📎 Conclusion

This project verifies a combinational logic circuit using:

* Gate-level design
* Exhaustive input testing
* Simulation-based validation

The results confirm that the circuit behaves correctly according to the defined logic expressions.
