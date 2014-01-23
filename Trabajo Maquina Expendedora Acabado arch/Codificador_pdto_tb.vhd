--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:12:46 01/13/2014
-- Design Name:   
-- Module Name:   C:/Users/Hubert/Desktop/Trabajo SED Expender Maquiner/Trabajo_SED domingo exceptop/Codificador_pdto_tb.vhd
-- Project Name:  Trabajo_SED
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Codificador_pdto
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
 
ENTITY Codificador_pdto_tb IS
END Codificador_pdto_tb;
 
ARCHITECTURE behavior OF Codificador_pdto_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Codificador_pdto
    PORT(
         CLK : IN  std_logic;
         Pdto1 : IN  std_logic;
         Pdto2 : IN  std_logic;
         Pdto3 : IN  std_logic;
         Dev : IN  std_logic;
         Reset : IN  std_logic;
         Selec : OUT  std_logic;
         Precio : OUT  std_logic_vector(7 downto 0);
         Codigo_Pdto : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal Pdto1 : std_logic := '0';
   signal Pdto2 : std_logic := '0';
   signal Pdto3 : std_logic := '0';
   signal Dev : std_logic := '0';
   signal Reset : std_logic := '1';

 	--Outputs
   signal Selec : std_logic;
   signal Precio : std_logic_vector(7 downto 0);
   signal Codigo_Pdto : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
	
	
	--La tabla de verdad (matriz salidas) con la que se comprobaran los resultados
	
	TYPE vtest is record
		Precio : std_logic_vector(7 DOWNTO 0);
		Codigo_Pdto : std_logic_vector(3 downto 0);
		Pdto1 : std_logic;
		Pdto2 : std_logic;
		Pdto3 : std_logic;
		Dev : std_logic;
	END RECORD;
	
	TYPE vtest_vector IS ARRAY (natural RANGE <>) OF vtest;
		CONSTANT test: vtest_vector := (
		(Pdto1 =>'1', Pdto2  => '0',Pdto3 => '0', Dev => '0', Codigo_Pdto =>"0001", Precio => "11001000"), --200 cent
		(Pdto1 =>'0', Pdto2  => '1',Pdto3 => '0', Dev => '0', Codigo_Pdto =>"0010", Precio => "11001000"), --200 cent
		(Pdto1 =>'0', Pdto2  => '0',Pdto3 => '1', Dev => '0', Codigo_Pdto =>"0011", Precio => "01111000"), --120 cent		
		(Pdto1 =>'0', Pdto2  => '0',Pdto3 => '0', Dev => '1', Codigo_Pdto =>"0000", Precio => "00000000") --0 cent		
		);
 
	
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Codificador_pdto PORT MAP (
          CLK => CLK,
          Pdto1 => Pdto1,
          Pdto2 => Pdto2,
          Pdto3 => Pdto3,
          Dev => Dev,
          Reset => Reset,
          Selec => Selec,
          Precio => Precio,
          Codigo_Pdto => Codigo_Pdto
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 20 ns. (reset inicializ a 1)
      wait for  CLK_period/2;
		
		Pdto1 <= '1','0' after CLK_period/2;

		Reset <= '0' after CLK_period*2;
		
		wait for CLK_period/2; --5 ns
		
		FOR i IN 0 TO test'HIGH LOOP
		
			wait for  CLK_period*2;
	
			wait for CLK_period/2; --5 ns
				
			-- Comprobado el funcionamiento con entradas de medio pulso de reloj.
			-- se ponen tal y como vendrian del sincronizador y el antirrebote
			
			Pdto1 <= test(i).Pdto1, '0' after CLK_period;
			Pdto2 <= test(i).Pdto2, '0' after CLK_period;
			Pdto3 <= test(i).Pdto3, '0' after CLK_period;
			Dev <= test(i).Dev, '0' after CLK_period;
		
			wait for CLK_period/2; -- 10 ns

			ASSERT Precio = test(i).Precio
			REPORT "Salida precio incorrecto."
			SEVERITY FAILURE;
		
			ASSERT Codigo_Pdto = test(i).Codigo_Pdto
			REPORT "Codigo Pdto incorrecto."
			SEVERITY FAILURE;
			
		
		END LOOP;		
		
		wait for  CLK_period*2;
						
		ASSERT false
		REPORT "Simulación finalizada. Test superado."
		SEVERITY FAILURE;
		

   end process;

END;
