# Verilog 2-to-1 Multiplexer (Dataflow) – Testbench & Simulation

## 📌 Overview

This project demonstrates the design and verification of a **2-to-1 multiplexer (MUX)** using Verilog dataflow modeling.
A dedicated testbench is used to apply input patterns and validate the functionality through simulation.

---

## 🧱 Design Description

### 🔹 Module: `mux_2x1_df`

The multiplexer is implemented using **dataflow modeling**:

```verilog
assign m_out = (sel) ? A : B;
```

### 📥 Inputs

* `A` : Input data 0
* `B` : Input data 1
* `sel` : Select signal

### 📤 Output

* `m_out` : Selected output

### ⚙️ Functionality

* If `sel = 1` → `m_out = A`
* If `sel = 0` → `m_out = B`

---

## 🧪 Testbench Description

### 🔹 Module: `t_mux_2x1_df`

The testbench is responsible for:

* Generating input stimulus
* Monitoring output changes
* Ending simulation automatically

---

### ⚡ Stimulus Sequence

| Time (ns) | sel | A | B |
| --------- | --- | - | - |
| 0         | 1   | 0 | 1 |
| 10        | 1   | 1 | 0 |
| 20        | 0   | 1 | 0 |
| 30        | 0   | 0 | 1 |

---

### 🖥️ Monitoring

The following system task is used:

```verilog
$monitor ("time = ", $time, "t_sel = %b t_A = %b t_B = %b t_mux_out = %b", t_sel, t_A, t_B, t_mux_out);
```

This continuously prints signal values whenever a change occurs.

---

### ⏱️ Simulation Control

```verilog
parameter stop_time = 50;
initial #stop_time $finish;
```

* Simulation automatically ends at **50 ns**

---

## 📊 Simulation Results

### 📝 Simulation Log

```text
time = 0  sel = 1  A = 0  B = 1  OUT = 0
time = 10 sel = 1  A = 1  B = 0  OUT = 1
time = 20 sel = 0  A = 1  B = 0  OUT = 0
time = 30 sel = 0  A = 0  B = 1  OUT = 1
```

---

## ✅ Result Analysis

The simulation results confirm correct MUX behavior:

* **Time 0**: `sel=1` → output follows `A` → `0` ✔️
* **Time 10**: `sel=1` → output follows `A` → `1` ✔️
* **Time 20**: `sel=0` → output follows `B` → `0` ✔️
* **Time 30**: `sel=0` → output follows `B` → `1` ✔️

👉 The design operates exactly as expected.

---

## ⚠️ Important Notes

* The testbench uses simulation-only constructs:

  * `initial`
  * `#delay`
  * `$monitor`
* These are **not synthesizable** and should not be used in FPGA synthesis.

---

## 🎯 Purpose

This project is intended for:

* Understanding **dataflow modeling in Verilog**
* Learning **testbench design**
* Practicing **functional verification via simulation**

---

## 🚀 How to Run

1. Compile both modules:

   * `mux_2x1_df`
   * `t_mux_2x1_df`
2. Run simulation using a Verilog simulator:

   * ModelSim / QuestaSim / Vivado Simulator
3. Observe console output and/or waveform

---

## 📎 Conclusion

This project successfully demonstrates:

* A clean implementation of a 2-to-1 multiplexer
* Effective verification using a structured testbench
* Accurate simulation results matching theoretical behavior
