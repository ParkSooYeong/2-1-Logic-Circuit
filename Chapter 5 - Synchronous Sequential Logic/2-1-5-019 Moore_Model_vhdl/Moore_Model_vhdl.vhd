library ieee;
use ieee.std_logic_1164.all;

entity Moore_Model_vhdl is
    port (
        x_in  : in bit;
        clock : in bit;
        reset : in bit;
        y_out : out bit_vector(1 downto 0)
    );
end Moore_Model_vhdl;

architecture Behavioral of Moore_Model_vhdl is

    type State_Type is (S0, S1, S2, S3);
    signal state : State_Type;

begin

    -- State Register and Next-State Logic
    process(clock, reset)
    begin
        if (reset = '0') then
            state <= S0;

        elsif (clock'event and clock = '1') then

            case state is

                when S0 =>
                    if (x_in = '0') then
                        state <= S1;
                    else
                        state <= S0;
                    end if;

                when S1 =>
                    if (x_in = '0') then
                        state <= S2;
                    else
                        state <= S3;
                    end if;

                when S2 =>
                    if (x_in = '0') then
                        state <= S3;
                    else
                        state <= S2;
                    end if;

                when S3 =>
                    if (x_in = '0') then
                        state <= S0;
                    else
                        state <= S3;
                    end if;

            end case;

        end if;
    end process;

    -- Output Logic (Moore Output)
    process(state)
    begin
        case state is
            when S0 =>
                y_out <= "00";

            when S1 =>
                y_out <= "01";

            when S2 =>
                y_out <= "10";

            when S3 =>
                y_out <= "11";
        end case;
    end process;

end Behavioral;
