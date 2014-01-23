--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:56:07 01/16/2014
-- Design Name:   
-- Module Name:   C:/Users/Hubert/Desktop/Trabajo SED Expender Maquiner/Trabajo_SED Entradas con antirrebote/SYNC_tb.vhd
-- Project Name:  Trabajo_SED
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SYNC
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
 
ENTITY SYNC_tb IS
END SYNC_tb;
 
ARCHITECTURE behavior OF SYNC_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SYNC
    PORT(
         AsyncIn : IN  std_logic;
         CLK : IN  std_logic;
         SyncIn : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal AsyncIn : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal SyncIn : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SYNC PORT MAP (
          AsyncIn => AsyncIn,
          CLK => CLK,
          SyncIn => SyncIn
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
      -- hold reset state for 100 ns.
      wait for CLK_period/2;	

      wait for CLK_period/2;

      -- insert stimulus here 

		AsyncIn <= '1','0' after CLK_period;

      wait for CLK_period*4;
		 wait for CLK_period/2;

		AsyncIn <= '1','0' after CLK_period;
		
		wait for CLK_period*4;	
		
		ASSERT false
		REPORT "Fin simulacion"
		SEVERITY failure;

   end process;

END;
