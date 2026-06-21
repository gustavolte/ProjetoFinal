library ieee;
use ieee.std_logic_1164.all;

entity reg3 is
	port(
			clk, reset, a2, a1, a0 : in bit;
			n2, n1, n0 : out bit);
end;

architecture behav of reg3 is
	begin
		process(clk, reset)
			begin
				if (reset = '1') then
					n2 <= '0';
					n1 <= '0';
					n0 <= '0';
				elsif (clk'event and clk = '1') then
					n2 <= a2;
					n1 <= a1;
					n0 <= a0;
				end if;
		end process;
end architecture behav;
