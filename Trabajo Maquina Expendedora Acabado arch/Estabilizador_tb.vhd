--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:59:57 01/16/2014
-- Design Name:   
-- Module Name:   C:/Users/Hubert/Desktop/Trabajo SED Expender Maquiner/Trabajo_SED Entradas con antirrebote/Estabilizador_tb.vhd
-- Project Name:  Trabajo_SED
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Estabilizador
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
 
ENTITY Estabilizador_tb IS
END Estabilizador_tb;
 
ARCHITECTURE behavior OF Estabilizador_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Estabilizador
    PORT(
         Pulsador_in : IN  std_logic;
         CLK : IN  std_logic;
         Pulsador_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Pulsador_in : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal Pulsador_out : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Estabilizador PORT MAP (
          Pulsador_in => Pulsador_in,
          CLK => CLK,
          Pulsador_out => Pulsador_out
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
      -- hold reset state for CLK_period ns.
      wait for CLK_period;	

      -- insert stimulus here 

	   wait for CLK_period/2;		

		Pulsador_in<='1','0' after CLK_period;
		
		
      wait for CLK_period*2;	
		
		Pulsador_in<='1','0' after CLK_period*2;
		
				
      wait for CLK_period*4;	
		
		Pulsador_in<='1','0' after CLK_period*3;
		
		wait for CLK_period*5;	
		
				
		Pulsador_in<='1','0' after CLK_period*4;
		
		wait for CLK_period*6;	

		ASSERT false
		REPORT "Fin simulacion"
		SEVERITY failure;

   end process;

END;
