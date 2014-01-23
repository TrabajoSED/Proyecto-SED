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
    generic (semiciclo: positive := 249999);
    Port (
			  CLK: in STD_LOGIC;
			  reset_maq: in STD_LOGIC;
			  --Entradas de monedas
			  V_as : in  STD_LOGIC;	
           X_as : in  STD_LOGIC;
           XX_as : in  STD_LOGIC;
           L_as : in  STD_LOGIC;
           C_as : in  STD_LOGIC;
           CC_as : in  STD_LOGIC;
			  --Entradas de seleccion de producto (DEV-> Devuelve importe introducido)
           P1_as : in  STD_LOGIC;
           P2_as : in  STD_LOGIC;
           P3_as : in  STD_LOGIC;
           DEV_as : in  STD_LOGIC;
           --Producto : out  STD_LOGIC_VECTOR (3 downto 0);
			  Digit_crtl:	out std_logic_vector (6 downto 0); --Salida del mux que enciende los segmentos un display
			  Digit_select: out std_logic_vector (3 downto 0); -- Salida del mux que enciende un display u otro
			  Entrega : out STD_LOGIC;	--Se activa al entregar el producto
			  --Salidas que indican las devoluciones de monedas
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
	
--------------------------------------------------------------
--------Instanciacion prueba de estabilizador de entrada------
--------------------------------------------------------------
	COMPONENT Estabilizador
	PORT(
		Pulsador_in : IN std_logic;
		CLK : IN std_logic;
		--reset : IN std_logic;          
		Pulsador_out : OUT std_logic
		);
	END COMPONENT;
--------------------------------------------------------------
--------------------------------------------------------------
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
		reset : IN std_logic;
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
	
	COMPONENT DecoderBinTo3BCD
	PORT(
		Binario : IN std_logic_vector(7 downto 0);
		CLK : IN std_logic;          
		BCD1 : OUT std_logic_vector(3 downto 0);
		BCD2 : OUT std_logic_vector(3 downto 0);
		BCD3 : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Divisor_CLK
   generic (semiciclo: positive);
	PORT(
		CLK_in : IN std_logic;          
		CLK_out : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT Mux4Display
	PORT(
		CLK : IN std_logic;
		D0_in : IN std_logic_vector(6 downto 0);
		D1_in : IN std_logic_vector(6 downto 0);
		D2_in : IN std_logic_vector(6 downto 0);
		D3_in : IN std_logic_vector(6 downto 0);          
		mux4play_out : OUT std_logic_vector(6 downto 0);
		selec : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	--COMPONENT Decod_Pdto_7Seg
	--PORT(
	--	CLK : IN std_logic;
	--	Pdto_in : IN std_logic_vector(3 downto 0);          
	--	Pdto_out : OUT std_logic_vector(6 downto 0)
	--	);
--	END COMPONENT;
	
	COMPONENT Decod_BCD4bits_7Segm
	PORT(
		BCD_in : IN std_logic_vector(3 downto 0);
		CLK : IN std_logic;          
		Segm7_out : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;
	
	--Señales salida sincronizadores/Entrada estabilizadores
	SIGNAL V_est:STD_LOGIC;
	SIGNAL X_est:STD_LOGIC;
	SIGNAL XX_est:STD_LOGIC;
	SIGNAL L_est:STD_LOGIC;
	SIGNAL C_est:STD_LOGIC;
	SIGNAL CC_est:STD_LOGIC;
	SIGNAL P1_est:STD_LOGIC;
	SIGNAL P2_est:STD_LOGIC;
	SIGNAL P3_est:STD_LOGIC;
	SIGNAL DEV_est:STD_LOGIC;
	--Señales entrada codificador precio/Salida estabilizadores
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
	--Señales entrada codificador pdto/Salida sincronizadores
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
	--Señales salidas producto y total/entrada decoders BCD

	--Señales BCD displays
	SIGNAL BCD1 : STD_LOGIC_VECTOR(3 DOWNTO 0); --Para seleccion producto
	SIGNAL BCD2 : STD_LOGIC_VECTOR(3 DOWNTO 0); --Unidades devolucion
	SIGNAL BCD3 : STD_LOGIC_VECTOR(3 DOWNTO 0); --Decenas devolucion
	SIGNAL BCD4 : STD_LOGIC_VECTOR(3 DOWNTO 0); --Centenas devolucion
	
	--Señal CLK ralentizado
	SIGNAL CLK_slow : STD_LOGIC;
	
	--Señales salida DECOD_BCD_7SEG/ Entrada MUX_Display
	SIGNAL TSUM_D1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL TSUM_D2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL TSUM_D3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
	
	--Señal salida Decod_PDTO/ Entrada Mux
	SIGNAL PDTO_D0 : STD_LOGIC_VECTOR(6 DOWNTO 0);

begin

	----------------------------------------------------------------------
	----------Instanciacion de todos los antirrebotes---------------------
	----------------------------------------------------------------------
	Inst_Estabilizador_V: Estabilizador PORT MAP(
		Pulsador_in => V_est,
		CLK => CLK_slow,
		Pulsador_out =>V--,
		--reset => 
	);
	Inst_Estabilizador_X: Estabilizador PORT MAP(
		Pulsador_in => X_est,
		CLK =>CLK_slow ,
		Pulsador_out => X--,
	--	reset => 0
	);
	Inst_Estabilizador_XX: Estabilizador PORT MAP(
		Pulsador_in =>XX_est ,
		CLK =>CLK_slow ,
		Pulsador_out => XX--,
		--reset => 0
	);
	Inst_Estabilizador_L: Estabilizador PORT MAP(
		Pulsador_in => L_est,
		CLK => CLK_slow,
		Pulsador_out =>L --,
		--reset => 0
	);
	Inst_Estabilizador_C: Estabilizador PORT MAP(
		Pulsador_in => C_est,
		CLK =>CLK_slow ,
		Pulsador_out => C--,
	--	reset => 0
	);
	Inst_Estabilizador_CC: Estabilizador PORT MAP(
		Pulsador_in => CC_est,
		CLK => CLK_slow,
		Pulsador_out => CC--,
	--	reset => 0
	);
	Inst_Estabilizador_P1: Estabilizador PORT MAP(
		Pulsador_in => P1_est,
		CLK =>CLK_slow ,
		Pulsador_out => P1--,
	--	reset => 0
	);
	Inst_Estabilizador_P2: Estabilizador PORT MAP(
		Pulsador_in => P2_est,
		CLK => CLK_slow,
		Pulsador_out =>P2 --,
	--	reset => 0
	);
	Inst_Estabilizador_P3: Estabilizador PORT MAP(
		Pulsador_in => P3_est,
		CLK =>CLK_slow ,
		Pulsador_out => P3--,
		--reset => 0
	);
	Inst_Estabilizador_DEV: Estabilizador PORT MAP(
		Pulsador_in => DEV_est,
		CLK =>CLK_slow ,
		Pulsador_out => DEV--,
	--	reset => 0
	);


	----------------------------------------------------------------------
	----------------Instanciacion de todos los sincronizadores------------
	----------------------------------------------------------------------
	Inst_SYNC_V: SYNC PORT MAP(
		AsyncIn =>V_as ,
		CLK => CLK_slow,
		SyncIn => V_est
	);
	Inst_SYNC_X: SYNC PORT MAP(
		AsyncIn => X_as,
		CLK => CLK_slow,
		SyncIn => X_est
	);
	Inst_SYNC_XX: SYNC PORT MAP(
		AsyncIn => XX_as,
		CLK => CLK_slow,
		SyncIn => XX_est
	);
	Inst_SYNC_L: SYNC PORT MAP(
		AsyncIn => L_as,
		CLK => CLK_slow,
		SyncIn => L_est
	);
	Inst_SYNC_C: SYNC PORT MAP(
		AsyncIn => C_as,
		CLK => CLK_slow,
		SyncIn => C_est
	);
	Inst_SYNC_CC: SYNC PORT MAP(
		AsyncIn => CC_as,
		CLK => CLK_slow,
		SyncIn => CC_est
	);
	Inst_SYNC_P1: SYNC PORT MAP(
		AsyncIn => P1_as,
		CLK => CLK_slow,
		SyncIn => P1_est
	);
	Inst_SYNC_P2: SYNC PORT MAP(
		AsyncIn => P2_as,
		CLK => CLK_slow,
		SyncIn => P2_est
	);
	Inst_SYNC_P3: SYNC PORT MAP(
		AsyncIn => P3_as,
		CLK => CLK_slow,
		SyncIn => P3_est
	);
	Inst_SYNC_DEV: SYNC PORT MAP(
		AsyncIn => DEV_as,
		CLK => CLK_slow,
		SyncIn => DEV_est
	);
	--------------------------------------------------------------
	--------Instanciacion resto de componentes--------------------
	--------------------------------------------------------------
	Inst_Codificador_Monedas: Codificador_Monedas PORT MAP(
		CLK =>CLK_slow,
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
		CLK => CLK_slow ,
		Pdto1 => P1,
		Pdto2 => P2,
		Pdto3 => P3,
		Dev => Dev,
		Reset => RESET_COD_PDTO,
		Selec => seleccion,
		Precio => precio,
		--Codigo_Pdto => Producto
		Codigo_Pdto => BCD1
	);
	
	Inst_Comparador_3outs: Comparador_3outs PORT MAP(
		CLK => CLK_slow,
		enable => enable_comp,
		Total => total,
		Precio => precio,
		Mayor => mayor,
		Igual => igual,
		Menor => menor
	);

	Inst_Sumador: Sumador PORT MAP(
		CLK => CLK_slow,
		Valor => valor,
		Enable => enable_mon,
		Reset => reset_sum,
		Total => total
	);
	
	Inst_Restador: Restador PORT MAP(
		total => total,
		precio => precio,
		enable => enable_rest,
		clk => CLK_slow,
		devolver => adevolver,
		ok => enable_dev
	);
	
	Inst_devolucion: devolucion PORT MAP(
		clk => CLK_slow,
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
		reset => reset_maq,
		clk => CLK_slow,
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
	
	Inst_DecoderBinTo3BCD: DecoderBinTo3BCD PORT MAP(
		Binario => total,
		CLK => CLK_slow,
		BCD1 => BCD2,
		BCD2 => BCD3,
		BCD3 => BCD4
	);
	
	Inst_Divisor_CLK: Divisor_CLK
     generic map (semiciclo => semiciclo)
	  PORT MAP(
		CLK_in => CLK,
		CLK_out => CLK_slow
	);

	Inst_Decod_BCD4bits_7Segm_CIFRA_UDS: Decod_BCD4bits_7Segm PORT MAP(
		BCD_in => BCD2,
		CLK => CLK_slow,
		Segm7_out => TSUM_D1
	);
	
	Inst_Decod_BCD4bits_7Segm_CIFRA_DEC: Decod_BCD4bits_7Segm PORT MAP(
		BCD_in => BCD3,
		CLK => CLK_slow,
		Segm7_out => TSUM_D2
	);
	
	Inst_Decod_BCD4bits_7Segm_CIFRA_CENT: Decod_BCD4bits_7Segm PORT MAP(
		BCD_in => BCD4,
		CLK => CLK_slow,
		Segm7_out => TSUM_D3
	);
	
	----------------------------------------------------------------------------------------
	-------Decodificador para el producto no mostraria más del numero 3, si se -------------
	-------añaden mas productos ya estan implementados los demas numeros al reutilizar------
	----------------------------------------------------------------------------------------
	Inst_Decod_BCD4bits_7Segm_CIFRA_PDTO: Decod_BCD4bits_7Segm PORT MAP(
		BCD_in => BCD1,
		CLK => CLK_slow,
		Segm7_out => PDTO_D0
	);
	
--	Inst_Decod_Pdto_7Seg: Decod_Pdto_7Seg PORT MAP(
	--	CLK => CLK_slow,
	--	Pdto_in => BCD1,
	--	Pdto_out => PDTO_D0
--	);
	
	Inst_Mux4Display: Mux4Display PORT MAP(
		CLK => CLK_slow,
		D0_in => PDTO_D0,
		D1_in => TSUM_D1,
		D2_in => TSUM_D2,
		D3_in => TSUM_D3,
		mux4play_out => Digit_crtl,
		selec => Digit_select
	);
	
	
	
end Behavioral;