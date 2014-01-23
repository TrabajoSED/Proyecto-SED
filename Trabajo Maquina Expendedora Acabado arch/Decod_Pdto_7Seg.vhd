----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:38:04 01/20/2014 
-- Design Name: 
-- Module Name:    Decod_Pdto_7Seg - Behavioral 
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

entity Decod_Pdto_7Seg is
    Port ( CLK : in  STD_LOGIC;
           Pdto_in : in  STD_LOGIC_VECTOR (3 downto 0);
           Pdto_out : out  STD_LOGIC_VECTOR (6 downto 0));
end Decod_Pdto_7Seg;

architecture Behavioral of Decod_Pdto_7Seg is

begin

		process (CLK)
		begin
			case Pdto_in is
				when "0000" => Pdto_out <= "1000000"; -- 0 (DEV)
				when "0001" => Pdto_out <= "1111001"; -- 1 (Pdto1)
				when "0010" => Pdto_out <= "0100100"; -- 2 (Pdto2)
				when "0011" => Pdto_out <= "0110000"; -- 3 (Pdto3)
				when others => Pdto_out <= "1000001"; -- U (Undefined)
			end case;
		end process;

end Behavioral;

