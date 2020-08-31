/*
	SQL QUE INSERE O USUÁRIO 20000 (MASTER) NO SISTEMA;	
	AUTHOR: RUAN ALVES	
*/

SET IDENTITY_INSERT [dbo].[PESSOA] ON 

INSERT [dbo].[PESSOA] ([CODIGO], [BAIRRO], [BAIRROCOBRANCA], [BAIRROENTREGA], [BLOQATRASO], [BLOQCHD1], [BLOQCHD3], 
[BLOQCHDV], [BLOQUEADO], [CATEGORIA], [CELULAR], [CELCOBRANCA], [CELENTREGA], [CEP], [CEPCOBRANCA], [CEPENTREGA], 
[CNPJ], [COMENTARIO], [COMISSAO], [COMPLEMENTO], [COMPCOBRANCA], [COMPENTREGA], [DADOSBANCARIO], [DTADMISSAO], 
[DTBLOQUEIO], [DTCADASTRO], [DTULTALTERACAO], [DTULTCOMPRA], [DTVENCIMENTO], [EMAIL], [EMAILBOLETO], [EMAILCOBRANCA], 
[EMAILENTREGA], [ENDERECO], [ENDCOBRANCA], [ENDENTREGA], [FANTASIA], [IDESTRANGEIRO], [IE], [ISCLIENTE], [ISCOLABORADOR], 
[ISFORNECEDOR], [ISMOTORISTA], [ISTRANSPORTADORA], [JUROS], [MOTIVOBLOQUEIO], [NOME], [NUMAPOLICE], [NUMAVERBACAO], 
[NUMCNH], [NUMREGISTRO], [NUMERO], [NUMCOBRANCA], [NUMENTREGA], [PRAZOENTREGA], [RNTRC], [SENHA], [STATUSALTERACAO], 
[STATUSFV], [TELEFONE], [TELCOBRANCA], [TELENTREGA], [TIPOMOTORISTA], [TIPOPESSOA], [USUARIO], [VLCREDDISPONIVEL], 
[VLCREDUTILIZADO], [VLLIMITECRED], [CODCIDADE], [CODCIDADECOBRANCA], [CODCIDADEENTREGA], [CODCOBRANCA], [CODEMPRESA], 
[CODNIVELACESSO], [CODPLANOPGTO], [CODREGIAO], [CODSEGNIVELACESSO], [CODSETOR], [CODTABELA], [TIPOCALCULO], [CODVENDEDOR], [CRC]) 
VALUES (20000, N'SETOR MASTER', N'SETOR MASTER', N'SETOR MASTER', 0, 0, 0, 0, 0, N' AD', N'          ', N'', 
N'', N'75000000', N'', N'', N'41347435751', N' ', CAST(0.000000 AS Numeric(20, 6)), N'SETOR MASTER', N'SETOR MASTER',
 N'SETOR MASTER', N' ', CAST(N'2015-05-05' AS Date), NULL, CAST(N'2015-05-05 17:09:23.0000000' AS DateTime2), 
 CAST(N'2016-01-06 12:28:15.3370000' AS DateTime2), NULL, CAST(N'2017-01-06' AS Date), N'adm@snsolucoes.com', N' ', N'adm@snsolucoes.com', 
 N'adm@snsolucoes.com', N'SETOR MASTER', N'SETOR MASTER', N'SETOR MASTER', N'MASTER', NULL, N'ISENTO', 1, 1, 1, 1, 1, 
 CAST(0.000000 AS Numeric(20, 6)), N' ', N'MASTER PLUS', N' ', N' ', N' 21212', N' 1212', N'0', N'0', N'0', 0, N'9999999', N'NA57KUW2zcTrIe8mDGHczQ==', 1, 0,
  N'6233333333', N'', N'', N'P', N'F', N'MASTER', CAST(10000.000000 AS Numeric(20, 6)), CAST(0.000000 AS Numeric(20, 6)), 
  CAST(10000.000000 AS Numeric(20, 6)), 1501402, 1501402, 1501402, N'D', 1, NULL, NULL, NULL, NULL, 1, NULL, N'2', NULL, NULL)

SET IDENTITY_INSERT [dbo].[PESSOA] OFF

/*
	FIM DA SQL DE INSERÇÃO DO USUÁRIO MASTER
	AUTHOR: RUAN ALVES	
*/

-- APOS INSERÇÃO DO USUÁRIO, FAVOR RODAR O SCRIPT --
-- APOS RODAR O SCRIPT A BAIXO, FAVOR CADASTRAR UM USUÁRIO, E VEJA SE A SEQUENCIA NÃO ESTÁ ACIMA DE 10000 OU 20000
-- SELECT MAX(CODIGO) FROM PESSOA WHERE CODIGO NOT IN (10000,20000)
DBCC CHECKIDENT(PESSOA, RESEED, /*COLOQUE AQUI O VALOR DA SQL: BuscarUltCodigoPessoa*/)
GO