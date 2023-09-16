library ieee;
use ieee.std_logic_1164.all;


entity logic_processor is
port (
	logic_in0                     : in std_logic_vector(3 downto 0);
	logic_in1                     : in std_logic_vector(3 downto 0);
	mux_select_LP                 : in std_logic_vector(1 downto 0);
	o_and, o_or, o_xor, o_xnor   : out std_logic_vector(3 downto 0)
); 
end logic_processor;

	architecture mux_logic_LProcess of logic_processor is
	
	component hex_mux port (
		hex_num3,hex_num2,hex_num1,hex_num0 : in std_logic_vector(3 downto 0);
		mux_select                          : in std_logic_vector(1 downto 0);
		hex_out                             : out std_logic_vector(3 downto 0) -- the hex output
	);
	end component;


begin

	o_and             <= (logic_in0 AND logic_in1);
	o_or              <= (logic_in0 OR logic_in1);
	o_xor             <= (logic_in0 XOR logic_in1);
	o_xnor            <= (logic_in0 XNOR logic_in1);

end mux_logic_LProcess;
	