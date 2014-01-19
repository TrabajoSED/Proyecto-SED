----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:26:42 12/27/2013 
-- Design Name: 
-- Module Name:    Sumador - Behavioral 
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

entity Sumador is
    Port ( 
			  CLK: in STD_LOGIC;
			  Valor : in  STD_LOGIC_VECTOR (7 downto 0);
           Enable : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Total : out  STD_LOGIC_VECTOR (7 downto 0));
end Sumador;

architecture Behavioral of Sumador is

signal Suma: STD_LOGIC_VECTOR(7 DOWNTO 0):="00000000";
begin

process(Reset,CLK) 
begin
	if Reset = '1' then --
		Suma <= (OTHERS => '0'); --resetea la suma		
		
	elsif( CLK'event and CLK='1') then

		if	Enable='1' then -- CAMBIADO; ENABLE YA VA POR EL FLANCO DEL RELOJ NO DEJA SU PROPIO FLANCO	
			Suma<=Suma+Valor;--Suma el valor acumulado hasta entonces más la entrada
		
		end if;	
	end if;
end process;

Total<=Suma;

end Behavioral;

