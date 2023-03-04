-- создаем три триггера для таблицы реаг-ие на удаление
-- прописываем для них порядок действия
-- из результата видно, что для отдельных строк (СПИ или ААА) вып-ся сначала 3-й триггер, потом 1-й и только потом 2-й
USE UNIVER;
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
create trigger TR_TEACHER_DEL1 
on TEACHER  after DELETE   
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @ins varchar(100);
print 'TR_TEACHER_DEL1'
	set @Id = (select TEACHER from DELETED)
	set @Name = (select TEACHER_NAME from DELETED)
	set @Gender = (select GENDER from DELETED)
	set @Pulpit = (select PULPIT from DELETED)
	set @ins = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL1', @ins);
go 
create trigger TR_TEACHER_DEL2 
on TEACHER  after DELETE   
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @ins varchar(100);
print 'TR_TEACHER_DEL2'
	set @Id = (select TEACHER from DELETED)
	set @Name = (select TEACHER_NAME from DELETED)
	set @Gender = (select GENDER from DELETED)
	set @Pulpit = (select PULPIT from DELETED)
	set @ins = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL2', @ins);
go 
create trigger TR_TEACHER_DEL3
on TEACHER  after DELETE   
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @ins varchar(100);
print 'TR_TEACHER_DEL3'
	set @Id = (select TEACHER from DELETED)
	set @Name = (select TEACHER_NAME from DELETED)
	set @Gender = (select GENDER from DELETED)
	set @Pulpit = (select PULPIT from DELETED)
	set @ins = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL3', @ins);
go 

-- блок показа всех триггеров табоицы
select t.name, e.type_desc 
         from sys.triggers  t 
		 join  sys.trigger_events e  on t.object_id = e.object_id  
								where OBJECT_NAME(t.parent_id) = 'TEACHER' and e.type_desc = 'DELETE';  

-- Изменение порядка выполнения триггеров выполняется с помощью си-стемных процедур
exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL3', 
	                        @order = 'First', @stmttype = 'DELETE';

exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL2', 
	                        @order = 'Last', @stmttype = 'DELETE';


insert into TEACHER values ('СПИ', 'Серджи Петя Иванович', 'м', 'ИСиТ')
insert into TEACHER values ('ААА', 'Антонио Антон Антонович', 'м', 'ИСиТ')
insert into TEACHER values ('ЕЖЖ', 'Евгеший Жека Женский', 'м', 'ИСиТ')

delete from TEACHER where TEACHER = 'СПИ'
delete from TEACHER where TEACHER = 'ААА'
delete from TEACHER where TEACHER = 'ЕЖЖ'

select * from TR_AUDIT

----------------------------------------------------------------------------------------------
drop table TR_AUDIT
drop trigger TR_TEACHER_DEL1
drop trigger TR_TEACHER_DEL2
drop trigger TR_TEACHER_DEL3