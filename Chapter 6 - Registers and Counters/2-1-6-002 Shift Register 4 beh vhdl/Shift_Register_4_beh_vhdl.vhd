library ieee;
use ieee.std_logic_1164.all;

entity Shift_Register_4_beh_vhdl is
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
end Shift_Register_4_beh_vhdl;

architecture Behavioral of Shift_Register_4_beh_vhdl is

    signal A_reg : std_logic_vector(3 downto 0);
    signal mode  : std_logic_vector(1 downto 0);

begin

    mode  <= s0 & s1;
    A_par <= A_reg;

    process(clk, Clear_b)
    begin
        if Clear_b = '0' then
            A_reg <= "0000";

        elsif rising_edge(clk) then

            case mode is

                when "00" =>
                    A_reg <= A_reg;

                when "01" =>
                    A_reg <= MSB_in & A_reg(3 downto 1);

                when "10" =>
                    A_reg <= A_reg(2 downto 0) & LSB_in;

                when "11" =>
                    A_reg <= I_par;

                when others =>
                    A_reg <= "0000";

            end case;

        end if;
    end process;

end Behavioral;
