----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:22:07 01/13/2014 
-- Design Name: 
-- Module Name:    devolucion - Behavioral 
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

entity devolucion is
    Port ( clk 		: in  	STD_LOGIC;
           devolver 	: in  	STD_LOGIC_VECTOR (7 downto 0);
           enable 	: in  	STD_LOGIC;
           ok 			: out  	STD_LOGIC;
           v 			: out  	STD_LOGIC;
           x 			: out  	STD_LOGIC;
           xx 			: out  	STD_LOGIC;
           l 			: out  	STD_LOGIC;
           c 			: out  	STD_LOGIC;
           cc 			: out  	STD_LOGIC
			 );
end devolucion;

architecture Behavioral of devolucion is
	signal resto	:	STD_LOGIC_VECTOR (7 downto 0);
	signal aux: STD_LOGIC;
	signal w_pulse: STD_LOGIC;
begin	
	

	process(clk)
	begin
		if clk'event and clk='1' then
			if enable = '0' then
				ok<='0';
				cc<='0';
				c<='0';
				l<='0';
				xx<='0';
				x<='0';
				v<='0';
				w_pulse<='0';
				aux<='0'; -- aux es la señal que se pone a uno con el primer enable que indica 
								-- que el componente esta preparaado para el comienzo de la operacion	
			elsif enable = '1' then
				if aux='0' then 
					resto <= devolver;
					ok<='0';
					cc<='0';
					c<='0';
					l<='0';
					xx<='0';
					x<='0';
					v<='0';
					aux<='1';	-- aux es la señal que se pone a uno con el primer enable que indica 
								-- que el componente esta preparaado para el comienzo de la operacion
				elsif aux='1' then
				
					if w_pulse='1' then
						cc<='0';
						c<='0';
						l<='0';
						xx<='0';
						x<='0';
						v<='0';
						w_pulse<='0';
						
					elsif (resto>=200) then
						resto<=resto-200;
						cc<='1';
						w_pulse<='1';
					elsif (resto>=100) then
						resto<=resto-100;
						c<='1';					
						w_pulse<='1';
					elsif (resto>=50) then
						resto<=resto-50;					
						l<='1';
						w_pulse<='1';		
					elsif (resto>=20) then
						resto<=resto-20;
						xx<='1';
						w_pulse<='1';
					elsif (resto>=10) then
						resto<=resto-10;
						x<='1';
						w_pulse<='1';
					elsif (resto>=5) then
						resto<=resto-5;
						v<='1';
						w_pulse<='1';
					elsif (resto=0) then
						ok<='1';
						w_pulse<='1';
					end if;
				end if;	
			end if;
		end if;	
		
	end process;
	
end Behavioral;

-- javi bajo antiguo
--architecture Behavioral of devolucion is
--	signal resto	:	STD_LOGIC_VECTOR (7 downto 0);
--begin	
--	process(clk, enable)
--	begin
--		if (enable'event and enable='1') then
--			resto <= devolver;
--		elsif enable='1' then
--			if (clk'event and clk='1' and resto>=200) then
--				resto<=resto-200;
--				cc<='1';
--			elsif (clk'event and clk='1' and resto>=100) then
--				resto<=resto-100;
--				c<='1';
--			elsif (clk'event and clk='1' and resto>=50) then
--				resto<=resto-50;
--				l<='1';
--			elsif (clk'event and clk='1' and resto>=20) then
--				resto<=resto-20;
--				xx<='1';
--			elsif (clk'event and clk='1' and resto>=10) then
--				resto<=resto-10;
--				x<='1';
--			elsif (clk'event and clk='1' and resto>=5) then
--				resto<=resto-5;
--				v<='1';
--			end if;
--		end if;
--	end process;
--end Behavioral;

