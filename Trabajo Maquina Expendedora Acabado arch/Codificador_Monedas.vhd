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

entity codificador_monedas is
  port (
    clk   : in  std_logic;
    v     : in  std_logic;
    x     : in  std_logic;
    xx    : in  std_logic;
    l     : in  std_logic;
   c     : in  std_logic;
    cc    : in  std_logic;
    valor : out std_logic_vector(7 downto 0);
    enable: out std_logic
 );
end codificador_monedas;


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































--architecture behavioral of Codificador_Monedas is
--  signal aggregate: std_logic_vector(5 downto 0);
  --signal coin: std_logic;
 -- signal reg: std_logic_vector(1 downto 0);
--begin
--  aggregate <= cc & c & l & xx & x & v;

--  process (clk, aggregate)
-- begin -- Modificado por javi l. condicion
--   if clk'event and clk = '1' then
--      case aggregate is
--	     when "000001" =>
--		    Valor <= CONV_STD_LOGIC_VECTOR(  5, valor'length);
--			 enable <= '1';
--	     when "000010" =>
--		    Valor <= CONV_STD_LOGIC_VECTOR( 10, valor'length);
--			 enable <= '1';
--	     when "000100" =>
--		    Valor <= CONV_STD_LOGIC_VECTOR( 20, valor'length);
--			 enable <= '1';
--	     when "001000" =>
--		    Valor <= CONV_STD_LOGIC_VECTOR( 50, valor'length);
--			 enable <= '1';
--	     when "010000" =>
--		    Valor <= CONV_STD_LOGIC_VECTOR(100, valor'length);
	--		 enable <= '1';
	 --    when "100000" =>
	--	    Valor <= CONV_STD_LOGIC_VECTOR(200, valor'length);
	--		 enable <= '1';
	 --    when others =>
	--	    Valor <= CONV_STD_LOGIC_VECTOR(  0, valor'length);
	--		 enable <= '0';
	--   end case;
  --  end if;
 -- end process;
--end behavioral;

