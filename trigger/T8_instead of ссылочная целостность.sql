-- ����������� instead of ������� ������� �������� �������� � AUDITORIUM_TYPE �� ����-� �������� ������ ���������!
USE UNIVER;
go
create trigger TR_UNIVER_DELETE
on AUDITORIUM_TYPE instead of DELETE
as
	raiserror (N'�������� ������ ���������!', 10, 1);
	return;
go

-------------------------------------
select * from AUDITORIUM_TYPE
delete from AUDITORIUM_TYPE where AUDITORIUM_TYPE = '��';
select * from AUDITORIUM_TYPE

--------------------------------------
drop trigger TR_UNIVER_DELETE
