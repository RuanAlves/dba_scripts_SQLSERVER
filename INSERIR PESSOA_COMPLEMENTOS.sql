/** VERIFICA AS PESSOAS QUE N�O POSSUI 'PESSOA_COMPLEMENTOS' */
SELECT P.CODIGO FROM  PESSOA P LEFT JOIN PESSOA_COMPLEMENTOS PC ON (P.CODIGO = PC.CODPESSOA) GROUP BY P.CODIGO HAVING COUNT(PC.CODPESSOA) = 0

/** FAZ O INSERT PESSOA_COMPLEMENTO **/
INSERT INTO PESSOA_COMPLEMENTOS (ISADMCARTAOPDV, ISCONTRIBUINTE, CODPESSOA)
(SELECT 0,0,CODIGO FROM PESSOA WHERE  CODIGO NOT IN (SELECT CODPESSOA FROM PESSOA_COMPLEMENTOS))
