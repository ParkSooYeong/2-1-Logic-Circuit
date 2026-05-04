# Verilog D Flip-Flop with Asynchronous Reset – Simulation & Analysis

## 📌 Overview

This project implements a **positive edge-triggered D Flip-Flop with asynchronous active-low reset** using Verilog.
The design captures input data (`D`) on the rising edge of the clock (`clk`) and immediately resets the output (`Q`) when the reset signal (`rst`) is asserted low.

---

## 🧱 Design Description

### 🔹 Module: `D_Flip_Flop_2`

```verilog id="y7b4zx"
module D_Flip_Flop_2 (input D, clk, rst, output reg Q);
    always @ (posedge clk, negedge rst)
        if (!rst) Q <= 1'b0;   // Asynchronous active-low reset
        else Q <= D;           // Capture data on rising clock edge
endmodule
```

---

## 📥 Inputs

* `D` : Data input
* `clk` : Clock signal (rising edge triggered)
* `rst` : Asynchronous reset (active-low)

---

## 📤 Output

* `Q` : Registered output

---

## ⚙️ Functionality

| Condition           | Behavior                  |
| ------------------- | ------------------------- |
| `rst = 0`           | `Q = 0` (immediate reset) |
| `rst = 1` & `clk ↑` | `Q <= D`                  |
| Otherwise           | `Q` holds previous value  |

---

## 🧪 Testbench Description

The testbench verifies:

* Normal flip-flop operation under clock control
* Immediate reset behavior (without waiting for clock)
* Proper recovery after reset release
* Stability of `Q` between clock edges

---

## 📊 Simulation Results

### 🔹 Waveform Analysis

From the simulation waveform:

---

### 1️⃣ Normal Operation (rst = 1)

* `Q` updates only at **rising edges of `clk`**
* `D` is sampled synchronously

---

### 2️⃣ Asynchronous Reset (rst = 0)

* When `rst` goes LOW:

  * `Q` is **immediately forced to 0**
  * No clock edge is required

---

### 3️⃣ Reset Release

* When `rst` returns to HIGH:

  * Flip-flop resumes normal operation
  * Next `clk ↑` determines new `Q`

---

### 4️⃣ Stability Between Edges

* Between clock edges:

  * `Q` remains constant
  * Independent of changes in `D`

---

## 🧠 RTL Schematic Interpretation

The synthesized RTL diagram shows:

* A **register element (Q~reg0)**
* Inputs:

  * `D` → Data input
  * `clk` → Clock input
  * `rst` → Connected to **CLR (clear)** input
* Output:

  * `Q`

This confirms:

* The reset is implemented as a **hardware clear signal**
* The design is a **true flip-flop (not a latch)**

---

## ⚠️ Important Notes

### ❗ Asynchronous Reset Behavior

* Reset is **not synchronized with clock**
* Faster response but may introduce:

  * Glitches
  * Metastability risks if improperly used

---

### ❗ Sensitivity List

```verilog id="rm1l9n"
always @ (posedge clk, negedge rst)
```

* Triggered by:

  * Rising edge of `clk`
  * Falling edge of `rst`

---

### ❗ Non-blocking Assignment

```verilog id="u2t8qk"
Q <= D;
```

* Ensures correct sequential logic behavior

---

## 🔄 Reset Types Comparison

| Feature   | Asynchronous Reset | Synchronous Reset                |
| --------- | ------------------ | -------------------------------- |
| Trigger   | Immediate          | Clock edge                       |
| Speed     | Fast               | Slower                           |
| Stability | Lower              | Higher                           |
| Usage     | Initialization     | Preferred in synchronous systems |

---

## 🎯 Purpose

This project demonstrates:

* Implementation of **edge-triggered sequential logic**
* Integration of **asynchronous reset mechanism**
* Verification through **timing waveform analysis**
* Observation of **register with clear input in synthesis**

---

## 🚀 How to Run

1. Compile:

   * `D_Flip_Flop_2.v`
   * Testbench file
2. Run simulation (ModelSim / QuestaSim)
3. Observe waveform:

   * Immediate reset behavior
   * Edge-triggered data capture
4. Check RTL viewer:

   * Confirm register with clear input

---

## 📎 Conclusion

The design successfully demonstrates:

* Correct operation of a **D Flip-Flop with asynchronous reset**
* Immediate response to reset signal
* Accurate synchronization with clock edges during normal operation
* Proper synthesis into a register with clear functionality
