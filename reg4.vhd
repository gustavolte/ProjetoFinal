library ieee;
use ieee.std_logic_1164.all;

entity reg4 is
	port(
			c, ld, clr, reset : in bit;
			s : in bit_vector(3 downto 0);
			q : out bit_vector(3 downto 0));
end reg4;

architecture behav of reg4 is
	begin
		process(c, reset)
			begin
				if (reset = '1') then
					q <= "0000";
				elsif (c'event and c = '1') then
					if (clr = '1') then
						q <= "0000";
					elsif (ld = '1') then
						q <= s;
					end if;
				end if;
		end process;
end architecture behav;
