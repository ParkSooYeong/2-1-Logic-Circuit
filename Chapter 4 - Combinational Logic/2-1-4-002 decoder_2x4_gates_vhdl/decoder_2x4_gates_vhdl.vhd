library ieee;
use ieee.std_logic_1164.all;

-- Declare entity-architecture pairs that will be components
-- Model for inverter component

entity inv_gate is
	port (B : out std_logic;
			A : in std_logic);
end inv_gate;

architecture Boolean_Equation of inv_gate is
	begin
		B <= not A;
end Boolean_Equation;

library ieee;
use ieee.std_logic_1164.all;

entity nand3_gate is
	port (D : out std_logic;
			A, B, C : in std_logic);
end nand3_gate;

architecture Boolean_Eq of nand3_gate is
	begin
		D <= not (A and B and C);
end Boolean_Eq;

library ieee;
use ieee.std_logic_1164.all;

-- Gate-level description of two-to-four line decoder

entity decoder_2x4_gates_vhdl is
	port (A, B, enable : in std_logic;
			D : out std_logic_vector(0 to 3));
end decoder_2x4_gates_vhdl;

architecture Structure of decoder_2x4_gates_vhdl is
	-- Identify components and ports
	component inv_gate
		port (B : out std_logic;
				A : in std_logic);
	end component;
		
	component nand3_gate
		port (D : out std_logic;
				A, B, C : in std_logic);
	end component;
		
	signal A_not, B_not, enable_not : std_logic; -- Internal signals
	
	begin -- Instance components and connect ports via port maps
		G1 : inv_gate port map (A_not, A);
		G2 : inv_gate port map (B_not, B);
		G3 : inv_gate port map (enable_not, enable);
		
		G4 : nand3_gate port map (D(0), A_not, B_not, enable_not);
		G5 : nand3_gate port map (D(1), A_not, B, enable_not);
		G6 : nand3_gate port map (D(2), A, B_not, enable_not);
		G7 : nand3_gate port map (D(3), A, B, enable_not);
end Structure;
