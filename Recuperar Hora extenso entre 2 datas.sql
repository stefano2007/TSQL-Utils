DECLARE @DATE1 DATETIME = '2021-06-16 19:00:00'
DECLARE @DATE2 DATETIME = '2021-06-16 23:59:59'

DECLARE @DATABASE DATETIME = '1900-01-01 00:00:00' --Data base apenas para adicionar os tempo em segundos e recuperar o tempo

SELECT CONVERT(
       VARCHAR(8)
       ,DATEADD(
          SECOND,
	      DATEDIFF(SECOND, @DATE1, @DATE2), -- Recuperar diferença entre segundos
          @DATABASE
	    )
       ,108) AS HoraExtenso-- RECUPERAR HORA HH:mm:ss

--output 04:59:59