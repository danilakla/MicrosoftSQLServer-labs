USE UNIVER
go
CREATE PROCEDURE PSUBJECT -- создание процедуры
as
begin
	declare @k int = (select count (*) from SUBJECT);
	select SUBJECT.SUBJECT [код], SUBJECT.SUBJECT_NAME [дисциплина], SUBJECT.PULPIT [кафедра] from SUBJECT;
	return @k;	--возвращает значение к точке вызова, равное общему количеству дисциплин 
end;
go

declare @k int = 0;
EXEC @k = PSUBJECT;
print 'кол-во дисциплин = ' + cast(@k as varchar(3));

--DROP PROCEDURE PSUBJECT