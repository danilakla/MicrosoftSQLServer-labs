-- ������� ��� �������� ��� ������� ����-�� �� ��������
-- ����������� ��� ��� ������� ��������
-- �� ���������� �����, ��� ��� ��������� ����� (��� ��� ���) ���-�� ������� 3-� �������, ����� 1-� � ������ ����� 2-�
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

-- ���� ������ ���� ��������� �������
select t.name, e.type_desc 
         from sys.triggers  t 
		 join  sys.trigger_events e  on t.object_id = e.object_id  
								where OBJECT_NAME(t.parent_id) = 'TEACHER' and e.type_desc = 'DELETE';  

-- ��������� ������� ���������� ��������� ����������� � ������� ��-������� ��������
exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL3', 
	                        @order = 'First', @stmttype = 'DELETE';

exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL2', 
	                        @order = 'Last', @stmttype = 'DELETE';


insert into TEACHER values ('���', '������ ���� ��������', '�', '����')
insert into TEACHER values ('���', '������� ����� ���������', '�', '����')
insert into TEACHER values ('���', '������� ���� �������', '�', '����')

delete from TEACHER where TEACHER = '���'
delete from TEACHER where TEACHER = '���'
delete from TEACHER where TEACHER = '���'

select * from TR_AUDIT

----------------------------------------------------------------------------------------------
drop table TR_AUDIT
drop trigger TR_TEACHER_DEL1
drop trigger TR_TEACHER_DEL2
drop trigger TR_TEACHER_DEL3