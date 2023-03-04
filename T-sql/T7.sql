
--Создать временную локальную таблицу из трех столбцов и 10 строк, запол-нить ее и вывести содержимое. Ис-пользовать оператор WHILE.
CREATE TABLE #TEST 
(
	TIND int, 
	TFIELD varchar(100),
	THASH varchar(20)
)
--SET nocount on --не выводит сообщения о вводе строки
-- Повторяет значение строки указанное число раз.
DECLARE @i int = 0
WHILE @i < 10
	begin
		insert #TEST(TIND, TFIELD, THASH) 
			values (@i, 'vladik', 1000 - @i)
		if (@i % 10 = 0) 
			print @i;
		set @i = @i + 1
	end
SELECT * FROM #TEST
DROP TABLE #TEST