# 4x1 Multiplexer (VHDL - Behavioral)

## 📌 Overview
This project implements a **4-to-1 Multiplexer (MUX)** using **VHDL Behavioral modeling**.  
A multiplexer selects one of several input signals and forwards the selected input to a single output line based on the value of the select signal.

---

## 🧠 Design Description

### ✔ Entity
- **Inputs**
  - `in_0`, `in_1`, `in_2`, `in_3` : 1-bit data inputs
  - `sel` : 2-bit select signal
- **Output**
  - `m_out` : selected output

### ✔ Behavior
The output is determined by the `sel` signal as follows:

| sel | Output |
|-----|--------|
| 00  | in_0   |
| 01  | in_1   |
| 10  | in_2   |
| 11  | in_3   |

---

## 💻 VHDL Code

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity mux_4x1_beh_vhdl is
    port (
        in_0, in_1, in_2, in_3 : in std_logic;
        sel : in std_logic_vector (1 downto 0);
        m_out : out std_logic
    );
end mux_4x1_beh_vhdl;

architecture Behavioral of mux_4x1_beh_vhdl is
begin
    process (in_0, in_1, in_2, in_3, sel)
    begin
        case sel is
            when "00" => m_out <= in_0;
            when "01" => m_out <= in_1;
            when "10" => m_out <= in_2;
            when "11" => m_out <= in_3;
            when others => m_out <= '0';
        end case;
    end process;
end Behavioral;
```

---

## 🧪 Testbench Description

- All combinations of `sel` (00, 01, 10, 11) are tested
- Input patterns are changed during simulation to verify correct switching behavior

---

## 📊 Simulation Result

### ✔ Observations
- `sel = 00` → `m_out = in_0`
- `sel = 01` → `m_out = in_1`
- `sel = 10` → `m_out = in_2`
- `sel = 11` → `m_out = in_3`
- Output changes immediately with input or select changes (combinational logic)

---

## 🧩 Schematic

- The synthesized circuit shows:
  - A single multiplexer block
  - Four data inputs
  - One 2-bit select line controlling the output

---

## ✅ Conclusion
- The 4x1 multiplexer is correctly implemented using behavioral VHDL
- Simulation waveform confirms correct functionality
- Design behaves as expected for all input and select combinations

---

## 📁 Files
- `mux_4x1_beh_vhdl.vhd` : Main design file
- `mux_4x1_beh_vhdl_tb.vhd` : Testbench file