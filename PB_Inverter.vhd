LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY PB_Inverter IS
	PORT
	(
		pb_n : IN std_logic_vector (3 downto 0);
		pb : OUT std_logic_vector (3 downto 0)
	); 
end PB_Inverter;
		
ARCHITECTURE gates OF PB_Inverter IS


BEGIN 

pb <= not(pb_n);

END gates;