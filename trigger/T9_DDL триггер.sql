-- ���������� ��� ������� DDL ������� ������� ��������� �������� � �������� ������
USE UNIVER;

go
create trigger DDL_UNIVER on database 
	for DDL_DATABASE_LEVEL_EVENTS  
as  
declare @t varchar(50)= EVENTDATA().value ('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
declare @t1 varchar(50)=EVENTDATA().value ('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
declare @t2 varchar(50)=EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 
if @t1 = 'AUDITORIUM' 
begin
	print '��� �������: '+@t;
	print '��� �������: '+@t1;
	print '��� �������: '+@t2;
	raiserror( N'�������� � ��������� ���������', 16, 1);  
	rollback;    
end;
--create table a(c int);
--alter table AUDITORIUM drop column AUDITORIUM;


DISABLE TRIGGER DDL_UNIVER ON DATABASE;
DROP TRIGGER DDL_UNIVER ON DATABASE;


