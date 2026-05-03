# Verilog D Flip-Flop (Positive Edge Triggered) – Simulation & Analysis

## 📌 Overview

This project implements a **positive edge-triggered D Flip-Flop** using Verilog and verifies its behavior through simulation and RTL synthesis.

The D Flip-Flop is a fundamental sequential logic element that captures input data (`D`) on the **rising edge of the clock (`clk`)** and holds that value until the next rising edge.

---

## 🧱 Design Description

### 🔹 Module: `D_Flip_Flop`

```verilog
module D_Flip_Flop (Q, D, clk);
    input D, clk;
    output Q;
    reg Q;
    
    always @ (posedge clk)
        Q <= D;
endmodule
```

---

## 📥 Inputs

* `D` : Data input
* `clk` : Clock signal (rising edge triggered)

---

## 📤 Output

* `Q` : Stored output value

---

## ⚙️ Functionality

| Clock Edge      | Behavior                 |
| --------------- | ------------------------ |
| Rising edge (↑) | `Q <= D`                 |
| Otherwise       | `Q` holds previous value |

---

## 🧪 Testbench Description

The testbench is designed to:

* Generate a periodic clock signal
* Apply various transitions to `D`
* Verify that:

  * `Q` updates **only at rising edges**
  * `Q` remains stable between clock edges

---

## 📊 Simulation Results

### 🔹 Waveform Analysis

From the simulation waveform:

---

### 1️⃣ Rising Edge Triggering

* Output `Q` changes **only at the rising edge of `clk`**
* Even if `D` changes multiple times between edges, `Q` does not update immediately

---

### 2️⃣ Data Sampling

* At each rising edge:

  * `Q` captures the current value of `D`
* This confirms correct edge-triggered behavior

---

### 3️⃣ Hold Behavior

* Between clock edges:

  * `Q` remains constant
  * Independent of changes in `D`

---

### 4️⃣ Timing Observation

* The waveform clearly shows:

  * `D` transitions occurring between clock edges
  * `Q` updating strictly at synchronization points (clock edges)

---

## 🧠 RTL Schematic Interpretation

The synthesized RTL diagram shows:

* A **register element (Q~reg0)** inferred
* Inputs:

  * `D` connected to data input
  * `clk` connected to clock input
* Output:

  * `Q`

This confirms that the design is implemented as a **flip-flop (not a latch)**.

---

## ⚠️ Important Notes

### ❗ Edge-Triggered Device

* Unlike latches, this design responds **only to clock edges**
* Provides better timing predictability

---

### ❗ Non-blocking Assignment

```verilog
Q <= D;
```

* Ensures proper sequential logic behavior
* Prevents race conditions in synchronous designs

---

### ❗ Synchronous Design Advantage

* Flip-flops are preferred in:

  * FPGA designs
  * Synchronous digital systems
* Avoids issues common in latch-based designs

---

## 🔄 Latch vs Flip-Flop (Key Difference)

| Feature          | Latch                | Flip-Flop                  |
| ---------------- | -------------------- | -------------------------- |
| Trigger Type     | Level-sensitive      | Edge-triggered             |
| Timing Stability | Lower                | Higher                     |
| Control Signal   | Enable               | Clock                      |
| Usage            | Rare (special cases) | Standard in digital design |

---

## 🎯 Purpose

This project demonstrates:

* Implementation of a **sequential logic element**
* Understanding of **clock-driven behavior**
* Verification using **simulation waveform**
* Observation of **register inference in synthesis**

---

## 🚀 How to Run

1. Compile:

   * `D_Flip_Flop.v`
   * Testbench file
2. Run simulation (ModelSim / QuestaSim)
3. Observe:

   * `Q` updates only at clock rising edges
4. Verify RTL schematic in synthesis tool

---

## 📎 Conclusion

The design successfully demonstrates:

* Correct implementation of a **positive edge-triggered D Flip-Flop**
* Accurate synchronization of data with clock edges
* Proper sequential behavior validated through simulation
* Successful synthesis into a register element
