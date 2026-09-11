library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Binary_Counter_4_Par_Load_vhdl is
    port (
        A_count : buffer unsigned(3 downto 0);
        C_out   : out std_logic;
        Data_in : in unsigned(3 downto 0);
        count   : in std_logic;
        load    : in std_logic;
        clk     : in std_logic;
        clear_b : in std_logic
    );
end Binary_Counter_4_Par_Load_vhdl;

architecture Behavioral of Binary_Counter_4_Par_Load_vhdl is
begin

    -- Carry-out is asserted when the counter is at 1111,
    -- counting is enabled, and parallel loading is disabled.
    C_out <= '1'
        when (A_count = "1111") and (count = '1') and (load = '0')
        else '0';

    process(clk, clear_b)
    begin

        -- Asynchronous active-low clear
        if clear_b = '0' then
            A_count <= "0000";

        -- Rising-edge triggered operation
        elsif rising_edge(clk) then

            -- Parallel Load has priority over Count
            if load = '1' then
                A_count <= Data_in;

            elsif count = '1' then
                A_count <= A_count + "0001";

            else
                A_count <= A_count;
            end if;

        end if;

    end process;

end Behavioral;
