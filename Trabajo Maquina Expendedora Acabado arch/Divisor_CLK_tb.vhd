--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:17:36 01/21/2014
-- Design Name:   
-- Module Name:   C:/Users/Hubert/Desktop/Trabajo SED Expender Maquiner/Proyecto_VHDL_FALTAN_TESTS_En teoria completo/Divisor_CLK_tb.vhd
-- Project Name:  Trabajo_SED
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Divisor_CLK
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
 
ENTITY Divisor_CLK_tb IS
END Divisor_CLK_tb;
 
ARCHITECTURE behavior OF Divisor_CLK_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Divisor_CLK
    PORT(
         CLK_in : IN  std_logic;
         CLK_out : OUT  std_logic--;
			--Reset : in  STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_in : std_logic := '0';
	--signal Reset : in  STD_LOGIC;

 	--Outputs
   signal CLK_out : std_logic;

   -- Clock period definitions
   constant CLK_in_period : time := 20 ns; --50MHz
   --constant CLK_out_period : time := 10 ms; -- 100 Hz
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Divisor_CLK PORT MAP (
          CLK_in => CLK_in,
          CLK_out => CLK_out--,
			-- Reset => Reset
        );

   -- Clock process definitions
   CLK_in_process :process
   begin
		CLK_in <= '0';
		wait for CLK_in_period/2;
		CLK_in <= '1';
		wait for CLK_in_period/2;
   end process;
 
  -- CLK_out_process :process
   --begin
	--	CLK_out <= '0';
	--	wait for CLK_out_period/2;
	--	CLK_out <= '1';
	--	wait for CLK_out_period/2;
   --end process;
 

   -- Stimulus process
   stim_proc: process
   begin		

      -- insert stimulus here 

      wait;
   end process;

END;
