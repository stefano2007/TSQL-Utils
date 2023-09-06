USE dbTestes
go
CREATE FUNCTION dbo.fn_calcular_diferenca_datas
(
  @DataIncio Datetime,
  @DataFinal Datetime
)
Returns Varchar(8)
AS 
BEGIN
  DECLARE @DataBase Datetime = '1900-01-01'
  RETURN CONVERT(
           VARCHAR(8)
           ,DATEADD(
              SECOND,
              DATEDIFF(
                SECOND, 
                @DataIncio, 
                @DataFinal
              ),
              @DataBase
	        )
         ,108)
END