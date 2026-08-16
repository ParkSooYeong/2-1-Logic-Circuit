library ieee;
use ieee.std_logic_1164.all;

entity Prob5_52_vhdl is
    port (
        x_in   : in  std_logic;
        clk    : in  std_logic;
        reset_b : in  std_logic;
        y_out  : out std_logic
    );
end Prob5_52_vhdl;

architecture Behavioral of Prob5_52_vhdl is
    constant s0 : std_logic_vector(1 downto 0) := "00";
    constant s1 : std_logic_vector(1 downto 0) := "01";
    constant s2 : std_logic_vector(1 downto 0) := "10";
    constant s3 : std_logic_vector(1 downto 0) := "11";

    signal state, next_state : std_logic_vector(1 downto 0);
begin

    -- State Register
    process (clk, reset_b)
    begin
        if reset_b = '0' then
            state <= s0;
        elsif clk'event and clk = '1' then
            state <= next_state;
        end if;
    end process;

    -- Next-State and Output Logic
    process (state, x_in)
    begin
        y_out <= '0';
        next_state <= s0;

        case state is

            when s0 =>
                y_out <= '0';

                if x_in = '1' then
                    next_state <= s1;
                else
                    next_state <= s0;
                end if;

            when s1 =>
                y_out <= '0';

                if x_in = '1' then
                    next_state <= s2;
                else
                    next_state <= s1;
                end if;

            when s2 =>
                if x_in = '1' then
                    y_out <= '0';
                    next_state <= s3;
                else
                    y_out <= '1';
                    next_state <= s2;
                end if;

            when s3 =>
                y_out <= '1';

                if x_in = '1' then
                    next_state <= s0;
                else
                    next_state <= s3;
                end if;

            when others =>
                y_out <= '0';
                next_state <= s0;

        end case;
    end process;

end Behavioral;
