# VHDL Gate-Level Circuit (Structural) – Simulation & Testbench

## 📌 Overview

This project implements and verifies a **combinational logic circuit** using **structural modeling in VHDL**.
The design is built from basic logic gate components and tested using a dedicated testbench that applies all possible input combinations.

---

## 🧱 Design Description

### 🔹 Top Module: `Circuit_of_Fig_4_2_vhdl`

The circuit is constructed using **hierarchical structural design**, where smaller gate modules are combined to form a complete system.

---

## 🔧 Basic Gate Components

The following reusable components are defined:

* `or2_gate`  → 2-input OR
* `or3_gate`  → 3-input OR
* `and2_gate` → 2-input AND
* `and3_gate` → 3-input AND
* `not_gate`  → NOT

Each component is implemented using **dataflow modeling**.

---

## ⚙️ Internal Logic

### Intermediate Signals

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

## 📥 Inputs / 📤 Outputs

### Inputs

* `A`, `B`, `C` : Input signals (`std_logic`)

### Outputs

* `F1`, `F2` : Output signals (`std_logic`)

---

## 🧪 Testbench Description

### 🔹 Entity: `t_Circuit_of_Fig_4_2_vhdl`

* Empty entity (used only for simulation)

### 🔹 Architecture: `Test_Bench`

* Declares internal signals for stimulus and response
* Instantiates the UUT (Unit Under Test)
* Attempts to apply all input combinations (`000 ~ 111`)

---

## 🔄 Intended Stimulus Behavior

The goal of the testbench is to:

* Start from input `000`
* Increment inputs sequentially
* Cover all **8 possible input combinations**

---

## ⚠️ Issues in Current Code

The provided testbench contains several **syntactic and structural errors**:

---

### ❌ 1. Incorrect Signal Declaration

```vhdl
signal : T1, T2, T3, F2_b, E1, E2, E3 : std_logic;
```

✔ Correct form:

```vhdl
signal T1, T2, T3, F2_b, E1, E2, E3 : std_logic;
```

---

### ❌ 2. Missing `end component` Statements

Each component declaration must be properly closed:

```vhdl
component or2_gate
    port (x, y : in std_logic; w : out std_logic);
end component;
```

---

### ❌ 3. Invalid Integer Declaration

```vhdl
integer k range 0 to 7 : 0;
```

✔ Correct form:

```vhdl
signal k : integer range 0 to 7 := 0;
```

---

### ❌ 4. Invalid Vector Assignment

```vhdl
t_A & t_B & t_C <= '000';
```

* Cannot assign a vector to concatenated signals

---

### ❌ 5. Illegal `while` Loop in Architecture

```vhdl
while k <= 7 loop
```

* Must be inside a **process block**

---

### ❌ 6. Missing `process` Block for Stimulus

Stimulus must be written as:

```vhdl
process
begin
    -- stimulus here
end process;
```

---

## ✅ Recommended Correct Stimulus (Example)

```vhdl
process
begin
    for i in 0 to 7 loop
        t_A <= std_logic'val((i / 4) mod 2);
        t_B <= std_logic'val((i / 2) mod 2);
        t_C <= std_logic'val(i mod 2);
        wait for 10 ns;
    end loop;
    wait;
end process;
```

---

## 📊 Expected Behavior

### Output `F2`

* `F2 = 1` when **at least two inputs are 1**
* Equivalent to a **majority function**

### Output `F1`

* `F1 = 1` when:

  * exactly one input is `1`, or
  * all inputs are `1`

---

## 🎯 Purpose

This project is intended for:

* Learning **structural modeling in VHDL**
* Understanding **hierarchical circuit design**
* Practicing **testbench creation and debugging**
* Verifying combinational logic through simulation

---

## 🚀 How to Run

1. Compile all gate modules:

   * `or2_gate`, `or3_gate`
   * `and2_gate`, `and3_gate`
   * `not_gate`
2. Compile top module:

   * `Circuit_of_Fig_4_2_vhdl`
3. Compile testbench:

   * `t_Circuit_of_Fig_4_2_vhdl`
4. Run simulation using:

   * ModelSim / QuestaSim / Vivado Simulator

---

## 📎 Conclusion

This project demonstrates:

* A complete structural VHDL design using modular gate components
* The importance of correct testbench construction
* Common pitfalls in VHDL syntax and simulation setup
