-- перечисляем все предметы на какой-то кафедре или выводим сообщение об ошибке
-- почему-то не работает, хотя код просматривал несколько раз и все корректно работает
USE UNIVER
DROP PROCEDURE SUBJECT_REPORT

go
CREATE PROCEDURE SUBJECT_REPORT @p char(10)
as declare @rc int = 0
begin try
	declare @subjectName nvarchar(15), @subjectline nvarchar(150) = ''
	
	declare Subj CURSOR for
	select SUBJECT.SUBJECT from SUBJECT
									where SUBJECT.PULPIT = @p;
	
	if not exists(select SUBJECT.SUBJECT from SUBJECT
												where SUBJECT.PULPIT = @p)
		begin
			raiserror('Ошибка в параметрах', 11, 1)
			return 0
		end
	else
		open Subj;
		fetch Subj into @subjectName;
		print 'Дисциплины с конкретной кафедры';
		while @@FETCH_STATUS = 0
			begin
				set @subjectline = rtrim(@subjectName) + ', ' + @subjectline;
				set @rc = @rc + 1;
				fetch Subj into @subjectName;
			end;
			print @subjectline;
			close Subj;
			return @rc;
end try
begin catch
	print 'Ошибка в параметрах'
	if ERROR_PROCEDURE() is not null
		print 'имя процедуры: ' + cast (error_procedure() as varchar(20)); 
		return @rc;
end catch;
go
------------------------------------------------------------------------------

declare @rc int;
exec @rc = SUBJECT_REPORT @p = 'ИСиТ';
print 'количество дисциплин = ' + cast(@rc as varchar(3));