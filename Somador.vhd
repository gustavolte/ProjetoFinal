library ieee;
use ieee.std_logic_1164.all;

entity Somador is
	port(
		a, b, ci : in bit;
		co, s : out bit
	);
end;

architecture behav of Somador is
	begin
		co <= (a and ci) or (a and b) or (b and ci);
		s <= (a and not b and not ci) or (not a and b and not ci) or (not a and not b and ci) or (a and b and ci);
end;