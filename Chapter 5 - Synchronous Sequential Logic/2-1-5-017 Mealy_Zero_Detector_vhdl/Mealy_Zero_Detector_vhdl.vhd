library ieee;
use ieee.std_logic_1164.all;
 
entity Mealy_Zero_Detector_vhdl is
	port (x_in, clock, reset : in std_logic;
			y_out : out std_logic);
end Mealy_Zero_Detector_vhdl;
 
architecture Behavioral of Mealy_Zero_Detector_vhdl is
	type state_type is (S0, S1, S2, S3);
	signal state, next_state : state_type;
begin
	process (clock, reset) begin
		if reset = '0' then 
			state <= S0;
		elsif rising_edge(clock) then 
			state <= next_state;
		end if;
	end process;
	
	process (state, x_in) begin
		case (state) is
			when S0 => 
				if x_in = '1' then 
					next_state <= S1; 
				else 
					next_state <= S0; 
				end if;
			when S1 => 
				if x_in = '1' then 
					next_state <= S0; 
				else 
					next_state <= S0; 
				end if;
			when S2 => 
				if x_in = '0' then 
					next_state <= S0; 
				else 
					next_state <= S2; 
				end if;
			when S3 => 
				if x_in = '1' then 
					next_state <= S2; 
				else 
					next_state <= S0; 
				end if;
			when others => 
				next_state <= S0;
		end case;
	end process;
	
	process (state, x_in) begin
		case (state) is
			when S0 => 
				y_out <= '0';
			when S1 => 
				y_out <= not x_in;
			when S2 => 
				y_out <= not x_in;
			when S3 => 
				y_out <= not x_in;
			when others =>
				y_out <= '0';
		end case;
	end process;
end Behavioral;
 
-- ============================================================================
-- TESTBENCH
-- ============================================================================

library ieee;
use ieee.std_logic_1164.all;

entity t_Mealy_Zero_Detector_vhdl is
end t_Mealy_Zero_Detector_vhdl;
 
architecture Behavioral of t_Mealy_Zero_Detector_vhdl is
	signal t_x_in : std_logic;
	signal t_y_out : std_logic;
	signal t_clock : std_logic := '0';
	signal t_reset : std_logic;
begin
	UUT : entity work.Mealy_Zero_Detector_vhdl 
		port map (
			x_in => t_x_in,
			y_out => t_y_out,
			clock => t_clock,
			reset => t_reset
		);
	
	-- Clock generation process
	process begin
		t_clock <= '0';
		wait for 5 ns;
		t_clock <= '1';
		wait for 5 ns;
	end process;
	
	-- Test stimulus process
	process begin
		t_reset <= '0';
		wait for 2 ns;
		t_reset <= '1';
		wait for 85 ns;
		t_reset <= '0';
		wait for 2 ns;
		t_reset <= '1';
		
		t_x_in <= '0';
		wait for 10 ns;
		t_x_in <= '1';
		wait for 20 ns;
		t_x_in <= '0';
		wait for 10 ns;
		t_x_in <= '1';
		wait for 10 ns;
		t_x_in <= '0';
		wait for 2 ns;
		t_x_in <= '1';
		wait for 2 ns;
		t_x_in <= '0';
		wait for 16 ns;
		t_x_in <= '1';
		wait for 10 ns;
		t_x_in <= '0';
		wait for 10 ns;
		t_x_in <= '1';
		wait for 10 ns;
		t_x_in <= '0';
		wait for 20 ns;
		t_x_in <= '1';
		wait for 40 ns;
		t_x_in <= '0';
		wait for 10 ns;
		t_x_in <= '1';
		wait;
	end process;
end Behavioral;
 