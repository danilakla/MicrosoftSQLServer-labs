USE UNIVER
go
CREATE PROCEDURE PSUBJECT -- �������� ���������
as
begin
	declare @k int = (select count (*) from SUBJECT);
	select SUBJECT.SUBJECT [���], SUBJECT.SUBJECT_NAME [����������], SUBJECT.PULPIT [�������] from SUBJECT;
	return @k;	--���������� �������� � ����� ������, ������ ������ ���������� ��������� 
end;
go

declare @k int = 0;
EXEC @k = PSUBJECT;
print '���-�� ��������� = ' + cast(@k as varchar(3));

--DROP PROCEDURE PSUBJECT