-- ����������� ������ ������� ���������� ����� ������� ������� ��� �������
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
if @ins > 0 and @del = 0	-- �.�. ������� INSERTED ����� ���������, � DELETED �����
begin
	print '�������: INSERT'
	set @Id = (select TEACHER from INSERTED)
	set @Name = (select TEACHER_NAME from INSERTED)
	set @Gender = (select GENDER from INSERTED)
	set @Pulpit = (select PULPIT from INSERTED)
	set @in = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TR_TEACHER', @in);
end;

else
if @ins = 0 and @del > 0	-- �����. ��������
begin
	print '�������: DELETE'
	set @Id = (select TEACHER from DELETED)
	set @Name = (select TEACHER_NAME from DELETED)
	set @Gender = (select GENDER from DELETED)
	set @Pulpit = (select PULPIT from DELETED)
	set @in = @Id + ' ' + @Name + ' ' + @Gender + ' ' + @Pulpit;
	insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER', @in);
end;
if @ins > 0 and @del > 0	-- ����� ��� ���������
begin
	print '�������: UPDATE'
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
-- ��������� � ������� ���������
insert into TEACHER(TEACHER, TEACHER_NAME, GENDER, PULPIT)
	values('���', '���������� ��������� ������������', '�', '����');
update TEACHER set PULPIT = '����' where TEACHER in('���');
delete from TEACHER where TEACHER in('���');

select * from TR_AUDIT

----------------------------------------------------------------------------------
drop table TR_AUDIT
drop trigger TR_TEACHER