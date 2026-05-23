library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------
-- D Flip-Flop
--------------------------------------------------
entity DFF_vhdl is
    port (
        D   : in  std_logic;
        clk : in  std_logic;
        rst : in  std_logic;
        Q   : out std_logic
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

--------------------------------------------------
-- IMPORTANT
-- Quartus requires library/use again
--------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------
-- JK Flip-Flop
--------------------------------------------------
entity JK_Flip_Flop_vhdl is
    port (
        J   : in  std_logic;
        K   : in  std_logic;
        clk : in  std_logic;
        rst : in  std_logic;
        Q   : out std_logic
    );
end JK_Flip_Flop_vhdl;

architecture Behavioral of JK_Flip_Flop_vhdl is

    signal Q_int : std_logic := '0';
    signal JK    : std_logic;

    component DFF_vhdl
        port (
            D   : in  std_logic;
            clk : in  std_logic;
            rst : in  std_logic;
            Q   : out std_logic
        );
    end component;

begin

    --------------------------------------------------
    -- JK Next-State Equation
    --------------------------------------------------
    JK <= (J and (not Q_int)) or ((not K) and Q_int);

    --------------------------------------------------
    -- D Flip-Flop Instance
    --------------------------------------------------
    M0 : DFF_vhdl
        port map (
            D   => JK,
            clk => clk,
            rst => rst,
            Q   => Q_int
        );

    Q <= Q_int;

end Behavioral;
