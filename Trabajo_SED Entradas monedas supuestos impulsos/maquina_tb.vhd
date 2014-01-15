--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:00:42 01/15/2014
-- Design Name:   
-- Module Name:   C:/Users/Hubert/Desktop/Trabajo SED Expender Maquiner/Trabajo_SED Martes C/maquina_tb.vhd
-- Project Name:  Trabajo_SED
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: maquina
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
 
ENTITY maquina_tb IS
END maquina_tb;
 
ARCHITECTURE behavior OF maquina_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT maquina
    PORT(
         clk : IN  std_logic;
         selec : IN  std_logic;
         mayor : IN  std_logic;
         menor : IN  std_logic;
         igual : IN  std_logic;
         dev_ok : IN  std_logic;
         reset_mon : OUT  std_logic;
         en_comp : OUT  std_logic;
         en_rest : OUT  std_logic;
         entrega : OUT  std_logic;
         reset_cp : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal selec : std_logic := '0';
   signal mayor : std_logic := '0';
   signal menor : std_logic := '0';
   signal igual : std_logic := '0';
   signal dev_ok : std_logic := '0';

 	--Outputs
   signal reset_mon : std_logic;
   signal en_comp : std_logic;
   signal en_rest : std_logic;
   signal entrega : std_logic;
   signal reset_cp : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: maquina PORT MAP (
          clk => clk,
          selec => selec,
          mayor => mayor,
          menor => menor,
          igual => igual,
          dev_ok => dev_ok,
          reset_mon => reset_mon,
          en_comp => en_comp,
          en_rest => en_rest,
          entrega => entrega,
          reset_cp => reset_cp
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 10 ns.
      wait for clk_period/2;	
		
      -- insert stimulus here 
		
		selec <= '1','0' after clk_period*3;
		
      wait for clk_period*6;			
		 
		menor <= '1','0' after clk_period*3;
	      
		wait for clk_period*6;		
		
		selec <= '1','0' after clk_period*3;
		
      wait for clk_period*6;	
		
		igual <= '1','0' after clk_period*3;
		
		wait for clk_period*8;	
		
		selec <= '1','0' after clk_period*3;
		
      wait for clk_period*8;				 
		
		mayor <= '1','0' after clk_period*3;
		
		wait for clk_period*8;			
		
		dev_ok <= '1','0' after clk_period*3;

		wait for clk_period*6;	
		
		ASSERT false
		REPORT "Fin Test"
		SEVERITY failure; 

   end process;

END;
