
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Sahar Ghoflsaz
-- 
-- Create Date:    18:02:46 01/29/2021 
-- Design Name: 
-- Module Name:    Receiver - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity receiver is
    Port ( clk,tick : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           rx_done : out  STD_LOGIC;
           serial_input : in  STD_LOGIC;
           dataout : out  STD_LOGIC_VECTOR (7 downto 0));
           --rx_data : in  STD_LOGIC);
end receiver;

architecture Behavioral of receiver is


type state_type is( idle,start,data,stop);
signal state_reg,state_next:state_type;

signal output_reg,output_next:unsigned(7 downto 0):="00000000";
signal buffer_reg,buffer_next:unsigned(7 downto 0):="00000000";
signal n_reg,n_next,data_count_reg,data_count_next:unsigned(3 downto 0):="0000";

begin

	process (clk, reset)
	begin
		if(reset='1') then
			state_reg<= idle;
			--buffer_reg <= (others=>'0');
			output_reg <= (others=>'0');
			data_count_reg <= (others=>'0');
			n_reg<= (others=>'0');
			
		elsif(clk'event and clk='1') then
			state_reg<= state_next;
			--buffer_reg <= buffer_next;
			output_reg <= output_next;
			data_count_reg <= data_count_next;
			n_reg <= n_next;
		end if;
	end process;

	process( tick,state_reg,serial_input,n_reg,data_count_reg,output_reg) 
	begin
		n_next<= n_reg;
		state_next<= state_reg;
		rx_done<= '0';
		output_next<= output_reg;
		data_count_next <= data_count_reg;
		
		case state_reg is
		
-------------------------waiting for start ---
		
			when idle =>
				
				if(serial_input='1') then
						state_next<= idle;
				else
						state_next<= start;
						n_next<= (others=>'0');
				end if;
		
----------------receive start bit ------------		
		
			when start =>
				if( tick='1')then
					if(n_reg="0111") then		
						state_next<= data;
						n_next<= "0000";
						data_count_next<= "0000";
					else
						n_next<= n_reg+1;
						state_next<= start;
					end if;
				end if;			

---------------receive data ------------------				
				
			when data =>
				if( tick='1')then
					if(n_reg="1111") then
						output_next<= serial_input & output_reg(7 downto 1);
						n_next<= "0000";
						if(data_count_reg="0111") then
						state_next<= stop;
						--n_next<= "0000";
						else
							data_count_next<= data_count_reg+1;
							state_next<= data;
						end if;
					else
						state_next<= data;
						n_next<= n_reg+1;
					end if;
				end if;
				
---------------receive stop bit -----------------
				
			when stop =>
				if(tick='1')then
					if(n_reg="1111") then
						rx_done<= '1';
						state_next<= idle;
					else
						state_next<= stop;
						n_next<= n_reg+1;
					end if;
				end if;
			
		end case;
		
	end process;
	dataout<= std_logic_vector(output_reg);
end Behavioral;

