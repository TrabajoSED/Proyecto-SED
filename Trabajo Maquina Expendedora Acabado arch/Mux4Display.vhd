----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:14:04 01/20/2014 
-- Design Name: 
-- Module Name:    Mux4Display - Behavioral 
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


--------------------------------------------------------------------------------------------------------
-------Es un multiplexor con estados incorporados, cambia la señal de seleccion a cada pulso------------
-------- de reloj, lo que permite ahorrarse el contador de anillo.--------------------------------------
entity Mux4Display is
	PORT (
        CLK      : IN  STD_LOGIC;
       -- reset    : IN  STD_LOGIC;
	  	  D0_in    : IN  STD_LOGIC_VECTOR(6 downto 0);  --Primer dígito.  (seleccion producto)
        D1_in    : IN  STD_LOGIC_VECTOR(6 downto 0);  --Segundo dígito. (unidades devolucion)
        D2_in    : IN  STD_LOGIC_VECTOR(6 downto 0);  --Tercer dígito.  (decenas devolucion)
        D3_in    : IN  STD_LOGIC_VECTOR(6 downto 0);  --Cuarto dígito.  (centenas devolucion)
        mux4play_out   : OUT STD_LOGIC_VECTOR(6 downto 0);  --Salida del multiplexor (valor a desplegar).
        selec    : OUT STD_LOGIC_VECTOR(3 downto 0)   --Valor que define cual dígito se va a mostrar.
    );																--3 extremo izquierda, 0 extremo derecha.
end Mux4Display;

architecture Behavioral of Mux4Display is

	--type estados is (rst, v0, v1, v2,v3);
	 type estados is (v0, v1, v2, v3);
    signal estado : estados;
	 
begin
    process (CLK) 
		begin
       -- if (reset = '1') then
        --    estado <= rst;
        --    selec <= x"F";
        --    salida <= "11111111";--Apagados los 7 segmentos y el punto.
				
        --elsif CLK' event and CLK='1' then
		  if CLK' event and CLK='1' then
            case estado is
                when v0 =>
                    mux4play_out <= D3_in;
                    selec <= "1101";
                    estado <= v1;
                when v1 =>
                    mux4play_out <= D2_in;
                    selec <= "1011";
                    estado <= v2;
                when v2 =>
                    mux4play_out <= D1_in;
                    selec <= "0111";
                    estado <= v3;
                when others =>	--Reset, v3, u otro indeterminado
                    mux4play_out <= D0_in;
                    selec <= "1110";
                    estado <= v0;
            end case;
        end if;
		end process;
end Behavioral;

