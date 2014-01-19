
-- VHDL Instantiation Created from source file Codificador_Monedas.vhd -- 18:10:04 01/13/2014
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Codificador_Monedas
	PORT(
		CLK : IN std_logic;
		V : IN std_logic;
		X : IN std_logic;
		XX : IN std_logic;
		L : IN std_logic;
		C : IN std_logic;
		CC : IN std_logic;          
		Valor : OUT std_logic_vector(7 downto 0);
		Enable : OUT std_logic
		);
	END COMPONENT;

	Inst_Codificador_Monedas: Codificador_Monedas PORT MAP(
		CLK => ,
		V => ,
		X => ,
		XX => ,
		L => ,
		C => ,
		CC => ,
		Valor => ,
		Enable => 
	);


