library ieee;
use ieee.std_logic_1164.all;

entity and_or_prop_delay_vhdl is
	port (A, B, C : in std_logic;
			D : out std_logic;
			E : buffer std_logic);
end and_or_prop_delay_vhdl;

architecture Structure of and_or_prop_delay_vhdl is
	component and2_gate -- 컴포넌트 선언
		port (A, B : in std_logic;
				w1 : out std_logic);
	end component;
	
	component or2_gate -- 컴포넌트 선언
		port (w1, E : in std_logic;
				D : out std_logic);
	end component;
	
	component inv_gate -- 컴포넌트 선언
		port (A : in std_logic;
				B : out std_logic);
	end component;
	
	signal w1 : std_logic;
	
	begin -- 컴포넌트 선언
		G1 : and2_gate port map (A, B, w1);
		G2 : or2_gate port map (w1, E, D);
		G3 : inv_gate port map (C, E);
end architecture Structure;

-- 	G1 : and2_gate port map (
--        A  => A,
--        B  => B,
--        w1 => w1
--    );
--
--    G2 : or2_gate port map (
--        w1 => w1,
--        E  => E,
--        D  => D

--    );
--
--    G3 : inv_gate port map (
--        A => C,
--        B => E
--    );
