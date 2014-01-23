--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:20:00 01/21/2014
-- Design Name:   
-- Module Name:   C:/Users/Hubert/Desktop/Trabajo SED Expender Maquiner/Proyecto_VHDL_FALTAN_TESTS_En teoria completo/DecoderBinTo3BCD_tb.vhd
-- Project Name:  Trabajo_SED
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DecoderBinTo3BCD
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
 
ENTITY DecoderBinTo3BCD_tb IS
END DecoderBinTo3BCD_tb;
 
ARCHITECTURE behavior OF DecoderBinTo3BCD_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DecoderBinTo3BCD
    PORT(
         Binario : IN  std_logic_vector(7 downto 0);
         CLK : IN  std_logic;
         BCD1 : OUT  std_logic_vector(3 downto 0);
         BCD2 : OUT  std_logic_vector(3 downto 0);
         BCD3 : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Binario : std_logic_vector(7 downto 0) := (others => '0');
   signal CLK : std_logic := '0';

 	--Outputs
   signal BCD1 : std_logic_vector(3 downto 0);
   signal BCD2 : std_logic_vector(3 downto 0);
   signal BCD3 : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DecoderBinTo3BCD PORT MAP (
          Binario => Binario,
          CLK => CLK,
          BCD1 => BCD1,
          BCD2 => BCD2,
          BCD3 => BCD3
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
      wait for CLK_period*2;	
      -- insert stimulus here 
		
		Binario <= "00000000"; --0

		wait for CLK_period*10;	

		Binario <= "00110010"; --50
		
		wait for CLK_period*10;	
		
		
		Binario <= "01100100"; --100
				
		wait for CLK_period*10;
		
		
		Binario <= "10100000"; --160
		
		wait for CLK_period*10;
		
		Binario <= "11001000"; --200		
		
		wait for CLK_period*10;
		
		Binario <= "10000111"; --135		
		
		wait for CLK_period*20;

    
		ASSERT false
		REPORT "fin de la simulacion"
		SEVERITY failure;
	 
	 
   end process;

END;
