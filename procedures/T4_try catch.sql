-- ������� ��������� � 4 �������� �����������, ������� ��������� ������ � ������� AUDITORIUM � try. ����� ��� �����-�� 1 ���� �������� 
-- ���-�, -1, ���� �� �������
USE UNIVER
DROP PROCEDURE PAUDITORIUM_INSERT

go
CREATE PROCEDURE PAUDITORIUM_INSERT @a char(20), @n varchar(50), @c int = 0, @t char(10)
as 
begin try
	insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
		values(@a, @n, @c, @t)
	return 1
end try
begin catch
	print '����� ������: ' + cast (error_number() as varchar(6));
	print '���������:    ' + error_message();
	print '�������:      ' + cast (error_severity() as varchar(6));
	print '�����:        ' + cast (error_state() as varchar(8));
	print '����� ������: ' + cast (error_line() as varchar(8));
	if ERROR_PROCEDURE() is not null
	print '��� ���������: ' + cast (error_procedure() as varchar(8)); 
		return -1
end catch
go


------------------------------------------------------------------------
declare @rez int;


begin tran

exec @rez = PAUDITORIUM_INSERT @a= '207-1', @n = '207-1', @c = 15, @t = '��-�'
print @rez
if @rez = 1	-- ���� �������� ����������
	select * from AUDITORIUM

rollback


-------------------------------------------------------------------------
--declare @rez int;


--begin tran

--exec @rez = PAUDITORIUM_INSERT @a= '206-1', @n = '207-1', @c = 15, @t = '��-�'
--print @rez
--if @rez = 1
--	select * from AUDITORIUM

--rollback