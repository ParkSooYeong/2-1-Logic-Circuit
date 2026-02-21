library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mag_compare_vhdl is
	port (A, B : in std_logic_vector (3 downto 0);
			A_lt_B, A_eq_B, A_gt_B : out std_logic);
end mag_compare_vhdl;

architecture Dataflow of mag_compare_vhdl is
	begin
		A_lt_B <= '1' when unsigned(A) < unsigned(B) else '0';
		A_gt_B <= '1' when unsigned(A) > unsigned(B) else '0';
		A_eq_B <= '1' when unsigned(A) = unsigned(B) else '0';
end Dataflow;
