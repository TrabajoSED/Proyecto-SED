--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:44:10 01/15/2014
-- Design Name:   
-- Module Name:   C:/Users/Hubert/Desktop/Trabajo SED Expender Maquiner/Trabajo_SED Martes B/Top_Expendedora_tb.vhd
-- Project Name:  Trabajo_SED
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Top_Expendedora
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
 
ENTITY Top_Expendedora_tb IS
END Top_Expendedora_tb;
 
ARCHITECTURE behavior OF Top_Expendedora_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Top_Expendedora
    PORT(
         CLK : IN  std_logic;
         V_as : IN  std_logic;
         X_as : IN  std_logic;
         XX_as : IN  std_logic;
         L_as : IN  std_logic;
         C_as : IN  std_logic;
         CC_as : IN  std_logic;
         P1_as : IN  std_logic;
         P2_as : IN  std_logic;
         P3_as : IN  std_logic;
         DEV_as : IN  std_logic;
         Producto : OUT  std_logic_vector(3 downto 0);
         Entrega : OUT  std_logic;
         V_sal : OUT  std_logic;
         X_sal : OUT  std_logic;
         XX_sal : OUT  std_logic;
         L_sal : OUT  std_logic;
         C_sal : OUT  std_logic;
         CC_sal : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal V_as : std_logic := '0';
   signal X_as : std_logic := '0';
   signal XX_as : std_logic := '0';
   signal L_as : std_logic := '0';
   signal C_as : std_logic := '0';
   signal CC_as : std_logic := '0';
   signal P1_as : std_logic := '0';
   signal P2_as : std_logic := '0';
   signal P3_as : std_logic := '0';
   signal DEV_as : std_logic := '0';

 	--Outputs
   signal Producto : std_logic_vector(3 downto 0);
   signal Entrega : std_logic;
   signal V_sal : std_logic;
   signal X_sal : std_logic;
   signal XX_sal : std_logic;
   signal L_sal : std_logic;
   signal C_sal : std_logic;
   signal CC_sal : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Top_Expendedora PORT MAP (
          CLK => CLK,
          V_as => V_as,
          X_as => X_as,
          XX_as => XX_as,
          L_as => L_as,
          C_as => C_as,
          CC_as => CC_as,
          P1_as => P1_as,
          P2_as => P2_as,
          P3_as => P3_as,
          DEV_as => DEV_as,
          Producto => Producto,
          Entrega => Entrega,
          V_sal => V_sal,
          X_sal => X_sal,
          XX_sal => XX_sal,
          L_sal => L_sal,
          C_sal => C_sal,
          CC_sal => CC_sal
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
      wait for CLK_period/2;	

      -- insert stimulus here 
		
		-- cliente introduce monedas
		
		C_as <= '1','0' after CLK_period/2; --100
		
		wait for CLK_period*2;
		
		C_as <= '1','0' after CLK_period/2; --100

		
		wait for CLK_period*3; -- debe pasar cierto tiempo
		
		-- seleccion producto
		
		P1_as <= '1','0' after CLK_period*2; --producto 1 : 200	
		
		-- ha de sacar entrega
		
		wait for CLK_period*10;	
		
		--prueba 2 producto

		C_as <= '1','0' after CLK_period/2; --100

		wait for CLK_period;
		
		L_as <= '1','0' after CLK_period/2; --100

		wait for CLK_period;
		
		X_as <= '1','0' after CLK_period/2; --100

		wait for CLK_period*5;
		
		P3_as <= '1','0' after CLK_period*2; --producto 1 : 120		
	
		-- prueba devolucion varias monedas
	
		wait for CLK_period*20;	
		
		L_as <= '1','0' after CLK_period/2; --100

		wait for CLK_period;
		
		DEV_as <= '1','0' after CLK_period/2; --100

		wait;
		
		ASSERT false
		REPORT "Test Superado"
		SEVERITY failure; 

   end process;

END;
