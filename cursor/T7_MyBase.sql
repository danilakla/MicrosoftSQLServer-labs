USE PP_MyBase;
SELECT * FROM �����_��������
DECLARE @m nvarchar(20), @col int, @dis nvarchar(20);
DECLARE Places CURSOR LOCAL DYNAMIC
	for SELECT �����_��������, ����������_�����, ��������
	FROM �����_��������

OPEN Places;

FETCH Places into @m, @col, @dis;
PRINT '��������� ������: ' + @m + ' ' + @dis

FETCH LAST from Places into @m, @col, @dis;
PRINT '��������� ������: ' + @m + ' ' + @dis

FETCH FIRST from Places into @m, @col, @dis;
PRINT '������ ������ ������: ' + @m + ' ' + @dis

CLOSE Places
PRINT '--------------------------------------------------------'
DECLARE Places CURSOR GLOBAL DYNAMIC
	for SELECT �����_��������, ����������_�����, ��������
	FROM �����_��������

OPEN Places;

FETCH Places into @m, @col, @dis;
PRINT '��������� ������: ' + @m + ' ' + @dis

FETCH LAST from Places into @m, @col, @dis;
PRINT '��������� ������: ' + @m + ' ' + @dis

FETCH FIRST from Places into @m, @col, @dis;
PRINT '������ ������ ������: ' + @m + ' ' + @dis

CLOSE Places
DEALLOCATE Places
go
PRINT '--------------------------------------------------------'
DECLARE @disc nvarchar(20), @rez char(300) = '';
DECLARE Placess CURSOR
	for SELECT ��������
	FROM �����_��������

OPEN Placess;

FETCH Placess into @disc;
PRINT '<-------����� ��������------->' 
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @rez = rtrim(@disc) + ', ' + @rez;
			FETCH Placess into @rez;
		END
	PRINT @rez
CLOSE Placess
DEALLOCATE Placess