library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testcounter_vhdl is
    port (
        A_count : out std_logic_vector(3 downto 0);
        C_out   : out std_logic;
        Data_in : in  std_logic_vector(3 downto 0);
        Count   : in  std_logic;
        Load    : in  std_logic;
        clk     : in  std_logic;
        clear_b : in  std_logic
    );
end testcounter_vhdl;

architecture Behavioral of testcounter_vhdl is

    signal A_reg : std_logic_vector(3 downto 0) := "0000";

begin

    A_count <= A_reg;

    ------------------------------------------------------------
    -- Carry-out
    -- Asserted when:
    -- A_count = 1111
    -- Count = 1
    -- Load = 0
    ------------------------------------------------------------
    C_out <= '1'
        when (A_reg = "1111") and (Count = '1') and (Load = '0')
        else '0';

    ------------------------------------------------------------
    -- 4-bit Binary Counter
    -- Active-low asynchronous clear
    ------------------------------------------------------------
    process(clk, clear_b)
    begin

        if clear_b = '0' then
            A_reg <= "0000";

        elsif rising_edge(clk) then

            if Load = '1' then
                A_reg <= Data_in;

            elsif Count = '1' then
                A_reg <= std_logic_vector(unsigned(A_reg) + 1);

            else
                A_reg <= A_reg;
            end if;

        end if;

    end process;

end Behavioral;
