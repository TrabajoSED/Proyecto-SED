
-- VHDL Instantiation Created from source file SYNC.vhd -- 15:24:35 01/02/2014
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT SYNC
	PORT(
		AsyncIn : IN std_logic;
		CLK : IN std_logic;          
		SyncIn : OUT std_logic
		);
	END COMPONENT;

	Inst_SYNC: SYNC PORT MAP(
		AsyncIn => ,
		CLK => ,
		SyncIn => 
	);


