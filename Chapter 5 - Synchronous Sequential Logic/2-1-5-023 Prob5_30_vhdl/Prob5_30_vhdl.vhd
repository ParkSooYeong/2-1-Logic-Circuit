library ieee;
use ieee.std_logic_1164.all;

entity Prob5_30_vhdl is
    port (
        A   : in  std_logic;
        B   : in  std_logic;
        C   : in  std_logic;
        clk : in  std_logic;
        E   : out std_logic;
        Q   : out std_logic
    );
end Prob5_30_vhdl;

architecture Behavioral of Prob5_30_vhdl is

    signal E_reg : std_logic := '0';
    signal Q_reg : std_logic := '0';

begin

    process(clk)
    begin
        if clk'event and clk = '1' then
            E_reg <= A or B;
            Q_reg <= E_reg and C;
        end if;
    end process;

    E <= E_reg;
    Q <= Q_reg;

end Behavioral;
