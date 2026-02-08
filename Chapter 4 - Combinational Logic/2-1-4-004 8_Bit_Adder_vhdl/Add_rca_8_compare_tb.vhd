library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ============================================================
-- Testbench for 8-bit Ripple Carry Adder (Add_rca_8_vhdl)
-- Compares DUT output with reference arithmetic result
-- ============================================================

entity Add_rca_8_compare_tb is
end Add_rca_8_compare_tb;

architecture behavior of Add_rca_8_compare_tb is

    -- DUT inputs
    signal A, B  : std_logic_vector(7 downto 0);
    signal Cin   : std_logic;

    -- DUT outputs
    signal Sum   : std_logic_vector(7 downto 0);
    signal Cout  : std_logic;

    -- Expected outputs
    signal Sum_exp  : std_logic_vector(7 downto 0);
    signal Cout_exp : std_logic;

begin

    ------------------------------------------------------------
    -- DUT instantiation
    ------------------------------------------------------------
    DUT : entity work.Add_rca_8_vhdl
        port map (
            a     => A,
            b     => B,
            c_in  => Cin,
            sum   => Sum,
            c_out => Cout
        );

    ------------------------------------------------------------
    -- Stimulus process
    ------------------------------------------------------------
    stim_proc : process
        variable result : unsigned(8 downto 0);
    begin
        for cin_i in 0 to 1 loop
            Cin <= std_logic'val(cin_i);

            for a_i in 0 to 255 loop
                for b_i in 0 to 255 loop

                    A <= std_logic_vector(to_unsigned(a_i, 8));
                    B <= std_logic_vector(to_unsigned(b_i, 8));

                    wait for 10 ns;

                    -- Reference calculation
                    result :=
                        to_unsigned(a_i, 9) +
                        to_unsigned(b_i, 9) +
                        to_unsigned(cin_i, 9);

                    Sum_exp  <= std_logic_vector(result(7 downto 0));
                    Cout_exp <= result(8);

                    wait for 1 ns;

                    -- Assertion check
                    assert (Sum = Sum_exp and Cout = Cout_exp)
                    report "ERROR (8-bit RCA): A=" & integer'image(a_i) &
                           " B=" & integer'image(b_i) &
                           " Cin=" & integer'image(cin_i)
                    severity error;

                end loop;
            end loop;
        end loop;

        report "=== TEST PASSED : Add_rca_8_vhdl ==="
        severity note;

        wait;
    end process;

end behavior;
