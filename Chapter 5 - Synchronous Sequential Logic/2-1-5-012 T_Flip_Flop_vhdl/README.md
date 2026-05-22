# T Flip-Flop (VHDL)

## Overview
This project implements a **T (Toggle) Flip-Flop** in VHDL using a D Flip-Flop structure.

The T Flip-Flop changes state according to the value of input `T`:

| T | Operation |
|---|---|
| 0 | Hold |
| 1 | Toggle |

The design was created and simulated using:

- Quartus Prime 15.1 Lite Edition
- ModelSim-Altera
- VHDL (IEEE STD_LOGIC_1164)

---

# Source Code

## T_Flip_Flop_vhdl.vhd

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity DFF_vhdl is
    port (
        D, clk, rst : in std_logic;
        Q : out std_logic
    );
end DFF_vhdl;

architecture Behavioral of DFF_vhdl is
begin
    process(clk, rst)
    begin
        if rst = '1' then
            Q <= '0';
        elsif rising_edge(clk) then
            Q <= D;
        end if;
    end process;
end Behavioral;


library ieee;
use ieee.std_logic_1164.all;

entity T_Flip_Flop_vhdl is
    port (
        T, clk, rst : in std_logic;
        Q : buffer std_logic
    );
end T_Flip_Flop_vhdl;

architecture Behavioral of T_Flip_Flop_vhdl is

    component DFF_vhdl
        port (
            D, clk, rst : in std_logic;
            Q : out std_logic
        );
    end component;

    signal DT : std_logic;

begin

    DT <= Q xor T;

    M0 : DFF_vhdl
        port map (
            D   => DT,
            clk => clk,
            rst => rst,
            Q   => Q
        );

end Behavioral;
```

---

# Testbench

## T_Flip_Flop_vhdl_tb.vhd

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity T_Flip_Flop_vhdl_tb is
end T_Flip_Flop_vhdl_tb;

architecture testbench of T_Flip_Flop_vhdl_tb is

    signal T   : std_logic := '0';
    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal Q   : std_logic;

begin

    uut : entity work.T_Flip_Flop_vhdl
        port map (
            T   => T,
            clk => clk,
            rst => rst,
            Q   => Q
        );

    clk_process : process
    begin
        while now < 160 ns loop
            clk <= '0';
            wait for 5 ns;

            clk <= '1';
            wait for 5 ns;
        end loop;

        wait;
    end process;

    stim_process : process
    begin

        rst <= '1';
        T <= '0';
        wait for 10 ns;

        rst <= '0';
        wait for 20 ns;

        T <= '1';
        wait for 40 ns;

        T <= '0';
        wait for 30 ns;

        T <= '1';
        wait for 40 ns;

        rst <= '1';
        wait for 10 ns;

        rst <= '0';
        wait for 10 ns;

        wait;

    end process;

end testbench;
```

---

# Simulation Result

The waveform confirms correct T Flip-Flop behavior:

- `T = 0` → Output holds current state
- `T = 1` → Output toggles on each rising clock edge
- `rst = 1` → Output resets to `0`

The simulation was successfully verified in ModelSim.

---

# RTL Schematic

The RTL Viewer shows:

- XOR gate generating `DT = Q xor T`
- D Flip-Flop block
- Feedback path from output `Q`
- Clock and reset connections

---

# Tools Used

- Quartus Prime 15.1 Lite Edition
- ModelSim-Altera
- VHDL
