library ieee;
use ieee.std_logic_1164.all;

entity decoder_2x4_df_beh_vhdl is
	port (A, B, enable : in std_logic;
			D : out std_logic_vector (3 downto 0));
end decoder_2x4_df_beh_vhdl;

architecture behavioral of decoder_2x4_df_beh_vhdl is
	begin
		process (A, B, enable)
			begin
				D(0) <= not ((not A) and (not B) and (not enable));
				D(1) <= not ((not A) and B and (not enable));
				D(2) <= not (A and (not B) and (not enable));
				D(3) <= not (A and B) and (not enable);
		end process;
end behavioral;
