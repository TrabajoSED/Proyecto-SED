
-- VHDL Instantiation Created from source file maquina.vhd -- 18:48:48 01/13/2014
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT maquina
	PORT(
		clk : IN std_logic;
		selec : IN std_logic;
		mayor : IN std_logic;
		menor : IN std_logic;
		igual : IN std_logic;
		dev_ok : IN std_logic;          
		reset_mon : OUT std_logic;
		en_comp : OUT std_logic;
		en_rest : OUT std_logic;
		entrega : OUT std_logic;
		reset_cp : OUT std_logic
		);
	END COMPONENT;

	Inst_maquina: maquina PORT MAP(
		clk => ,
		selec => ,
		mayor => ,
		menor => ,
		igual => ,
		dev_ok => ,
		reset_mon => ,
		en_comp => ,
		en_rest => ,
		entrega => ,
		reset_cp => 
	);


