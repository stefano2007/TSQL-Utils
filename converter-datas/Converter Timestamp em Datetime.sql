/*
  Autor: Stefano S Ferreira da Silva
  Data: 05/09/2023
  Assunto: Converter Timestamp em Datetime
*/

/*
  Nesse exemplo, vamos converter Timestamp em Datetime, usaremos a funções de manipulação de data com DATEADD.
  Por limitação do segundo parametro de entrada da função(DATEADD) receber um inteiro (limite máximo é 2147483647), 
  precisaremos converter um valor em millisegundos em segundos usaremos 
  a variavél @DATA_TIMESTAMP_MILLISECOND dividindo por 1000 para isso.
*/

/*
  Usaremos para receber as variaveis um BIGINT e depois converteremos para INT e usarmos na função DATEADD
*/
DECLARE @DATA_TIMESTAMP_MILLISECOND BIGINT = 1693914096000
DECLARE @DATA_TIMESTAMP_SECOND      INT    = @DATA_TIMESTAMP_MILLISECOND / 1000 

/*
  @DATA_TIMESTAMP_BASE armazenará a data inicial do timestamp
  @HORA_UTC guarda a quantidade de hora no nosso horario (Brasil) com horario UTC
*/
DECLARE @DATA_TIMESTAMP_BASE        DATETIME = '1970-01-01'
DECLARE @HORA_UTC                   INT = -3

--Essa é a data global armazenada
SELECT DATEADD(
              SECOND, 
              @DATA_TIMESTAMP_SECOND, 
              @DATA_TIMESTAMP_BASE
           ) as DataUTC

--Aqui convertemos a o horario local subtraindo -3 horas
SELECT DATEADD(
           HOUR, 
           @HORA_UTC,
           DATEADD(
              SECOND, 
              @DATA_TIMESTAMP_SECOND, 
              @DATA_TIMESTAMP_BASE
           )
	   ) as DataLocal

/*
  Resumo: Oque é Timestamp, e um valor geralmente em segundo ou millesegundos que tem como data incio dia 01/01/1970 às 00:00:00.
  Referência Timestamp: https://hkotsubo.github.io/blog/2019-05-02/o-que-e-timestamp
*/
/*
  Referência DATEADD: https://learn.microsoft.com/pt-br/sql/t-sql/functions/dateadd-transact-sql?view=sql-server-ver16
*/