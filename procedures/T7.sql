USE PP_MyBase
go
create procedure OUTPUT_PROCEDURE as
begin
	declare @count int = (select count(*) from Сделки)
	select * from Сделки
	return @count
end
go

declare @count int
exec @count = OUTPUT_PROCEDURE
print @count

drop procedure OUTPUT_PROCEDURE


------------------------------------------------//---------------------------------------------

go
CREATE TABLE #SDELKI
(
	Номер_сделки int primary key,
	Покупатель nvarchar(20),
	Место_хранения nvarchar(10),
	Наименование_товара nvarchar(20),
	Количество int,
	Дата_сделки date,
	Цена real
)
--------------------------------------------------------
go

ALTER PROCEDURE [dbo].[OUTPUT_PROCEDURE] @p varchar(20) = null
as
begin
	declare @k int = (select count (*) from Сделки);
	select * from Сделки
					where Покупатель = @p;
end;
go
-------------------------------------------------------
INSERT #SDELKI exec OUTPUT_PROCEDURE @p = 'Фирма1'
INSERT #SDELKI exec OUTPUT_PROCEDURE @p = 'Фирма3'

SELECT * FROM #SDELKI
DROP TABLE #SDELKI
