# 2x4 Decoder (VHDL)

## Overview
This project implements a **2-to-4 Decoder** using **VHDL behavioral modeling**.  
The decoder converts a **2-bit input (A, B)** into **four output signals (D[3:0])** with an **enable signal**.

When the decoder is enabled, only one output becomes active depending on the input combination.

---

## Block Diagram

Inputs
- A
- B
- enable

Outputs
- D(3)
- D(2)
- D(1)
- D(0)

The circuit uses basic logic operations (AND / NOT) to generate the decoder outputs.

---

## Truth Table

| enable | A | B | D3 | D2 | D1 | D0 |
|------|------|------|------|------|------|------|
| 0 | 0 | 0 | 1 | 1 | 1 | 0 |
| 0 | 0 | 1 | 1 | 1 | 0 | 1 |
| 0 | 1 | 0 | 1 | 0 | 1 | 1 |
| 0 | 1 | 1 | 0 | 1 | 1 | 1 |
| 1 | X | X | 1 | 1 | 1 | 1 |

Note  
- `enable = 0` → Decoder is active  
- `enable = 1` → All outputs inactive

---

## VHDL Design

### Entity

library ieee;
use ieee.std_logic_1164.all;

entity decoder_2x4_df_beh_vhdl is
	port (
		A, B, enable : in std_logic;
		D : out std_logic_vector (3 downto 0)
	);
end decoder_2x4_df_beh_vhdl;

### Architecture

architecture behavioral of decoder_2x4_df_beh_vhdl is
begin
	process (A, B, enable)
	begin
		D(0) <= not ((not A) and (not B) and (not enable));
		D(1) <= not ((not A) and B and (not enable));
		D(2) <= not (A and (not B) and (not enable));
		D(3) <= not (A and B and (not enable));
	end process;
end behavioral;

---

## Simulation

The simulation waveform verifies the correct behavior of the decoder.

Example cases:

Input  
A=0 B=0 enable=0  

Output  
D = 1110

Input  
A=0 B=1 enable=0  

Output  
D = 1101

Input  
A=1 B=0 enable=0  

Output  
D = 1011

Input  
A=1 B=1 enable=0  

Output  
D = 0111

---

## Project Structure

```
decoder_2x4_df_beh_vhdl
│
├── decoder_2x4_df_beh_vhdl.vhd
├── decoder_2x4_tb.vhd
├── waveform.png
├── schematic.png
└── README.md
```

---

## Tools

- VHDL
- Intel Quartus Prime
- ModelSim (simulation)
