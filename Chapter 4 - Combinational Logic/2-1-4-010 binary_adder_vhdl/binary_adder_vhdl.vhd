library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity binary_adder_vhdl is
	port (A, B : in std_logic_vector (3 downto 0);
			C_in : in std_logic;
			sum : out std_logic_vector (3 downto 0);
			C_out : out std_logic);
end binary_adder_vhdl;

architecture Dataflow of binary_adder_vhdl is
	signal temp : unsigned(4 downto 0);  -- 5-bit intermediate signal
	
	begin
		temp <= unsigned('0' & A) + unsigned('0' & B) + (4 downto 1 => '0', 0 => C_in);
		sum   <= std_logic_vector(temp(3 downto 0));
		C_out <= temp(4); -- Compatible word sizes
end Dataflow;
