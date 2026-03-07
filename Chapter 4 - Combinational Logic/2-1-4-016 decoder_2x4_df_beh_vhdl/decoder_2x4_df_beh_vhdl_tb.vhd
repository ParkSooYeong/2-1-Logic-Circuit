library ieee;
use ieee.std_logic_1164.all;

entity decoder_2x4_df_beh_vhdl_tb is
end decoder_2x4_df_beh_vhdl_tb;

architecture behavior of decoder_2x4_df_beh_vhdl_tb is

    -- Component Declaration
    component decoder_2x4_df_beh_vhdl
        port(
            A      : in std_logic;
            B      : in std_logic;
            enable : in std_logic;
            D      : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Testbench Signals
    signal A      : std_logic := '0';
    signal B      : std_logic := '0';
    signal enable : std_logic := '0';
    signal D      : std_logic_vector(3 downto 0);

begin

    -- DUT Instantiation
    uut: decoder_2x4_df_beh_vhdl
        port map(
            A => A,
            B => B,
            enable => enable,
            D => D
        );

    -- Stimulus Process
    stim_proc: process
    begin

        enable <= '0'; A <= '0'; B <= '0';
        wait for 10 ns;

        enable <= '0'; A <= '0'; B <= '1';
        wait for 10 ns;

        enable <= '0'; A <= '1'; B <= '0';
        wait for 10 ns;

        enable <= '0'; A <= '1'; B <= '1';
        wait for 10 ns;

        enable <= '1'; A <= '0'; B <= '0';
        wait for 10 ns;

        enable <= '1'; A <= '0'; B <= '1';
        wait for 10 ns;

        enable <= '1'; A <= '1'; B <= '0';
        wait for 10 ns;

        enable <= '1'; A <= '1'; B <= '1';
        wait for 10 ns;

        wait;

    end process;

end behavior;
