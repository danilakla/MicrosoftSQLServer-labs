-- скалярная ф-я которая возвращет кол-во преподов. на кафедре
USE UNIVER;
go
CREATE FUNCTION FCTEACHER(@pulpitCode nvarchar(10)) returns int
as
begin
	declare @rc int = (select count(*) from TEACHER	 -- isnull - если первый пар-р равен null, то выведтся второй
										where TEACHER.PULPIT = isnull(@pulpitCode, TEACHER.PULPIT));
	return @rc;
end;
go

select PULPIT, dbo.FCTEACHER(PULPIT) [Количество преподавателей] from PULPIT

-- при null выводится общее кол-во всех преподов.
select top 1 dbo.FCTEACHER(NULL) [Всего преподавателей] from PULPIT

drop function FCTEACHER