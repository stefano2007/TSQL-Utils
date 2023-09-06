USE dbTestes
GO
ALTER FUNCTION dbo.fn_Cast_Datetime_Timestamp
(
   @data Datetime, 
   @tipo_retorno varchar(11), 
   @isDateUTC bit
)
RETURNS BIGINT
AS
BEGIN
  /*
    Autor: Stefano S Ferreira da Silva
    Data: 05/09/2023
    Assunto: Receber Datetime e retornar correspondente em Timestamp(return BIGINT) parametros(data datetime, tipo_retorno varchar(11)"SECOND OU MILLISECOND", isDateUTC bit "Informa se a data de entrada já esta no formato UTC")
  */
  DECLARE @DtAux datetime = @data
  /*
    @DATA_TIMESTAMP_BASE armazenará a data inicial do timestamp
    @HORA_UTC guarda a quantidade de hora no nosso horario (Brasil) com horario UTC
  */
  DECLARE @DATA_TIMESTAMP_BASE        DATETIME = '1970-01-01'
  DECLARE @HORA_UTC                   INT = DATEDIFF(HOUR, GETUTCDATE(), GETDATE())--CALCULAR DIFERENÇA ENTRE HORARIO LOCAL E HORARIO UTC
  
  IF(@tipo_retorno NOT IN('SECOND', 'MILLISECOND'))
  BEGIN
	RETURN 0;
  END
  
  --Atualizar o horario local para UTC
  IF(@isDateUTC = 0)
  BEGIN
      SET @DtAux = DATEADD(HOUR, (@HORA_UTC) *-1, @DtAux)
  END 

  DECLARE @TIMESTAMP_SECOND      INT

  --Obtem quantidade de segundos apartir da data base do Timestamp
  SET @TIMESTAMP_SECOND = DATEDIFF(
                SECOND, 
                @DATA_TIMESTAMP_BASE, 
                @DtAux
             ) 

  --Multiplica por 1000 caso parametro em MILLISECOND
  RETURN CASE 
         WHEN @tipo_retorno = 'MILLISECOND' 
           THEN @TIMESTAMP_SECOND * CAST(1000 AS bigint) 
         ELSE @TIMESTAMP_SECOND 
         END
END
GO

--Exemplo de uso
DECLARE @data Datetime = GETDATE(), 
        @tipo_retorno varchar(11) = 'MILLISECOND', 
        @isDateUTC bit = 0

select dbo.fn_Cast_Datetime_Timestamp(@data, @tipo_retorno, @isDateUTC)

SET @data = GETUTCDATE() 
SET @tipo_retorno = 'SECOND'
SET @isDateUTC = 1

select dbo.fn_Cast_Datetime_Timestamp(@data, @tipo_retorno, @isDateUTC)


1694001591000
1694001591

--Testa o resultado
select dbo.fn_Cast_Timestamp_Datetime(1694001591000, 'MILLISECOND', 1)

select dbo.fn_Cast_Timestamp_Datetime(1694001591, 'SECOND', 1)