USE dbTestes
GO
CREATE FUNCTION dbo.fn_Cast_Timestamp_Datetime
(
   @timestamp BIGINT, 
   @tipo_entrada varchar(11),
   @convertDataLocal bit
)
RETURNS Datetime
AS
BEGIN
  /*
    Autor: Stefano S Ferreira da Silva
    Data: 05/09/2023
    Assunto: Receber Timestamp e converter em Datetime, parametros(timestamp BIGINT, tipo_entrada varchar(11)"SECOND OU MILLISECOND", convertDataLocal bit "converte em Datetime Local")
  */
  DECLARE @DtOutput datetime
  /*
    @DATA_TIMESTAMP_BASE armazenar� a data inicial do timestamp
    @HORA_UTC guarda a quantidade de hora no nosso horario (Brasil) com horario UTC
  */
  DECLARE @DATA_TIMESTAMP_BASE        DATETIME = '1970-01-01'
  DECLARE @HORA_UTC                   INT = DATEDIFF(HOUR, GETUTCDATE(), GETDATE())--CALCULAR DIFEREN�A ENTRE HORARIO LOCAL E HORARIO UTC
  
  IF(@tipo_entrada NOT IN('SECOND', 'MILLISECOND'))
  BEGIN
	RETURN @DATA_TIMESTAMP_BASE
  END
   
  --Multiplica por 1000 caso parametro � SECOND
  DECLARE @DATA_TIMESTAMP_MILLISECOND BIGINT = CASE WHEN @tipo_entrada = 'SECOND' THEN @timestamp * 1000 ELSE @timestamp END
  DECLARE @DATA_TIMESTAMP_SECOND      INT    = @DATA_TIMESTAMP_MILLISECOND / 1000 
  
  --Converter segundos e datetime apartir de 1970-01-01
  SET @DtOutput = DATEADD(
                     SECOND, 
                     @DATA_TIMESTAMP_SECOND, 
                     @DATA_TIMESTAMP_BASE
                   )

  --Se quiser o retorno em horario local
  IF(@convertDataLocal = 1)
  BEGIN
      SET @DtOutput = DATEADD(HOUR, @HORA_UTC, @DtOutput)
  END     
  RETURN @DtOutput
END
GO

--Exemplo de uso
DECLARE @timestamp BIGINT = 1693914096000, 
        @tipo_entrada varchar(11)= 'MILLISECOND', 
		@convertDataLocal bit = 1

select dbo.fn_Cast_Timestamp_Datetime(@timestamp, @tipo_entrada, @convertDataLocal)

SET @timestamp = 1693914096 
SET @tipo_entrada = 'SECOND'
SET @convertDataLocal = 1

select dbo.fn_Cast_Timestamp_Datetime(@timestamp, @tipo_entrada, @convertDataLocal)