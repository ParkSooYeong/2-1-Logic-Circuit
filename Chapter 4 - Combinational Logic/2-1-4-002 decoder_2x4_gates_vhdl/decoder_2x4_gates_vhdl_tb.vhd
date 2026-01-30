library ieee;
use ieee.std_logic_1164.all;

entity decoder_2x4_gates_vhdl_tb is
end decoder_2x4_gates_vhdl_tb;

architecture behavior of decoder_2x4_gates_vhdl_tb is

    -- Component declaration for DUT
    component decoder_2x4_gates_vhdl
        port (
            A      : in  std_logic;
            B      : in  std_logic;
            enable : in  std_logic;
            D      : out std_logic_vector(0 to 3)
        );
    end component;

    -- Testbench signals
    signal A_tb      : std_logic := '0';
    signal B_tb      : std_logic := '0';
    signal enable_tb : std_logic := '0';
    signal D_tb      : std_logic_vector(0 to 3);

begin

    -- Instantiate the DUT
    DUT : decoder_2x4_gates_vhdl
        port map (
            A      => A_tb,
            B      => B_tb,
            enable => enable_tb,
            D      => D_tb
        );

    -- Stimulus process
    stim_proc : process
    begin
        -- enable = 0 (decoder active)
        enable_tb <= '0';

        A_tb <= '0'; B_tb <= '0'; wait for 10 ns;
        A_tb <= '0'; B_tb <= '1'; wait for 10 ns;
        A_tb <= '1'; B_tb <= '0'; wait for 10 ns;
        A_tb <= '1'; B_tb <= '1'; wait for 10 ns;

        -- enable = 1 (all outputs inactive)
        enable_tb <= '1';
        A_tb <= '0'; B_tb <= '0'; wait for 10 ns;
        A_tb <= '1'; B_tb <= '1'; wait for 10 ns;

        -- End simulation
        wait;
    end process;

end behavior;
