library ieee;
use ieee.std_logic_1164.all;

entity testcounter_vhdl_tb is
end testcounter_vhdl_tb;

architecture Behavioral of testcounter_vhdl_tb is

    signal t_count   : std_logic := '0';
    signal t_load    : std_logic := '0';
    signal t_clk     : std_logic := '0';
    signal t_clear_b : std_logic := '1';

    signal t_C0      : std_logic;
    signal t_A       : std_logic_vector(3 downto 0);
    signal t_in      : std_logic_vector(3 downto 0) := "0000";

    component testcounter_vhdl
        port (
            A_count : out std_logic_vector(3 downto 0);
            C_out   : out std_logic;
            Data_in : in  std_logic_vector(3 downto 0);
            Count   : in  std_logic;
            Load    : in  std_logic;
            clk     : in  std_logic;
            clear_b : in  std_logic
        );
    end component;

begin

    ----------------------------------------------------------------
    -- DUT
    ----------------------------------------------------------------
    UUT : testcounter_vhdl
        port map (
            A_count => t_A,
            C_out   => t_C0,
            Data_in => t_in,
            Count   => t_count,
            Load    => t_load,
            clk     => t_clk,
            clear_b => t_clear_b
        );

    ----------------------------------------------------------------
    -- Clock Generation
    -- 10 ns Period
    ----------------------------------------------------------------
    clock_process : process
    begin
        while now < 160 ns loop
            t_clk <= '0';
            wait for 5 ns;

            t_clk <= '1';
            wait for 5 ns;
        end loop;

        wait;
    end process;

    ----------------------------------------------------------------
    -- Stimulus
    ----------------------------------------------------------------
    stimulus_process : process
    begin

        ----------------------------------------------------------------
        -- Initial Clear
        ----------------------------------------------------------------
        t_clear_b <= '1';
        t_count   <= '0';
        t_load    <= '0';
        t_in      <= "0000";

        wait for 2 ns;

        t_clear_b <= '0';

        wait for 3 ns;

        t_clear_b <= '1';

        ----------------------------------------------------------------
        -- Parallel Load: 1010
        ----------------------------------------------------------------
        wait for 5 ns;

        t_load  <= '1';
        t_count <= '0';
        t_in    <= "1010";

        wait for 10 ns;

        ----------------------------------------------------------------
        -- Count
        -- 1010 -> 1011 -> 1100 -> 1101 -> 1110
        ----------------------------------------------------------------
        t_load  <= '0';
        t_count <= '1';

        wait for 40 ns;

        ----------------------------------------------------------------
        -- Hold
        ----------------------------------------------------------------
        t_count <= '0';

        wait for 10 ns;

        ----------------------------------------------------------------
        -- Parallel Load: 1110
        ----------------------------------------------------------------
        t_load  <= '1';
        t_in    <= "1110";

        wait for 10 ns;

        ----------------------------------------------------------------
        -- Count
        -- 1110 -> 1111
        ----------------------------------------------------------------
        t_load  <= '0';
        t_count <= '1';

        wait for 10 ns;

        ----------------------------------------------------------------
        -- C_out Check
        -- A_count = 1111
        ----------------------------------------------------------------
        wait for 5 ns;

        ----------------------------------------------------------------
        -- Overflow
        -- 1111 -> 0000
        ----------------------------------------------------------------
        wait for 5 ns;

        ----------------------------------------------------------------
        -- Load Priority Test
        -- Load = 1 and Count = 1
        -- Data_in = 0101
        ----------------------------------------------------------------
        t_load  <= '1';
        t_count <= '1';
        t_in    <= "0101";

        wait for 10 ns;

        ----------------------------------------------------------------
        -- Hold
        ----------------------------------------------------------------
        t_load  <= '0';
        t_count <= '0';

        wait for 10 ns;

        ----------------------------------------------------------------
        -- Asynchronous Clear
        ----------------------------------------------------------------
        t_clear_b <= '0';

        wait for 5 ns;

        t_clear_b <= '1';

        ----------------------------------------------------------------
        -- Count Again
        ----------------------------------------------------------------
        t_count <= '1';

        wait for 35 ns;

        wait;

    end process;

end Behavioral;
