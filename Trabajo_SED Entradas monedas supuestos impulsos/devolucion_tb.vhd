--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:17:34 01/14/2014
-- Design Name:   
-- Module Name:   C:/Users/Hubert/Desktop/Trabajo SED Expender Maquiner/Trabajo_SED lunes B/devolucion_tb.vhd
-- Project Name:  Trabajo_SED
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: devolucion
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
 
ENTITY devolucion_tb IS
END devolucion_tb;
 
ARCHITECTURE behavior OF devolucion_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT devolucion
    PORT(
         clk : IN  std_logic;
         devolver : IN  std_logic_vector(7 downto 0);
         enable : IN  std_logic;
         ok : OUT  std_logic;
         v : OUT  std_logic;
         x : OUT  std_logic;
         xx : OUT  std_logic;
         l : OUT  std_logic;
         c : OUT  std_logic;
         cc : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal devolver : std_logic_vector(7 downto 0) := (others => '0');
   signal enable : std_logic := '0';

 	--Outputs
   signal ok : std_logic;
   signal v : std_logic;
   signal x : std_logic;
   signal xx : std_logic;
   signal l : std_logic;
   signal c : std_logic;
   signal cc : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: devolucion PORT MAP (
          clk => clk,
          devolver => devolver,
          enable => enable,
          ok => ok,
          v => v,
          x => x,
          xx => xx,
          l => l,
          c => c,
          cc => cc
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
      -- hold reset state for 100 ns.
      wait for clk_period/2;	
		
		devolver <= "10111001"; -- 185 a devolver 

      -- insert stimulus here 
		wait for clk_period;

		enable <= '1';
		
		wait for clk_period*12;	
	
		wait for clk_period/2;
		
		ASSERT ok='1'
		REPORT "error a la salida"
		SEVERITY failure;
		
		--wait for clk_period;

		enable <= '0';
		
		wait for clk_period;
		
		devolver <= "00101000"; -- 40 a devolver 
		
		wait for clk_period;

		enable <= '1';
		
		wait for clk_period*6;	
	
		wait for clk_period/2;
		
		ASSERT ok='1'
		REPORT "error a la salida para varias monedas de la misma"
		SEVERITY failure;
		
		--wait for clk_period;

		enable <= '0';
		
		wait for clk_period;
				
		ASSERT false
		REPORT "Fin sim. Test superado."
		SEVERITY failure;		

   end process;

END;
