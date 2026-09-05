library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- 4-to-1 Multiplexer
------------------------------------------------------------
entity Mux_4x1 is
    port (
        i0      : in  std_logic;
        i1      : in  std_logic;
        i2      : in  std_logic;
        i3      : in  std_logic;
        sel     : in  std_logic_vector(1 downto 0);
        mux_out : out std_logic
    );
end Mux_4x1;

architecture Behavioral of Mux_4x1 is
begin

    process(i0, i1, i2, i3, sel)
    begin
        case sel is
            when "00" =>
                mux_out <= i0;

            when "01" =>
                mux_out <= i1;

            when "10" =>
                mux_out <= i2;

            when "11" =>
                mux_out <= i3;

            when others =>
                mux_out <= '0';
        end case;
    end process;

end Behavioral;


library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- D Flip-Flop
------------------------------------------------------------
entity D_flip_flop is
    port (
        D   : in  std_logic;
        clk : in  std_logic;
        clr : in  std_logic;
        Q   : out std_logic
    );
end D_flip_flop;

architecture Behavioral of D_flip_flop is
begin

    process(clk, clr)
    begin
        if clr = '1' then
            Q <= '0';

        elsif rising_edge(clk) then
            Q <= D;
        end if;
    end process;

end Behavioral;


library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Single Shift Register Stage
------------------------------------------------------------
entity stage is
    port (
        i0     : in  std_logic;
        i1     : in  std_logic;
        i2     : in  std_logic;
        i3     : in  std_logic;
        sel    : in  std_logic_vector(1 downto 0);
        clk    : in  std_logic;
        clr    : in  std_logic;
        Q      : out std_logic
    );
end stage;

architecture Structural of stage is

    signal mux_out : std_logic;

    component Mux_4x1
        port (
            i0      : in  std_logic;
            i1      : in  std_logic;
            i2      : in  std_logic;
            i3      : in  std_logic;
            sel     : in  std_logic_vector(1 downto 0);
            mux_out : out std_logic
        );
    end component;

    component D_flip_flop
        port (
            D   : in  std_logic;
            clk : in  std_logic;
            clr : in  std_logic;
            Q   : out std_logic
        );
    end component;

begin

    M0 : Mux_4x1
        port map (
            i0      => i0,
            i1      => i1,
            i2      => i2,
            i3      => i3,
            sel     => sel,
            mux_out => mux_out
        );

    M1 : D_flip_flop
        port map (
            D   => mux_out,
            clk => clk,
            clr => clr,
            Q   => Q
        );

end Structural;


library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- 4-bit Shift Register - Structural Model
------------------------------------------------------------
entity Shift_Register_4_str_vhdl is
    port (
        s0      : in  std_logic;
        s1      : in  std_logic;
        MSB_in  : in  std_logic;
        LSB_in  : in  std_logic;
        clk     : in  std_logic;
        Clear_b : in  std_logic;
        I_par   : in  std_logic_vector(3 downto 0);
        A_par   : out std_logic_vector(3 downto 0)
    );
end Shift_Register_4_str_vhdl;

architecture Structural of Shift_Register_4_str_vhdl is

    signal sel   : std_logic_vector(1 downto 0);
    signal clr   : std_logic;
    signal A_reg : std_logic_vector(3 downto 0);

    component stage
        port (
            i0  : in  std_logic;
            i1  : in  std_logic;
            i2  : in  std_logic;
            i3  : in  std_logic;
            sel : in  std_logic_vector(1 downto 0);
            clk : in  std_logic;
            clr : in  std_logic;
            Q   : out std_logic
        );
    end component;

begin

    sel <= s0 & s1;
    clr <= not Clear_b;

    A_par <= A_reg;

    ------------------------------------------------------------
    -- Stage 0
    ------------------------------------------------------------
    ST0 : stage
        port map (
            i0  => A_reg(0),
            i1  => A_reg(1),
            i2  => LSB_in,
            i3  => I_par(0),
            sel => sel,
            clk => clk,
            clr => clr,
            Q   => A_reg(0)
        );

    ------------------------------------------------------------
    -- Stage 1
    ------------------------------------------------------------
    ST1 : stage
        port map (
            i0  => A_reg(1),
            i1  => A_reg(2),
            i2  => A_reg(0),
            i3  => I_par(1),
            sel => sel,
            clk => clk,
            clr => clr,
            Q   => A_reg(1)
        );

    ------------------------------------------------------------
    -- Stage 2
    ------------------------------------------------------------
    ST2 : stage
        port map (
            i0  => A_reg(2),
            i1  => A_reg(3),
            i2  => A_reg(1),
            i3  => I_par(2),
            sel => sel,
            clk => clk,
            clr => clr,
            Q   => A_reg(2)
        );

    ------------------------------------------------------------
    -- Stage 3
    ------------------------------------------------------------
    ST3 : stage
        port map (
            i0  => A_reg(3),
            i1  => MSB_in,
            i2  => A_reg(2),
            i3  => I_par(3),
            sel => sel,
            clk => clk,
            clr => clr,
            Q   => A_reg(3)
        );

end Structural;
