----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:31:19 12/27/2013 
-- Design Name: 
-- Module Name:    Top_Expendedora - Behavioral 
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


--Comentarios sobre nomenclatura:
--Los puertos que hacen referencia a los valores de las monedas estan escritos en numeros romanos.
--Los puertos acabados en "_as" hacen referencia a las entradas asincronas que aun no han sido sincronizadas
--El mismo nombre de ese puerto, sin la terminacion "_as" hace referencia a que esa señal ya ha sido sincronizada

----------------------------------------------------------------------------------------------------------
--P1,P2,P3 hacen referencia a que la maquina expendedora tiene 3 productos para elegir despues de añadir
--el importe de los productos es:
--
--		P1:	2 euros
--		P2:	2 euros		(para demostrar que diferencia entre dos productos de mismo precio)
--		P3:	1.50 euros
----------------------------------------------------------------------------------------------------------

--DEV es para que te devuelvan las monedas que has introducido.


entity Top_Expendedora is
    Port (
			  CLK: in STD_LOGIC;
			  V_as : in  STD_LOGIC;
           X_as : in  STD_LOGIC;
           XX_as : in  STD_LOGIC;
           L_as : in  STD_LOGIC;
           C_as : in  STD_LOGIC;
           CC_as : in  STD_LOGIC;
           P1_as : in  STD_LOGIC;
           P2_as : in  STD_LOGIC;
           P3_as : in  STD_LOGIC;
           DEV_as : in  STD_LOGIC;
           Producto : out  STD_LOGIC_VECTOR (3 downto 0);
			  Entrega : out STD_LOGIC;
			  V_sal : out STD_LOGIC;
			  X_sal : out STD_LOGIC;
			  XX_sal : out STD_LOGIC;
			  L_sal : out STD_LOGIC;
			  C_sal : out STD_LOGIC;
			  CC_sal : out STD_LOGIC
			  );
end Top_Expendedora;

-------------------------------------------------------------
---------Ctos antirrebote y conexiones añadidas--------------
-------------------------------------------------------------

