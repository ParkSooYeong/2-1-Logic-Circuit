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

---

# VHDL Testbench Example – Design_Unit

## 📌 Overview

This project demonstrates a simple VHDL testbench for verifying a digital design module (`Design_Unit`).
The testbench applies input stimulus, observes the output response, and helps validate the functional behavior of the design through simulation.

> ⚠️ Note: This testbench is intended for **simulation only** and is **not synthesizable**.

---

## 🧱 Testbench Architecture

The testbench is written using the following structure:

* **Entity (`t_Design_Unit`)**

  * Empty entity (no ports required for testbench)

* **Architecture (`Test_Bench`)**

  * Component declaration of the design under test (`Design_Unit`)
  * Internal signals for stimulus and response
  * UUT (Unit Under Test) instantiation
  * Processes to generate input signals

---

## ⚙️ Signal Description

### Input Signals (Stimulus)

* `t_A` : Input signal A
* `t_B` : Input signal B
* `t_sel` : Select/control signal

### Output Signal (Response)

* `t_m_out` : Output from the design module

---

## 🔄 Simulation Behavior

The testbench uses two processes:

### 1️⃣ Input Initialization Process

```vhdl
process begin
    t_A <= '1';
    t_B <= '0';
end process;
```

* Sets initial values for input signals

---

### 2️⃣ Select Signal Control Process

```vhdl
process begin
    sel <= '1';
    wait for 10 ns;
    sel <= '0';
end process;
```

* Toggles the select signal after 10 ns delay

---

## ⏱️ Timing Concept

* `t_A = 1`, `t_B = 0` (constant inputs)
* `sel` changes state after **10 ns**
* Output `t_m_out` responds based on input selection logic

---

## 🧪 Simulation Setup

### Requirements

* VHDL simulator (e.g., ModelSim, QuestaSim, Vivado Simulator)

### Steps

1. Compile the design unit (`Design_Unit`)
2. Compile the testbench (`t_Design_Unit`)
3. Run simulation
4. Observe waveform results

---

## 📊 Expected Behavior

If `Design_Unit` is implemented as a **2-to-1 multiplexer**:

* When `sel = '1'` → Output follows `A`
* When `sel = '0'` → Output follows `B`

---

## ⚠️ Important Notes

* The testbench uses:

  * `process`
  * `wait for`
* These constructs are **not synthesizable**
* This code is strictly for **functional verification**

---

## ❗ Known Issues in Current Code

* Signal `sel` is used instead of `t_sel` in the process
  → This may cause simulation errors unless corrected

Recommended fix:

```vhdl
t_sel <= '1';
wait for 10 ns;
t_sel <= '0';
```

* Processes do not include `wait` statements for repetition
  → Simulation may stop or behave unexpectedly

---

## 🎯 Purpose

This example is intended for:

* Learning VHDL testbench structure
* Understanding signal stimulus generation
* Practicing simulation-based verification

---

## 📎 Example Use Case

This testbench can be used to verify:

* Multiplexers (MUX)
* Simple combinational logic
* Basic digital circuits
