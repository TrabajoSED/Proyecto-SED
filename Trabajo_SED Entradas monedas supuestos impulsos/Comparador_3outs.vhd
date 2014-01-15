----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:07:44 12/28/2013 
-- Design Name: 
-- Module Name:    Comparador_3outs - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Comparador_3outs is
    Port ( 	CLK 		: 	in 	STD_LOGIC;
				enable	:	in		STD_LOGIC;
				Total 	: 	in  	STD_LOGIC_VECTOR(7 DOWNTO 0);
				Precio 	: 	in  	STD_LOGIC_VECTOR(7 DOWNTO 0);
				Mayor 	: 	out  	STD_LOGIC;
				Igual 	: 	out  	STD_LOGIC;
				Menor 	: 	out  	STD_LOGIC
			);
end Comparador_3outs;

architecture Behavioral of Comparador_3outs is

begin

process(CLK)
begin
   if (CLK'event and CLK ='1') then   
		if (enable = '1') then
			if ( Total > Precio ) then 
				Mayor <= '1';
				Igual <='0';
				Menor <='0';
			elsif (Total = Precio) then 
				Mayor <='0';
				Igual <= '1';
				Menor <='0';
			elsif (Total < Precio) then
				Mayor <='0';
				Igual <='0';
				Menor <='1';
			end if;
		elsif enable = '0' then
			Mayor <='0';
			Igual <='0';
			Menor <='0';
		end if; 
	end if;
end process; 
    
end Behavioral;

