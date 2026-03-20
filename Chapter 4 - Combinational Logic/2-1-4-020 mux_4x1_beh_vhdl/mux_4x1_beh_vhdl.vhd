-- 4 Channel Multiplexer VHDL Behavior Skill

library ieee;
use ieee.std_logic_1164.all;

entity mux_4x1_beh_vhdl is
	port (in_0, in_1, in_2, in_3 : in std_logic;
			sel : in std_logic_vector (1 downto 0);
			m_out : out std_logic);
end mux_4x1_beh_vhdl;

architecture Behavioral of mux_4x1_beh_vhdl is
	begin
		process (in_0, in_1, in_2, in_3, sel)
			begin
				case sel is
					when "00" => m_out <= in_0;
					when "01" => m_out <= in_1;
					when "10" => m_out <= in_2;
					when "11" => m_out <= in_3;
					when others => m_out <= '0';
				end case;
		end process;
end Behavioral;
