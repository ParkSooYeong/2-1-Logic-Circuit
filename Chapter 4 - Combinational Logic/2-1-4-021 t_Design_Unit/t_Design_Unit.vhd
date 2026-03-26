entity t_Design_Unit is
	-- Empty
end;

architecture Test_Bench of t_Design_Unit is
	-- Declare component of design unit to be tested
	component Design_Unit
		port (A, B, sel : in bit;
				m_out : out bit);
	end Design_Unit;
	
	-- Declare stimulus signals
	signal t_A, t_B, t_sel : bit;
	
	-- Declare response signals
	signal t_m_out : bit;
	
	begin
		-- Instantiate unit under test
		UUT : Design_Unit port map (t_A, t_B, t_sel, t_m_out);
		-- Declare process to generate stimulus
		process begin
			t_A <= '1';
			t_B <= '0';
		end process;
		
		process begin
			sel <= '1';
			wait for 10ns;
			sel <= '0';
		end process;
end Test_Bench
