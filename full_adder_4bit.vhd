library ieee;
use ieee.std_logic_1164.all;


entity full_adder_4bit is
port (
   hex_A     : in std_logic_vector(3 downto 0);
	hex_B     : in std_logic_vector(3 downto 0);
	carry     : out std_logic;
	sum       : out std_logic_vector(3 downto 0)
); 
end full_adder_4bit;

	
architecture full_4_adder_logic of full_adder_4bit is
	
--
-- Components Used ---
------------------------------------------------------------------- 
  component full_adder_1bit port (
		one        : in std_logic;
		two        : in std_logic;
		carry_in   : in std_logic;
		full_sum   : out std_logic;
		carry_out  : out std_logic
		
   ); 
   end component;
	
	signal carry_2       : std_logic;
	signal carry_3       : std_logic;
	signal initial_carry : std_logic;
	
begin

	-- for the sum adding
	
	INST0: fUll_adder_1bit   port map(hex_A(0), hex_B(0), '0', sum(0), initial_carry);
	INST1: full_adder_1bit   port map(hex_A(1), hex_B(1), initial_carry, sum(1), carry_2);
	INST2: full_adder_1bit   port map(hex_A(2), hex_B(2), carry_2, sum(2), carry_3);
	INST3: full_adder_1bit   port map(hex_A(3), hex_B(3), carry_3, sum(3), carry);
	
end full_4_adder_logic;
	