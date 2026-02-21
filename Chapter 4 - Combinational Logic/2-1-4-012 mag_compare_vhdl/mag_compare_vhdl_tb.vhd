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

    -- DUT 인스턴스
    uut: entity work.mag_compare_vhdl
        port map (
            A => A,
            B => B,
            A_lt_B => A_lt_B,
            A_eq_B => A_eq_B,
            A_gt_B => A_gt_B
        );

    stimulus: process
        variable i, j : integer;
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
