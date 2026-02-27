-- 2-to-1 Multiplexer Dataflow Skill

library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1_vhdl is
	port (A, B, sel : in std_logic;
			m_out : out std_logic);
end mux_2x1_vhdl;

architecture Dataflow of mux_2x1_vhdl is
	begin
		m_out <= A when sel = '1' else B; -- Conditional Signal Assignment Statement
end Dataflow;
