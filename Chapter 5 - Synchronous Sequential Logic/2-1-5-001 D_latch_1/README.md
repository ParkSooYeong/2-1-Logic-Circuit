# Verilog D Latch (Level-Sensitive) – Simulation & Analysis

## 📌 Overview

This project implements and verifies a **level-sensitive D latch** using Verilog.
The latch captures the input data (`D`) when the enable signal is active and holds its value when the enable is inactive.

---

## 🧱 Design Description

### 🔹 Module: `D_latch_1`

```verilog
always @ (enable, D)
    if (enable) Q <= D;
```

---

## 📥 Inputs

* `D` : Data input
* `enable` : Latch enable signal

---

## 📤 Output

* `Q` : Latched output

---

## ⚙️ Functionality

| Enable | Behavior                   |
| ------ | -------------------------- |
| 1      | `Q = D` (transparent mode) |
| 0      | `Q` holds previous value   |

---

## 🧪 Testbench Description

The testbench verifies:

* Transparent behavior when `enable = 1`
* Hold (memory) behavior when `enable = 0`
* Response to changes in input `D`

---

## 📊 Simulation Results

### 🔹 Waveform Analysis

Based on the simulation waveform:

---

### 1️⃣ Enable = 1 (Transparent Mode)

* Output `Q` follows input `D`
* Any change in `D` is immediately reflected in `Q`

---

### 2️⃣ Enable = 0 (Latch Mode)

* Output `Q` remains constant
* Changes in `D` do **not** affect `Q`

---

### 3️⃣ Transition Behavior

* When `enable` transitions from `1 → 0`:

  * The last value of `D` is stored in `Q`
* When `enable` transitions from `0 → 1`:

  * The latch becomes transparent again

---

## 🧠 Circuit Interpretation

### 🔹 Synthesized Structure

The latch is implemented as:

* A **storage element (latch)**
* Controlled by the `enable` signal

Conceptually:

```text
if (enable)
    Q = D
else
    Q = Q (hold)
```

---

## ⚠️ Important Notes

### ❗ Level-Sensitive Behavior

* This is **not edge-triggered**
* Output depends on the **level of `enable`**, not transitions

---

### ❗ Potential Issues

* Sensitive to glitches when `enable = 1`
* Can cause unintended behavior in synchronous designs

---

### ❗ Synthesis Warning

* Latches are generally avoided in FPGA design unless explicitly required

---

## 🎯 Purpose

This project is intended for:

* Understanding **latch behavior**
* Learning the difference between:

  * Latch (level-sensitive)
  * Flip-flop (edge-triggered)
* Practicing **simulation-based verification**

---

## 🚀 How to Run

1. Compile:

   * `D_latch_1`
   * Testbench module
2. Run simulation using:

   * ModelSim / QuestaSim / Vivado Simulator
3. Observe waveform:

   * `Q` follows `D` when enabled
   * `Q` holds value when disabled

---

## 📎 Conclusion

This project successfully demonstrates:

* The behavior of a **level-sensitive D latch**
* Correct operation of enable-controlled data storage
* Proper verification through simulation waveform analysis
