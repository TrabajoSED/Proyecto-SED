----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:53:21 01/20/2014 
-- Design Name: 
-- Module Name:    Divisor_CLK - Behavioral 
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

entity Divisor_CLK is
--	 Generic(
--			CLK_salida_Hz : integer := 100;	--Hz reloj salida
--			CLK_sys_Hz	:	integer := 50000000	--Hz reloj de placa
--			
--			);
    generic (semiciclo: positive := 499999);
    Port ( CLK_in : in  STD_LOGIC;
           CLK_out : out  STD_LOGIC--;
           --Reset : in  STD_LOGIC
			 );
			  
end Divisor_CLK;

architecture Behavioral of Divisor_CLK is
	 
	 signal onda_clk_out: STD_LOGIC;
    signal contador: integer range 0 to semiciclo := 0; 
	 --Frec. CLK_in entre frec. CLK_ out deseada.
	 --En este caso, salida 100Hz  ---> 50MHz/100Hz--> 500.000-->Entre 2 (clk sube. clk baja)--> 250.000
	 --Contador de 0 a 249.999
																		
begin
   -- process (reset, entrada) 
	process (CLK_in) 
		begin
       -- if (reset = '1') then
          -- onda_clk_out <= '0';
			--	contador <= 0;
        --elsif rising_edge(entrada) then
		 if CLK_in' event and CLK_in='1' then
		 
				if (onda_clk_out = 'U') then
				
					onda_clk_out <= '0';
					
            elsif (contador = semiciclo) then
                onda_clk_out <= NOT(onda_clk_out);
                contador <= 0;
            else
                contador <= contador+1;
            end if;
        end if;
    end process;
     
    CLK_out <= onda_clk_out;

end Behavioral;

