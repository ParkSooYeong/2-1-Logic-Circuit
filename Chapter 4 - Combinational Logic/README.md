# mag_compare_vhdl

## Overview

`mag_compare_vhdl` is a 4-bit unsigned magnitude comparator implemented in VHDL using the Dataflow modeling style.  
The module compares two 4-bit inputs (`A` and `B`) and generates three mutually exclusive outputs:

- `A_lt_B` : Asserted when A < B  
- `A_eq_B` : Asserted when A = B  
- `A_gt_B` : Asserted when A > B  

The design is purely combinational and fully synthesizable.

---

## Entity Description

### Inputs

- `A : std_logic_vector(3 downto 0)`  
  First 4-bit unsigned operand  

- `B : std_logic_vector(3 downto 0)`  
  Second 4-bit unsigned operand  

### Outputs

- `A_lt_B : std_logic`  
  High when A is less than B  

- `A_eq_B : std_logic`  
  High when A equals B  

- `A_gt_B : std_logic`  
  High when A is greater than B  

Only one output is high at any given time.

---

## VHDL Implementation

    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    entity mag_compare_vhdl is
        port (
            A, B    : in  std_logic_vector(3 downto 0);
            A_lt_B  : out std_logic;
            A_eq_B  : out std_logic;
            A_gt_B  : out std_logic
        );
    end mag_compare_vhdl;

    architecture Dataflow of mag_compare_vhdl is
    begin
        A_lt_B <= '1' when unsigned(A) < unsigned(B) else '0';
        A_gt_B <= '1' when unsigned(A) > unsigned(B) else '0';
        A_eq_B <= '1' when unsigned(A) = unsigned(B) else '0';
    end Dataflow;

---

## Functional Behavior

| Condition | A_lt_B | A_eq_B | A_gt_B |
|------------|--------|--------|--------|
| A < B | 1 | 0 | 0 |
| A = B | 0 | 1 | 0 |
| A > B | 0 | 0 | 1 |

The comparison is performed using unsigned arithmetic via `numeric_std`.

---

## Testbench Description

The testbench performs exhaustive verification:

- Iterates A from 0 to 15
- Iterates B from 0 to 15
- Tests all 256 possible input combinations
- Observes waveform outputs for correctness

### Testbench Code

    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    entity mag_compare_vhdl_tb is
    end mag_compare_vhdl_tb;

    architecture behavior of mag_compare_vhdl_tb is

        signal A, B     : std_logic_vector(3 downto 0);
        signal A_lt_B   : std_logic;
        signal A_eq_B   : std_logic;
        signal A_gt_B   : std_logic;

    begin

        uut: entity work.mag_compare_vhdl
            port map (
                A => A,
                B => B,
                A_lt_B => A_lt_B,
                A_eq_B => A_eq_B,
                A_gt_B => A_gt_B
            );

        stimulus: process
        begin
            for i in 0 to 15 loop
                for j in 0 to 15 loop
                    A <= std_logic_vector(to_unsigned(i,4));
                    B <= std_logic_vector(to_unsigned(j,4));
                    wait for 10 ns;
                end loop;
            end loop;
            wait;
        end process;

    end behavior;

---

## Simulation Results

- All 256 input combinations verified
- Outputs correctly reflect unsigned magnitude relationship
- Exactly one output asserted at a time
- No undefined (U) or high-impedance (Z) states observed

Waveform analysis confirms correct comparator functionality.

---

## Synthesis Characteristics

- Pure combinational logic
- No clock required
- No registers inferred
- Fully synthesizable in Quartus / ModelSim

---

## Project Structure

mag_compare_vhdl/
├── mag_compare_vhdl.vhd
├── mag_compare_vhdl_tb.vhd
└── README.md

---

## Author

Project: mag_compare_vhdl  
Date: February 22, 2026  

```