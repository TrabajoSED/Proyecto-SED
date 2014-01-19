
-- VHDL Instantiation Created from source file Sumador.vhd -- 18:41:59 01/13/2014
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Sumador
	PORT(
		CLK : IN std_logic;
		Valor : IN std_logic_vector(7 downto 0);
		Enable : IN std_logic;
		Reset : IN std_logic;          
		Total : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	Inst_Sumador: Sumador PORT MAP(
		CLK => ,
		Valor => ,
		Enable => ,
		Reset => ,
		Total => 
	);


