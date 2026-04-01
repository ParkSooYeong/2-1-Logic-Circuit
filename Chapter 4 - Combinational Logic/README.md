# VHDL 2-to-1 Multiplexer (Dataflow) – Testbench & Simulation

## 📌 Overview

This project demonstrates the verification of a **2-to-1 multiplexer (MUX)** implemented in VHDL using a testbench.
The testbench applies stimulus signals over time and observes the resulting output to validate correct functionality.

> ⚠️ Note: This testbench is intended for **simulation only** and is not synthesizable.

---

## 🧱 Design Description

### 🔹 Module: `mux_2x1_df_vhdl`

A 2-to-1 multiplexer selects one of two inputs based on a select signal.

### 📥 Inputs

* `A` : Input data 0
* `B` : Input data 1
* `sel` : Select signal

### 📤 Output

* `C` : Output signal

### ⚙️ Functionality

* If `sel = '1'` → `C = A`
* If `sel = '0'` → `C = B`

---

## 🧪 Testbench Description

### 🔹 Entity: `t_mux_2x1_df_vhdl`

* Empty entity (no ports required)
* Used only for simulation purposes

### 🔹 Architecture: `Dataflow`

Includes:

* Signal declarations for stimulus and response
* Component declaration of the DUT
* Stimulus generation process
* UUT instantiation

---

## ⚙️ Signal Description

### Input Signals (Stimulus)

* `t_A` : Input A
* `t_B` : Input B
* `t_sel` : Select signal

### Output Signal (Response)

* `t_C` : Output from the multiplexer

---

## 🔄 Stimulus Sequence

| Time (ns) | sel | A | B |
| --------- | --- | - | - |
| 0         | 1   | 0 | 1 |
| 10        | 1   | 1 | 0 |
| 20        | 0   | 1 | 0 |
| 30        | 0   | 0 | 1 |

---

## ⏱️ Simulation Behavior

The testbench uses a single process:

```vhdl id="gkz9qv"
process begin
    t_sel <= '1';
    t_A <= '0';
    t_B <= '1';
    wait for 10 ns;

    t_A <= '1';
    t_B <= '0';
    wait for 10 ns;

    t_sel <= '0';
    wait for 10 ns;

    t_A <= '0';
    t_B <= '1';
end process;
```

* Inputs are applied sequentially with **10 ns intervals**
* Output changes according to `sel`

---

## 📊 Expected Results

The output `C` should follow:

* When `sel = '1'` → output follows `A`
* When `sel = '0'` → output follows `B`

---

## ⚠️ Important Notes

### ❗ Issues in Current Code

1. **Signal Type Mismatch**

```vhdl id="8k0r9x"
signal t_sel : std_logic_vector (1 downto 0);
```

* `sel` in component is `std_logic`
* Should be:

```vhdl id="o2q9bx"
signal t_sel : std_logic;
```

---

2. **Unused Signal**

```vhdl id="9aj1j2"
signal t_mux_out : std_logic;
```

* Declared but not used

---

3. **Missing Library Declarations**
   You should include:

```vhdl id="z3l8nx"
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
```

---

## 🎯 Purpose

This project is intended for:

* Learning VHDL testbench design
* Understanding multiplexer behavior
* Practicing simulation-based verification

---

## 🚀 How to Run

1. Compile:

   * `mux_2x1_df_vhdl`
   * `t_mux_2x1_df_vhdl`
2. Run simulation using:

   * ModelSim / QuestaSim / Vivado Simulator
3. Observe waveform or simulation output

---

## 📎 Conclusion

This testbench successfully demonstrates:

* Structured stimulus generation in VHDL
* Verification of a 2-to-1 multiplexer
* Time-based signal control using `wait for`
