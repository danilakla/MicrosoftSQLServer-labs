-- разработать скал€рную ф-ю вывода дисциплин дл€ кафедр
USE UNIVER;
go
CREATE FUNCTION FSUBJECTS(@pulpit varchar(20)) returns varchar(300)
as
begin 
	declare @disc char(20);
	declare @line varchar(300) = 'ƒисциплины: ';
	declare Subj CURSOR LOCAL
	for	select SUBJECT.SUBJECT from SUBJECT
									where SUBJECT.PULPIT = @pulpit;
	open Subj;
	fetch Subj into @disc;
	while @@FETCH_STATUS = 0
	begin
		set @line = @line + ', ' + rtrim(@disc);
		FETCH Subj into @disc;
	end;
	return @line;
	end;
go
------------------------------
select PULPIT, dbo.FSUBJECTS(PULPIT) [ƒисциплины] from PULPIT

DROP FUNCTION FSUBJECTS;