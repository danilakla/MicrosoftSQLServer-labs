-- разработать скалярную ф-ю (возвращающее единственное число (значение))
USE UNIVER;
go
CREATE FUNCTION COUNT_STUDENTS(@faculty varchar(20)) returns int
as
begin 
	declare @rc int = 0;
	set @rc = (select count(*) 
				from STUDENT
				Join GROUPS ON STUDENT.IDGROUP = GROUPS.IDGROUP
				Join FACULTY ON GROUPS.FACULTY = FACULTY.FACULTY
								where FACULTY.FACULTY = @faculty);
	return @rc;
end;
go
--------------------------------------------
declare @f int = [dbo].[COUNT_STUDENTS]('ИТ');
print 'Количество студентов на ФИТ: ' + cast(@f as varchar(4));
--------------------------------------------

go
ALTER FUNCTION [dbo].[COUNT_STUDENTS](@faculty varchar(20) = null, @prof varchar(20) = null) returns int
as
begin 
	declare @rc int = 0;
	set @rc = (select count(*) 
				from STUDENT
				Join GROUPS ON STUDENT.IDGROUP = GROUPS.IDGROUP
				Join FACULTY ON GROUPS.FACULTY = FACULTY.FACULTY
								where FACULTY.FACULTY = @faculty and GROUPS.PROFESSION = @prof);
	return @rc;
end;
go

declare @ress int = [dbo].[COUNT_STUDENTS]('ХТИТ', '1-36 07 01')
print 'Кол-во студентов на ХТИТе: ' + cast(@ress as varchar(2));

drop function COUNT_STUDENTS