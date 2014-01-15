----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:04:36 01/13/2014 
-- Design Name: 
-- Module Name:    Restador - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Restador is
    Port ( total 		: 	in  	STD_LOGIC_VECTOR (7 downto 0);
           precio 	: 	in  	STD_LOGIC_VECTOR (7 downto 0);
           enable 	: 	in  	STD_LOGIC;
			  clk			:	in		STD_LOGIC;
           devolver 	: 	out  	STD_LOGIC_VECTOR (7 downto 0);
           ok 			: 	out  	STD_LOGIC
			 );
end Restador;

-- ENABLE DEBERIA LLAMARSE RESET

architecture Behavioral of Restador is
begin
	process(enable,clk)
	begin 
	
		if enable='0' then
				ok<='0';
				devolver <= (OTHERS => '0');
				
		elsif (clk'event and clk='1') then
			-- if enable='1' then ya con el else enable debe ser 1
				devolver <= total - precio;
				ok<='1';
			--end if;
		end if;	
	end process;
end Behavioral;

