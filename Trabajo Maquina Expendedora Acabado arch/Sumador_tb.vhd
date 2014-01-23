--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:35:24 01/12/2014
-- Design Name:   
-- Module Name:   C:/Users/Hubert/Desktop/Trabajo SED Expender Maquiner/Trabajo_SED/Sumador_tb.vhd
-- Project Name:  Trabajo_SED
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Sumador
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
 
ENTITY Sumador_tb IS
END Sumador_tb;
 
ARCHITECTURE behavior OF Sumador_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sumador
    PORT(
         CLK : IN  std_logic;
         Valor : IN  std_logic_vector(7 downto 0);
         Enable : IN  std_logic;
         Reset : IN  std_logic;
         Total : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal Valor : std_logic_vector(7 downto 0) := (others => '0');
   signal Enable : std_logic := '0';
   signal Reset : std_logic := '0';

 	--Outputs
   signal Total : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sumador PORT MAP (
          CLK => CLK,
          Valor => Valor,
          Enable => Enable,
          Reset => Reset,
          Total => Total
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
		reset<='1','0' after clk_period/2;
		
		wait for clk_period/2; --10 ns		
		
      -- insert stimulus here 
		-- enable esta inicializado a 0
		
		wait for clk_period/4; --10 ns
		
		Valor <= "00110010"; -- 50
	  
		wait for clk_period/2; --10 ns	

		enable <= '1'; 
		
		wait for clk_period/2; --10	
						
		ASSERT Total = "00110010" -- 50
		REPORT "Salida incorrecta."	
		SEVERITY FAILURE;	

		wait for clk_period/2; --10
		
		Valor <= "01100100"; -- 100

		wait for clk_period/2; --10
				
		ASSERT Total = "10010110" -- 150
		REPORT "Salida incorrecta."	
		SEVERITY FAILURE;
		
		enable <= '0';
		
		wait for clk_period/2; --10
				
		ASSERT Total = "10010110" -- 150
		REPORT "Salida incorrecta."	
		SEVERITY FAILURE;
		
		wait for clk_period; --20	
				
		Reset <= '1';
		
		wait for clk_period/2; --10
		
		ASSERT Total = "00000000" -- 0
		REPORT "Salida incorrecta."	
		SEVERITY FAILURE;
		
		ASSERT false
		REPORT "Fin sim. Test superado"	
		SEVERITY FAILURE;
		
   end process;

END;
