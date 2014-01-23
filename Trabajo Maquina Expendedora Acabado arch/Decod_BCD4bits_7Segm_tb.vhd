--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:44:48 01/21/2014
-- Design Name:   
-- Module Name:   C:/Users/Hubert/Desktop/Trabajo SED Expender Maquiner/Proyecto_VHDL_FALTAN_TESTS_En teoria completo/Decod_BCD4bits_7Segm_tb.vhd
-- Project Name:  Trabajo_SED
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decod_BCD4bits_7Segm
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
 
ENTITY Decod_BCD4bits_7Segm_tb IS
END Decod_BCD4bits_7Segm_tb;
 
ARCHITECTURE behavior OF Decod_BCD4bits_7Segm_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decod_BCD4bits_7Segm
    PORT(
         BCD_in : IN  std_logic_vector(3 downto 0);
         CLK : IN  std_logic;
         Segm7_out : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal BCD_in : std_logic_vector(3 downto 0) := (others => '0');
   signal CLK : std_logic := '0';

 	--Outputs
   signal Segm7_out : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
	
			TYPE vtest is record 
				BCD_in : std_logic_vector(3 DOWNTO 0); 
				Segm7_out : std_logic_vector(6 DOWNTO 0); 
		END RECORD; 
		
		-- se presenta la tabla de verdad
		
		TYPE vtest_vector IS ARRAY (natural RANGE <>) OF vtest; 		
		
		CONSTANT test: vtest_vector := ( 
				(BCD_in => "0000", Segm7_out => "0000001"), 
				(BCD_in => "0001", Segm7_out => "1001111"), 
				(BCD_in => "0010", Segm7_out => "0010010"), 
				(BCD_in => "0011", Segm7_out => "0000110"), 
				(BCD_in => "0100", Segm7_out => "1001100"), 
				(BCD_in => "0101", Segm7_out => "0100100"), 
				(BCD_in => "0110", Segm7_out => "0100000"), 
				(BCD_in => "0111", Segm7_out => "0001111"), 
				(BCD_in => "1000", Segm7_out => "0000000"), 
				(BCD_in => "1001", Segm7_out => "0000100")
		); 
	
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decod_BCD4bits_7Segm PORT MAP (
          BCD_in => BCD_in,
          CLK => CLK,
          Segm7_out => Segm7_out
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
				
			FOR i IN 0 TO test'HIGH LOOP 				-- recorre la tabla
					WAIT FOR clk_period/2; 
					BCD_in <= test(i).BCD_in; 
					WAIT FOR clk_period/2; 
					ASSERT Segm7_out = test(i).Segm7_out 			-- comprueba si el valor corresponde con la tabla de verdad, si es falso:	
					REPORT "Salida incorrecta." 
					SEVERITY FAILURE; 
			END LOOP; 
			
			WAIT FOR clk_period/2; 
			
			ASSERT false 									-- falso = siempre lo hace -> si no se interrumpió con el anterior bucle:
			REPORT "Simulación finalizada. Test superado." 
			SEVERITY FAILURE; 
   end process;

END;

