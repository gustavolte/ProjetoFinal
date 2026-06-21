library ieee;
use ieee.std_logic_1164.all;

entity controlador is
	port(
		  clk, a2, a1, a0, botao, ida, volta, t, eq : in bit;
		  led, n2, n1, n0, idaLd, idaclr, voltald, voltaclr  : out bit;
		  templd, tempclr, VFLoad, VFClr, VNVLoad, VNVClr : out bit
		);
end;

architecture behav of controlador is
	signal s0, s1, s2, s3 : bit;
	begin

		s0 <= (not a2) and (not a1) and (not a0);
		s1 <= (not a2) and (not a1) and a0;
		s2 <= (not a2) and a1 and (not a0);
		s3 <= (not a2) and a1 and a0;

		n0 <= (s0 and botao) or (s1 and not t) or s2;
		n1 <= (s1 and t) or s2;
		n2 <= '0';

		
		templd <= s1;

		
		idaLd   <= s1 and ida;
		voltald <= s1 and volta;

		
		VFLoad  <= s2;
		VNVLoad <= s2;

		
		tempclr  <= s0;
		idaclr   <= s0;
		voltaclr <= s0;
		VFClr    <= s0;
		VNVClr   <= s0;

		
		led <= s3 and eq;
end;
