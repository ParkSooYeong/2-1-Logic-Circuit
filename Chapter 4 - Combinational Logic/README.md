# 2x1 Multiplexer (Behavioral VHDL)

## Project Information
- **Project Name**: mux_2x1_beh_vhdl  
- **Date**: March 15, 2026  
- **Description**: Implementation of a 2-to-1 multiplexer using Behavioral modeling in VHDL and verification using a testbench.

---

## Overview

A **2x1 Multiplexer (MUX)** selects one of two input signals and forwards the selected input to the output based on the value of a control signal.

In this design:

- Inputs: `A`, `B`
- Control signal: `enable`
- Output: `m_out`

### Operation

| enable | Output |
|------|------|
| 0 | B |
| 1 | A |

If `enable = '1'`, the output becomes **A**.  
If `enable = '0'`, the output becomes **B**.

---

## VHDL Design (Behavioral Model)

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1_beh_vhdl is
	port (
		A, B : in std_logic;
		enable : in std_logic;
		m_out : out std_logic
	);
end mux_2x1_beh_vhdl;

architecture Behavioral of mux_2x1_beh_vhdl is
begin
	process(A, B, enable)
	begin
		if enable = '1' then
			m_out <= A;
		else
			m_out <= B;
		end if;
	end process;
end Behavioral;
```

---

## Testbench Code

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1_beh_vhdl_tb is
end mux_2x1_beh_vhdl_tb;

architecture behavior of mux_2x1_beh_vhdl_tb is

	component mux_2x1_beh_vhdl
		port (
			A, B : in std_logic;
			enable : in std_logic;
			m_out : out std_logic
		);
	end component;

	signal A : std_logic := '0';
	signal B : std_logic := '0';
	signal enable : std_logic := '0';
	signal m_out : std_logic;

begin

	UUT: mux_2x1_beh_vhdl
		port map (
			A => A,
			B => B,
			enable => enable,
			m_out => m_out
		);

	stim_proc: process
	begin

		A <= '0'; B <= '0'; enable <= '0';
		wait for 10 ns;

		A <= '0'; B <= '1'; enable <= '0';
		wait for 10 ns;

		A <= '1'; B <= '0'; enable <= '0';
		wait for 10 ns;

		A <= '1'; B <= '1'; enable <= '0';
		wait for 10 ns;

		A <= '0'; B <= '0'; enable <= '1';
		wait for 10 ns;

		A <= '0'; B <= '1'; enable <= '1';
		wait for 10 ns;

		A <= '1'; B <= '0'; enable <= '1';
		wait for 10 ns;

		A <= '1'; B <= '1'; enable <= '1';
		wait for 10 ns;

		wait;

	end process;

end behavior;
```

---

## Simulation Result

The waveform confirms correct multiplexer behavior.

- When **enable = 0**, output follows **B**
- When **enable = 1**, output follows **A**

The simulation verifies that all input combinations produce the expected output.

---

## Block Diagram

The multiplexer structure consists of:

- Two data inputs (**A**, **B**)
- One control signal (**enable**)
- One output (**m_out**)

The control signal determines which input is routed to the output.

---

## Conclusion

This project demonstrates:

- Behavioral modeling in **VHDL**
- Design of a **2x1 Multiplexer**
- Verification using a **testbench**
- Functional validation through **simulation waveform**

The results confirm that the design operates according to the expected multiplexer logic.

---