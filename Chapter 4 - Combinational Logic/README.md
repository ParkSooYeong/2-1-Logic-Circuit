# 2x4 Decoder (Dataflow Modeling in Verilog)

## 📌 Project Overview

This project implements a **2-to-4 line decoder** using Verilog Dataflow modeling.

The decoder has:

- Inputs: `A`, `B`
- Enable input: `enable`
- Outputs: `D[0:3]`

The design was synthesized using Quartus Prime and verified through simulation.

---

## 🧩 Module Description

### 🔹 Port Definition

```verilog
module decoder_2x4_df(
    input A, B, enable,
    output [0:3] D
);
```

- `A`, `B` → Select inputs  
- `enable` → Active-low enable (based on logic expression)  
- `D[0:3]` → Decoder outputs  

---

## ⚙️ Logic Implementation

The design uses dataflow modeling with continuous assignments.

```verilog
assign D[0] = !((!A) && (!B) && (!enable)),
       D[1] = !((!A) && B && (!enable)),
       D[2] = ((A) && (!B) && (!enable)),
       D[3] = !(A && B && (!enable));
```

### 🔎 Important Note

Since the logic includes `(!enable)` inside AND terms,  
the decoder is effectively **active-low enabled**.

- When `enable = 0` → decoder operates normally  
- When `enable = 1` → outputs remain inactive  

---

## 🏗 RTL Structure

From the RTL Viewer:

- Each output is implemented using AND gates and inverters.
- Synthesis converts logic expressions into gate-level structures.
- Outputs are grouped as a bus `D[0:3]`.

The RTL schematic confirms:

- Proper decoding structure
- Gate-level realization of dataflow logic
- No latches inferred

---

## 🧪 Simulation Results

Simulation verifies correct operation for all input combinations.

### ✔ When `enable = 0`

| A | B | D[0] | D[1] | D[2] | D[3] |
|---|---|------|------|------|------|
| 0 | 0 | 0 | 1 | 1 | 1 |
| 0 | 1 | 1 | 0 | 1 | 1 |
| 1 | 0 | 1 | 1 | 1 | 1 |
| 1 | 1 | 1 | 1 | 1 | 0 |

One output becomes active (logic low) depending on input combination.

---

### ✔ When `enable = 1`

All outputs remain inactive due to the active-low enable condition.

---

## 🔬 Tools Used

- Quartus Prime 15.1 Lite Edition
- ModelSim
- Verilog (IEEE 1364-2001 / 2005)

---

## ⚠️ Observations

- The decoder outputs are **active-low**.
- Enable signal is also active-low.
- Gate-level implementation matches theoretical decoder behavior.
- No synthesis warnings or unintended hardware structures were observed.

---

## ✅ Conclusion

This project demonstrates:

- Dataflow modeling in Verilog
- Active-low enable decoder implementation
- Functional verification through waveform analysis
- Successful synthesis and RTL validation

The design correctly performs 2-to-4 decoding with active-low outputs.

---

## 👨‍💻 Author

Digital Logic Design Laboratory  
Verilog Dataflow Modeling Practice
