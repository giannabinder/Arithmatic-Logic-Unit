library ieee;
use ieee.std_logic_1164.all;


entity two_to_one_mux is
port (
	first_input, second_input           : in std_logic_vector(3 downto 0);
	select_2_to_1                       : in std_logic;          
	hex_out_2_to_1                      : out std_logic_vector(3 downto 0) -- the hex output
);

end two_to_one_mux;

architecture mux_logic_2_to_1 of two_to_one_mux is

begin

-- for the multiplexing of four hex input buses
with select_2_to_1  select
	hex_out_2_to_1  <= first_input when '0',
							 second_input when '1';
end mux_logic_2_to_1;