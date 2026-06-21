library ieee;
use ieee.std_logic_1164.all;

entity comp is
	port(
		a, b, in_maior, in_igual, in_menor : in bit;
		out_maior, out_igual, out_menor : out bit
	);
end;

architecture behav of comp is
	begin
		out_maior <= in_maior or (in_igual and a and not b);
		out_igual <= in_igual and (a xnor b);
		out_menor <= in_menor or (in_igual and not a and b);
end;
