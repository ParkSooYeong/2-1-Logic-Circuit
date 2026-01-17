-- 2-입력 and-게이트 컴포넌트를 위한 모델
library ieee;
use ieee.std_logic_1164.all;

entity and2_gate is
	port (A, B : in std_logic;
			w1 : out std_logic);
end and2_gate;

architecture Boolean_Operator of and2_gate is
	begin
		w1 <= A and B after 30ns; -- 지연 시간을 갖는 로직 연산자
end architecture Boolean_Operator;
