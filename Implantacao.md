# Check List Técnico Implantação

## 1º - Processos Básicos que deverão ser testados

### 1.1º - Em ambiente de Homologação (Arquivo config.xml com a tag tpAmb = 2):

* Menu Principal: Verificar se Logo da empresa está visível.
* Rotina 101: Cadastrar um novo Cliente (Utilize para gerar CPF: https://www.4devs.com.br/gerador_de_cpf).
* Rotina 611: Cadastrar Limite de Crédito para o Cliente novo (Pode ser de R$ 5.000,00)
* Rotina 113: Cadastrar um novo Produto (pode ser duplicado um produto que já seja utilizado na base do cliente).
* Rotina 113: Definir os Grupos de Tributação para o produto novo.
* Rotina 119: Precificar Produto novo.
* Rotina 801: Lançar a Entrada manual na 801 para o produto cadastrado
* Rotina 201: Lançar uma NFENTRADA na rotina 201 para o produto cadastrado (Inserir Desconto e outros atributos)
* Rotina 802: Conferir estoque do produto novo pelo 'Extrato de Movimentação', e utilizar a aba 'Posição do Estoque'.
* Rotina 802: Conferir e custo da última entrada lançada, e verificar o abatimento do desconto.
* Rotina 602: Conferir se foi gerada o 'Contas a Pagar' referente a Nota de Entrada.

### 1.2º - Realização de Vendas Balcão para Cliente cadastrado

* Rotina 301: Emitir venda BALCÃO para o cliente cadastrado. Um dos produtos inseridos para venda, deverá ser o novo produto cadastrado.
* Rotina 307: Conferir se gerou comissão. No caso verificar qual comissão o vendedor trabalha: CPA ou CPP.
* Rotina 303: Conferir o Pedido inserido pelo relatório: LASER – ANALÍTICO. (Verificar se LOGO da empresa aparece no relatório)
* Rotina 305: Transmitir NF-e gerada para o pedido balcão para conferir geração/autorização de XML junto á SEFAZ.
* Rotina 802: Conferir atualização do estoque para os produtos da venda.
* Rotina 611: Conferir 'Limite de Crédito' do cliente.
* Rotina 608: Conferir a gravação do título gerado para o cliente no CONTASARECEBER.
* Rotina 608: Realizar o desdobramento do título gerado pela venda.
* Rotina 608: Efetuar a baixa do título desdobrado.
* Rotina 608: Efetuar o estorno da baixa realizada anteriormente.
* OBS: Como houve desdobramento do título para o cliente, o sistema não aceitará o cancelamento da NF-e. Neste caso, implantador deverá realizar uma devolução da NFSAIDA com formulário próprio (rotinas 201, 202). (Deverá verificar a transmissão e autorizada a NFENTRADA em Ambiente de Homologação)
* Rotina 802: Conferir a volta do produto para o estoque (rotina 802) após a devolução da NFSAIDA. Utilizar 'Extrato de Movimentação' e aba 'Posição do Estoque'.
* Rotina 307: Conferir se gerou comissão negativa.
* Rotina 305: Implantador deverá gerar outra Nota, para testar o Cancelamento/Inutilização da mesma. Assim verificando também: comissão, estoque, limite de crédito e títulos.
