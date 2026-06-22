library ieee;
use ieee.std_logic_1164.all;

entity ProjetoFinal is
    port(
            vacas, temp : in bit_vector(3 downto 0);
            ida, volta, botao, clk, reset : in bit;
            VacasFicaram, VacasNaoVoltaram : out bit_vector(3 downto 0);
            Led : out bit
    );
end;

architecture behav of ProjetoFinal is
    signal eq, t : bit;
    
	 signal eqcomp : bit_vector (2 downto 0);
	 signal gtcomp : bit_vector (2 downto 0);
	 signal ltcomp : bit_vector (2 downto 0);
	 signal eqcomp2 : bit_vector (2 downto 0);
	 signal gtcomp2 : bit_vector (2 downto 0);
	 signal ltcomp2 : bit_vector (2 downto 0);
	 
	 signal co_ci_ida : bit_vector(3 downto 0);
	 signal co_ci_volta : bit_vector(3 downto 0);
	 signal co_ci_temp : bit_vector(3 downto 0);
	 signal c_sub1 : bit_vector(3 downto 0);
	 signal c_sub2 : bit_vector(3 downto 0);
	 
	 signal not_ida : bit_vector(3 downto 0);
	 signal not_volta : bit_vector(3 downto 0);
	 
    signal a2,a1,a0 : bit;
    signal n2,n1,n0 : bit;
    
    signal idaLd, idaclr : bit;
    signal voltald, voltaclr : bit;
    signal templd, tempclr : bit;
    signal VFLoad, VFClr : bit;
    signal VNVLoad, VNVClr : bit;
    
    signal Regtemp, Regida, RegVolta : bit_vector(3 downto 0);
    signal Addtemp, Addida, Addvolta : bit_vector(3 downto 0);
    signal subtrator1, subtrator2 : bit_vector(3 downto 0);
    
    component reg4 is
        port(
                c, ld, clr, reset : in bit;
                s : in bit_vector(3 downto 0);
                q : out bit_vector(3 downto 0));
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
		uregida:   reg4 port map (c => clk, reset => reset, ld => idaLd,   clr => idaclr,   s => Addida, q => Regida);
		uregvolta: reg4 port map (c => clk, reset => reset, ld => voltald, clr => voltaclr, s => Addvolta, q => RegVolta);
		uregtemp:  reg4 port map (c => clk, reset => reset, ld => templd,  clr => tempclr,  s => Addtemp,  q => Regtemp);
		uregvf:  reg4 port map (c => clk, reset => reset, ld => VFLoad,  clr => VFClr,  s => subtrator1, q => VacasFicaram);
		uregvnv: reg4 port map (c => clk, reset => reset, ld => VNVLoad, clr => VNVClr, s => subtrator2, q => VacasNaoVoltaram);
		
		c0 : controlador port map(
											clk => clk, led => Led, a2 => a2, a1 => a1, a0 => a0, botao => botao, ida => ida, volta => volta, t => t,
											eq => eq, n2 => n2, n1 => n1, n0 => n0, idaLd => idaLd, idaclr => idaclr, voltald => voltald, voltaclr => voltaclr,
											templd => templd, tempclr => tempclr, VFload => VFload, VFclr => VFclr, VNVLoad => VNVLoad, VNVClr => VNVClr);
		
		c1 : reg3 port map(clk => clk, reset => reset, a2 => n2, a1 => n1, a0 =>n0, n2 => a2, n1 => a1, n0 => a0);
		
		
		comptemp1 : comp port map(a => temp(3), b => Regtemp(3), in_maior => '0' , in_igual => '1', in_menor => '0', out_maior => gtcomp(2), out_igual => eqcomp(2), out_menor => ltcomp(2));
		comptemp2: comp port map(a => temp(2), b => Regtemp(2), in_maior => gtcomp(2) , in_igual => eqcomp(2), in_menor => ltcomp(2), out_maior => gtcomp(1), out_igual => eqcomp(1), out_menor => ltcomp(1));
		comptemp3 : comp port map(a => temp(1), b => Regtemp(1), in_maior => gtcomp(1) , in_igual => eqcomp(1), in_menor => ltcomp(1), out_maior => gtcomp(0), out_igual => eqcomp(0), out_menor => ltcomp(0));
		comptemp4 : comp port map(a => temp(0), b => Regtemp(0), in_maior => gtcomp(0) , in_igual => eqcomp(0), in_menor => ltcomp(0), out_maior => open, out_igual => t, out_menor => open);
		
		comptemp5 : comp port map(a => Regida(3), b => RegVolta(3), in_maior => '0' , in_igual => '1', in_menor => '0', out_maior => gtcomp2(2), out_igual => eqcomp2(2), out_menor => ltcomp2(2));
		comptemp6 : comp port map(a => Regida(2), b => RegVolta(2), in_maior => gtcomp2(2) , in_igual => eqcomp2(2), in_menor => ltcomp2(2), out_maior => gtcomp2(1), out_igual => eqcomp2(1), out_menor => ltcomp2(1));
		comptemp7 : comp port map(a => Regida(1), b => RegVolta(1), in_maior => gtcomp2(1) , in_igual => eqcomp2(1), in_menor => ltcomp2(1), out_maior => gtcomp2(0), out_igual => eqcomp2(0), out_menor => ltcomp2(0));
		comptemp8 : comp port map(a => Regida(0), b => RegVolta(0), in_maior => gtcomp2(0) , in_igual => eqcomp2(0), in_menor => ltcomp2(0), out_maior => open, out_igual => eq, out_menor => open);
		
		co_ci_ida(0) <= '1'; 
		si0: Somador port map (a => Regida(0), b => '0', ci => co_ci_ida(0), co => co_ci_ida(1), s => Addida(0));
		si1: Somador port map (a => Regida(1), b => '0', ci => co_ci_ida(1), co => co_ci_ida(2), s => Addida(1));
		si2: Somador port map (a => Regida(2), b => '0', ci => co_ci_ida(2), co => co_ci_ida(3), s => Addida(2));
		si3: Somador port map (a => Regida(3), b => '0', ci => co_ci_ida(3), co => open, s => Addida(3));
		
		
		co_ci_volta(0) <= '1'; 
		sv0: Somador port map (a => RegVolta(0), b => '0', ci => co_ci_volta(0), co => co_ci_volta(1), s => Addvolta(0));
		sv1: Somador port map (a => RegVolta(1), b => '0', ci => co_ci_volta(1), co => co_ci_volta(2), s => Addvolta(1));
		sv2: Somador port map (a => RegVolta(2), b => '0', ci => co_ci_volta(2), co => co_ci_volta(3), s => Addvolta(2));
		sv3: Somador port map (a => RegVolta(3), b => '0', ci => co_ci_volta(3), co => open, s => Addvolta(3));
		
		co_ci_temp(0) <= '1'; 
		st0: Somador port map (a => Regtemp(0), b => '0', ci => co_ci_temp(0), co => co_ci_temp(1), s => Addtemp(0));
		st1: Somador port map (a => Regtemp(1), b => '0', ci => co_ci_temp(1), co => co_ci_temp(2), s => Addtemp(1));
		st2: Somador port map (a => Regtemp(2), b => '0', ci => co_ci_temp(2), co => co_ci_temp(3), s => Addtemp(2));
		st3: Somador port map (a => Regtemp(3), b => '0', ci => co_ci_temp(3), co => open, s => Addtemp(3));

		
		not_ida <= not Regida; 
		c_sub1(0) <= '1';
		sb1_0: Somador port map (a => vacas(0), b => not_ida(0), ci => c_sub1(0), co => c_sub1(1), s => subtrator1(0));
		sb1_1: Somador port map (a => vacas(1), b => not_ida(1), ci => c_sub1(1), co => c_sub1(2), s => subtrator1(1));
		sb1_2: Somador port map (a => vacas(2), b => not_ida(2), ci => c_sub1(2), co => c_sub1(3), s => subtrator1(2));
		sb1_3: Somador port map (a => vacas(3), b => not_ida(3), ci => c_sub1(3), co => open, s => subtrator1(3));

		
		not_volta <= not RegVolta; 
		c_sub2(0) <= '1';
		sb2_0: Somador port map (a => Regida(0), b => not_volta(0), ci => c_sub2(0), co => c_sub2(1), s => subtrator2(0));
		sb2_1: Somador port map (a => Regida(1), b => not_volta(1), ci => c_sub2(1), co => c_sub2(2), s => subtrator2(1));
		sb2_2: Somador port map (a => Regida(2), b => not_volta(2), ci => c_sub2(2), co => c_sub2(3), s => subtrator2(2));
		sb2_3: Somador port map (a => Regida(3), b => not_volta(3), ci => c_sub2(3), co => open, s => subtrator2(3));

end architecture;