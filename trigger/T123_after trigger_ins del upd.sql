-- ������ �������� �� ������� �������, �������� � ����������
USE UNIVER
go

create table TR_AUDIT
(
	ID int identity,											--�����
	STMT varchar(20) check (STMT in('INS', 'DEL', 'UPD')),		--DML-�������� (������� �� ������� ������� �����������)
	TRNAME varchar(50),											--��� ��������
	CC varchar(300)												--�����������
)
--------------------------------------------------------------------------------------INSERT
go
create trigger TR_TEACHER_INS
on TEACHER after INSERT	-- �������� ��� ����� ������� ����� ����������� ����� ��������� insert � TEACHER
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @ins varchar(100);
print '�������� �������'
set @Id = (select TEACHER from INSERTED)	-- ���������� � ���������� �� �������� ������� �� �������� (� ��� ���-�� � ���������� INSERTED)
set @Name = (select TEACHER_NAME from INSERTED)
set @Gender = (select GENDER from INSERTED)
set @Pulpit = (select PULPIT from INSERTED)

if (@Gender not in ('�', '�'))
begin
	raiserror('������� ������ ���', 10, 1)
	rollback
end

set @ins = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit
insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TR_TEACHER_INS', @ins);	-- CC (@ins) - �������� �������� �������� ������
return;
go
----------------------------------------------------------------------------------------INSERT test
insert into TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT)
	values('���', '���������� ��������� ���������', '�', '����');

select * from TR_AUDIT

----------------------------------------------------------------------------------------2. UPDATE
go
create trigger TR_TEACHER_UPD
on TEACHER after UPDATE
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @upd varchar(150);
print '�������� ���������'
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
update TEACHER set PULPIT = '����' where TEACHER in('���');

select * from TR_AUDIT

----------------------------------------------------------------------------------------3. DELETE
go
create trigger TR_TEACHER_DEL
on TEACHER after DELETE
as 
declare @Id varchar(20), @Name varchar(50), @Gender varchar(1), @Pulpit varchar(15), @del varchar(100);
print '�������� ��������'
set @Id = (select TEACHER from DELETED)		-- ��� ����� � ���� �������� �������� ������ ������� �� ������� ����� ������
set @Name = (select TEACHER_NAME from DELETED)
set @Gender = (select GENDER from DELETED)
set @Pulpit = (select PULPIT from DELETED)
set @del = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL', @del);
return;
go
----------------------------------------------------------------------------------------DELETE test
delete TEACHER where TEACHER in('���');

select * from TR_AUDIT



----------------------------------------------------------------------------------------

drop trigger TR_TEACHER_INS
drop trigger TR_TEACHER_DEL
drop trigger TR_TEACHER_UPD
drop table TR_AUDIT