library ieee;
use ieee.std_logic_1164.all;

entity and_or_prop_delay_vhdl_tb is
end and_or_prop_delay_vhdl_tb;

architecture tb of and_or_prop_delay_vhdl_tb is

    -- DUT 포트와 연결될 신호 선언
    signal A, B, C : std_logic := '0';
    signal D       : std_logic;
    signal E       : std_logic;

begin

    -- DUT 인스턴스
    UUT : entity work.and_or_prop_delay_vhdl
        port map (
            A => A,
            B => B,
            C => C,
            D => D,
            E => E
        );

    -- 입력 자극 프로세스
    stim_proc : process
    begin
        -- 초기 상태
        A <= '0'; B <= '0'; C <= '0';
        wait for 100 ns;

        -- 입력 변화 1
        A <= '1'; B <= '0'; C <= '0';
        wait for 100 ns;

        -- 입력 변화 2
        A <= '0'; B <= '1'; C <= '0';
        wait for 100 ns;

        -- 입력 변화 3
        A <= '1'; B <= '1'; C <= '0';
        wait for 100 ns;

        -- 입력 변화 4 (C 변화 → inv_gate 영향 확인)
        A <= '0'; B <= '0'; C <= '1';
        wait for 100 ns;

        -- 입력 변화 5
        A <= '1'; B <= '0'; C <= '1';
        wait for 100 ns;

        -- 입력 변화 6
        A <= '0'; B <= '1'; C <= '1';
        wait for 100 ns;

        -- 입력 변화 7
        A <= '1'; B <= '1'; C <= '1';
        wait for 100 ns;

        -- 시뮬레이션 종료
        wait;
    end process;

end architecture tb;
