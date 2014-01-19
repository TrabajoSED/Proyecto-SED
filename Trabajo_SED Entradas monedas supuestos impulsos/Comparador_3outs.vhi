
-- VHDL Instantiation Created from source file Comparador_3outs.vhd -- 18:40:38 01/13/2014
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Comparador_3outs
	PORT(
		CLK : IN std_logic;
		enable : IN std_logic;
		Total : IN std_logic_vector(7 downto 0);
		Precio : IN std_logic_vector(7 downto 0);          
		Mayor : OUT std_logic;
		Igual : OUT std_logic;
		Menor : OUT std_logic
		);
	END COMPONENT;

	Inst_Comparador_3outs: Comparador_3outs PORT MAP(
		CLK => ,
		enable => ,
		Total => ,
		Precio => ,
		Mayor => ,
		Igual => ,
		Menor => 
	);


