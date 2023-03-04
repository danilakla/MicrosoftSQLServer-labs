--Разработать скрипт, в котором опре-деляется общая вместимость аудито-рий. Когда общая вместимость пре-вышает 200, 
--то вывести количество аудиторий, среднюю вместимость аудиторий, количество аудиторий, вместимость которых меньше средней, 
--и процент таких аудиторий. Когда общая вместимость аудиторий меньше 200, то вывести сообщение о размере общей вместимости

USE UNIVER;
DECLARE @capacity int = (SELECT SUM(AUDITORIUM.AUDITORIUM_CAPACITY) FROM AUDITORIUM),
		@numOfAud int = (SELECT COUNT(*) FROM AUDITORIUM),
		@avgCapac int = (SELECT AVG(AUDITORIUM.AUDITORIUM_CAPACITY) FROM AUDITORIUM),
		@numLessAvg int,
		@proc numeric(8,3);	--Тип numeric позволяет хранить числа с очень большим количеством цифр
							-- Вычисления с типом numeric дают точные результаты, где это возможно, например, при сложении, вычитании и умножении.
IF @capacity > 200
begin
	PRINT 'Полная вместимость аудиторий: ' + cast(@capacity as varchar(10));	/* cast преобразует один тип в другой. надо так делать иначе будет ошибка Conversion failed when converting the varchar value 'Полная вместимость аудиторий: ' to data type int. */
	PRINT 'Количество аудиторий: ' + cast(@numOfAud as varchar(10));
	PRINT 'Средняя вместимость аудиторий: ' + cast(@avgCapac as varchar(10));
	SET @numLessAVG = (SELECT count(*)		-- выбор тех ауд., вместимость которых меньше среднего
							FROM AUDITORIUM
							WHERE AUDITORIUM_CAPACITY < @avgCapac)
	PRINT 'Количество аудиторий, вместимость которых менее средней: ' + cast(@numLessAVG as varchar(10));
	SET @proc = ((cast(@numLessAvg as numeric(8,3)) *100) / cast(@numOfAud as numeric(8,3)));	-- подсчет процент таких ауд.
	PRINT 'Процент аудиторий, вместимость которых менее средней: ' + cast(@proc as varchar(10));
end
ELSE IF @capacity = 200 PRINT 'Общая вместительность равна 200'
ELSE IF @capacity < 200 PRINT 'Общая вместительность меньше 200'

