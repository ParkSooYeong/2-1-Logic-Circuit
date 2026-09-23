library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_vhdl is
    port (
        Enable    : in  std_logic;
        ReadWrite : in  std_logic;
        DataIn    : in  std_logic_vector(3 downto 0);
        Address   : in  std_logic_vector(5 downto 0);
        DataOut   : out std_logic_vector(3 downto 0)
    );
end memory_vhdl;

architecture Behavioral of memory_vhdl is

    type memory_array is array (0 to 63) of std_logic_vector(3 downto 0);
    signal Mem : memory_array;

begin

    ------------------------------------------------------------
    -- Asynchronous Write
    -- ReadWrite = 0 : Write
    ------------------------------------------------------------
    write_process : process(Enable, ReadWrite, DataIn, Address)
    begin
        if Enable = '1' and ReadWrite = '0' then
            Mem(to_integer(unsigned(Address))) <= DataIn;
        end if;
    end process;

    ------------------------------------------------------------
    -- Asynchronous Read
    -- ReadWrite = 1 : Read
    ------------------------------------------------------------
    read_process : process(Enable, ReadWrite, Address, Mem)
    begin
        DataOut <= (others => 'Z');

        if Enable = '1' and ReadWrite = '1' then
            DataOut <= Mem(to_integer(unsigned(Address)));
        end if;
    end process;

end Behavioral;
