# Check List Técnico Implantação

### Em ambiente de Homologação (Arquivo config.xml com a tag tpAmb = 2):

* Rotina 101: Cadastrar um novo Cliente (Utilize para gerar CPF: https://www.4devs.com.br/gerador_de_cpf).
* Rotina 611: Cadastrar Limite de Crédito para o Cliente novo (Pode ser de R$ 5.000,00)
* Rotina 113: Cadastrar um novo Produto (pode ser duplicado um produto que já seja utilizado na base do cliente).
* Rotina 113: Definir os Grupos de Tributação para o produto novo.
* Rotina 119: Precificar Produto novo.
* Rotina 801: Lançar a Entrada manual na 801 para o produto cadastrado
* Rotina 201: Lançar uma NFENTRADA na rotina 201 para o produto cadastrado (Inserir Desconto e outros atributos)
* Rotina 802: Conferir estoque do produto novo pelo 'Extrato de Movimentação'
* Rotina 802: Conferir e custo da última entrada lançada, e verificar o abatimento do desconto.
* Rotina 602: Conferir se foi gerada o 'Contas a Pagar' referente a Nota de Entrada.
