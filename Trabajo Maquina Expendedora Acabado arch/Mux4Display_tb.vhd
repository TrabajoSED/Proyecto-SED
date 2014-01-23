--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:38:08 01/21/2014
-- Design Name:   
-- Module Name:   C:/Users/Hubert/Desktop/Trabajo SED Expender Maquiner/Proyecto_VHDL_FALTAN_TESTS_En teoria completo/Mux4Display_tb.vhd
-- Project Name:  Trabajo_SED
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Mux4Display
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
 
ENTITY Mux4Display_tb IS
END Mux4Display_tb;
 
ARCHITECTURE behavior OF Mux4Display_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mux4Display
    PORT(
         CLK : IN  std_logic;
         D0_in : IN  std_logic_vector(6 downto 0);
         D1_in : IN  std_logic_vector(6 downto 0);
         D2_in : IN  std_logic_vector(6 downto 0);
         D3_in : IN  std_logic_vector(6 downto 0);
         mux4play_out : OUT  std_logic_vector(6 downto 0);
         selec : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal D0_in : std_logic_vector(6 downto 0) := (others => '0');
   signal D1_in : std_logic_vector(6 downto 0) := (others => '0');
   signal D2_in : std_logic_vector(6 downto 0) := (others => '0');
   signal D3_in : std_logic_vector(6 downto 0) := (others => '0');

 	--Outputs
   signal mux4play_out : std_logic_vector(6 downto 0);
   signal selec : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux4Display PORT MAP (
          CLK => CLK,
          D0_in => D0_in,
          D1_in => D1_in,
          D2_in => D2_in,
          D3_in => D3_in,
          mux4play_out => mux4play_out,
          selec => selec
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
	
      wait for CLK_period*10;

      -- insert stimulus here 

		D0_in <= "1001111"; -- 1 -- producto
		D1_in <= "0000001"; -- 0
		D2_in <= "1001100"; -- 4
		D3_in <= "0100100"; -- 5

       wait for CLK_period*20;
		 
		 ASSERT false
		 REPORT "Fin sim."
		 SEVERITY failure;
		 
   end process;

END;
