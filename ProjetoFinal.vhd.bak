library ieee;
use ieee.std_logic_1164.all;

entity ProjetoFinal is
    port(
            vacas, temp : in bit_vector(7 downto 0);
            ida, volta, botao, clk, reset : in bit;
            VacasFicaram, VacasNaoVoltaram : out bit_vector(7 downto 0);
            Led : out bit
    );
end;

architecture behav of ProjetoFinal is
    signal eq, t : bit;
    
	 signal eqcomp : bit_vector (6 downto 0);
	 signal gtcomp : bit_vector (6 downto 0);
	 signal ltcomp : bit_vector (6 downto 0);
	 signal eqcomp2 : bit_vector (6 downto 0);
	 signal gtcomp2 : bit_vector (6 downto 0);
	 signal ltcomp2 : bit_vector (6 downto 0);
	 
	 signal co_ci_ida : bit_vector(7 downto 0);
	 signal co_ci_volta : bit_vector(7 downto 0);
	 signal co_ci_temp : bit_vector(7 downto 0);
	 signal c_sub1 : bit_vector(7 downto 0);
	 signal c_sub2 : bit_vector(7 downto 0);
	 
	 signal not_ida : bit_vector(7 downto 0);
	 signal not_volta : bit_vector(7 downto 0);
	 
    signal a2,a1,a0 : bit;
    signal n2,n1,n0 : bit;
    
    signal idaLd, idaclr : bit;
    signal voltald, voltaclr : bit;
    signal templd, tempclr : bit;
    signal VFLoad, VFClr : bit;
    signal VNVLoad, VNVClr : bit;
    
    signal Regtemp, Regida, RegVolta : bit_vector(7 downto 0);
    signal Addtemp, Addida, Addvolta : bit_vector(7 downto 0);
    signal subtrator1, subtrator2 : bit_vector(7 downto 0);
    
    component reg8 is
        port(
                c, ld, clr, reset : in bit;
                s : in bit_vector(7 downto 0);
                q : out bit_vector(7 downto 0));
    end component;
    
    component comp is
        port(
                a, b, in_maior, in_igual, in_menor : in bit;
                out_maior, out_igual, out_menor : out bit
        );
    end component;
    
    component Somador is
        port(
                a, b, ci : in bit;
                co, s : out bit
        );
    end component;
	 
	 component controlador is
			port(
					clk, a2, a1, a0, botao, ida, volta, t, eq : in bit;
					led, n2, n1, n0, idaLd, idaclr, voltald, voltaclr  : out bit;
					templd, tempclr, VFLoad, VFClr, VNVLoad, VNVClr : out bit
			);
	 end component;
	 
	 component reg3 is
			port(
					clk, reset, a2, a1, a0 : in bit;
					n2, n1, n0 : out bit
			);
	 end component;
    
    begin
		uregida:   reg8 port map (c => clk, reset => reset, ld => idaLd,   clr => idaclr,   s => Addida, q => Regida);
		uregvolta: reg8 port map (c => clk, reset => reset, ld => voltald, clr => voltaclr, s => Addvolta, q => RegVolta);
		uregtemp:  reg8 port map (c => clk, reset => reset, ld => templd,  clr => tempclr,  s => Addtemp,  q => Regtemp);
		uregvf:  reg8 port map (c => clk, reset => reset, ld => VFLoad,  clr => VFClr,  s => subtrator1, q => VacasFicaram);
		uregvnv: reg8 port map (c => clk, reset => reset, ld => VNVLoad, clr => VNVClr, s => subtrator2, q => VacasNaoVoltaram);
		
		c0 : controlador port map(
											clk => clk, led => Led, a2 => a2, a1 => a1, a0 => a0, botao => botao, ida => ida, volta => volta, t => t,
											eq => eq, n2 => n2, n1 => n1, n0 => n0, idaLd => idaLd, idaclr => idaclr, voltald => voltald, voltaclr => voltaclr,
											templd => templd, tempclr => tempclr, VFload => VFload, VFclr => VFclr, VNVLoad => VNVLoad, VNVClr => VNVClr		
		);
		c1 : reg3 port map(clk => clk, reset => reset, a2 => n2, a1 => n1, a0 =>n0, n2 => a2, n1 => a1, n0 => a0);
		
		comptemp0 : comp port map(a => temp(7), b => Regtemp(7), in_maior => '0', in_igual => '1', in_menor => '0', out_maior => gtcomp(6), out_igual => eqcomp(6), out_menor => ltcomp(6));
		comptemp1 : comp port map(a => temp(6), b => Regtemp(6), in_maior => gtcomp(6) , in_igual => eqcomp(6), in_menor => ltcomp(6), out_maior => gtcomp(5), out_igual => eqcomp(5), out_menor => ltcomp(5));
		comptemp2 : comp port map(a => temp(5), b => Regtemp(5), in_maior => gtcomp(5) , in_igual => eqcomp(5), in_menor => ltcomp(5), out_maior => gtcomp(4), out_igual => eqcomp(4), out_menor => ltcomp(4));
		comptemp3 : comp port map(a => temp(4), b => Regtemp(4), in_maior => gtcomp(4) , in_igual => eqcomp(4), in_menor => ltcomp(4), out_maior => gtcomp(3), out_igual => eqcomp(3), out_menor => ltcomp(3));
		comptemp4 : comp port map(a => temp(3), b => Regtemp(3), in_maior => gtcomp(3) , in_igual => eqcomp(3), in_menor => ltcomp(3), out_maior => gtcomp(2), out_igual => eqcomp(2), out_menor => ltcomp(2));
		comptemp5: comp port map(a => temp(2), b => Regtemp(2), in_maior => gtcomp(2) , in_igual => eqcomp(2), in_menor => ltcomp(2), out_maior => gtcomp(1), out_igual => eqcomp(1), out_menor => ltcomp(1));
		comptemp6 : comp port map(a => temp(1), b => Regtemp(1), in_maior => gtcomp(1) , in_igual => eqcomp(1), in_menor => ltcomp(1), out_maior => gtcomp(0), out_igual => eqcomp(0), out_menor => ltcomp(0));
		comptemp7 : comp port map(a => temp(0), b => Regtemp(0), in_maior => gtcomp(0) , in_igual => eqcomp(0), in_menor => ltcomp(0), out_maior => open, out_igual => t, out_menor => open);
		comptemp8 : comp port map(a => Regida(7), b => RegVolta(7), in_maior => '0', in_igual => '1', in_menor => '0', out_maior => gtcomp2(6), out_igual => eqcomp2(6), out_menor => ltcomp2(6));
		comptemp9 : comp port map(a => Regida(6), b => RegVolta(6), in_maior => gtcomp2(6) , in_igual => eqcomp2(6), in_menor => ltcomp2(6), out_maior => gtcomp2(5), out_igual => eqcomp2(5), out_menor => ltcomp2(5));
		comptemp10 : comp port map(a => Regida(5), b => RegVolta(5), in_maior => gtcomp2(5) , in_igual => eqcomp2(5), in_menor => ltcomp2(5), out_maior => gtcomp2(4), out_igual => eqcomp2(4), out_menor => ltcomp2(4));
		comptemp11 : comp port map(a => Regida(4), b => RegVolta(4), in_maior => gtcomp2(4) , in_igual => eqcomp2(4), in_menor => ltcomp2(4), out_maior => gtcomp2(3), out_igual => eqcomp2(3), out_menor => ltcomp2(3));
		comptemp12 : comp port map(a => Regida(3), b => RegVolta(3), in_maior => gtcomp2(3) , in_igual => eqcomp2(3), in_menor => ltcomp2(3), out_maior => gtcomp2(2), out_igual => eqcomp2(2), out_menor => ltcomp2(2));
		comptemp13 : comp port map(a => Regida(2), b => RegVolta(2), in_maior => gtcomp2(2) , in_igual => eqcomp2(2), in_menor => ltcomp2(2), out_maior => gtcomp2(1), out_igual => eqcomp2(1), out_menor => ltcomp2(1));
		comptemp14 : comp port map(a => Regida(1), b => RegVolta(1), in_maior => gtcomp2(1) , in_igual => eqcomp2(1), in_menor => ltcomp2(1), out_maior => gtcomp2(0), out_igual => eqcomp2(0), out_menor => ltcomp2(0));
		comptemp15 : comp port map(a => Regida(0), b => RegVolta(0), in_maior => gtcomp2(0) , in_igual => eqcomp2(0), in_menor => ltcomp2(0), out_maior => open, out_igual => eq, out_menor => open);
		co_ci_ida(0) <= '1'; 
		si0: Somador port map (a => Regida(0), b => '0', ci => co_ci_ida(0), co => co_ci_ida(1), s => Addida(0));
		si1: Somador port map (a => Regida(1), b => '0', ci => co_ci_ida(1), co => co_ci_ida(2), s => Addida(1));
		si2: Somador port map (a => Regida(2), b => '0', ci => co_ci_ida(2), co => co_ci_ida(3), s => Addida(2));
		si3: Somador port map (a => Regida(3), b => '0', ci => co_ci_ida(3), co => co_ci_ida(4), s => Addida(3));
		si4: Somador port map (a => Regida(4), b => '0', ci => co_ci_ida(4), co => co_ci_ida(5), s => Addida(4));
		si5: Somador port map (a => Regida(5), b => '0', ci => co_ci_ida(5), co => co_ci_ida(6), s => Addida(5));
		si6: Somador port map (a => Regida(6), b => '0', ci => co_ci_ida(6), co => co_ci_ida(7), s => Addida(6));
		si7: Somador port map (a => Regida(7), b => '0', ci => co_ci_ida(7), co => open,         s => Addida(7));
		co_ci_volta(0) <= '1'; 
		sv0: Somador port map (a => RegVolta(0), b => '0', ci => co_ci_volta(0), co => co_ci_volta(1), s => Addvolta(0));
		sv1: Somador port map (a => RegVolta(1), b => '0', ci => co_ci_volta(1), co => co_ci_volta(2), s => Addvolta(1));
		sv2: Somador port map (a => RegVolta(2), b => '0', ci => co_ci_volta(2), co => co_ci_volta(3), s => Addvolta(2));
		sv3: Somador port map (a => RegVolta(3), b => '0', ci => co_ci_volta(3), co => co_ci_volta(4), s => Addvolta(3));
		sv4: Somador port map (a => RegVolta(4), b => '0', ci => co_ci_volta(4), co => co_ci_volta(5), s => Addvolta(4));
		sv5: Somador port map (a => RegVolta(5), b => '0', ci => co_ci_volta(5), co => co_ci_volta(6), s => Addvolta(5));
		sv6: Somador port map (a => RegVolta(6), b => '0', ci => co_ci_volta(6), co => co_ci_volta(7), s => Addvolta(6));
		sv7: Somador port map (a => RegVolta(7), b => '0', ci => co_ci_volta(7), co => open,           s => Addvolta(7));
		co_ci_temp(0) <= '1'; 
		st0: Somador port map (a => Regtemp(0), b => '0', ci => co_ci_temp(0), co => co_ci_temp(1), s => Addtemp(0));
		st1: Somador port map (a => Regtemp(1), b => '0', ci => co_ci_temp(1), co => co_ci_temp(2), s => Addtemp(1));
		st2: Somador port map (a => Regtemp(2), b => '0', ci => co_ci_temp(2), co => co_ci_temp(3), s => Addtemp(2));
		st3: Somador port map (a => Regtemp(3), b => '0', ci => co_ci_temp(3), co => co_ci_temp(4), s => Addtemp(3));
		st4: Somador port map (a => Regtemp(4), b => '0', ci => co_ci_temp(4), co => co_ci_temp(5), s => Addtemp(4));
		st5: Somador port map (a => Regtemp(5), b => '0', ci => co_ci_temp(5), co => co_ci_temp(6), s => Addtemp(5));
		st6: Somador port map (a => Regtemp(6), b => '0', ci => co_ci_temp(6), co => co_ci_temp(7), s => Addtemp(6));
		st7: Somador port map (a => Regtemp(7), b => '0', ci => co_ci_temp(7), co => open,          s => Addtemp(7));
		not_ida <= not Regida; 
		c_sub1(0) <= '1';
		sb1_0: Somador port map (a => vacas(0), b => not_ida(0), ci => c_sub1(0), co => c_sub1(1), s => subtrator1(0));
		sb1_1: Somador port map (a => vacas(1), b => not_ida(1), ci => c_sub1(1), co => c_sub1(2), s => subtrator1(1));
		sb1_2: Somador port map (a => vacas(2), b => not_ida(2), ci => c_sub1(2), co => c_sub1(3), s => subtrator1(2));
		sb1_3: Somador port map (a => vacas(3), b => not_ida(3), ci => c_sub1(3), co => c_sub1(4), s => subtrator1(3));
		sb1_4: Somador port map (a => vacas(4), b => not_ida(4), ci => c_sub1(4), co => c_sub1(5), s => subtrator1(4));
		sb1_5: Somador port map (a => vacas(5), b => not_ida(5), ci => c_sub1(5), co => c_sub1(6), s => subtrator1(5));
		sb1_6: Somador port map (a => vacas(6), b => not_ida(6), ci => c_sub1(6), co => c_sub1(7), s => subtrator1(6));
		sb1_7: Somador port map (a => vacas(7), b => not_ida(7), ci => c_sub1(7), co => open,      s => subtrator1(7));
		not_volta <= not RegVolta; 
		c_sub2(0) <= '1';
		sb2_0: Somador port map (a => Regida(0), b => not_volta(0), ci => c_sub2(0), co => c_sub2(1), s => subtrator2(0));
		sb2_1: Somador port map (a => Regida(1), b => not_volta(1), ci => c_sub2(1), co => c_sub2(2), s => subtrator2(1));
		sb2_2: Somador port map (a => Regida(2), b => not_volta(2), ci => c_sub2(2), co => c_sub2(3), s => subtrator2(2));
		sb2_3: Somador port map (a => Regida(3), b => not_volta(3), ci => c_sub2(3), co => c_sub2(4), s => subtrator2(3));
		sb2_4: Somador port map (a => Regida(4), b => not_volta(4), ci => c_sub2(4), co => c_sub2(5), s => subtrator2(4));
		sb2_5: Somador port map (a => Regida(5), b => not_volta(5), ci => c_sub2(5), co => c_sub2(6), s => subtrator2(5));
		sb2_6: Somador port map (a => Regida(6), b => not_volta(6), ci => c_sub2(6), co => c_sub2(7), s => subtrator2(6));
		sb2_7: Somador port map (a => Regida(7), b => not_volta(7), ci => c_sub2(7), co => open,      s => subtrator2(7));
end architecture;