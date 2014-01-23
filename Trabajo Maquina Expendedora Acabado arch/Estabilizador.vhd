----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:13:44 01/15/2014 
-- Design Name: 
-- Module Name:    Estabilizador - Behavioral 
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

entity Estabilizador is
    Port ( Pulsador_in : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Pulsador_out : out  STD_LOGIC--;
          -- reset : in  STD_LOGIC
			 );
end Estabilizador;

architecture Behavioral of Estabilizador is

--  Provides a one-shot pulse from a non-clock input, with reset

	signal Q1, Q2, Q3 : std_logic;
 
begin

	process(CLK)
	begin
		if (CLK'event and CLK = '1') then
		--	if (reset = '1') then
			--	Q1 <= '0';
			--	Q2 <= '0';
			--	Q3 <= '0'; 
		--	else
				Q1 <= Pulsador_in;
				Q2 <= Q1;
				Q3 <= Q2;
		--	end if;
		end if;
	end process;
 
Pulsador_out <= Q1 and Q2 and (not Q3);
end Behavioral;

