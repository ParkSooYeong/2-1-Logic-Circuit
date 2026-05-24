library ieee;
use ieee.std_logic_1164.all;

entity JK_Flip_Flop_vhdl_2 is
	port (J, K, clk, rst : in std_logic; Q, Q_b : buffer std_logic);
end JK_Flip_Flop_vhdl_2;

architecture Behavioral_Case_vhdl of JK_Flip_Flop_vhdl_2 is
	signal JK : std_logic_vector(1 downto 0);
begin
	JK <= J & K;
	Q_b <= not Q;
	process (clk) begin
		if (clk'event and clk = '1') then
			if (rst = '1') then Q <= '0';
			else case JK is
				when "00" => Q <= Q;
				when "01" => Q <= '0';
				when "10" => Q <= '1';
				when "11" => Q <= not Q;
				when others => null;
			end case;
			end if;
		end if;
	end process;
end Behavioral_Case_vhdl;
