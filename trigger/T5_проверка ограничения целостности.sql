-- показываем что after триггеры не нарушают ограничение целостности, так как при возникновении ошибки, триггер просто не выполнится
USE UNIVER
go

create table TR_AUDIT
(
	ID int identity,
	STMT varchar(20) check (STMT in('INS', 'DEL', 'UPD')),
	TRNAME varchar(50),
	CC varchar(300)
)
--------------------------------------------------------------------------------------INERT
go
create trigger TR_TEACHER_INS
on TEACHER after INSERT
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @ins varchar(100);
print 'Операция вставки'
set @Id = (select TEACHER from INSERTED)
set @Name = (select TEACHER_NAME from INSERTED)
set @Gender = (select GENDER from INSERTED)
set @Pulpit = (select PULPIT from INSERTED)

if (@Gender not in ('м', 'ж'))
begin
	raiserror('Неверно указан пол', 10, 1)
	rollback
end

set @ins = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit
insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TR_TEACHER_INS', @ins);
return;
go
----------------------------------------------------------------------------------------INSERT test
insert into TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT)
	values('ВВС', 'Вакуленчик Владислав Сергеевич', 'м', 'ИСиТ');					--если в бд уже есть, то выполнение оператора не допускается (как и выполнение триггера)
	--delete TEACHER where TEACHER in('ВВС');
select * from TR_AUDIT


----------------------------------------------------------------------------------------------------
drop table TR_AUDIT
drop trigger TR_TEACHER_INS