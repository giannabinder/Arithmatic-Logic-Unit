library ieee;
use ieee.std_logic_1164.all;


entity full_adder_1bit is
port (
	one       : in std_logic;
	two       : in std_logic;
	carry_in  : in std_logic;
	full_sum : out std_logic;
	carry_out  : out std_logic
); 
end full_adder_1bit;

	architecture full_adder_logic of full_adder_1bit is

begin

	-- for the sum adding
	full_sum <= ((one XOR two) XOR carry_in);
	carry_out <= ((one AND two) OR ((one XOR two) AND carry_in));
	
end full_adder_logic;
	