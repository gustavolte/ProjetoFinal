# 🐄 ProjetoFinal — Controle de Contagem de Vacas (VHDL / Quartus II)

Projeto desenvolvido em **VHDL** utilizando o ambiente **Intel Quartus II 13.0 SP1**, com alvo na FPGA **Cyclone II (EP2C35F672C6)**. O circuito implementa um sistema digital de **monitoramento e contagem de vacas** que entram e saem de um local, rastreando quantas ficaram e quantas não voltaram.

---

## 📋 Descrição do Sistema

O sistema recebe entradas externas relacionadas ao movimento de vacas (`ida` e `volta`) e a um valor de temperatura (`temp`), processando tudo através de uma **máquina de estados finitos (FSM)** com datapath estrutural em VHDL.

### Entradas

| Sinal       | Largura  | Descrição                                      |
|-------------|----------|------------------------------------------------|
| `vacas`     | 8 bits   | Quantidade total de vacas                      |
| `temp`      | 8 bits   | Valor de temperatura de referência             |
| `ida`       | 1 bit    | Indica que uma vaca saiu                       |
| `volta`     | 1 bit    | Indica que uma vaca voltou                     |
| `botao`     | 1 bit    | Botão de início/gatilho da FSM                 |
| `clk`       | 1 bit    | Clock do sistema                               |
| `reset`     | 1 bit    | Reset assíncrono global                        |

### Saídas

| Sinal              | Largura  | Descrição                                      |
|--------------------|----------|------------------------------------------------|
| `VacasFicaram`     | 8 bits   | Resultado: vacas que ficaram (vacas − ida)     |
| `VacasNaoVoltaram` | 8 bits   | Resultado: vacas que não voltaram (ida − volta)|
| `Led`              | 1 bit    | LED indicador de estado de igualdade atingido  |

---

## 🧩 Arquitetura e Componentes

O projeto é composto por **6 arquivos VHDL**, cada um responsável por um componente:

```
ProjetoFinal/
├── ProjetoFinal.vhd    # Entidade top-level — instancia todos os componentes
├── controlador.vhd     # FSM (Máquina de Estados Finitos) — lógica de controle
├── reg3.vhd            # Registrador de 3 bits — armazena estado atual da FSM
├── reg8.vhd            # Registrador de 8 bits com load/clear — armazena contagens
├── comp.vhd            # Comparador bit a bit — compara dois vetores de 8 bits
├── Somador.vhd         # Somador completo de 1 bit — base dos somadores/subtradores
├── Waveform.vwf        # Forma de onda de simulação 1
├── Waveform1.vwf       # Forma de onda de simulação 2
└── ProjetoFinal.qsf    # Configurações do projeto Quartus II
```

---

## 🔁 Máquina de Estados (FSM)

O **controlador** implementa uma FSM com **4 estados** codificados em 3 bits (`a2, a1, a0`):

| Estado | a2 a1 a0 | Descrição                                           |
|--------|----------|-----------------------------------------------------|
| S0     | 0 0 0    | **Idle / Reset** — limpa todos os registradores     |
| S1     | 0 0 1    | **Leitura** — captura `temp`, `ida` e `volta`       |
| S2     | 0 1 0    | **Cálculo** — computa `VacasFicaram` e `VacasNaoVoltaram` |
| S3     | 0 1 1    | **Saída** — ativa o LED se `ida == volta` (eq)     |

### Lógica de Transição

```
S0 → S1 : quando botao = '1'
S1 → S1 : enquanto temp ≠ Regtemp (t = '0')
S1 → S2 : quando temp = Regtemp  (t = '1')
S2 → S1 : sempre (loop de leitura)
```

---

## ⚙️ Datapath

### Somadores (Incrementadores)
Os registradores de `ida`, `volta` e `temp` possuem **incrementadores de 8 bits** construídos com 8 instâncias do `Somador` (carry-ripple), com `ci(0) = '1'` para implementar `Reg + 1`.

### Subtrações (via complemento de 2)
As saídas finais são calculadas por subtração usando a identidade:
```
A - B = A + (NOT B) + 1
```
- `VacasFicaram     = vacas - Regida`
- `VacasNaoVoltaram = Regida - RegVolta`

### Comparadores
Dois comparadores de 8 bits em cascata, cada um construído com 8 instâncias do `comp`:
- **Comparador 1**: `temp` vs `Regtemp` → sinal `t` (igualdade)
- **Comparador 2**: `Regida` vs `RegVolta` → sinal `eq` (igualdade)

---

## 🛠️ Ferramentas Utilizadas

- **Intel Quartus II 13.0 SP1** — síntese e compilação
- **ModelSim-Altera** — simulação funcional (Verilog output)
- **FPGA**: Cyclone II — `EP2C35F672C6` (FBGA-672)
- **Linguagem**: VHDL (IEEE 1164)

---

## 📊 Simulação

O projeto inclui dois arquivos de forma de onda (`.vwf`) para validação funcional:
- `Waveform.vwf` — simulação básica das entradas e saídas
- `Waveform1.vwf` — simulação estendida com mais casos de teste

---

## 👥 Autores

Projeto acadêmico desenvolvido para disciplina de **Sistemas Digitais / Circuitos Digitais**.

---

## 📄 Licença

Este projeto é de uso **acadêmico**. Consulte os autores para qualquer uso externo.
