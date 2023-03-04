USE [UNIVER]
GO

/****** Object:  StoredProcedure [dbo].[PSUBJECT]    Script Date: 19.05.2022 11:07:12 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
GO
-- ���-�� ��������� ����� ������� ����� ��� ��������� ������� � �������� ��������
--@p - ��� �������, @c - ���-�� �����
ALTER PROCEDURE [dbo].[PSUBJECT] @p varchar(20) = null, @c int output -- ��������� ��� ������� ���������: p ��������� ���� �� �� varchar, � - �������� ��������
as
begin
	declare @k int = (select count (*) from SUBJECT);
	set @c = (select count(*) from SUBJECT where SUBJECT.PULPIT = @p)
	select SUBJECT.SUBJECT [���], SUBJECT.SUBJECT_NAME [����������], SUBJECT.PULPIT [�������] from SUBJECT
																				where SUBJECT.PULPIT = @p;
	return @k;		--���������� �������� � ����� ������, ������ ������ ���������� ��������� 
end;
GO

declare @k int, @rez int = 0
exec @k = PSUBJECT @p = '����', @c = @rez output
print @k
print @rez