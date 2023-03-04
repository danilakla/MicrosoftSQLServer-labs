-- разработать запрос который определяет какое событие вызвало наш триггер
USE UNIVER;
go

create table TR_AUDIT
(
	ID int identity,
	STMT varchar(20) check (STMT in('INS', 'DEL', 'UPD')),
	TRNAME varchar(50),
	CC varchar(300)
)
-----------------------------------------------------------------------------------------
go
create trigger TR_TEACHER
on TEACHER after INSERT, DELETE, UPDATE
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @in varchar(300);
declare @ins int = (select count(*) from INSERTED),
	    @del int = (select count(*) from DELETED);
if @ins > 0 and @del = 0	-- т.е. таблица INSERTED будет заполнена, а DELETED пуста
begin
	print 'Событие: INSERT'
	set @Id = (select TEACHER from INSERTED)
	set @Name = (select TEACHER_NAME from INSERTED)
	set @Gender = (select GENDER from INSERTED)
	set @Pulpit = (select PULPIT from INSERTED)
	set @in = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TR_TEACHER', @in);
end;

else
if @ins = 0 and @del > 0	-- соотв. наоборот
begin
	print 'Событие: DELETE'
	set @Id = (select TEACHER from DELETED)
	set @Name = (select TEACHER_NAME from DELETED)
	set @Gender = (select GENDER from DELETED)
	set @Pulpit = (select PULPIT from DELETED)
	set @in = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER', @in);
end;
if @ins > 0 and @del > 0	-- будут обе заполнены
begin
	print 'Событие: UPDATE'
	set @Id = (select TEACHER from INSERTED)
	set @Name = (select TEACHER_NAME from INSERTED)
	set @Gender = (select GENDER from INSERTED)
	set @Pulpit = (select PULPIT from INSERTED)
	set @in = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit;
	set @Id = (select TEACHER from DELETED)
	set @Name = (select TEACHER_NAME from DELETED)
	set @Gender = (select GENDER from DELETED)
	set @Pulpit = (select PULPIT from DELETED)
	set @in = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit + ' / ' + @in;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TR_TEACHER', @in);
end;
return;
go

------------------------------------------------------------------------------- test
-- тестируем с разными событиями
insert into TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT)
	values('ХАВ', 'Харланович Анастасия Владимировна', 'ж', 'ИСиТ');
update TEACHER set PULPIT = 'ИСиТ' where TEACHER in('ХАВ');
delete from TEACHER where TEACHER in('ХАВ');

select * from TR_AUDIT

----------------------------------------------------------------------------------
drop table TR_AUDIT
drop trigger TR_TEACHER