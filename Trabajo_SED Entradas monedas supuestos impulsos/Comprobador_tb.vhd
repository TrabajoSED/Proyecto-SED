--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:19:18 01/13/2014
-- Design Name:   
-- Module Name:   C:/Users/Hubert/Desktop/Trabajo SED Expender Maquiner/Trabajo_SED domingo exceptop/Comprobador_tb.vhd
-- Project Name:  Trabajo_SED
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Comprobador
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
 
ENTITY Comprobador_tb IS
END Comprobador_tb;
 
ARCHITECTURE behavior OF Comprobador_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Comprobador
    PORT(
         CLK : IN  std_logic;
         OK : IN  std_logic;
         Codigo_Pdto : IN  std_logic_vector(1 downto 0);
         Pdto : OUT  std_logic_vector(1 downto 0);
         Tf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal OK : std_logic := '0';
   signal Codigo_Pdto : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Pdto : std_logic_vector(1 downto 0);
   signal Tf : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Comprobador PORT MAP (
          CLK => CLK,
          OK => OK,
          Codigo_Pdto => Codigo_Pdto,
          Pdto => Pdto,
          Tf => Tf
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
      -- hold reset state for 10 ns.
		wait for CLK_period;	

      -- insert stimulus here 
		wait for CLK_period/2;

		Codigo_Pdto <= "01"; -- por ejemplo
		
		wait for CLK_period/4;	
		
		OK <= '1', '0' after CLK_period;
		
		wait for CLK_period;
		
		ASSERT Pdto = Codigo_Pdto 
		REPORT "Codigo Pdto incorrecto"
		SEVERITY failure;
			
		ASSERT tf = '1'
		REPORT "Salida incorrecta"
		SEVERITY failure;
		
		wait for CLK_period;	
		
		ASSERT Pdto = "00"
		REPORT "Codigo Pdto incorrecto"
		SEVERITY failure;	
		ASSERT tf = '0'
		REPORT "Salida incorrecta"
		SEVERITY failure;	
		
		wait for CLK_period;		
		
		ASSERT  false
		REPORT "Fin simulacion"
		SEVERITY failure;

   end process;

END;
