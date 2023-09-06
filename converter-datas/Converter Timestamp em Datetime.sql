/*
  Autor: Stefano S Ferreira da Silva
  Data: 05/09/2023
  Assunto: Converter Timestamp em Datetime
*/

/*
  Nesse exemplo, vamos converter Timestamp em Datetime, usaremos a fun��es de manipula��o de data com DATEADD.
  Por limita��o do segundo parametro de entrada da fun��o(DATEADD) receber um inteiro (limite m�ximo � 2147483647), 
  precisaremos converter um valor em millisegundos em segundos usaremos 
  a variav�l @DATA_TIMESTAMP_MILLISECOND dividindo por 1000 para isso.
*/

/*
  Usaremos para receber as variaveis um BIGINT e depois converteremos para INT e usarmos na fun��o DATEADD
*/
DECLARE @DATA_TIMESTAMP_MILLISECOND BIGINT = 1693914096000
DECLARE @DATA_TIMESTAMP_SECOND      INT    = @DATA_TIMESTAMP_MILLISECOND / 1000 

/*
  @DATA_TIMESTAMP_BASE armazenar� a data inicial do timestamp
  @HORA_UTC guarda a quantidade de hora no nosso horario (Brasil) com horario UTC
*/
DECLARE @DATA_TIMESTAMP_BASE        DATETIME = '1970-01-01'
DECLARE @HORA_UTC                   INT = -3

--Essa � a data global armazenada
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
  Resumo: Oque � Timestamp, e um valor geralmente em segundo ou millesegundos que tem como data incio dia 01/01/1970 �s 00:00:00.
  Refer�ncia Timestamp: https://hkotsubo.github.io/blog/2019-05-02/o-que-e-timestamp
*/
/*
  Refer�ncia DATEADD: https://learn.microsoft.com/pt-br/sql/t-sql/functions/dateadd-transact-sql?view=sql-server-ver16
*/