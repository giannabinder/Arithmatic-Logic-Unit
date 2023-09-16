library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


 entity LogicalStep_Lab2_top is
port (
	clkin_50			: in	std_logic;
	pb_n				: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;



architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
  component SevenSegment port (
		hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
		sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	component segment7_mux port (
		clk            : in std_logic := '0';
		DIN2           : in std_logic_vector (6 downto 0);
		DIN1           : in std_logic_vector (6 downto 0);
		DOUT           : out std_logic_vector (6 downto 0);
		DIG2           : out std_logic;
		DIG1           : out std_logic
	);
	end component;
	
	component logic_processor port (
		logic_in0                     : in std_logic_vector(3 downto 0);
		logic_in1                     : in std_logic_vector(3 downto 0);
		mux_select_LP                 : in std_logic_vector(1 downto 0);
		o_and,o_or,o_xor,o_xnor       : out std_logic_vector(3 downto 0)	
	
	);
	end component; 
	
	component PB_Inverter port (
		pb_n   : IN std_logic_vector (3 downto 0);
		pb     : OUT std_logic_vector (3 downto 0)
	);
	end component;
	
	component full_adder_4bit port (
		hex_A     : in std_logic_vector(3 downto 0);
		hex_B     : in std_logic_vector(3 downto 0);
		carry     : out std_logic;
		sum       : out std_logic_vector(3 downto 0)
		
	);
	end component;
	
	component two_to_one_mux port (
		first_input                         : in std_logic_vector(3 downto 0);
		second_input                        : in std_logic_vector(3 downto 0);
		select_2_to_1                       : in std_logic;          
		hex_out_2_to_1                      : out std_logic_vector(3 downto 0) -- the hex output
	);
	end component;
	
	component hex_mux port (
		hex_num0,hex_num1,hex_num2,hex_num3 : in std_logic_vector(3 downto 0);
		mux_select                          : in std_logic_vector(1 downto 0);
		hex_out                             : out std_logic_vector(3 downto 0) -- the hex output
	);
	end component;
	
	
-- Create any signals, or temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--
	
	signal hex_A		    : std_logic_vector(3 downto 0);
	signal hex_B		    : std_logic_vector(3 downto 0);
	
	signal seg7_A		    : std_logic_vector(6 downto 0);
	signal seg7_B		    : std_logic_vector(6 downto 0);
	
	signal pb             : std_logic_vector(3 downto 0);
	
	signal concatenation  : std_logic_vector(3 downto 0);
	signal hex_A_sum		 : std_logic_vector(3 downto 0);
	signal hex_B_carry	 : std_logic_vector(3 downto 0);
	signal carry          : std_logic;
	signal sum            : std_logic_vector(3 downto 0);
	
	signal o_and, o_or, o_xor, o_xnor : std_logic_vector(3 downto 0);
	
	
-- Here the circuit begins

begin

	hex_A <= sw(3 downto 0);
	hex_B <= sw(7 downto 4);
	
	-- concatenation
	concatenation <= "000" & carry;
	
--COMPONENT HOOKUP
--
-- generate the seven segment coding

	INSTA1: logic_processor port map(hex_A, hex_B, pb(1 downto 0), o_and, o_or, o_xor, o_xnor);
	INSTA2: hex_mux         port map(o_and, o_or, o_xor, o_xnor, pb(1 downto 0), leds(3 downto 0));
	INSTB: PB_Inverter      port map(pb_n(3 downto 0), pb(3 downto 0));
	
	INSTC: full_adder_4bit  port map(hex_A, hex_B, carry, sum);
	
	INSTD: two_to_one_mux   port map(hex_A, sum, pb(2), hex_A_sum);
	INSTE: two_to_one_mux   port map(hex_B, concatenation, pb(2), hex_B_carry);
	
	
	INST1: SevenSegment     port map(hex_A_sum, seg7_A);
	INST2: SevenSegment     port map(hex_B_carry, seg7_B);
	INST3: segment7_mux     port map(clkin_50, seg7_A, seg7_B, seg7_data(6 downto 0), seg7_char2, seg7_char1);

end SimpleCircuit;

