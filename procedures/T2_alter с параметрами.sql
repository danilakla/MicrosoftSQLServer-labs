USE [UNIVER]
GO

/****** Object:  StoredProcedure [dbo].[PSUBJECT]    Script Date: 19.05.2022 11:07:12 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
GO
-- изм-ть процедуру таким образом чтобы она содержала входной и выходной параметр
--@p - код кафедры, @c - кол-во строк
ALTER PROCEDURE [dbo].[PSUBJECT] @p varchar(20) = null, @c int output -- принимает два входных параметра: p принимает знач по ум varchar, с - выходной параметр
as
begin
	declare @k int = (select count (*) from SUBJECT);
	set @c = (select count(*) from SUBJECT where SUBJECT.PULPIT = @p)
	select SUBJECT.SUBJECT [код], SUBJECT.SUBJECT_NAME [дисциплина], SUBJECT.PULPIT [кафедра] from SUBJECT
																				where SUBJECT.PULPIT = @p;
	return @k;		--возвращает значение к точке вызова, равное общему количеству дисциплин 
end;
GO

declare @k int, @rez int = 0
exec @k = PSUBJECT @p = '»—и“', @c = @rez output
print @k
print @rez