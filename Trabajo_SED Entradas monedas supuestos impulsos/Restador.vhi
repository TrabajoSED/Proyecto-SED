
-- VHDL Instantiation Created from source file Restador.vhd -- 18:44:19 01/13/2014
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Restador
	PORT(
		total : IN std_logic_vector(7 downto 0);
		precio : IN std_logic_vector(7 downto 0);
		enable : IN std_logic;
		clk : IN std_logic;          
		devolver : OUT std_logic_vector(7 downto 0);
		ok : OUT std_logic
		);
	END COMPONENT;

	Inst_Restador: Restador PORT MAP(
		total => ,
		precio => ,
		enable => ,
		clk => ,
		devolver => ,
		ok => 
	);


