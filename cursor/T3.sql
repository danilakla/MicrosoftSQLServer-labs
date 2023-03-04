--�������� ������������ ������� �������� � �������� ��������������� ����-�� �� ��������� ������� ��������� �� TEMPDB,
--� ��� ���������� �������� �������������� � ���� ��������

--����� �������� ������� @@CURSOR_ROWS ����� -n (���������� �������) ��� ����������� �������, ����� n ��� ���������� �������,
--����� 0, ���� ���-��� �� ������

-- ����������� ��������� ��������� ��������� ������� �� ������� ����������, �� �������� ���������� �����.

--��� ���������� ������� ��� ��������� (UPDATE, DELETE � INSERT) � �����-��� ������� �� ���������� �� ���������� ������� �����

use UNIVER
DECLARE @sid char(25), @sdate char(25), @spr char(3)
DECLARE StudPr CURSOR LOCAL STATIC
				for SELECT PROGRESS.IDSTUDENT, PROGRESS.PDATE, PROGRESS.NOTE
					FROM PROGRESS
					WHERE PROGRESS.SUBJECT IN('����')
	OPEN StudPr;
	print '���������� �����: ' + cast(@@CURSOR_ROWS as varchar(5));
	UPDATE PROGRESS set NOTE = 6 where IDSTUDENT = 1014
	DELETE PROGRESS where IDSTUDENT = 1016
	INSERT PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
			values('����', 1016, cast('2013-12-01' as date), 7);
	FETCH StudPr into @sid, @sdate, @spr;
	while @@FETCH_STATUS = 0
	begin
		print @sid + '' + @sdate + '' + @spr;
		fetch StudPr into @sid, @sdate, @spr;
	end;
	CLOSE StudPr;
	DEALLOCATE StudPr


---------------------------------------------------------------
go
DECLARE @sid char(25), @sdate char(25), @spr char(3)
DECLARE StudPr CURSOR LOCAL DYNAMIC
				for SELECT PROGRESS.IDSTUDENT, PROGRESS.PDATE, PROGRESS.NOTE
					FROM PROGRESS
					WHERE PROGRESS.SUBJECT IN('����')
	OPEN StudPr;
	print '���������� �����: ' + cast(@@CURSOR_ROWS as varchar(5));
	UPDATE PROGRESS set NOTE = 5 where IDSTUDENT = 1014
	DELETE PROGRESS where IDSTUDENT = 1016
	INSERT PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
			values('����', 1016, cast('2013-12-01' as date), 5);
	FETCH StudPr into @sid, @sdate, @spr;
	while @@FETCH_STATUS = 0
	begin
		print @sid + '' + @sdate + '' + @spr;
		fetch StudPr into @sid, @sdate, @spr;
	end;
	CLOSE StudPr;
	DEALLOCATE StudPr
go