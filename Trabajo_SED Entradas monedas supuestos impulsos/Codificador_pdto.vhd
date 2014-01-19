----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:33:00 12/28/2013 
-- Design Name: 
-- Module Name:    Codificador_pdto - Behavioral 
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


--------------------------------------------------------------------------------
-------Provisional, mirar si se puede hacer enlazando a una lista externa-------
--------------------------------------------------------------------------------
entity Codificador_pdto is
    Port ( CLK : in  STD_LOGIC;
           Pdto1 : in  STD_LOGIC;
           Pdto2 : in  STD_LOGIC;
           Pdto3 : in  STD_LOGIC;
			  Dev		: in STD_LOGIC;
           Reset : in  STD_LOGIC;
			  Selec	: out STD_LOGIC;
           Precio : out  STD_LOGIC_VECTOR (7 downto 0);
           Codigo_Pdto : out  STD_LOGIC_VECTOR (3 downto 0));
end Codificador_pdto;

architecture Behavioral of Codificador_pdto is
--SIGNAL auxPrecio: STD_LOGIC_VECTOR(7 DOWNTO 0);
--SIGNAL auxCod: STD_LOGIC_VECTOR(3 DOWNTO 0);
--SIGNAL auxSel: std_logic; 

begin
--------------------------------------------------------------------------------
-------Provisional, mirar si se puede hacer enlazando a una lista externa-------
--------------------------------------------------------------------------------
process(CLK,Reset)

	begin
	--La idea es que cuando se active alguna salida de la entidad TOP, se reseteen los valores de la
	--eleccion del producto y su precio, por tanto se resetea el valor con el cual comparar.
	
	-- MODIFICADO JAVI GUIT,  
	if (Reset='1')then
		Precio<="00000000";
		Codigo_Pdto<="0000";
		Selec<='0'; 
	-- aqui habia un end if que si se dejaba, entraba en conflicto con el siguiente if, por eso el segundo if debe estar 
	-- condicionado a que reset no sea 1 (else siguiente).
	
-----Como no me dejan poner UNAFFECTED, y quiero que si no hay entrada, la salida sea la correspondiente 
--a la provocada por la ultima entrada...
---Para ello, en el "ELSE" que engloba los demás casos, asigno los valores de las señales auxiliares
--a las salidas. A las señales auxiliares se les asigna el valor correspondiente segun cada entrada.
		elsif (CLK'event and CLK='1')then
			if( Pdto1='1') then 
				Precio<="11001000"; --200 =  2€
				Codigo_Pdto<="0001";
				Selec<='1'; 
				--Pone a 0 el ok para que pase a 1 cuando se copie a la salida y la maquina de estado reconozca el flanco
				--Precio<="11001000";
				--Codigo_Pdto<="0001";
			
			elsif(Pdto2='1') then
				Precio<="11001000"; --200 =  2€
				Codigo_Pdto<="0010";
				Selec<='1'; --Pone a 0 el ok para que pase a 1 cuando se copie a la salida y la maquina de estado reconozca el flanco
				--Precio<="11001000";
				--Codigo_Pdto<="0010";
		
			elsif(Pdto3='1') then
				Precio<="01111000"; --120 = 1,20€
				Codigo_Pdto<="0011";
				Selec<='1';
				--Precio<="01111000";
				--Codigo_Pdto<="0011";
			
			elsif(Dev='1') then
				Precio<="00000000"; --0€ -> Devuelve el dinero
				Codigo_Pdto<="0000"; --Codigo Nulo que indica no entregar ningún producto
				Selec<='1';
				--La opción de devolver dinero es un producto más para hacer más sencillo el código, simplemente cuesta 0 y no da nada.
				
			else Selec<='0'; -- no se seleciono producto
		
			end if;
	end if;
	
	--mod javi
	--Selec <= auxSel;	-- activa salida de se ha elegido producto. (para maq estados)
	
end process;

end Behavioral;

