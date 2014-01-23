----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:24:20 01/20/2014 
-- Design Name: 
-- Module Name:    DecoderBinTo3BCD - Behavioral 
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

entity DecoderBinTo3BCD is
    Port ( Binario : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           CLK : in  STD_LOGIC;
           BCD1 : out  STD_LOGIC_VECTOR(3 DOWNTO 0);
           BCD2 : out  STD_LOGIC_VECTOR(3 DOWNTO 0);
           BCD3 : out  STD_LOGIC_VECTOR(3 DOWNTO 0));
end DecoderBinTo3BCD;

architecture Behavioral of DecoderBinTo3BCD is
	signal inicio: STD_LOGIC_VECTOR(7 DOWNTO 0); --:= "00000000";
	signal bin_anterior: STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal aux1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000" ;
	signal aux2 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000" ;
	signal aux3 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000" ;

begin

--	process(Binario)
--	begin
--		if Binario /= "00000000"  then 
--			inicio<=Binario;
--			aux1<="0000";
--			aux2<="0000";
--			aux3<="0000";
--		end if;	
--	end process;

	process (CLK,Binario)	
	begin
	
	-- si binario es 0 se inicializa, si cambia tambien.
	

			
		if (CLK'event and CLK='1') then
		
			if bin_anterior/=Binario then
				bin_anterior<=Binario;
				inicio<=Binario;
				aux1<="0000";
				aux2<="0000";
				aux3<="0000";
			end if;
			
			if (inicio>=100) then
				inicio<=inicio - 100;
				aux1<=aux1+'1';
			elsif(inicio>=10) then
				inicio<=inicio - 10;
				aux2<=aux2+'1';
			elsif(inicio>=1) then
				inicio<=inicio - 1;
				aux3<=aux3+'1';
			elsif(inicio=0) then
				BCD1<=aux1;
				BCD2<=aux2;
				BCD3<=aux3;
			end if;
		end if;
	end process;
end Behavioral;

