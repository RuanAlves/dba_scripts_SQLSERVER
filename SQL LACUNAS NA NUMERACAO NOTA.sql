/**
* #Author: Douglas Valadares
* # SQL que demonstra se houve algum salto no campo numnota, exibindo o primeiro e o ultimo numero do salto
*/

WITH C AS (
SELECT (Convert(Numeric(10), NUMNOTA)) AS CUR, LEAD(Convert(Numeric(10), NUMNOTA))
OVER(ORDER BY (Convert(Numeric(10), NUMNOTA))) AS NXT,
MODELO AS MODELO ,SERIE AS SERIE, CODEMPRESA, NUMNOTA
  FROM NFSAIDA
  WHERE MODELO = 'D1'
  AND CODEMPRESA = 1
  AND SERIE = '001'

) SELECT CUR + 1 AS INICIO_PRIMEIRA_NOTA, NXT - 1 AS FIM_ULTIMA_NOTA, MODELO, SERIE, CODEMPRESA
  FROM C
  WHERE nxt - cur > 1
  ORDER BY (Convert(Numeric(10), NUMNOTA))
