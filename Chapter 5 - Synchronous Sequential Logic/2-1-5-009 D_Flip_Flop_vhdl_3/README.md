# D Flip-Flop (Negative Edge Triggered, Asynchronous Active-High Reset) - VHDL

## Overview
This project implements a **negative-edge-triggered D Flip-Flop** with an **asynchronous active-high reset** using VHDL.

- `clk` falling edge (`1 → 0`) updates `Q`
- `rst = '1'` immediately resets `Q` to `'0'`
- Behavioral modeling style is used

---

## VHDL Design Code

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity D_Flip_Flop_vhdl_3 is
	port (
		D, clk, rst : in std_logic;
		Q : out std_logic
	);
end D_Flip_Flop_vhdl_3;

architecture Behavioral of D_Flip_Flop_vhdl_3 is
begin
	process (clk, rst)
	begin
		if rst = '1' then
			Q <= '0';

		elsif clk'event and clk = '0' then
			Q <= D;
		end if;
	end process;
end Behavioral;
```

---

# Testbench

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity D_Flip_Flop_vhdl_3_tb is
end D_Flip_Flop_vhdl_3_tb;

architecture test_bench of D_Flip_Flop_vhdl_3_tb is

	component D_Flip_Flop_vhdl_3
		port (
			D, clk, rst : in std_logic;
			Q : out std_logic
		);
	end component;

	signal D     : std_logic := '0';
	signal clk   : std_logic := '0';
	signal rst   : std_logic := '0';
	signal Q     : std_logic;

begin

	UUT: D_Flip_Flop_vhdl_3
		port map (
			D   => D,
			clk => clk,
			rst => rst,
			Q   => Q
		);

	-- Clock generation (10 ns period)
	clock_process : process
	begin
		while now < 80 ns loop
			clk <= '0';
			wait for 5 ns;

			clk <= '1';
			wait for 5 ns;
		end loop;

		wait;
	end process;

	-- Stimulus process
	stim_proc : process
	begin
		-- Reset active
		rst <= '1';
		D <= '0';
		wait for 10 ns;

		-- Release reset
		rst <= '0';

		-- Apply inputs
		D <= '1';
		wait for 20 ns;

		D <= '0';
		wait for 20 ns;

		D <= '1';
		wait for 20 ns;

		-- Assert reset again
		rst <= '1';
		wait for 10 ns;

		rst <= '0';
		D <= '0';

		wait;
	end process;

end test_bench;
```

---

# Simulation Result

## Functional Behavior

### Reset Operation
- When `rst = '1'`, output `Q` is immediately cleared to `'0'`
- Reset works asynchronously independent of clock

### Negative Edge Triggering
- `Q` changes only at the falling edge of `clk`
- During other clock states, `Q` retains previous value

### Data Transfer
- At each negative edge:
  - `Q <= D`

---

# Waveform Analysis

| Time (ns) | rst | clk Edge | D | Q | Description |
|----------|-----|-----------|---|---|-------------|
| 0        | 1   | -         | 0 | 0 | Reset active |
| 10       | 0   | ↓         | 1 | 1 | Q captures D |
| 30       | 0   | ↓         | 0 | 0 | Q updated |
| 50       | 0   | ↓         | 1 | 1 | Q updated |
| 70       | 1   | -         | 1 | 0 | Asynchronous reset |

---

# Synthesis Information

- Tool: Intel Quartus Prime Lite 15.1
- Language: VHDL
- Device: FPGA compatible
- Design Type:
  - Sequential Logic
  - Negative-edge-triggered D Flip-Flop
  - Asynchronous reset

---

# Files

| File Name | Description |
|-----------|-------------|
| `D_Flip_Flop_vhdl_3.vhd` | Main VHDL design |
| `D_Flip_Flop_vhdl_3_tb.vhd` | Testbench |
| `README.md` | Project documentation |
