# D_Flip_Flop_vhdl_2

## Overview
This project implements a **D Flip-Flop with Active-Low Asynchronous Reset** using VHDL.

The flip-flop updates the output `Q` with the input `D` on the rising edge of the clock signal `clk`.  
When the reset signal `rst_b` becomes `'0'`, the output is immediately cleared regardless of the clock.

---

## VHDL Source Code

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity D_Flip_Flop_vhdl_2 is
	port (
		D, clk, rst_b : in std_logic;
		Q : out std_logic
	);
end D_Flip_Flop_vhdl_2;

architecture Behavioral of D_Flip_Flop_vhdl_2 is
begin
	process (clk, rst_b)
	begin
		if rst_b = '0' then
			Q <= '0';

		elsif rising_edge(clk) then
			Q <= D;
		end if;
	end process;
end Behavioral;
```

---

## Operation Description

### Inputs
- `D` : Data input
- `clk` : Clock input
- `rst_b` : Active-Low asynchronous reset input

### Output
- `Q` : Flip-flop output

---

## Functional Behavior

| rst_b | Clock Edge | D | Q |
|------|------------|---|---|
| 0 | X | X | 0 |
| 1 | Rising Edge | 0 | 0 |
| 1 | Rising Edge | 1 | 1 |

---

## Timing Behavior

- When `rst_b = '0'`
  - Output `Q` is immediately reset to `0`
- When `rst_b = '1'`
  - `Q` follows `D` only on the rising edge of `clk`
- Between clock edges
  - `Q` retains its previous value

---

## Testbench Example

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity D_Flip_Flop_vhdl_2_tb is
end D_Flip_Flop_vhdl_2_tb;

architecture Test_Bench of D_Flip_Flop_vhdl_2_tb is

	component D_Flip_Flop_vhdl_2
		port (
			D, clk, rst_b : in std_logic;
			Q : out std_logic
		);
	end component;

	signal D, clk, rst_b, Q : std_logic;

begin

	UUT : D_Flip_Flop_vhdl_2
		port map (
			D => D,
			clk => clk,
			rst_b => rst_b,
			Q => Q
		);

	process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;

	process
	begin
		rst_b <= '0';
		D <= '0';

		wait for 15 ns;
		rst_b <= '1';

		D <= '1';
		wait for 20 ns;

		D <= '0';
		wait for 20 ns;

		D <= '1';
		wait for 20 ns;

		rst_b <= '0';
		wait for 20 ns;

		rst_b <= '1';
		D <= '0';
		wait;

	end process;

end Test_Bench;
```

---

## Simulation Result

The simulation waveform confirms:

- `Q` is asynchronously cleared when `rst_b = 0`
- `Q` captures `D` on the rising edge of `clk`
- `Q` maintains its value between clock edges

---

## Tools Used

- Intel Quartus Prime Lite Edition 15.1
- ModelSim-Altera
- VHDL (IEEE `std_logic_1164`)
