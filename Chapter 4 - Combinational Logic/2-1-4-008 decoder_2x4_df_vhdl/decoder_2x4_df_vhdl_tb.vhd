library ieee;
use ieee.std_logic_1164.all;

entity decoder_2x4_df_vhdl_tb is
end decoder_2x4_df_vhdl_tb;

architecture behavior of decoder_2x4_df_vhdl_tb is

    -- Component declaration
    component decoder_2x4_df_vhdl
        port (
            A, B, enable : in std_logic;
            D : out std_logic_vector (3 downto 0)
        );
    end component;

    -- Test signals
    signal A, B, enable : std_logic := '0';
    signal D : std_logic_vector (3 downto 0);

begin

    -- Instantiate DUT
    uut: decoder_2x4_df_vhdl
        port map (
            A => A,
            B => B,
            enable => enable,
            D => D
        );

    -- Stimulus process
    stim_proc: process
    begin

        -- enable = '0'
        enable <= '0';

        A <= '0'; B <= '0'; wait for 10 ns;
        A <= '0'; B <= '1'; wait for 10 ns;
        A <= '1'; B <= '0'; wait for 10 ns;
        A <= '1'; B <= '1'; wait for 10 ns;

        -- enable = '1'
        enable <= '1';

        A <= '0'; B <= '0'; wait for 10 ns;
        A <= '0'; B <= '1'; wait for 10 ns;
        A <= '1'; B <= '0'; wait for 10 ns;
        A <= '1'; B <= '1'; wait for 10 ns;

        wait;
    end process;

end behavior;
