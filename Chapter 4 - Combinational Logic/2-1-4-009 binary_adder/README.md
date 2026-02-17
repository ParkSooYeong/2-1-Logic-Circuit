# 4-Bit Binary Adder (Verilog Dataflow Modeling)

## 📌 Project Overview

This project implements a **4-bit binary adder** using Verilog dataflow modeling.

The design performs binary addition of:

- Two 4-bit inputs (`A`, `B`)
- One carry input (`C_in`)

and produces:

- 4-bit sum output (`sum`)
- Carry output (`C_out`)

The adder is implemented using a continuous assignment statement and synthesized using Quartus Prime.

---

## 🧩 Module Declaration

```verilog
// Dataflow description of four-bit adder
// Verilog 2001, 2005 module port syntax

module binary_adder(
    input  [3:0] A, B,
    input        C_in,
    output [3:0] sum,
    output       C_out
);

    assign {sum, C_out} = A + B + C_in;

endmodule
```

---

## 🔹 Port Description

| Signal | Width | Description |
|--------|--------|------------|
| A | 4-bit | First operand |
| B | 4-bit | Second operand |
| C_in | 1-bit | Carry input |
| sum | 4-bit | Sum output |
| C_out | 1-bit | Carry output |

---

## ⚙️ Design Description

The adder is implemented using a **dataflow modeling style**:

```verilog
assign {sum, C_out} = A + B + C_in;
```

### ✔ Explanation

- `{sum, C_out}` uses concatenation.
- The result of `A + B + C_in` produces a 5-bit value.
- The lower 4 bits are assigned to `sum`.
- The MSB (carry bit) is assigned to `C_out`.

This creates a combinational 4-bit ripple-carry adder structure during synthesis.

---

## 🏗 RTL Structure

From the RTL Viewer:

- The design is implemented using Cyclone IV logic cells.
- Internal carry-chain logic is inferred automatically.
- The synthesis tool optimizes the addition using dedicated FPGA carry logic.
- No flip-flops or sequential elements are generated.

The structure confirms a pure combinational implementation.

---

## 🧪 Simulation Results

Simulation verifies correct behavior for:

- Basic addition
- Carry generation
- Overflow cases
- Maximum input combinations

### Example Test Cases

| A | B | C_in | sum | C_out |
|----|----|------|------|--------|
| 0000 | 0000 | 0 | 0000 | 0 |
| 0101 | 0011 | 0 | 1000 | 0 |
| 0101 | 0011 | 1 | 1001 | 0 |
| 1111 | 0001 | 0 | 0000 | 1 |
| 1111 | 1111 | 1 | 1111 | 1 |

Waveform analysis confirms correct propagation of carry.

---

## 🛠 Tools Used

- Quartus Prime 15.1 Lite Edition
- ModelSim
- Verilog (IEEE 1364-2005)

---

## ⚠️ Important Notes

- The adder uses continuous assignment (combinational logic).
- No clock is required.
- Synthesis automatically infers optimized carry-chain hardware.
- This implementation is suitable for FPGA-based arithmetic logic.

---

## ✅ Conclusion

This project demonstrates:

- Verilog dataflow modeling
- 4-bit binary addition
- Carry propagation
- FPGA carry-chain inference
- RTL verification and simulation validation

The binary adder operates correctly under all tested input combinations.

---

## 👨‍💻 Author

Digital Logic Design Laboratory  
Verilog Dataflow Modeling Practice
