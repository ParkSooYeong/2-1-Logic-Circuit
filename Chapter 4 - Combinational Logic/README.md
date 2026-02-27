# mux_2x1_vhdl

## Overview

`mux_2x1_vhdl` is a 2-to-1 multiplexer implemented in VHDL using the Dataflow modeling style.  
The design selects one of two single-bit inputs (`A` or `B`) according to the control signal `sel`.

This is a purely combinational circuit and is fully synthesizable in FPGA/ASIC tools such as Quartus Prime.

---

## Functional Description

The multiplexer operates according to the following rule:

- If `sel = '1'` → `m_out = A`
- If `sel = '0'` → `m_out = B`

VHDL conditional signal assignment is used for implementation.

---

## Entity Declaration

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1_df_vhdl is
    port (
        A, B : in  std_logic;
        sel  : in  std_logic;
        m_out : out std_logic
    );
end mux_2x1_df_vhdl;
```

---

## Architecture (Dataflow)

```vhdl
architecture Dataflow of mux_2x1_df_vhdl is
begin
    m_out <= A when sel = '1' else B;
end Dataflow;
```

---

## Truth Table

| sel | A | B | m_out |
|-----|---|---|--------|
| 0   | X | 0 |   0    |
| 0   | X | 1 |   1    |
| 1   | 0 | X |   0    |
| 1   | 1 | X |   1    |

(X = don't care)

---

## Testbench Description

The testbench applies all possible input combinations (2³ = 8 cases):

- A = '0' or '1'
- B = '0' or '1'
- sel = '0' or '1'

Each combination is applied with a time delay to observe waveform behavior.

---

## Example Testbench

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1_df_vhdl_tb is
end mux_2x1_df_vhdl_tb;

architecture behavior of mux_2x1_df_vhdl_tb is

    signal A      : std_logic := '0';
    signal B      : std_logic := '0';
    signal sel    : std_logic := '0';
    signal m_out  : std_logic;

begin

    uut: entity work.mux_2x1_df_vhdl
        port map (
            A => A,
            B => B,
            sel => sel,
            m_out => m_out
        );

    stimulus: process
    begin
        A <= '0'; B <= '0'; sel <= '0'; wait for 10 ns;
        A <= '0'; B <= '0'; sel <= '1'; wait for 10 ns;
        A <= '0'; B <= '1'; sel <= '0'; wait for 10 ns;
        A <= '0'; B <= '1'; sel <= '1'; wait for 10 ns;
        A <= '1'; B <= '0'; sel <= '0'; wait for 10 ns;
        A <= '1'; B <= '0'; sel <= '1'; wait for 10 ns;
        A <= '1'; B <= '1'; sel <= '0'; wait for 10 ns;
        A <= '1'; B <= '1'; sel <= '1'; wait for 10 ns;

        wait;
    end process;

end behavior;
```

---

## Simulation Results

- All 8 input combinations verified
- Output follows `sel` control correctly
- No undefined (`U`) or unknown (`X`) states observed
- Pure combinational response (no clock required)

Waveform confirms correct multiplexer behavior.

---

## Synthesis Characteristics

- Combinational logic only
- No latches inferred
- No clock dependency
- Minimal logic resource usage
- Fully synthesizable in Quartus Prime (15.1 Lite verified)

---

## Project Structure

```
mux_2x1_vhdl/
├── mux_2x1_df_vhdl.vhd
├── mux_2x1_df_vhdl_tb.vhd
└── README.md
```

---

## Author

Project: mux_2x1_vhdl  
Date: February 28, 2026  
Revision: Dataflow implementation
