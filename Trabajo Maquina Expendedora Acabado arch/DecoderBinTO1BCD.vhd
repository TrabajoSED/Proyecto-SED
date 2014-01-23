----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:41:06 01/20/2014 
-- Design Name: 
-- Module Name:    DecoderBinTO1BCD - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DecoderBinTO1BCD is
    Port ( Binario : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
			  CLK : in STD_LOGIC;
			  
           BCD : out  STD_LOGIC_VECTOR(3 DOWNTO 0)
			  );
end DecoderBinTO1BCD;

architecture Behavioral of DecoderBinTO1BCD is

begin

	process(CLK)
	begin
		if (CLK'event and CLK='1') then
			BCD<="00" & Binario(1 DOWNTO 0);
		end if;
	end process;

end Behavioral;

