
-- VHDL Instantiation Created from source file Codificador_pdto.vhd -- 18:11:02 01/13/2014
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Codificador_pdto
	PORT(
		CLK : IN std_logic;
		Pdto1 : IN std_logic;
		Pdto2 : IN std_logic;
		Pdto3 : IN std_logic;
		Dev : IN std_logic;
		Reset : IN std_logic;          
		Selec : OUT std_logic;
		Precio : OUT std_logic_vector(7 downto 0);
		Codigo_Pdto : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	Inst_Codificador_pdto: Codificador_pdto PORT MAP(
		CLK => ,
		Pdto1 => ,
		Pdto2 => ,
		Pdto3 => ,
		Dev => ,
		Reset => ,
		Selec => ,
		Precio => ,
		Codigo_Pdto => 
	);


