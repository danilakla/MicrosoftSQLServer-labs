-- ��������� �-� ������� ��������� ���-�� ��������. �� �������
USE UNIVER;
go
CREATE FUNCTION FCTEACHER(@pulpitCode nvarchar(10)) returns int
as
begin
	declare @rc int = (select count(*) from TEACHER	 -- isnull - ���� ������ ���-� ����� null, �� �������� ������
										where TEACHER.PULPIT = isnull(@pulpitCode, TEACHER.PULPIT));
	return @rc;
end;
go

select PULPIT, dbo.FCTEACHER(PULPIT) [���������� ��������������] from PULPIT

-- ��� null ��������� ����� ���-�� ���� ��������.
select top 1 dbo.FCTEACHER(NULL) [����� ��������������] from PULPIT

drop function FCTEACHER