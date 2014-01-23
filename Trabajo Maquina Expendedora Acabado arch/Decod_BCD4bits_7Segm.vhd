----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:40:01 01/20/2014 
-- Design Name: 
-- Module Name:    Decod_BCD4bits_7Segm - Behavioral 
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

entity Decod_BCD4bits_7Segm is
    Port ( 
				BCD_in : in  STD_LOGIC_VECTOR (3 downto 0);
            CLK : in  STD_LOGIC;
            Segm7_out : out  STD_LOGIC_VECTOR (6 downto 0)--Punto decimal se encendera o apagara desde la entidad top
			 );
end Decod_BCD4bits_7Segm;

architecture Behavioral of Decod_BCD4bits_7Segm is

begin

	process (clk, BCD_in)
	begin
		if clk'event and clk='1' then
        case BCD_in is
            when "0000" =>  Segm7_out <= "1000000"; -- 0
            when "0001" =>  Segm7_out <= "1111001"; -- 1
            when "0010" =>  Segm7_out <= "0100100"; -- 2
            when "0011" =>  Segm7_out <= "0110000"; -- 3
            when "0100" =>  Segm7_out <= "0011001"; -- 4
            when "0101" =>  Segm7_out <= "0010010"; -- 5
            when "0110" =>  Segm7_out <= "0000010"; -- 6
            when "0111" =>  Segm7_out <= "1111000"; -- 7
            when "1000" =>  Segm7_out <= "0000000"; -- 8
            when "1001" =>  Segm7_out <= "0010000"; -- 9
				when others =>  Segm7_out <= "0000110"; -- E
			end case;
		end if;
    end process;
end Behavioral;

