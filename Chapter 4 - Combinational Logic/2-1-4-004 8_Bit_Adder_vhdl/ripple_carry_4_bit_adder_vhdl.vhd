library ieee;
use ieee.std_logic_1164.all;

entity ripple_carry_4_bit_adder_vhdl is
	port (A, B : in std_logic_vector(3 downto 0);
			C0 : in std_logic;
			C4 : out std_logic;
			sum : out std_logic_vector(3 downto 0));
end ripple_carry_4_bit_adder_vhdl;

architecture Structural of ripple_carry_4_bit_adder_vhdl is
	component full_adder_vhdl
		port (A, B : in std_logic_vector(3 downto 0);
				C0 : in std_logic;
				C4 : out std_logic;
				sum : out std_logic_vector(3 downto 0));
	end component;
	
	signal C1, C2, C3 : std_logic;
	
	begin
		FA0 : full_adder_vhdl port map(S => sum(0), C => C1, x => A(0), y = B(0), z => C0);
		FA1 : full_adder_vhdl port map(S => sum(1), C => C2, x => A(1), y = B(1), z => C1);
		FA2 : full_adder_vhdl port map(S => sum(2), C => C3, x => A(2), y = B(2), z => C2);
		FA3 : full_adder_vhdl port map(S => sum(3), C => C4, x => A(3), y = B(3), z => C3);
end Structural;
