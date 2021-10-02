library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PWM is
    PORT(
       clk : in std_logic;
       pwm : out std_logic;
       sd : out std_logic 
    );
end PWM;

architecture Behavioral of PWM is
component PWMDriver is
    Port ( 
       clk : in STD_LOGIC;
       pwm_level : in STD_LOGIC_VECTOR (9 downto 0);
       pwm_out : out STD_LOGIC);
end component;

COMPONENT dist_mem_gen_0
  PORT (
    a : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    spo : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
  );
END COMPONENT;

signal count : unsigned(16 downto 0) := (others => '0');
constant freq : integer := 543;

signal lut_addr : unsigned(9 downto 0) := (others => '0');
signal lut_out : std_logic_vector(9 downto 0) := (others => '0');

signal pwm_int : std_logic := '0';

begin

pd0 : PWMDriver
port map(
    clk => clk,
    pwm_level => lut_out,
    pwm_out => pwm_int
);

dmg0 : dist_mem_gen_0
  PORT MAP (
    a => std_logic_vector(lut_addr),
    spo => lut_out
);

PWM <= '0' when pwm_int = '0' else 'Z';

process(CLK)
begin
    if rising_edge(CLK) then
        if count = freq then
            lut_addr <= lut_addr + 1;
            count <= (others => '0');
        else
            count <= count + 1;
        end if;
    end if;
end process;

end Behavioral;