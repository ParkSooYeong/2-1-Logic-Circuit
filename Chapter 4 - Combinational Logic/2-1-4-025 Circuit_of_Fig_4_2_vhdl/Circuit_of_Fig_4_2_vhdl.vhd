library ieee;
use ieee.std_logic_1164.all;

entity or2_gate is
	port (x, y : in std_logic;
			w : out std_logic);
end or2_gate;

architecture Dataflow of or2_gate is
	begin
		w <= x or y;
end Dataflow;

entity or3_gate is
	port (x, y, z : in std_logic;
			w : out std_logic);
end or3_gate;

architecture Dataflow of or3_gate is
	begin
		w <= x or y or z;
end Dataflow;

entity and2_gate is
	port (x, y : in std_logic;
			w : out std_logic);
end and2_gate;

architecture Dataflow of and2_gate is
	begin
		w <= x and y;
end Dataflow;

entity and3_gate is
	port (x, y, z : in std_logic;
			w : out std_logic);
end and3_gate;

architecture Dataflow of and3_gate is
	begin
		w <= x and y and z;
end Dataflow;

entity not_gate is
	port (x : in std_logic;
			y : out std_logic);
end not_gate;

architecture Dataflow of not_gate is
	begin
		y <= not x;
end Dataflow;

entity Circuit_of_Fig_4_2_vhdl is
	port (A, B, C : in std_logic;
			F1, F2 : out std_logic);
end Circuit_of_Fig_4_2_vhdl;

architecture Structural of Circuit_of_Fig_4_2_vhdl is
	signal : T1, T2, T3, F2_b, E1, E2, E3 : std_logic;
	component or2_gate port (x, y : in std_logic; w : out std_logic);
	component or3_gate port (x, y, z : in std_logic; w : out std_logic);
	component and2_gate port (x, y : in std_logic; w : out std_logic);
	component and3_gate port (x, y, z : in std_logic; w : out std_logic);
	component not_gate port (x : in std_logic; y : out std_logic);
	
	begin
		G1 : or3_gate port map (w => T1, x => A, y => B, z => C);
		G2 : and3_gate port map (w => T2, x => A, y => B, z => C);
		G3 : and2_gate port map (w => E1, x => A, y => B);
		G4 : and2_gate port map (w => E2, x => A, y => C);
		G5 : and2_gate port map (w => E3, x => B, y => C);
		G6 : or3_gate port map (w => F2, x => E1, y => E2, z => E3);
		G7 : not_gate port map (x => F2, y => F2_b);
		G8 : and2_gate port map (w => T3, x => T1, y => F2_b);
		G9 : or2_gate port map (w => F1, x => T2, y => T3);
end Structural;

entity t_Circuit_of_Fig_4_2_vhdl is
	port ();
end t_Circuit_of_Fig_4_2_vhdl;

architecture Test_Bench of t_Circuit_of_Fig_4_2_vhdl is
	signal t_A, t_B, t_C : std_logic;
	signal t_F1, t_F2 : std_logic;
	
	integer k range 0 to 7 : 0;
	
	component Circuit_of_Fig_4_2_vhdl port (A, B, C : in std_logic; F1, F2 : out std_logic);
	-- UUT is a component
	
	begin
		-- Instantiate (by name) the UUT
		UUT : Circuit_of_Fig_4_2_vhdl port map (F1 => t_F1, F2 => t_F2, A => t_A, B => t_B, C => t_C);
		
		-- Apply stimulus signals
		t_A & t_B & t_C <= '000';
		
		while k <= 7 loop
			t_A & t_B & t_C <= t_A & t_B & t_C + '001';
			k := k + 1;
		end loop;
end Test_Bench;
