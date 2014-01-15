--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:05:37 01/12/2014
-- Design Name:   
-- Module Name:   C:/Users/Hubert/Desktop/Trabajo SED Expender Maquiner/Trabajo_SED/Comparador_3outs_tb.vhd
-- Project Name:  Trabajo_SED
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Comparador_3outs
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Comparador_3outs_tb IS
END Comparador_3outs_tb;
 
ARCHITECTURE behavior OF Comparador_3outs_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Comparador_3outs
    PORT(
         CLK : IN  std_logic;
			enable	:	in		STD_LOGIC;
         Total : IN  std_logic_vector(7 downto 0);
         Precio : IN  std_logic_vector(7 downto 0);
         Mayor : OUT  std_logic;
         Igual : OUT  std_logic;
         Menor : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal Total : std_logic_vector(7 downto 0) := (others => '0');
   signal Precio : std_logic_vector(7 downto 0) := (others => '0');
	signal enable	:	STD_LOGIC := '0';

 	--Outputs
   signal Mayor : std_logic;
   signal Igual : std_logic;
   signal Menor : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Comparador_3outs PORT MAP (
          CLK => CLK,
			 enable => enable,
          Total => Total,
          Precio => Precio,
          Mayor => Mayor,
          Igual => Igual,
          Menor => Menor
        );

	-- Definicion del RELOJ
  CLK_process : process	
  begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Testbench process
	
	--NOTAS : las entradas llegan sincronizadas
	--			pues son salidas sincronas del sumador y el cod producto
	-- FALTARIA COMPROBAR EL ENABLE que no esta en el codigo normal??
	
	
   tb: process
   begin		
      -- hold reset state for 10 ns.
      wait for CLK_period/2; --10ns	

      -- insert stimulus here 
		-- Precio solo puede valer: 200 o 120
		
		wait for CLK_period;	--20 ns	 
		Precio <= "11001000"; -- 200 =  2€
				
		wait for CLK_period/2;	--10 ns		
		enable <= '1';
		wait for CLK_period/2;	--10 ns		
		
		wait for CLK_period;	--20 ns
		Total <= "11000011"; -- 195
			--ASSERT (Menor ='1' and Igual ='0' and Mayor ='0'); -- salidas que deben ser
			--REPORT "Error en comparacion <"
			--SEVERITY failure; 
			
		wait for CLK_period;	--20 ns
		Total <= "11001000"; -- 200
			
		wait for CLK_period;	--20 ns
		Total <= "11001101"; -- 205

		wait for CLK_period;	--20 ns
		
		-- enable
		
		enable <='0';
	
		wait for CLK_period;	--20 ns
		
		ASSERT false
		REPORT "Fin de la simulacion"
		SEVERITY failure;
		
		
		
   end process;

END;
