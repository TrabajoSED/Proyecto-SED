----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:43:01 01/13/2014 
-- Design Name: 
-- Module Name:    maquina - Behavioral 
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

ENTITY maquina IS
	PORT (
		reset		:	IN std_logic;
		clk		:	IN std_logic;
		selec		:	IN std_logic;
		mayor		: 	IN std_logic;
	   menor		: 	IN std_logic;
		igual		:	IN std_logic;
		dev_ok	:	IN std_logic;
		reset_mon:	OUT std_logic;
		en_comp	:	OUT std_logic;
		en_rest	:	OUT std_logic;
		entrega	:	OUT std_logic;
		reset_cp	:	OUT std_logic
		);
END;

ARCHITECTURE behavioral OF maquina IS
	TYPE tipo_estado IS (reposo, prod_selec, devolucion, fin, limpieza);
	SIGNAL estado : tipo_estado:= reposo;
	SIGNAL sig_estado : tipo_estado := REPOSO;
	SIGNAL sig_reset_mon,sig_en_comp,sig_en_rest,sig_entrega,sig_reset_cp: std_logic;

	
BEGIN

-- CAMBIADO PUREBAS MIERDER
  process (clk) --,sig_estado,sig_reset_mon,sig_en_comp,sig_en_rest,sig_entrega,sig_reset_cp)
  begin
    if clk = '1' and clk'event then
      estado    <= sig_estado;
      reset_mon <= sig_reset_mon;
      en_comp   <= sig_en_comp;
      en_rest   <= sig_en_rest;
      entrega   <= sig_entrega;
      reset_cp  <= sig_reset_cp;		
    end if;
  end process;

	PROCESS (estado, selec, mayor, menor, igual, dev_ok, reset)
	BEGIN
	
		--sig_reset_mon <= '0';
		--sig_en_comp <= '0';
		--sig_en_rest <= '0';
		--sig_entrega <= '0';
		--sig_reset_cp <= '0';
		--sig_estado <= reposo;
		
    --sig_estado <= estado;

    CASE estado IS
      WHEN reposo =>
        sig_reset_mon <= '0';
        sig_en_comp   <= '0';
        sig_en_rest   <= '0';
        sig_entrega   <= '0';
        sig_reset_cp  <= '0';
				--espera_fin<= "00";
		  IF reset = '1' THEN
			 sig_estado <= limpieza;
        ELSIF selec = '1' THEN
          sig_estado <= prod_selec;
		  ELSE
		    sig_estado <= estado;
        END IF;
				
      WHEN prod_selec =>
        sig_reset_mon <= '0';
        sig_en_comp   <= '1';
        sig_en_rest   <= '0';
        sig_entrega   <= '0';
        sig_reset_cp  <= '0';
        IF reset = '1' THEN
			 sig_estado <= limpieza;
        ELSIF mayor = '1' THEN
	       sig_estado <= devolucion;
        ELSIF igual = '1' THEN
	       sig_estado <= fin;
        ELSIF menor = '1' THEN
	       sig_estado <= reposo;
		  ELSE
		    sig_estado <= estado;
        END IF;

      WHEN devolucion =>
        sig_reset_mon <= '0';
        sig_en_comp   <= '0';
        sig_en_rest   <= '1';
        sig_entrega   <= '0';
        sig_reset_cp  <= '0';
        IF reset = '1' THEN
			 sig_estado <= limpieza;
        ELSIF dev_ok = '1' THEN
          sig_estado <= fin;
		  ELSE
		    sig_estado <= estado;
        END IF;
      WHEN fin =>
        sig_reset_mon <= '0';
        sig_en_comp   <= '0';
        sig_en_rest   <= '0';
        sig_entrega   <= '1';
        sig_reset_cp  <= '0';
        sig_estado    <= limpieza;

     WHEN limpieza =>
       sig_reset_mon <= '1';
       sig_en_comp   <= '0';
       sig_en_rest   <= '0';
       sig_entrega   <= '0';
       sig_reset_cp  <= '1';
       sig_estado    <= reposo;
				
      WHEN OTHERS => 
       sig_estado    <= reposo;
    END CASE;
  END PROCESS;
END behavioral;

