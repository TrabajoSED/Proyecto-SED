
-- VHDL Instantiation Created from source file devolucion.vhd -- 18:46:54 01/13/2014
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT devolucion
	PORT(
		clk : IN std_logic;
		devolver : IN std_logic_vector(7 downto 0);
		enable : IN std_logic;          
		ok : OUT std_logic;
		v : OUT std_logic;
		x : OUT std_logic;
		xx : OUT std_logic;
		l : OUT std_logic;
		c : OUT std_logic;
		cc : OUT std_logic
		);
	END COMPONENT;

	Inst_devolucion: devolucion PORT MAP(
		clk => ,
		devolver => ,
		enable => ,
		ok => ,
		v => ,
		x => ,
		xx => ,
		l => ,
		c => ,
		cc => 
	);


