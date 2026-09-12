library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Complement D Flip-Flop
------------------------------------------------------------
entity Comp_D_flip_flop is
    port (
        clk   : in  std_logic;
        reset : in  std_logic;
        Q     : out std_logic
    );
end Comp_D_flip_flop;

architecture Behavioral of Comp_D_flip_flop is

    signal Q_reg : std_logic := '0';

begin

    process(clk, reset)
    begin
        if reset = '1' then
            Q_reg <= '0';

        elsif falling_edge(clk) then
            Q_reg <= not Q_reg after 2 ns;
        end if;
    end process;

    Q <= Q_reg;

end Behavioral;


library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- 4-bit Ripple Counter
------------------------------------------------------------
entity Ripple_Counter_4bit_vhdl is
    port (
        count : in  std_logic;
        reset : in  std_logic;
        A0    : out std_logic;
        A1    : out std_logic;
        A2    : out std_logic;
        A3    : out std_logic
    );
end Ripple_Counter_4bit_vhdl;

architecture Structural of Ripple_Counter_4bit_vhdl is

    signal A_reg : std_logic_vector(3 downto 0);

    component Comp_D_flip_flop
        port (
            clk   : in  std_logic;
            reset : in  std_logic;
            Q     : out std_logic
        );
    end component;

begin

    ------------------------------------------------------------
    -- Output Mapping
    ------------------------------------------------------------
    A0 <= A_reg(0);
    A1 <= A_reg(1);
    A2 <= A_reg(2);
    A3 <= A_reg(3);

    ------------------------------------------------------------
    -- Ripple Counter Stages
    ------------------------------------------------------------
    F0 : Comp_D_flip_flop
        port map (
            clk   => count,
            reset => reset,
            Q     => A_reg(0)
        );

    F1 : Comp_D_flip_flop
        port map (
            clk   => A_reg(0),
            reset => reset,
            Q     => A_reg(1)
        );

    F2 : Comp_D_flip_flop
        port map (
            clk   => A_reg(1),
            reset => reset,
            Q     => A_reg(2)
        );

    F3 : Comp_D_flip_flop
        port map (
            clk   => A_reg(2),
            reset => reset,
            Q     => A_reg(3)
        );

end Structural;
