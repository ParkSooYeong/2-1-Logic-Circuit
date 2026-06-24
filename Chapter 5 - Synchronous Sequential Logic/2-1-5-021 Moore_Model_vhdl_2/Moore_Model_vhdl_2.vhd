library ieee;
use ieee.std_logic_1164.all;

entity Moore_Model_vhdl_2 is
    port (
        x_in  : in  std_logic;
        clk   : in  std_logic;
        rst_b : in  std_logic;
        y_out : out std_logic
    );
end Moore_Model_vhdl_2;

architecture Behavioral of Moore_Model_vhdl_2 is
    type state_type is (S0, S1, S2, S3);
    signal state : state_type;
begin

    process(clk, rst_b)
    begin
        if rst_b = '0' then
            state <= S0;

        elsif clk'event and clk = '1' then
            case state is
                when S0 =>
                    if x_in = '1' then state <= S1;
                    else state <= S0;
                    end if;

                when S1 =>
                    if x_in = '1' then state <= S2;
                    else state <= S1;
                    end if;

                when S2 =>
                    if x_in = '1' then state <= S3;
                    else state <= S2;
                    end if;

                when S3 =>
                    if x_in = '1' then state <= S0;
                    else state <= S3;
                    end if;
            end case;
        end if;
    end process;

    y_out <= '1' when state = S3 else '0';

end Behavioral;


library ieee;
use ieee.std_logic_1164.all;

entity Toggle_Flip_Flop is
    port (
        T     : in  std_logic;
        clk   : in  std_logic;
        rst_b : in  std_logic;
        Q     : out std_logic
    );
end Toggle_Flip_Flop;

architecture Behavioral of Toggle_Flip_Flop is
    signal Q_int : std_logic := '0';
begin

    process(clk, rst_b)
    begin
        if rst_b = '0' then
            Q_int <= '0';

        elsif clk'event and clk = '1' then
            if T = '1' then
                Q_int <= not Q_int;
            else
                Q_int <= Q_int;
            end if;
        end if;
    end process;

    Q <= Q_int;

end Behavioral;


library ieee;
use ieee.std_logic_1164.all;

entity Moore_Model_STR_vhdl_2 is
    port (
        x_in  : in  std_logic;
        clk   : in  std_logic;
        rst_b : in  std_logic;
        y_out : out std_logic;
        A     : out std_logic;
        B     : out std_logic
    );
end Moore_Model_STR_vhdl_2;

architecture Structural of Moore_Model_STR_vhdl_2 is
    signal TA, TB : std_logic;
    signal A_int, B_int : std_logic;
begin

    TA <= x_in and B_int;
    TB <= x_in;

    TFF_A : entity work.Toggle_Flip_Flop
        port map (
            T     => TA,
            clk   => clk,
            rst_b => rst_b,
            Q     => A_int
        );

    TFF_B : entity work.Toggle_Flip_Flop
        port map (
            T     => TB,
            clk   => clk,
            rst_b => rst_b,
            Q     => B_int
        );

    A <= A_int;
    B <= B_int;

    y_out <= A_int and B_int;

end Structural;
