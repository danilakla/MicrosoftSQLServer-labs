
-- ������ � if else
USE UNIVER;
DECLARE @capacity int = (select sum(AUDITORIUM.AUDITORIUM_CAPACITY) from AUDITORIUM)
IF (@capacity > 100)
begin 
PRINT '��������� ��������������� ��������� ������ 100';
PRINT '��������� ���������������: ' + cast(@capacity as varchar(10));
end;
ELSE
begin
PRINT '��������� ��������������� ��������� ������ ��� ����� 100';
PRINT '��������� ���������������: ' + cast(@capacity as varchar(10));
end;