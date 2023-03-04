-------------------------------------------------------------------------
USE PP_MyBase;
go
create function COUNT_Sdelki(@firm nvarchar(20)) returns int
as 
begin
	declare @rc int = 0;
	set @rc = (select count(������.�����_������) 
				from ������
				Join ������������� ON �������������.������������_����� = ������.����������
					where ������������_����� = @firm);
return @rc;
end
go
						------------------------------
declare @f1 int = dbo.COUNT_Sdelki('�����1')
declare @f2 int = dbo.COUNT_Sdelki('�����2')
declare @f3 int = dbo.COUNT_Sdelki('�����3')

print '���������� ������� = ' + cast(@f1 as varchar(4));
print '���������� ������� = ' + cast(@f2 as varchar(4));
print '���������� ������� = ' + cast(@f3 as varchar(4));

-----------------------------------------------------------------------------

go
create function FSdelki(@firm char(20)) returns char(300)
as
begin
declare @f char(20);
declare @line varchar(300) = '���������� ������: ';
declare FSdelki CURSOR LOCAL
				for select ������.������������_������ from ������ where ������.���������� = @firm;
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

select ������������_�����, dbo.FSdelki(������������_�����) from �������������


drop function COUNT_Sdelki
drop function FSdelki