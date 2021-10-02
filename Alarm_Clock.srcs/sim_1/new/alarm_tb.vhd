LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity alarm_tb is
--  Port ( );
end alarm_tb;

architecture Behavioral of alarm_tb is

signal clk : std_logic := '0';
-- To hold alarm time
signal alarm_hours_msb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal alarm_hours_lsb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); 
signal alarm_mins_msb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal alarm_mins_lsb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); 
signal alarm_sec_msb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal alarm_sec_lsb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); 
-- To hold clock time
signal clock_hours_msb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal clock_hours_lsb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); 
signal clock_mins_msb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal clock_mins_lsb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); 
signal clock_sec_msb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal clock_sec_lsb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
-- To hold running clock time
signal run_clock_hours_msb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal run_clock_hours_lsb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); 
signal run_clock_mins_msb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal run_clock_mins_lsb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); 
signal run_clock_sec_msb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal run_clock_sec_lsb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
-- To hold time change
--signal set_clock_hours_msb : STD_LOGIC_VECTOR(3 downto 0);
--signal set_clock_hours_lsb : STD_LOGIC_VECTOR(3 downto 0); 
--signal set_clock_mins_msb : STD_LOGIC_VECTOR(3 downto 0);
--signal set_clock_mins_lsb : STD_LOGIC_VECTOR(3 downto 0); 
--signal set_clock_sec_msb : STD_LOGIC_VECTOR(3 downto 0);
--signal set_clock_sec_lsb : STD_LOGIC_VECTOR(3 downto 0);
-- Numbers to be displayed
signal disp_hours_msb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal disp_hours_lsb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal disp_mins_msb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal disp_mins_lsb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal disp_sec_msb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal disp_sec_lsb : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

signal clock_time : std_logic_vector(23 downto 0);
--signal alarm_time : std_logic_vector(23 downto 0);
signal enable :std_logic := '0';

signal set_time : std_logic := '0';
signal set_alarm : std_logic := '0';
--signal toggle_alarm : std_logic;
--signal mins_up : std_logic;

begin

--    alarm_clock: entity work.Alarm(Behavioral)
--        port map(
--            clk => clk,
--            set_time => set_time,
--            set_alarm => set_alarm,
--            toggle_alarm => toggle_alarm,
--            hrs_up => '0',
--            hrs_dwn => '0',
--            mins_up => mins_up,
--            mins_dwn => '0',
--            sec_reset => '0'
--        );
        
        -- Run the clock for the simulation
        clk_process: process
        begin            
            
            for i in 0 to 86400 loop -- simulate 24 hours (clk edge every ms instead of second) 
                wait for 1ms;
                clk <= '1';
                wait for 1ms;
                clk <= '0';
            end loop;
            
            wait;
        
        end process;
        
       
        
    output: -- This controls output display
    process(clk)
    begin
        
        -- Display the alarm time if set alarm is toggled
        if(set_alarm = '1' and set_time = '0') then
            disp_hours_msb <= alarm_hours_msb;
            disp_hours_lsb <= alarm_hours_lsb;
            disp_mins_msb <= alarm_mins_msb;
            disp_mins_lsb <= alarm_mins_lsb;
            disp_sec_msb <= alarm_sec_msb;
            disp_sec_lsb <= alarm_sec_lsb;
        
        -- Display clock time otherwise    
        else
            disp_hours_msb <= clock_hours_msb;
            disp_hours_lsb <= clock_hours_lsb;
            disp_mins_msb <= clock_mins_msb;
            disp_mins_lsb <= clock_mins_lsb;
            disp_sec_msb <= clock_sec_msb;
            disp_sec_lsb <= clock_sec_lsb;
        end if;
        
    end process;
    
    run_clock:
    process(clk)
    begin
            
            -- Update Time
            if(rising_edge(clk)) then
                
                if(enable = '0') then
                    clock_sec_lsb <= clock_sec_lsb + "0001";
                    if(clock_sec_lsb = "1001") then -- at 9, set to zero and increment msb
                        clock_sec_lsb <= "0000";
                        clock_sec_msb <= clock_sec_msb + "0001";
                        if(clock_sec_msb = "0101") then -- if = 5
                            clock_sec_msb <= "0000";
                            clock_mins_lsb <= clock_mins_lsb + "0001";
                            if(clock_mins_lsb = "1001") then -- if = 9
                                clock_mins_lsb <= "0000";
                                clock_mins_msb <= clock_mins_msb + "0001";
                                if(clock_mins_msb = "0101") then -- if = 5
                                    clock_mins_msb <= "0000";
                                    clock_hours_lsb <= clock_hours_lsb + "0001";
                                    if(not (clock_hours_msb = "0010")) then --  MSB != 2
                                        if(clock_hours_lsb = "1001") then -- lsb = 9
                                            clock_hours_lsb <= "0000";
                                            clock_hours_msb <= clock_hours_msb + "0001";
                                        end if;
                                    elsif(clock_hours_msb = "0010") then
                                        if(clock_hours_lsb = "0011") then -- lsb = 3
                                            clock_hours_lsb <= "0000";
                                            clock_hours_msb <= "0000";
                                        end if;
                                    end if;
                                end if;
                            end if;
                        end if;
                        
                    end if;
               
                end if;
            end if;
                
    end process;


end Behavioral;

