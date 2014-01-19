--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:05:27 01/13/2014
-- Design Name:   
-- Module Name:   C:/Users/Hubert/Desktop/Trabajo SED Expender Maquiner/Trabajo_SED domingo exceptop/Restador_tb.vhd
-- Project Name:  Trabajo_SED
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Restador
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
 
ENTITY Restador_tb IS
END Restador_tb;
 
ARCHITECTURE behavior OF Restador_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Restador
    PORT(
         total : IN  std_logic_vector(7 downto 0);
         precio : IN  std_logic_vector(7 downto 0);
         enable : IN  std_logic;
         clk : IN  std_logic;
         devolver : OUT  std_logic_vector(7 downto 0);
         ok : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal total : std_logic_vector(7 downto 0) := (others => '0');
   signal precio : std_logic_vector(7 downto 0) := (others => '0');
   signal enable : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal devolver : std_logic_vector(7 downto 0);
   signal ok : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Restador PORT MAP (
          total => total,
          precio => precio,
          enable => enable,
          clk => clk,
          devolver => devolver,
          ok => ok
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
		wait for clk_period/2; --10 ns

      -- insert stimulus here 
		-- enable esta inicializado a 0
		
		wait for clk_period/4; --10 ns
		
		total <= "11111010"; -- 250
		precio <= "11001000"; -- 200
	  
		wait for clk_period/2; --10 ns	

		enable <= '1'; 
		
		wait for clk_period; --20	
						
		ASSERT devolver = "00110010" -- 50
		REPORT "Salida incorrecta."	
		SEVERITY FAILURE;	
		ASSERT 	ok = '1'
		REPORT "Ok incorrecto."	
		SEVERITY FAILURE;
		
		wait for clk_period/2; --10
		
		enable <= '0';
		
		wait for clk_period; --20
		
		ASSERT devolver = "00000000" -- 0
		REPORT "Salida incorrecta."	
		SEVERITY FAILURE;
		ASSERT 	ok = '0'
		REPORT "Ok incorrecto."	
		SEVERITY FAILURE;
		
		wait for clk_period; --20	
				
		ASSERT false
		REPORT "Fin sim. Test superado"	
		SEVERITY FAILURE;
      
   end process;

END;
