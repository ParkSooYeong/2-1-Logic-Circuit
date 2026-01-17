-- 인버터 컴포넌트를 위한 모델
library ieee;
use ieee.std_logic_1164.all;

entity inv_gate is
	port (A : in std_logic;
			B : out std_logic);
end inv_gate;

architecture Boolean_Operator of inv_gate is
	begin
		B <= not A after 10ns;
end architecture Boolean_Operator;
