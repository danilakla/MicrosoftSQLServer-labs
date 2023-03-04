-- ���-�� ���, ����� � ��������� �� ���� ��������� ���������
USE UNIVER;
go
CREATE TABLE #SUBJECT
(
	SUBJECT char(10) primary key,
	SUBJECT_NAME varchar(100),
	PULPIT char(20)
)
--------------------------------------------------------
go
--@p - ��� �������, @c - ���-�� �����
ALTER PROCEDURE [dbo].[PSUBJECT] @p varchar(20) = null
as
begin
	declare @k int = (select count (*) from SUBJECT);
	select SUBJECT.SUBJECT [���], SUBJECT.SUBJECT_NAME [����������], SUBJECT.PULPIT [�������] from SUBJECT
																				where SUBJECT.PULPIT = @p;
end;
go
-------------------------------------------------------
INSERT #SUBJECT exec PSUBJECT @p = '����'	-- �� ����, ��������� ���-�� ������ �� �������� ��������� � ������� subject

SELECT * FROM #SUBJECT
DROP TABLE #SUBJECT
