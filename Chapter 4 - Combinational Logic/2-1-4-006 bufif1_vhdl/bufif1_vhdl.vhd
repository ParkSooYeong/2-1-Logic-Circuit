library ieee;
use ieee.std_logic_1164.all;

entity bufif1_vhdl is
	port (buf_in, control : in std_logic;
			buf_out : out std_logic);
end bufif1_vhdl;

architecture Dataflow of bufif1_vhdl is
	begin
		buf_out <= buf_in when control = '1' else 'Z';
end Dataflow;

library ieee;
use ieee.std_logic_1164.all;

entity notif1 is
	port (not_in, control : in std_logic;
			not_out : out std_logic);
end notif1;

architecture Dataflow of notif1 is
	begin
		not_out <= not(not_in) when control = '1' else 'Z';
end Dataflow;
