-- 2-입력 or-게이트 컴포넌트를 위한 모델
library ieee;
use ieee.std_logic_1164.all;

entity or2_gate is
	port (w1, E : in std_logic;
			D : out std_logic);
end or2_gate;

architecture Boolean_Operator of or2_gate is
	begin
		D <= w1 or E after 20ns; -- 로직 연산자
end architecture Boolean_Operator;
