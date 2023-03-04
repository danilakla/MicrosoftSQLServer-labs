-- ���� �-� ������-� ��� ���-�: ��� ���-� � �������
-- ��� null null - ������� ��� ���-� � ���-�
-- ��� str null - ������� ��� ���-� �-�� str
-- ��� null str - ������� ���-� ���-� str
USE UNIVER;
go
CREATE FUNCTION FFACPUL(@facultyCode varchar(20), @pulpitCode varchar(20)) returns table
as return
	select FACULTY.FACULTY, PULPIT.PULPIT	-- isnull - ���� ������ ���-� ����� null, �� �������� ������
											FROM FACULTY
											Left Outer Join PULPIT ON FACULTY.FACULTY = PULPIT.FACULTY
											where FACULTY.FACULTY = isnull(@facultyCode, FACULTY.FACULTY) 
												  and 
												  PULPIT.PULPIT = isnull(@pulpitCode, PULPIT.PULPIT)

go
------------------------------------------------------------------------------
select * from [dbo].[FFACPUL](NULL, NULL);

select * from [dbo].[FFACPUL]('��', NULL);

select * from [dbo].[FFACPUL](NULL, '�����');

select * from [dbo].[FFACPUL]('����', '�����');


drop function FFACPUL