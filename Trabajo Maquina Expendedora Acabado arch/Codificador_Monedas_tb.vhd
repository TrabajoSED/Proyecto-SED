--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:45:25 01/12/2014
-- Design Name:   
-- Module Name:   C:/Users/Hubert/Desktop/Trabajo SED Expender Maquiner/Trabajo_SED/Codificador_Monedas_tb.vhd
-- Project Name:  Trabajo_SED
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Codificador_Monedas
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
 
ENTITY Codificador_Monedas_tb IS
END Codificador_Monedas_tb;
 
ARCHITECTURE behavior OF Codificador_Monedas_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Codificador_Monedas
    PORT(
         CLK : IN  std_logic;
         V : IN  std_logic;
         X : IN  std_logic;
         XX : IN  std_logic;
         L : IN  std_logic;
         C : IN  std_logic;
         CC : IN  std_logic;
         Valor : OUT  std_logic_vector(7 downto 0);
         Enable : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal V : std_logic := '0';
   signal X : std_logic := '0';
   signal XX : std_logic := '0';
   signal L : std_logic := '0';
   signal C : std_logic := '0';
   signal CC : std_logic := '0';

 	--Outputs
   signal Valor : std_logic_vector(7 downto 0);
   signal Enable : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
	
	--La tabla de verdad (matriz salidas) con la que se comprobaran los resultados
	
	TYPE vtest is record
		Valor : std_logic_vector(7 DOWNTO 0);
		V : std_logic;
		X : std_logic;
		XX : std_logic;
		L : std_logic;
		C : std_logic ;
		CC : std_logic ;
		Enable : std_logic;
	END RECORD;
	
	TYPE vtest_vector IS ARRAY (natural RANGE <>) OF vtest;
		CONSTANT test: vtest_vector := (
		(Enable =>'0', V => '0',X => '0',XX => '0',L => '0',C => '0',CC => '0', Valor => "00000000"), --0 cent
		(Enable =>'1', V => '1',X => '0',XX => '0',L => '0',C => '0',CC => '0', Valor => "00000101"), --5 cent
		(Enable =>'1', V => '0',X => '1',XX => '0',L => '0',C => '0',CC => '0', Valor => "00001010"), --10 cent
		(Enable =>'1', V => '0',X => '0',XX => '1',L => '0',C => '0',CC => '0', Valor => "00010100"), --20 cent
		(Enable =>'1', V => '0',X => '0',XX => '0',L => '1',C => '0',CC => '0', Valor => "00110010"), --50 cent
		(Enable =>'1', V => '0',X => '0',XX => '0',L => '0',C => '1',CC => '0', Valor => "01100100"), --1 € 
		(Enable =>'1', V => '0',X => '0',XX => '0',L => '0',C => '0',CC => '1', Valor => "11001000") --2 € 
		);
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Codificador_Monedas PORT MAP (
          CLK => CLK,
          V => V,
          X => X,
          XX => XX,
          L => L,
          C => C,
          CC => CC,
          Valor => Valor,
          Enable => Enable
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
      wait for  CLK_period/2;
      -- insert stimulus here 
		
		-- comprobacion tabla verdad salidas
		
		FOR i IN 0 TO test'HIGH LOOP
	
			wait for CLK_period; 
				
			V <= test(i).V ,'0' after CLK_period;
			X <= test(i).X ,'0' after CLK_period;
			XX <= test(i).XX ,'0' after CLK_period;
			L <= test(i).L ,'0' after CLK_period;
			C <= test(i).C ,'0' after CLK_period;
			CC <= test(i).CC ,'0' after CLK_period;
		
			wait for CLK_period/2;

			ASSERT Valor = test(i).Valor
			REPORT "Salida Valor incorrecto."
			SEVERITY FAILURE;
		
			ASSERT Enable = test(i).Enable
			REPORT "Salida Enable incorrecto."
			SEVERITY FAILURE;
			
			wait for CLK_period/2;			
		
		END LOOP;
		
			wait for CLK_period;			
		
		-- comprobacion reset
		
		ASSERT false
		REPORT "Simulación finalizada. Test superado."
		SEVERITY FAILURE;

   end process;

END;
