\# D Flip-Flop Using VHDL (Positive Edge Triggered)



\## Overview

This project implements a \*\*positive-edge-triggered D Flip-Flop\*\* using VHDL behavioral modeling.



The flip-flop captures the input data `D` and transfers it to the output `Q` on the \*\*rising edge\*\* of the clock signal `clk`.



\---



\## Features

\- VHDL behavioral modeling

\- Positive-edge-triggered operation

\- Synchronous data storage

\- Simple sequential logic implementation

\- Simulation waveform verification



\---



\## VHDL Design



```vhdl

library ieee;

use ieee.std\_logic\_1164.all;



entity D\_Flip\_Flop\_vhdl\_1 is

&#x09;port (

&#x20;       D, clk : in std\_logic;

&#x09;	Q : out std\_logic

&#x20;   );

end D\_Flip\_Flop\_vhdl\_1;



architecture Behavioral of D\_Flip\_Flop\_vhdl\_1 is

begin



&#x09;process(clk)

&#x09;begin

&#x09;	if clk'event and clk = '1' then

&#x20;           Q <= D;

&#x20;       end if;

&#x09;end process;



end Behavioral;

```



\---



\## Description



\### Inputs

| Signal | Description |

|--------|-------------|

| `D` | Data input |

| `clk` | Clock input |



\### Output

| Signal | Description |

|--------|-------------|

| `Q` | Stored output |



\---



\## Operation



The D Flip-Flop operates according to the following rule:



\- On every \*\*rising edge\*\* of `clk`

&#x20; - `Q` becomes equal to `D`



\### Behavior Summary



| Clock Edge | D | Q(next) |

|------------|---|----------|

| Rising Edge | 0 | 0 |

| Rising Edge | 1 | 1 |

| No Rising Edge | X | Holds Previous Value |



\---



\## Simulation



The waveform simulation verifies:



\- `Q` updates only at the rising edge of the clock

\- Changes in `D` between clock edges do not immediately affect `Q`

\- Stored data remains stable until the next rising edge



\---



\## Waveform Observation



\### Example Timing Behavior

1\. `D` changes before the rising edge

2\. At the next positive edge of `clk`, `Q` captures the value of `D`

3\. Between clock edges, `Q` remains unchanged



\---



\## Tools Used

\- VHDL

\- Intel Quartus Prime

\- ModelSim



\---



\## Applications

\- Registers

\- Counters

\- Shift registers

\- Finite State Machines (FSM)

\- Sequential digital systems



\---



\## Notes



The following expression is commonly used in classic VHDL edge detection:



```vhdl

if clk'event and clk = '1' then

```



Modern VHDL coding style often prefers:



```vhdl

if rising\_edge(clk) then

```



Both implementations provide equivalent functionality.



