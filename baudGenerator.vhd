

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:02:46 01/29/2021 
-- Design Name: 
-- Module Name:     Baud Generator - Behavioral 
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

entity baudgen is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           tick : out  STD_LOGIC);
end baudgen;

architecture Behavioral of baudgen is

constant clock: integer := 24000000;
constant baudrate: integer := 115200;
constant divide: integer := 16; 

signal temp1, temp2 :integer RANGE 0 TO 100000000:=0;
signal clkdiv_reg,clkdiv_next:unsigned(26 downto 0):=(others=>'0');


begin

	process (clk, reset)
	begin
	
		if(reset='1') then		
			clkdiv_reg <= (others=>'0');
		elsif(clk'event and clk='1') then
			clkdiv_reg <= clkdiv_next;
		end if;
		
	end process;
	
	temp1<= clock/ (divide * baudrate);
	
	clkdiv_next <= (others=>'0') when (clkdiv_reg= (temp1 - 1)) else
			clkdiv_reg+1;
			
	tick <= '1' when clkdiv_reg=0 else '0';

end Behavioral;
