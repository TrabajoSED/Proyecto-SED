----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:45:25 12/28/2013 
-- Design Name: 
-- Module Name:    Comprobador - Behavioral 
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

entity Comprobador is
    Port ( CLK: in STD_LOGIC;
			  OK : in  STD_LOGIC;
           Codigo_Pdto : in  STD_LOGIC_VECTOR (1 downto 0);
           Pdto : out  STD_LOGIC_VECTOR(1 downto 0);
			  Tf: out STD_LOGIC
			  );
end Comprobador;

architecture Behavioral of Comprobador is

begin

process(CLK)--Cuando recibe el ok del comparador de monedas, indica el codigo del producto al actuador
	begin
	
	if(CLK'event and CLK='1')then
		if( OK='1') then 
			Pdto<=Codigo_Pdto;
			Tf<= '1';
		else
			Pdto<="00";
			Tf<='0';
		end if;
	end if;
end process;

end Behavioral;

