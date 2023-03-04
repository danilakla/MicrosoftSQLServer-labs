-- разработать instead of триггер который заменяет удаление в AUDITORIUM_TYPE на сооб-е Удаление данных запрещено!
USE UNIVER;
go
create trigger TR_UNIVER_DELETE
on AUDITORIUM_TYPE instead of DELETE
as
	raiserror (N'Удаление данных запрещено!', 10, 1);
	return;
go

-------------------------------------
select * from AUDITORIUM_TYPE
delete from AUDITORIUM_TYPE where AUDITORIUM_TYPE = 'ЛК';
select * from AUDITORIUM_TYPE

--------------------------------------
drop trigger TR_UNIVER_DELETE
