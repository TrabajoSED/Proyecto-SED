----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:05:59 11/15/2013 
-- Design Name: 
-- Module Name:    ff_d - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



entity ff_d is

  PORT (
	  CLK  : in  std_logic;
	  d    : in  std_logic;
	  q    : out std_logic
  );
end ff_d;

architecture Behavioral of ff_d is

begin

	process(CLK)
	begin
		
		if clk'event and clk='1' then
			q <= d;
		end if;
	end process;

end Behavioral;

