----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:25:09 12/27/2013 
-- Design Name: 
-- Module Name:    Codificador_Monedas - Behavioral 
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

entity Codificador_Monedas is
    Port ( CLK: in STD_LOGIC;
			  V : in  STD_LOGIC;
           X : in  STD_LOGIC;
           XX : in  STD_LOGIC;
           L : in  STD_LOGIC;
           C : in  STD_LOGIC;
           CC : in  STD_LOGIC;
           Valor : out  STD_LOGIC_VECTOR(7 DOWNTO 0);
           Enable : out  STD_LOGIC);
end Codificador_Monedas;

architecture Behavioral of Codificador_Monedas is

begin

process (CLK)
	begin -- Modificado por javi l. condicion
	if (CLK'event and CLK='1') then 
		if (V='1') then --Moneda 5 cent
			Valor<="00000101";
			Enable<='1';
	
		elsif (X='1') then--Moneda 10 cent
			Valor<="00001010";
			Enable<='1';
	
		elsif (XX='1') then--Moneda 20 cent
			Valor<="00010100";
			Enable<='1';
	
		elsif (L='1') then--Moneda 50 cent
			Valor<="00110010";
			Enable<='1';
	
		elsif (C='1') then--Moneda 1 euro
			Valor<="01100100";
			Enable<='1';
	
		elsif (CC='1') then--Moneda 2 euros
			Valor<="11001000";
			Enable<='1';
	
		else
		-- añadido javi lopez
			Valor<= (OTHERS =>'0');
			Enable<='0';
		end if;
	end if;
end process;
end Behavioral;

