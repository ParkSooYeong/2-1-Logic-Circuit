# Verilog Testbench Example – Design_Unit

## 📌 Overview

This project provides a simple Verilog testbench for verifying a basic digital design module (`Design_Unit`).
The testbench is designed to simulate input stimulus, observe output behavior, and generate waveform data for analysis.

> ⚠️ Note: This project focuses on simulation only. It is **not intended for synthesis in FPGA tools such as Quartus**.

---

## 🧱 Testbench Structure

The testbench includes the following components:

* **Stimulus signals** (`t_A`, `t_B`, `t_select`)
* **Response signal** (`t_m_out`)
* **Unit Under Test (UUT)** instantiation
* Input stimulus generation using `initial` blocks
* Periodic toggling of the `select` signal
* Console monitoring using `$monitor`
* Waveform generation using `$dumpfile` and `$dumpvars`

---

## ⚙️ Simulation Behavior

### Input Signals

* `t_A`, `t_B`: Input data signals
* `t_select`: Control signal (toggled every 10ns)

### Output Signal

* `t_m_out`: Output from the design module

### Stimulus Flow

1. Initialize all inputs to `0`
2. Apply different input combinations over time
3. Toggle `t_select` periodically using a `forever` loop
4. End simulation after a fixed duration

---

## ⏱️ Timing Diagram Concept

* `t_select` toggles every **10ns**
* Input combinations change every **10ns**
* Output reflects selected input based on `t_select`

---

## 🧪 Simulation Setup

### Requirements

* Verilog simulator (e.g., ModelSim, QuestaSim, Vivado Simulator)

### Run Simulation

1. Compile the design module (`Design_Unit`)
2. Compile the testbench (`t_Design_Unit`)
3. Run simulation
4. Open waveform file (`wave.vcd`)

---

## 📊 Waveform Output

The testbench generates a VCD file:

```
wave.vcd
```

You can view it using waveform viewers such as:

* GTKWave
* ModelSim waveform viewer

---

## ⚠️ Important Notes

* This testbench uses simulation-only constructs:

  * `initial`
  * `#delay`
  * `forever`
  * `$monitor`, `$dumpfile`, `$dumpvars`
* These constructs are **not synthesizable**

---

## 🎯 Purpose

This project is intended for:

* Learning Verilog testbench structure
* Practicing simulation-based verification
* Understanding input stimulus and waveform analysis

---

## 📎 Example Use Case

This testbench is suitable for verifying simple combinational logic such as:

* Multiplexers (MUX)
* Basic logic gates
* Small digital modules
