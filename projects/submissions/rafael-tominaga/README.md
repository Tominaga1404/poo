# Pousada Paraiso Management System

## 1. Nome e Descrição do Domínio
* **Nome do Sistema:** Pousada Paraiso Management System
* **Descrição:** Aplicação em console desenvolvida em Java 21 para o gerenciamento operacional de uma pousada/hotel. O sistema automatiza o registro de hóspedes, alocação de quartos conforme a categoria, cálculo dinâmico e polimórfico de diárias com adicionais de serviços, controle de ocupação e emissão de extrato consolidado no check-out.

---

## 2. Casos de Uso da Aplicação

### UC01 - Realizar Check-in de Hóspede
* **Ator:** Recepcionista.
* **Descrição:** Aloca uma acomodação disponível para um hóspede informado, definindo a quantidade pretendida de diárias e atualizando o estado do quarto para ocupado.
* **Pré-condição:** Acomodação desocupada e quantidade de diárias válida ($> 0$).
* **Pós-condição:** Acomodação associada ao hóspede e marcada como indisponível.

### UC02 - Consultar Ocupação e Faturamento Estimado
* **Ator:** Administrador / Gerente da Pousada.
* **Descrição:** Percorre todas as acomodações cadastradas na estrutura de dados (vetor polimórfico), listando os quartos em uso e totalizando o faturamento projetado com base nas regras tarifárias de cada categoria.
* **Pós-condição:** Relatório impresso com o total consolidado de receitas e percentual de ocupação.

### UC03 - Realizar Check-out e Fechamento de Conta
* **Ator:** Recepcionista.
* **Descrição:** Executa a desocupação da acomodação, calcula o montante devido aplicando as regras tarifárias específicas da categoria do quarto (e eventuais serviços extras/taxas mínimas) e libera a acomodação para novas reservas.
* **Pós-condição:** Quarto liberado e extrato final emitido no terminal.

---

## 3. Regras de Negócio

* **RN01 - Bloqueio de Quarto Ocupado:** Uma acomodação não pode receber check-in se já estiver com o estado de ocupação ativo (`ocupada == true`).
* **RN02 - Validação Estrita de Noites:** O período de estadia informado deve ser de no mínimo 1 (uma) diária inteira; valores menores ou iguais a zero devem ser terminantemente rejeitados com mensagem explicativa.
* **RN03 - Especialização Tarifária Polimórfica:**
  * O `QuartoStandard` cobra uma tarifa básica fixa por diária, com acréscimo pontual se o frigobar personalizado for ativado.
  * A `SuitePresidencial` aplica um acréscimo percentual obrigatório de 25% sobre a diária-base caso o serviço de mordomo exclusivo esteja habilitado.
* **RN04 - Integridade dos Dados de Hóspede:** Não é permitido instanciar ou cadastrar um hóspede com nome vazio/em branco ou documento nulo; tais violações devem disparar exceções de argumento inválido (`IllegalArgumentException`).
* **RN05 - Taxa Compulsoria de Higienização:** Caso ocorra cancelamento imediato ou saída antecipada sem diárias consumidas registradas na finalização da estadia, o sistema aplica uma taxa fixa de higienização de R$ 80,00.

---

## 4. Diagrama de Classes

### Relações e Papéis no Diagrama:
1. **`Acomodacao` (Classe Abstrata):** Raiz da hierarquia de acomodações, contendo atributos encapsulados (`numero`, `valorDiariaBase`, `ocupada`), membro estático contador (`totalAcomodacoes`) e o método polimórfico abstrato `calcularPrecoTotal(int noites)`.
2. **`QuartoStandard`:** Subclasse que herda de `Acomodacao` e especializa o comportamento tarifário considerando opcionais de frigobar.
3. **`SuitePresidencial`:** Subclasse que herda de `Acomodacao` e especializa o comportamento aplicando a taxa de mordomo.
4. **`Hospede`:** Classe associada que armazena os dados cadastrais validados.
5. **`Hospedagem`:** Representa a associação/composição entre `Hospede` e `Acomodacao`, encapsulando as operações de negócio (check-in, check-out e cálculo do total).
6. **`SistemaPousada`:** Ponto de entrada (`main`), orquestrando menus, coleções em array e demonstrações de cenários.

---

## 5. Mapeamento de Requisitos Obrigatórios do Projeto

| Requisito do Edital | Onde / Como foi implementado |
| :--- | :--- |
| **Versão Java** | Java 21 LTS (`switch` expressions, records/regras modernas). |
| **Pelo menos 4 classes de domínio** | `Acomodacao`, `QuartoStandard`, `SuitePresidencial`, `Hospede`, `Hospedagem`. |
| **Encapsulamento e Proteção de Estado** | Atributos privados em todas as entidades; mutação controlada exclusivamente por métodos de negócio (`ocupar()`, `desocupar()`). |
| **Membro de Classe (`static`)** | Variável estática contadora em `Acomodacao` para rastrear instâncias criadas e emitir relatórios globais. |
| **Herança e Polimorfismo** | `Acomodacao` (superclasse abstrata) estendida por `QuartoStandard` e `SuitePresidencial`; chamada polimórfica percorrida em array: `a.calcularPrecoTotal(noites)`. |
| **Sobrescrita de `toString()`** | Implementada em `Hospede` e nas subclasses de `Acomodacao`. |
| **Estruturas de Seleção** | Uso de `if-else` (validação de estado) e `switch expression` (menu do sistema e cálculo de opcionais). |
| **Estruturas de Repetição** | Uso de laço `for-each` (percorrer vetor polimórfico de quartos) e `while` (controle de ciclo de vida do menu principal). |
| **Array de Objetos do Domínio** | Armazenamento de quartos em `Acomodacao[] catalogoQuartos`. |
| **Validação e Fronteiras** | Cenário de sucesso, rejeição de check-in em quarto ocupado (RN01), rejeição de noites $\le 0$ (RN02) e caso de fronteira com exatamente 1 diária. |

---

## 6. Instruções de Compilação e Execução

A partir da raiz da submissão:

```bash
cd projects/submissions/rafael-tominaga
mkdir -p bin
javac -d bin src/*.java
java -cp bin SistemaPousada
```
