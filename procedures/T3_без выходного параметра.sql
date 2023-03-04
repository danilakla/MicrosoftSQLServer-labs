-- изм-ть так, чтобы у процедуры не было выходного параметра
USE UNIVER;
go
CREATE TABLE #SUBJECT
(
	SUBJECT char(10) primary key,
	SUBJECT_NAME varchar(100),
	PULPIT char(20)
)
--------------------------------------------------------
go
--@p - код кафедры, @c - кол-во строк
ALTER PROCEDURE [dbo].[PSUBJECT] @p varchar(20) = null
as
begin
	declare @k int = (select count (*) from SUBJECT);
	select SUBJECT.SUBJECT [код], SUBJECT.SUBJECT_NAME [дисциплина], SUBJECT.PULPIT [кафедра] from SUBJECT
																				where SUBJECT.PULPIT = @p;
end;
go
-------------------------------------------------------
INSERT #SUBJECT exec PSUBJECT @p = '»—и“'	-- по идее, добавл€ем рез-ие строки из запросов процедуры в таблицу subject

SELECT * FROM #SUBJECT
DROP TABLE #SUBJECT
