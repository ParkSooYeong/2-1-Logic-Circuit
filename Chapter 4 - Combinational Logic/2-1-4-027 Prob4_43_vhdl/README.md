# VHDL Conditional Logic with Tri-State Output – Simulation & Analysis

## 📌 Overview

This project implements and verifies a **conditional logic circuit with enable control and tri-state output** using VHDL.
The design uses **behavioral modeling** and is validated through simulation and waveform analysis.

---

## 🧱 Design Description

### 🔹 Module: `Prob4_43_vhdl`

The circuit is defined using a **conditional signal assignment**:

```vhdl id="k2d8sj"
Q <= A when S = '1' and E = '1'
     else '0' when S = '0' and E = '1'
     else 'Z';
```

---

## 📥 Inputs

* `A` : Input signal
* `S` : Select signal
* `E` : Enable signal

---

## 📤 Output

* `Q` : Output signal (supports tri-state)

---

## ⚙️ Functionality

| Enable (E) | Select (S) | Output (Q) |
| ---------- | ---------- | ---------- |
| 0          | X          | Z (High-Z) |
| 1          | 1          | A          |
| 1          | 0          | 0          |

---

## 🧪 Testbench Description

The testbench verifies:

* Enable/disable behavior
* Select-based output control
* High-impedance (`Z`) state
* Dynamic changes in input `A`

---

## 📊 Simulation Results

### 🔹 Waveform Analysis

From the simulation waveform:

---

### 1️⃣ Disabled State (`E = 0`)

* Output `Q = Z`
* Independent of `A` and `S`
* Confirms correct tri-state behavior

---

### 2️⃣ Enabled + Select = 1 (`E = 1, S = 1`)

* Output follows input `A`
* Changes in `A` are reflected immediately in `Q`

---

### 3️⃣ Enabled + Select = 0 (`E = 1, S = 0`)

* Output is forced to `'0'`
* Independent of input `A`

---

### 4️⃣ Transition Behavior

* When `E` toggles:

  * Output switches between valid logic and high-impedance
* When `S` toggles:

  * Output switches between `A` and constant `'0'`

---

## 🧠 Circuit Interpretation

### 🔹 Synthesized Structure

Based on the schematic:

* **AND gates**

  * Generate conditions: `S·E`, `S'·E`

* **Multiplexer-like structure**

  * Selects between:

    * `A`
    * Constant `'0'`

* **Tri-state buffer**

  * Controlled by `E`
  * Outputs:

    * Valid data when enabled
    * High-impedance when disabled

👉 Logical structure:

```id="q9x2mf"
Conditional Logic → Enable Control → Output (Tri-State)
```

---

## ⚠️ Important Notes

* `'Z'` represents **high-impedance state**

* This is commonly used in:

  * Bus systems
  * Shared signal lines

* The design is **not a standard MUX**

  * Unlike typical MUX:

    * `S = 0` → selects `B`
  * Here:

    * `S = 0` → outputs constant `'0'`

---

## 🎯 Purpose

This project is intended for:

* Understanding **VHDL conditional assignment**
* Learning **tri-state logic behavior**
* Practicing **simulation-based verification**
* Analyzing **non-standard multiplexer structures**

---

## 🚀 How to Run

1. Compile:

   * `Prob4_43_vhdl`
   * Testbench module
2. Run simulation using:

   * ModelSim / QuestaSim / Vivado Simulator
3. Observe:

   * Waveform (`Q = Z`, `0`, `A`)
   * Signal transitions

---

## 📎 Conclusion

This project successfully demonstrates:

* Conditional logic design using VHDL
* Proper enable-controlled tri-state behavior
* Accurate simulation results matching expected logic

The circuit highlights how simple conditions can create flexible and efficient digital logic structures.
