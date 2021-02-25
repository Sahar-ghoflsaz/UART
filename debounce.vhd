----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:20:15 02/17/2021 
-- Design Name: 
-- Module Name:    debounce - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity debounce is
   port(
      clk: in std_logic;
		reset: in std_logic;
      input: in std_logic;
      debounced: out std_logic
   );
end debounce ;

architecture rtl of debounce is
  
   type state_type is (idle, debounce1, detect, debounce2);
   signal state_reg, state_next: state_type;
   signal q_reg, q_next: unsigned(20 downto 0);

begin

   process(clk,reset)
   begin
      if reset='1' then
         state_reg <= idle;
         q_reg <= (others=>'0');
      elsif (clk'event and clk='1') then
         state_reg <= state_next;
         q_reg <= q_next;
      end if;
   end process;


   process(state_reg,input,q_reg)
   begin
      
      debounced <= '0';
      state_next <= state_reg;
		q_next <= q_reg;
      case state_reg is
		
         when idle =>
 
            if (input='1') then	
					q_next <= (others=>'1');
               state_next <= debounce1;
            end if;
				
         when debounce1=>
            
            if (input='1') then
               q_next <= q_reg - 1; 
               if (q_next=0) then
                  state_next <= detect;
                  debounced <= '1';
               end if;
            else 
               state_next <= idle;
            end if;
				
         when detect =>
			
            if (input='0') then
					q_next <= (others=>'1');
               state_next <= debounce2;
            end if;
				
         when debounce2=>
            
            if (input='0') then
               q_next <= q_reg - 1;
               if (q_next/=0) then
                  state_next <= idle;
               end if;
            else 
               state_next <= detect;
            end if;
				
      end case;
   end process;
end rtl;
