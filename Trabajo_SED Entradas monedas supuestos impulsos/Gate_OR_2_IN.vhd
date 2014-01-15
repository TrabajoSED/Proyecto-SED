----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:35:30 12/28/2013 
-- Design Name: 
-- Module Name:    Gate_OR - Behavioral 
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

entity Gate_OR is
    Port ( in1 : in  STD_LOGIC;
           in2 : in  STD_LOGIC;
           Pout : out  STD_LOGIC);
end Gate_OR;

architecture Behavioral of Gate_OR is

begin

Pout <= in1 or in2 ;

end Behavioral;

