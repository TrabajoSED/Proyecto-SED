
-- VHDL Instantiation Created from source file Comprobador.vhd -- 13:20:44 12/28/2013
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Comprobador
	PORT(
		CLK : IN std_logic;
		OK : IN std_logic;
		Codigo_Pdto : IN std_logic_vector(1 downto 0);          
		Pdto : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;

	Inst_Comprobador: Comprobador PORT MAP(
		CLK => ,
		OK => ,
		Codigo_Pdto => ,
		Pdto => 
	);


