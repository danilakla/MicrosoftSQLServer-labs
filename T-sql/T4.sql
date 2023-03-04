-- 1
-- вычисления корней уравнений системы
DECLARE @z float, @x int = 5, @t int = 13
if		@t > @x
	SET @z = power(sin(@t),2);
else if @t < @x
	SET @z = 4 * (@t + @x);
else
	SET @z = (1 - exp(@x - 2))
PRINT 'z= ' + cast(@z as varchar(10))


-- 2
-- преобразование полного ФИО в сокращенное
DECLARE @result nvarchar(20);
DECLARE @fullname TABLE 
			(
				surname nvarchar(10) default 'Вакуленчик',
				name nvarchar(10) default 'Владислав',
				secondname nvarchar(10) default 'Сергеевич'
			);
INSERT @fullname default values;
SELECT * FROM @fullname;

-- функция LEFT извлекает подстроку из строки, начиная с самого левого символа.
Set @result = (SELECT (surname + ' ' + left(name, 1) + '. ' + left(secondname, 1) + '.') from @fullname); 

PRINT @result
SELECT @result result


-- 3
-- Вывести список студнтов, чей др в некст месяце
-- DATEDIFF( интервал, дата1, дата2 ) - Возвращает значение типа Variant (Long), указывающее на количество интервалов времени между двумя указанными датами
-- функция YEAR возвращает четырехзначный год (как число) с учетом значения даты
-- SYSDATETIME() - Возвращает значение типа datetime2(7), которое содержит дату и время компьютера, на котором запущен экземпляр SQL Server.
USE UNIVER;
SELECT STUDENT.NAME [Имя студента],
	   STUDENT.BDAY [День рождения],
	   DATEDIFF(YEAR, STUDENT.BDAY, SYSDATETIME()) AS [Количество полных лет]
FROM STUDENT 
-- функция MONTH возвращает месяц (число от 1 до 12) с учетом значения даты.
-- DATEADD( интервал (m - месяц), число, дата ) - Возвращает значение типа Variant (Date), содержащее результат прибавления к дате указанного интервала времени
WHERE MONTH(STUDENT.BDAY) = MONTH(DATEADD(m, 1, SYSDATETIME())) --добавляем к нашему ПК месяцу единицу


-- 4
-- поиск дня недели, в который студенты некоторой группы сдавали экзамен по СУБД.
-- DatePart (интервал (w - week), дата ) - данные содержащее указанную часть заданной даты.
DECLARE @examday date
SET @examday = (SELECT PROGRESS.PDATE 
				FROM PROGRESS Inner Join STUDENT ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
				WHERE PROGRESS.SUBJECT in('СУБД') and STUDENT.IDSTUDENT in('1015'))
PRINT 'День, в который студенты некоторой группы сдавали экзамен по СУБД: ' + cast(@examday as varchar(10))
PRINT 'День недели, в который студенты некоторой группы сдавали экзамен по СУБД: ' + CONVERT (varchar(12), DATEPART(w, @examday))
