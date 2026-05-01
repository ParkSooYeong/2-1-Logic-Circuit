# VHDL D Latch (Level-Sensitive) – Simulation & Analysis

## 📌 Overview

This project implements and verifies a **level-sensitive D latch** using VHDL.
The latch stores input data (`D`) when the enable signal is active and holds the value when the enable is inactive.

---

## 🧱 Design Description

### 🔹 Module: `D_latch_vhdl`

```vhdl
process (enable, D)
begin
    if enable = '1' then
        Q <= D;
    end if;
end process;
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
| '1'    | `Q = D` (transparent mode) |
| '0'    | `Q` holds previous value   |

---

## 🧪 Testbench Description

The testbench verifies:

* Transparent behavior when `enable = '1'`
* Hold behavior when `enable = '0'`
* Output stability during disabled state
* Response to dynamic input changes

---

## 📊 Simulation Results

### 🔹 Waveform Analysis

Based on the simulation waveform:

---

### 1️⃣ Enable = '1' (Transparent Mode)

* Output `Q` follows input `D`
* Any transition in `D` is immediately reflected in `Q`

---

### 2️⃣ Enable = '0' (Latch / Hold Mode)

* Output `Q` remains constant
* Changes in `D` do **not** affect `Q`

---

### 3️⃣ State Retention

* When `enable` transitions from `'1' → '0'`,
  the last value of `D` is stored in `Q`

---

### 4️⃣ Re-Enable Behavior

* When `enable` returns to `'1'`,
  `Q` resumes tracking `D`

---

## 🧠 Circuit Interpretation

### 🔹 Synthesized Structure

The RTL schematic confirms:

* A **latch block (Q$latch)** is inferred
* Inputs:

  * `DATAIN` ← `D`
  * `LATCH_ENABLE` ← `enable`
* Output:

  * `Q`

Conceptually:

```text
if (enable = '1')
    Q = D
else
    Q = previous value
```

---

## ⚠️ Important Notes

### ❗ Latch Inference

* The absence of an `else` clause causes **implicit latch creation**
* This is intentional in this design

---

### ❗ Level-Sensitive Behavior

* This is **not edge-triggered**
* Output depends on the **level of `enable`**

---

### ❗ Design Considerations

* Latches can introduce:

  * Timing hazards
  * Glitch sensitivity
* Typically avoided in synchronous FPGA design unless necessary

---

## 🎯 Purpose

This project is intended for:

* Understanding **latch behavior in VHDL**
* Learning **process-based modeling**
* Practicing **simulation and waveform analysis**
* Observing **implicit memory element inference**

---

## 🚀 How to Run

1. Compile:

   * `D_latch_vhdl`
   * Testbench module
2. Run simulation using:

   * ModelSim / QuestaSim
3. Observe waveform:

   * `Q` follows `D` when enabled
   * `Q` holds value when disabled

---

## 📎 Conclusion

This project successfully demonstrates:

* Proper implementation of a **D latch in VHDL**
* Correct enable-controlled data storage behavior
* Accurate simulation results matching expected latch operation
* Successful synthesis into a latch structure
