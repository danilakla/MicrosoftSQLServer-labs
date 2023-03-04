-------------------------------------------------------------------------
USE PP_MyBase;
go
create function COUNT_Sdelki(@firm nvarchar(20)) returns int
as 
begin
	declare @rc int = 0;
	set @rc = (select count(Сделки.Номер_сделки) 
				from Сделки
				Join Поклажедатели ON Поклажедатели.Наименование_фирмы = Сделки.Покупатель
					where Наименование_фирмы = @firm);
return @rc;
end
go
						------------------------------
declare @f1 int = dbo.COUNT_Sdelki('Фирма1')
declare @f2 int = dbo.COUNT_Sdelki('Фирма2')
declare @f3 int = dbo.COUNT_Sdelki('Фирма3')

print 'Количество заказов = ' + cast(@f1 as varchar(4));
print 'Количество заказов = ' + cast(@f2 as varchar(4));
print 'Количество заказов = ' + cast(@f3 as varchar(4));

-----------------------------------------------------------------------------

go
create function FSdelki(@firm char(20)) returns char(300)
as
begin
declare @f char(20);
declare @line varchar(300) = 'Заказанные товары: ';
declare FSdelki CURSOR LOCAL
				for select Сделки.Наименование_товара from Сделки where Сделки.Покупатель = @firm;
open FSdelki;
fetch FSdelki into @f;
while @@FETCH_STATUS = 0
begin
	set @line = @line + ', ' + rtrim(@f);
	FETCH FSdelki into @f;
end;
return @line;
end;
go

select Наименование_фирмы, dbo.FSdelki(Наименование_фирмы) from Поклажедатели


drop function COUNT_Sdelki
drop function FSdelki