library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1_beh_vhdl is
	port (A, B : in std_logic;
			enable : in std_logic;
			m_out : out std_logic);
end mux_2x1_beh_vhdl;

architecture Behavioral of mux_2x1_beh_vhdl is
	begin
		process (A, B, enable)
			begin
				if
					enable = '1' then m_out <= A;
				else
					m_out <= B;
				end if;
		end process;
end Behavioral;
