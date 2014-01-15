----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:56:11 01/02/2014 
-- Design Name: 
-- Module Name:    SYNC - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SYNC is
  
   Port (  AsyncIn : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           SyncIn : out  STD_LOGIC
			);
end SYNC;

architecture Behavioral of SYNC is

	COMPONENT ff_d
	PORT(
		CLK : IN std_logic;
		d : IN std_logic;          
		q : OUT std_logic
		);
	END COMPONENT;
	
	SIGNAL meta: STD_LOGIC; --Une los dos ff

begin
	
	Inst_ff_d_1: ff_d PORT MAP(
		CLK => CLK,
		d => AsyncIn,
		q => meta
	);

	Inst_ff_d_2: ff_d PORT MAP(
		CLK => CLK,
		d => meta,
		q => SyncIn
	);

end Behavioral;

