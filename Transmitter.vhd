

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:02:46 01/29/2021 
-- Design Name: 
-- Module Name:    Transmitter - Behavioral 
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

entity transmitter is
    Port ( clk,tick : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           tx_done : out  STD_LOGIC;
           serial_output : out  STD_LOGIC;
           datain : in  STD_LOGIC_VECTOR (7 downto 0);
           tx_data : in  STD_LOGIC);
end transmitter;

architecture Behavioral of transmitter is


type state_type is( idle,start,data,stop);
signal state_reg,state_next:state_type;

signal tx_reg,tx_next:std_logic;
signal output_reg,output_next:unsigned(7 downto 0):="00000000";
signal buffer_reg,buffer_next:unsigned(7 downto 0):="00000000";
signal n_reg,n_next,data_count_reg,data_count_next:unsigned(3 downto 0):="0000";

begin

process (clk, reset)
	begin
		if(reset='1') then
			state_reg<= idle;
			buffer_reg <= (others=>'0');
			output_reg <= (others=>'0');
			data_count_reg <= (others=>'0');
			tx_reg<='1';
		elsif(clk'event and clk='1') then
			state_reg<= state_next;
			buffer_reg <= buffer_next;
			output_reg <= output_next;
			data_count_reg <= data_count_next;
			tx_reg<=tx_next;
		end if;
	end process;

	process( state_reg,buffer_reg,tick,tx_data,datain) 
	begin
		n_next<= n_reg;
		state_next<= state_reg;
		tx_done<= '0';
		output_next<= output_reg;
		data_count_next<= data_count_reg;
		case state_reg is
		
			when idle =>
				tx_next<='1';
				if( tx_data='1')then 
					state_next<= start;
					n_next<= "0000";
					output_next<= unsigned(datain);
				end if;
			when start => 
					tx_next<='0';
					if(tick='1') then
						if(n_reg="1111") then
							state_next<= data;
							n_next<= "0000";
							data_count_next<= "0000";
						else
							n_next<= n_reg+1;
							state_next<= start;
						end if;
					end if;
				
				
			when data =>
				tx_next<=output_next(0);
				if( tick='1')then
				if(n_reg="1111") then
					
					output_next<= '0' & output_reg(7 downto 1);
					n_next<= "0000";
					if(data_count_reg="1111") then
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
			when stop =>
				tx_next<= '1';
				if( tick='1')then
				if(n_reg="1111") then
					
					tx_done<= '1';
					state_next<= idle;
				else
					state_next<= stop;
					n_next<= n_reg+1;
					
				end if;
				end if;
			
		end case;
		
	end process;
	serial_output<= tx_reg;
	--dataout<= std_logic_vector(output_reg);
end Behavioral;
