# Au-Au Palace — Sistema de hospedagem para cães

## Descrição

Sistema de gerenciamento para um hotel de cães. O sistema permite cadastrar tutores e seus cães, registrar hospedagens, selecionar serviços adicionais, calcular os valores da estadia e emitir uma nota fiscal detalhada. Também permite visualizar os cães cadastrados e consultar estatísticas básicas do sistema.

## Casos de uso 

1. **Cadastrar tutor e cão:** cadastrar um novo tutor e seu cão, ou informar o CPF de um tutor já existente para associar outro cão a ele.
2. **Registrar uma hospedagem:** selecionar um cão cadastrado, informar o número de diárias, escolher serviços extras e visualizar a nota fiscal com valores, taxa de cão idoso e eventual desconto de aniversário.
3. **Consultar os cães cadastrados:** listar os cães com dados básicos, som e diária base.

## Funcionalidades implementadas

1. **Cadastrar tutor e cão:** registra CPF, nome e telefone do tutor e os dados do cão. Se o CPF já estiver cadastrado, o novo cão é associado ao tutor existente. O cadastro verifica campos obrigatórios, CPF e telefone numéricos, data de nascimento válida, porte selecionado e vacinação.
2. **Registrar hospedagem:** permite selecionar um cão pelo índice, informar a quantidade de diárias e escolher banho, tosa e adestramento. 
3. **Listar cães cadastrados:** apresenta os dados de cada cão, o som definido pela subclasse e o valor da diária base.
4. **Consultar estatísticas:** apresenta a quantidade total de cães cadastrados.
5. **Sair:** encerra o menu da aplicação.

## Regras de negócio

- O cão precisa estar vacinado para ser cadastrado e hospedado.
- O cão deve ter nome, raça, data de nascimento válida e um tutor associado.
- O CPF do tutor deve conter 11 dígitos numéricos; o mesmo CPF é reutilizado para vincular mais de um cão ao tutor já cadastrado.
- A quantidade de diárias deve ser maior que zero.
- O sistema aceita até 10 cães, 10 tutores e 10 registros de hospedagem por execução.
- A diária base depende do porte: pequeno R$ 50,00; médio R$ 60,00; grande R$ 70,00.
- Cães com 7 anos ou mais recebem uma taxa adicional de 10% sobre o subtotal das diárias.
- Quando o mês de nascimento do cão coincide com o mês atual, é aplicado um desconto de 10% sobre o subtotal das diárias, considerando também a taxa de cão idoso quando aplicável. Os serviços extras são somados depois desse desconto e não recebem abatimento.

## Organização das classes

- `AuAuPalaceApp`: apresenta o menu, lê as entradas, coordena o fluxo da aplicação e gerencia os arrays.
- `Tutor`: armazena e valida os dados do tutor.
- `Cao`: classe abstrata com dados e comportamentos comuns aos cães, validações e vínculo com o tutor.
- `CaoPequeno`, `CaoMedio` e `CaoGrande`: especializam o tipo `Cao`, implementando o som e a diária base de cada porte.
- `Hospedagem`: valida as condições de uma hospedagem, calcula valores e gera a nota fiscal textual.
- `HospedagemInvalidaException`: representa erros de validação relacionados à hospedagem.