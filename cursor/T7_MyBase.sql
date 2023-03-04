USE PP_MyBase;
SELECT * FROM Места_хранения
DECLARE @m nvarchar(20), @col int, @dis nvarchar(20);
DECLARE Places CURSOR LOCAL DYNAMIC
	for SELECT Место_хранения, Количество_ячеек, Описание
	FROM Места_хранения

OPEN Places;

FETCH Places into @m, @col, @dis;
PRINT 'следующая строка: ' + @m + ' ' + @dis

FETCH LAST from Places into @m, @col, @dis;
PRINT 'последняя строка: ' + @m + ' ' + @dis

FETCH FIRST from Places into @m, @col, @dis;
PRINT 'первая строка строка: ' + @m + ' ' + @dis

CLOSE Places
PRINT '--------------------------------------------------------'
DECLARE Places CURSOR GLOBAL DYNAMIC
	for SELECT Место_хранения, Количество_ячеек, Описание
	FROM Места_хранения

OPEN Places;

FETCH Places into @m, @col, @dis;
PRINT 'следующая строка: ' + @m + ' ' + @dis

FETCH LAST from Places into @m, @col, @dis;
PRINT 'последняя строка: ' + @m + ' ' + @dis

FETCH FIRST from Places into @m, @col, @dis;
PRINT 'первая строка строка: ' + @m + ' ' + @dis

CLOSE Places
DEALLOCATE Places
go
PRINT '--------------------------------------------------------'
DECLARE @disc nvarchar(20), @rez char(300) = '';
DECLARE Placess CURSOR
	for SELECT Описание
	FROM Места_хранения

OPEN Placess;

FETCH Placess into @disc;
PRINT '<-------Места хранения------->' 
	WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @rez = rtrim(@disc) + ', ' + @rez;
			FETCH Placess into @rez;
		END
	PRINT @rez
CLOSE Placess
DEALLOCATE Placess