architecture Behavioral of Top_Expendedora is

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
	
	--COMPONENT Comprobador
	--PORT(
	--	CLK : IN std_logic;
	--	OK : IN std_logic;
	--	Codigo_Pdto : IN std_logic_vector(1 downto 0);          
	--	Pdto : OUT std_logic_vector(1 downto 0);
	--	Tf: OUT std_logic
	--	);
	--END COMPONENT;
	
	COMPONENT Sumador
	PORT(
		CLK : IN std_logic;
		Valor : IN std_logic_vector(7 downto 0);
		Enable : IN std_logic;
		Reset : IN std_logic;          
		Total : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	--COMPONENT Gate_OR
	--PORT(
	--	in1 : IN std_logic;
	--	in2 : IN std_logic;          
	--	Pout : OUT std_logic
	--	);
	--END COMPONENT;
	
	COMPONENT SYNC
	PORT(
		AsyncIn : IN std_logic;
		CLK : IN std_logic;          
		SyncIn : OUT std_logic
		);
	END COMPONENT;
	
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
	
	--Señales entrada codificador precio
	SIGNAL V: STD_LOGIC;
	SIGNAL X: STD_LOGIC;
	SIGNAL XX: STD_LOGIC;
	SIGNAL L: STD_LOGIC;
	SIGNAL C: STD_LOGIC;
	SIGNAL CC: STD_LOGIC;
	--Señales salida codificador precio/entrada sumador
	SIGNAL valor: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL enable_mon:STD_LOGIC;
	--Señales salida maquina/entrada sumador 
	SIGNAL reset_sum: STD_LOGIC;
	--Señales salida sumador/entrada comparador y restador
	SIGNAL total: STD_LOGIC_VECTOR(7 DOWNTO 0);
	--Señal salida maquina/entrada comparador
	SIGNAL enable_comp: STD_LOGIC;
	--Señales salida comparador/entrada maquina
	SIGNAL mayor:STD_LOGIC;
	SIGNAL igual:STD_LOGIC;
	SIGNAL menor:STD_LOGIC;
	--Señales entrada codificador pdto
	SIGNAL P1:STD_LOGIC;
	SIGNAL P2:STD_LOGIC;
	SIGNAL P3:STD_LOGIC;
	SIGNAL Dev:STD_LOGIC;
	SIGNAL RESET_COD_PDTO:STD_LOGIC;--Sale de maquina
	--Señales salida codificador pdto
	SIGNAL precio: STD_LOGIC_VECTOR(7 DOWNTO 0);--Entra a COMPARADOR y RESTADOR
	SIGNAL seleccion: STD_LOGIC; --Va a maquina
	--SIGNAL producto: STD_LOGIC_VECTOR(1 DOWNTO 0); Esta patilla va directa a la salida
	--Señales entrada restador/salida maquina
	SIGNAL enable_rest: STD_LOGIC;
	--Señales salida restador/entrada devolucion
	SIGNAL adevolver: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL enable_dev: STD_LOGIC;
	--Señales salida devolucion/entrada maquina
	SIGNAL ok_dev: STD_LOGIC;
	
	
begin
	----------------------------------------------------------------------
	----------------Instanciacion de todos los sincronizadores------------
	----------------------------------------------------------------------
	Inst_SYNC_V: SYNC PORT MAP(
		AsyncIn =>V_as ,
		CLK => CLK,
		SyncIn => V
	);
	Inst_SYNC_X: SYNC PORT MAP(
		AsyncIn => X_as,
		CLK => CLK,
		SyncIn => X
	);
	Inst_SYNC_XX: SYNC PORT MAP(
		AsyncIn => XX_as,
		CLK => CLK,
		SyncIn => XX
	);
	Inst_SYNC_L: SYNC PORT MAP(
		AsyncIn => L_as,
		CLK => CLK,
		SyncIn => L
	);
	Inst_SYNC_C: SYNC PORT MAP(
		AsyncIn => C_as,
		CLK => CLK,
		SyncIn => C
	);
	Inst_SYNC_CC: SYNC PORT MAP(
		AsyncIn => CC_as,
		CLK => CLK,
		SyncIn => CC
	);
	Inst_SYNC_P1: SYNC PORT MAP(
		AsyncIn => P1_as,
		CLK => CLK,
		SyncIn => P1
	);
	Inst_SYNC_P2: SYNC PORT MAP(
		AsyncIn => P2_as,
		CLK => CLK,
		SyncIn => P2
	);
	Inst_SYNC_P3: SYNC PORT MAP(
		AsyncIn => P3_as,
		CLK => CLK,
		SyncIn => P3
	);
	Inst_SYNC_DEV: SYNC PORT MAP(
		AsyncIn => DEV_as,
		CLK => CLK,
		SyncIn => DEV
	);
	--------------------------------------------------------------
	--------Instanciacion resto de componentes--------------------
	--------------------------------------------------------------
	Inst_Codificador_Monedas: Codificador_Monedas PORT MAP(
		CLK => CLK,
		V => V,
		X => X,
		XX => XX,
		L => L,
		C => C,
		CC =>CC ,
		Valor => valor,
		Enable => enable_mon
	);
	
	Inst_Codificador_pdto: Codificador_pdto PORT MAP(
		CLK => CLK ,
		Pdto1 => P1,
		Pdto2 => P2,
		Pdto3 => P3,
		Dev => Dev,
		Reset => RESET_COD_PDTO,
		Selec => seleccion,
		Precio => precio,
		Codigo_Pdto => Producto
	);
	
	Inst_Comparador_3outs: Comparador_3outs PORT MAP(
		CLK => CLK,
		enable => enable_comp,
		Total => total,
		Precio => precio,
		Mayor => mayor,
		Igual => igual,
		Menor => menor
	);

	Inst_Sumador: Sumador PORT MAP(
		CLK => CLK,
		Valor => valor,
		Enable => enable_mon,
		Reset => reset_sum,
		Total => total
	);
	
	Inst_Restador: Restador PORT MAP(
		total => total,
		precio => precio,
		enable => enable_rest,
		clk => CLK,
		devolver => adevolver,
		ok => enable_dev
	);
	
	Inst_devolucion: devolucion PORT MAP(
		clk => CLK,
		devolver => adevolver,
		enable => enable_dev,
		ok => ok_dev,
		v => V_sal,
		x => X_sal,
		xx => XX_sal,
		l => L_sal,
		c => C_sal,
		cc => CC_sal
	);
	
	Inst_maquina: maquina PORT MAP(
		clk => CLK,
		selec => seleccion,
		mayor => mayor,
		menor => menor,
		igual => igual,
		dev_ok => ok_dev,
		reset_mon => reset_sum,
		en_comp => enable_comp,
		en_rest => enable_rest,
		entrega => Entrega,
		reset_cp => RESET_COD_PDTO
	);

end Behavioral;

