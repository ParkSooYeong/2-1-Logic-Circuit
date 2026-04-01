entity t_mux_2x1_df_vhdl is
	port ();
end t_mux_2x1_df_vhdl;

architecture Dataflow of t_mux_2x1_df_vhdl is
	signal t_A, t_B, t_C : std_logic;
	signal t_sel : std_logic_vector (1 downto 0);
	signal t_mux_out : std_logic;
	
	component mux_2x1_df_vhdl
		port (A, B : in std_logic;
				C : out std_logic;
				sel : in std_logic);
	end component;
	
	process begin
		-- Stimulus signal assignments
		t_sel <= '1';
		t_A <= '0';
		t_B <= '1';
		wait for 10ns;
		t_A <= '1';
		t_B <= '0';
		wait for 10ns;
		t_sel <= '0';
		wait for 10ns;
		t_A <= '0';
		t_B <= '1';
	end process;
	
	-- Instantiate UUT
	M0 : mux_2x1_df_vhdl port map (A => t_A, B => t_B, C => t_C, sel => t_sel);
end Dataflow;
