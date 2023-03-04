-- делаем триггеры на события ВСТАВКИ, УДАЛЕНИЯ и ОБНОВЛЕНИЯ
USE UNIVER
go

create table TR_AUDIT
(
	ID int identity,											--номер
	STMT varchar(20) check (STMT in('INS', 'DEL', 'UPD')),		--DML-оператор (событие на которое триггер среагировал)
	TRNAME varchar(50),											--имя триггера
	CC varchar(300)												--комментарий
)
--------------------------------------------------------------------------------------INSERT
go
create trigger TR_TEACHER_INS
on TEACHER after INSERT	-- означает что такой триггер будет выполняться после оператора insert у TEACHER
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @ins varchar(100);
print 'Операция вставки'
set @Id = (select TEACHER from INSERTED)	-- записываем в переменные те значения которые мы вставили (и ктр нах-ся в псевдотабл INSERTED)
set @Name = (select TEACHER_NAME from INSERTED)
set @Gender = (select GENDER from INSERTED)
set @Pulpit = (select PULPIT from INSERTED)

if (@Gender not in ('м', 'ж'))
begin
	raiserror('Неверно указан пол', 10, 1)
	rollback
end

set @ins = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit
insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TR_TEACHER_INS', @ins);	-- CC (@ins) - значения столбцов вводимой строки
return;
go
----------------------------------------------------------------------------------------INSERT test
insert into TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT)
	values('ВВС', 'Вакуленчик Владислав Сергеевич', 'м', 'ИСиТ');

select * from TR_AUDIT

----------------------------------------------------------------------------------------2. UPDATE
go
create trigger TR_TEACHER_UPD
on TEACHER after UPDATE
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @upd varchar(150);
print 'Операция изменения'
set @Id = (select TEACHER from INSERTED)
set @Name = (select TEACHER_NAME from INSERTED)
set @Gender = (select GENDER from INSERTED)
set @Pulpit = (select PULPIT from INSERTED)

set @upd = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit

set @Id = (select TEACHER from DELETED)
set @Name = (select TEACHER_NAME from DELETED)
set @Gender = (select GENDER from DELETED)
set @Pulpit = (select PULPIT from DELETED)

set @upd = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit + ' / ' + @upd

insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TR_TEACHER_UPD', @upd);
return;
go
----------------------------------------------------------------------------------------UPDATE test
update TEACHER set PULPIT = 'ИСиТ' where TEACHER in('ВВС');

select * from TR_AUDIT

----------------------------------------------------------------------------------------3. DELETE
go
create trigger TR_TEACHER_DEL
on TEACHER after DELETE
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @del varchar(100);
print 'Операция удаления'
set @Id = (select TEACHER from DELETED)		-- как видим в этих запросах меняется только таблица из которой берем данные
set @Name = (select TEACHER_NAME from DELETED)
set @Gender = (select GENDER from DELETED)
set @Pulpit = (select PULPIT from DELETED)
set @del = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL', @del);
return;
go
----------------------------------------------------------------------------------------DELETE test
delete TEACHER where TEACHER in('ВВС');

select * from TR_AUDIT



----------------------------------------------------------------------------------------

drop trigger TR_TEACHER_INS
drop trigger TR_TEACHER_DEL
drop trigger TR_TEACHER_UPD
drop table TR_AUDIT