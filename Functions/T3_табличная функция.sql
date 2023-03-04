-- табл ф-€ приним-€ два пар-а: код фак-а и кафедры
-- при null null - выводим все фак-ы и каф-ы
-- при str null - выводим все каф-ы ф-та str
-- при null str - выводим фак-т каф-ы str
USE UNIVER;
go
CREATE FUNCTION FFACPUL(@facultyCode varchar(20), @pulpitCode varchar(20)) returns table
as return
	select FACULTY.FACULTY, PULPIT.PULPIT	-- isnull - если первый пар-р равен null, то выведтс€ второй
											FROM FACULTY
											Left Outer Join PULPIT ON FACULTY.FACULTY = PULPIT.FACULTY
											where FACULTY.FACULTY = isnull(@facultyCode, FACULTY.FACULTY) 
												  and 
												  PULPIT.PULPIT = isnull(@pulpitCode, PULPIT.PULPIT)

go
------------------------------------------------------------------------------
select * from [dbo].[FFACPUL](NULL, NULL);

select * from [dbo].[FFACPUL]('»“', NULL);

select * from [dbo].[FFACPUL](NULL, 'ЋћиЋ«');

select * from [dbo].[FFACPUL]('““Ћѕ', 'ЋћиЋ«');


drop function FFACPUL