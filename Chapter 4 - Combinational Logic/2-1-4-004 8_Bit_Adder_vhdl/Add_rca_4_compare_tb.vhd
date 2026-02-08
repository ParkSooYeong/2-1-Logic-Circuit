library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ============================================================
-- Testbench for 4-bit Ripple Carry Adder (Add_rca_4_vhdl)
-- Compares DUT output with reference arithmetic result
-- ============================================================

entity Add_rca_4_compare_tb is
end Add_rca_4_compare_tb;

architecture behavior of Add_rca_4_compare_tb is

    -- DUT input signals
    signal A, B   : std_logic_vector(3 downto 0);
    signal Cin    : std_logic;
    
    -- DUT output signals
    signal Sum    : std_logic_vector(3 downto 0);
    signal Cout   : std_logic;

    -- Expected (reference) outputs
    signal Sum_exp  : std_logic_vector(3 downto 0);
    signal Cout_exp : std_logic;

begin

    ----------------------------------------------------------------
    -- DUT (Device Under Test) instantiation
    ----------------------------------------------------------------
    DUT : entity work.Add_rca_4_vhdl
        port map (
            A     => A,
            B     => B,
            c_in  => Cin,
            sum   => Sum,
            c_out => Cout
        );

    ----------------------------------------------------------------
    -- Stimulus and verification process
    ----------------------------------------------------------------
    stim_proc : process
        -- 5-bit variable to hold sum + carry
        variable result : unsigned(4 downto 0);
    begin

        -- Test all possible input combinations
        for cin_i in 0 to 1 loop
            Cin <= std_logic'val(cin_i);

            for a_i in 0 to 15 loop
                for b_i in 0 to 15 loop

                    -- Apply inputs
                    A <= std_logic_vector(to_unsigned(a_i, 4));
                    B <= std_logic_vector(to_unsigned(b_i, 4));

                    wait for 10 ns;

                    -- Calculate reference result
                    result :=
                        to_unsigned(a_i, 5) +
                        to_unsigned(b_i, 5) +
                        to_unsigned(cin_i, 5);

                    Sum_exp  <= std_logic_vector(result(3 downto 0));
                    Cout_exp <= result(4);

                    wait for 1 ns;

                    -- Compare DUT output with reference result
                    assert (Sum = Sum_exp and Cout = Cout_exp)
                    report "ERROR: A=" & integer'image(a_i) &
                           " B=" & integer'image(b_i) &
                           " Cin=" & integer'image(cin_i)
                    severity error;

                end loop;
            end loop;
        end loop;

        -- Test completed successfully
        report "=== TEST PASSED : Add_rca_4_vhdl ==="
        severity note;

        wait;
    end process;

end behavior;
