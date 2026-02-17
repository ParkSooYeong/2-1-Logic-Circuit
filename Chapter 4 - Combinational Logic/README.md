# 2x4 Decoder (VHDL Dataflow Modeling)

## 📌 Project Overview

This project implements a **2-to-4 line decoder** using VHDL Dataflow modeling.

The decoder includes:

- Two select inputs: `A`, `B`
- One enable input: `enable`
- Four outputs: `D(3 downto 0)`

The design was synthesized and verified using Quartus Prime and ModelSim.

---

## 🧩 Entity Declaration

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity decoder_2x4_df_vhdl is
    port (
        A, B, enable : in std_logic;
        D : out std_logic_vector (3 downto 0)
    );
end decoder_2x4_df_vhdl;
```

### 🔹 Port Description

| Signal | Type | Description |
|--------|------|------------|
| A | std_logic | Select input |
| B | std_logic | Select input |
| enable | std_logic | Active-low enable signal |
| D(3:0) | std_logic_vector | Decoder outputs |

---

## ⚙️ Architecture (Dataflow)

```vhdl
architecture Dataflow of decoder_2x4_df_vhdl is
begin
    D(0) <= not ((not A) and (not B) and (not enable));
    D(1) <= not (not A) and B and not enable;
    D(2) <= not (A and (not B) and (not enable));
    D(3) <= not (A and B and (not enable));
end Dataflow;
```

---

## 🔎 Functional Behavior

This decoder uses **active-low logic**:

- The enable signal is **active-low**
- Outputs are **active-low**

### ✔ When `enable = '0'`

The decoder operates normally and one output becomes LOW depending on the input combination.

| A | B | Active Output |
|---|---|--------------|
| 0 | 0 | D(0) |
| 0 | 1 | D(1) |
| 1 | 0 | D(2) |
| 1 | 1 | D(3) |

Only one output is driven LOW at a time.

---

### ✔ When `enable = '1'`

All outputs remain inactive (logic HIGH).

---

## 🏗 RTL Structure

From the RTL Viewer:

- Each output is implemented using AND gates and inverters.
- The design contains only combinational logic.
- No latches or flip-flops are inferred.
- Outputs are grouped into a bus `D(3 downto 0)`.

---

## 🧪 Simulation Results

Simulation confirms:

- Correct decoding for all input combinations
- Proper active-low enable behavior
- Stable combinational operation
- No timing or synthesis warnings

Waveform verification shows correct transitions at 10 ns intervals.

---

## 🛠 Tools Used

- Quartus Prime 15.1 Lite Edition
- ModelSim
- VHDL (IEEE 1076)
- IEEE `std_logic_1164` library

---

## ⚠️ Important Notes

- The design uses explicit `not` operators to implement active-low behavior.
- Always include:

```vhdl
library ieee;
use ieee.std_logic_1164.all;
```

Otherwise, `std_logic` will not be recognized during synthesis.

---

## ✅ Conclusion

This project demonstrates:

- VHDL Dataflow modeling
- Active-low decoder implementation
- RTL synthesis verification
- Functional simulation validation

The 2x4 decoder operates correctly under all tested conditions.

---

## 👨‍💻 Author

Digital Logic Design Laboratory  
VHDL Dataflow Modeling Practice
