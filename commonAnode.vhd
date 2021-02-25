----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:52:22 04/24/2018 
-- Design Name: 
-- Module Name:    CommonAnode - Behavioral 
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
use ieee.std_logic_arith.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CommonAnode is
    Port ( clk: in std_logic; 
			DataIn : in  STD_LOGIC_VECTOR (7 downto 0);
           A,B,C,D,E,F,G,H : out  STD_LOGIC;
			  enable : out  STD_LOGIC_VECTOR (3 DOWNTO 0));
end CommonAnode;

architecture Behavioral of CommonAnode is

signal Counter  : std_logic_vector(20 downto 0):="000000000000000000000";
signal Counter2  : std_logic_vector(3 downto 0):=(others=>'0');
signal temp1  : std_logic_vector(7 downto 0):=(others=>'0');
signal temp2  : std_logic_vector(7 downto 0):=(others=>'1');
begin
	temp1<=  "00000011" when DataIn="00110000" else --0
				"11110011" when DataIn="00110001" else --1
				"00100101" when DataIn="00110010" else --2
				"00001101" when DataIn="00110011" else --3
				"10011001" when DataIn="00110100" else --4
				"01001001" when DataIn="00110101" else --5
				"01000001" when DataIn="00110110" else--6
				"00011111" when DataIn="00110111" else--7
				"00000001" when DataIn="00111000" else--8
				"00001001" when DataIn="00111001" else--9
				"00000101" when DataIn="01100001" else--a
				"11000001" when DataIn="01100010" else--b
				"11100101" when DataIn="01100011" else--c
				"10000101" when DataIn="01100100" else--d
				"00100001" when DataIn="01100101" else--e
				"01110001" when DataIn="01100110" else--f
				"00001001" when DataIn="01100111" else--g
				"11010001" when DataIn="01101000" else--h
				"11110011" when DataIn="01101001" else--i
				"10001111" when DataIn="01101010" else--j
				"11100001" when DataIn="01101011" else--k
				"11110011" when DataIn="01101100" else--l
				"00001101" when DataIn="01101101" else--m
				"11010101" when DataIn="01101110" else--n
				"11000101" when DataIn="01101111" else--o
				"00110001" when DataIn="01110000" else--p
				"00011001" when DataIn="01110001" else--q
				"11110101" when DataIn="01110010" else--r
				"01001001" when DataIn="01110011" else--s
				"11100001" when DataIn="01110100" else--t
				"11000111" when DataIn="01110101" else--u
				"11000111" when DataIn="01110110" else--v
				"01100001" when DataIn="01110111" else--w
				"10010001" when DataIn="01111000" else--x
				"10001001" when DataIn="01111001" else--y
				"00100101" when DataIn="01111010" else--z
				"00010001" when DataIn="01000001" else--A
				"00000001" when DataIn="01000010" else--B
				"01100011" when DataIn="01000011" else--C
				"00000011" when DataIn="01000100" else--D
				"01100001" when DataIn="01000101" else--E
				"01110001" when DataIn="01000110" else--F
				"10111101" when DataIn="01000111" else--G
				"10010001" when DataIn="01001000" else--H
				"11110011" when DataIn="01001001" else--I
				"10001111" when DataIn="01001010" else--J
				"11100001" when DataIn="01001011" else--K
				"11100011" when DataIn="01001100" else--L
				"00001101" when DataIn="01001101" else--M
				"11010101" when DataIn="01001110" else--N
				"00000011" when DataIn="01001111" else--O
				"00110001" when DataIn="01010000" else--P
				"00011001" when DataIn="01010001" else--Q
				"00010001" when DataIn="01010010" else--R
				"01001001" when DataIn="01010011" else--S
				"01110011" when DataIn="01010100" else--T
				"10000011" when DataIn="01010101" else--U
				"10000011" when DataIn="01010110" else--V
				"01100001" when DataIn="01010111" else--W
				"10010001" when DataIn="01011000" else--X
				"10011001" when DataIn="01011001" else--Y
				"00100101" when DataIn="01011010" else--Z
				not DataIn;
	--enable<="0111";
	
	process(clk)
	begin
	if(Clk='1' and Clk'event)then
	     Counter <= Counter + 1;
		  if (Counter(15)='1' ) then
				Counter2 <= Counter2 + 1;
				if (Counter2 = "0001") then
					A <=temp1(7);
					B <=temp1(6);
					C <=temp1(5);
					D <=temp1(4);
					E <=temp1(3);
					F <=temp1(2);
					G <=temp1(1);
					H <=temp1(0);
					Enable(0) <= '1';
					Enable(1) <= '1';
					Enable(2) <= '1';
					Enable(3) <= '0';
					Counter <= "000000000000000000000";
					
				elsif (Counter2 = "0010") then
					A <=temp2(7);
					B <=temp2(6);
					C <=temp2(5);
					D <=temp2(4);
					E <=temp2(3);
					F <=temp2(2);
					G <=temp2(1);
					H <=temp2(0);
					Enable(0) <= '1';
					Enable(1) <= '1';
					Enable(2) <= '0';
					Enable(3) <= '1';
					Counter <= "000000000000000000000";
					
				elsif (Counter2 = "0011") then
					A <=temp2(7);
					B <=temp2(6);
					C <=temp2(5);
					D <=temp2(4);
					E <=temp2(3);
					F <=temp2(2);
					G <=temp2(1);
					H <=temp2(0);
					Enable(0) <= '1';
					Enable(1) <= '0';
					Enable(2) <= '1';
					Enable(3) <= '1';
					Counter <= "000000000000000000000";
				
				elsif (Counter2 = "0100") then
					A <=temp2(7);
					B <=temp2(6);
					C <=temp2(5);
					D <=temp2(4);
					E <=temp2(3);
					F <=temp2(2);
					G <=temp2(1);
					H <=temp2(0);
					Enable(0) <= '0';
					Enable(1) <= '1';
					Enable(2) <= '1';
					Enable(3) <= '1';
					Counter2 <= "0000";
					Counter <= "000000000000000000000";
				end if;
			end if;	
	end if;
	end process;
							

end Behavioral;

