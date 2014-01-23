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

entity sumador is
  port ( 
    clk: in std_logic;
    valor : in  std_logic_vector(7 downto 0);
    enable: in  std_logic;
    reset : in  std_logic;
    total : out std_logic_vector(7 downto 0));
end sumador;

architecture behavioral of sumador is
  signal suma: std_logic_vector(7 downto 0);
begin
  process(reset,clk) 
  begin
    if reset = '1' then --
      suma <= (others => '0'); --resetea la suma	
		
    elsif clk'event and clk = '1' then
	 
      if enable = '1' then -- CAMBIADO; ENABLE YA VA POR EL FLANCO DEL RELOJ NO DEJA SU PROPIO FLANCO	
        suma <= suma + valor;--Suma el valor acumulado hasta entonces más la entrada
      end if;
    end if;
  end process;
  
  total <= suma;
  
end Behavioral;
