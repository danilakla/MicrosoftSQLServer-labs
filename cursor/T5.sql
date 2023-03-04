
set nocount on;

declare @Sub nvarchar(10), @Sub_Name nvarchar(30);
declare currentOf cursor global dynamic for select SUBJECT, SUBJECT_NAME from SUBJECT for update

open currentOf 
fetch currentOf into @Sub, @Sub_Name
while @@FETCH_STATUS = 0
  begin
    if @Sub like 'ВТЛ%' update SUBJECT set SUBJECT_NAME = 'влад' where current of currentOf -- если наш текущий курсор совпадает с currentOf, то тогда обновляем
    print '' + @Sub + ' ' + @Sub_Name
    fetch currentOf into @Sub, @Sub_Name
  end
close currentOf
deallocate currentOf

select SUBJECT[Предмет], SUBJECT_NAME[Предмет но полный] from SUBJECT
go

update SUBJECT set SUBJECT_NAME = 'Водный транспорт леса' where SUBJECT_NAME = 'влад'