# Verilog D Latch (Level-Sensitive, ANSI Style) – Simulation & Analysis

## 📌 Overview

This project implements and verifies a **level-sensitive D latch** using Verilog with **ANSI-style port declaration**.
The latch updates its output when enabled and retains its value when disabled.

---

## 🧱 Design Description

### 🔹 Module: `D_latch_2`

```verilog
module D_latch_2 (input enable, D, output reg Q);
    always @ (enable, D)
        if (enable) Q <= D;
endmodule
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
* Output response to input changes
* Stability during disabled state

---

## 📊 Simulation Results

### 🔹 Waveform Analysis

From the simulation waveform:

---

### 1️⃣ Enable = 1 (Transparent Mode)

* Output `Q` follows input `D`
* Any transition in `D` is immediately reflected in `Q`

---

### 2️⃣ Enable = 0 (Latch / Hold Mode)

* Output `Q` remains constant
* Changes in `D` do **not** affect `Q`

---

### 3️⃣ State Retention

* When `enable` transitions from `1 → 0`,
  the last value of `D` is stored in `Q`

---

### 4️⃣ Re-Enable Behavior

* When `enable` returns to `1`,
  `Q` resumes tracking `D`

---

## 🧠 Circuit Interpretation

### 🔹 Synthesized Structure

The circuit is implemented as a **level-sensitive latch**:

```text
if (enable)
    Q = D
else
    Q = Q (hold previous value)
```

* No clock signal
* Behavior depends on **signal level**, not edge

---

## ⚠️ Important Notes

### ❗ Level-Sensitive Device

* This is a **latch**, not a flip-flop
* Output changes whenever `enable = 1`

---

### ❗ Design Considerations

* Can introduce **timing hazards**
* Sensitive to glitches on `D` when enabled
* Generally avoided in synchronous FPGA design unless necessary

---

### ❗ Coding Style

* Uses **ANSI-style port declaration**
* Equivalent hardware to traditional style (`D_latch_1`)

---

## 🎯 Purpose

This project is intended for:

* Understanding **latch behavior in Verilog**
* Learning **level-sensitive storage elements**
* Comparing coding styles in HDL
* Practicing **simulation and waveform analysis**

---

## 🚀 How to Run

1. Compile:

   * `D_latch_2`
   * Testbench module
2. Run simulation using:

   * ModelSim / QuestaSim / Vivado Simulator
3. Observe waveform:

   * `Q` follows `D` when enabled
   * `Q` holds value when disabled

---

## 📎 Conclusion

This project successfully demonstrates:

* Correct implementation of a **D latch**
* Proper enable-controlled data storage behavior
* Clear distinction between **transparent** and **hold** modes
* Equivalent functionality across different Verilog coding styles
