library ieee;
use ieee.std_logic_1164.all;

-- D Flip-Flop Module
entity DFF_vhdl is
	port (
		D   : in  std_logic;
		clk : in  std_logic;
		rst : in  std_logic;
		Q   : out std_logic
	);
end DFF_vhdl;

architecture Behavioral of DFF_vhdl is
begin
	process(clk, rst)
	begin
		if rst = '1' then
			Q <= '0';
		elsif rising_edge(clk) then
			Q <= D;
		end if;
	end process;
end Behavioral;


-- T Flip-Flop Module
library ieee;
use ieee.std_logic_1164.all;

entity T_Flip_Flop_vhdl is
	port (
		T, clk, rst : in std_logic;
		Q           : buffer std_logic
	);
end T_Flip_Flop_vhdl;

architecture Behavioral of T_Flip_Flop_vhdl is

	component DFF_vhdl
		port (
			D   : in  std_logic;
			clk : in  std_logic;
			rst : in  std_logic;
			Q   : out std_logic
		);
	end component;

	signal DT : std_logic;

begin

	DT <= Q xor T;

	M0 : DFF_vhdl
		port map (
			D   => DT,
			clk => clk,
			rst => rst,
			Q   => Q
		);

end Behavioral;
