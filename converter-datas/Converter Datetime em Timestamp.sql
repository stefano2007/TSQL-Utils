/*
  Autor: Stefano S Ferreira da Silva
  Data: 05/09/2023
  Assunto: Converter Datetime em Timestamp 
*/
/*
  Nesse exemplo, vamos converter Datetime em Timestamp, usaremos a função de manipulação de data com DATEDIFF
  O retorno do DATEDIFF retorna um valor int ou seja até 2147483647, por esse motivo iremos primeiro 
  obter valores em segundos depois converter em milissegundos multiplicando por 1000.
*/

/*
  @DATA_UTC guarda o horario UTC
  @DATA_TIMESTAMP_BASE armazenará a data inicial do timestamp
*/
DECLARE @DATA_UTC                   DATETIME = GETUTCDATE()
DECLARE @DATA_TIMESTAMP_BASE        DATETIME = '1970-01-01'

DECLARE @TIMESTAMP_SECOND      INT
DECLARE @TIMESTAMP_MILLISECOND BIGINT

--Obtem quantidade de segundos apartir da data base do Timestamp
SET @TIMESTAMP_SECOND = DATEDIFF(
              SECOND, 
              @DATA_TIMESTAMP_BASE, 
              @DATA_UTC
           ) 
--Converte o timestamp de segundos para millisegundos
SET @TIMESTAMP_MILLISECOND = @TIMESTAMP_SECOND * CAST(1000 AS BIGINT)

SELECT @TIMESTAMP_SECOND      as TimestampSegund,
       @TIMESTAMP_MILLISECOND as TimestampMilliSegund

/*
  Resumo: Oque é Timestamp, e um valor geralmente em segundo ou millesegundos que tem como data incio dia 01/01/1970 às 00:00:00.
  Referência Timestamp: https://hkotsubo.github.io/blog/2019-05-02/o-que-e-timestamp
*/
/*
  Referência DATEDIFF: https://learn.microsoft.com/pt-br/sql/t-sql/functions/datediff-transact-sql?view=sql-server-ver16
*/