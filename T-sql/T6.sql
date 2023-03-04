
-- Разработать сценарий, в котором с помощью CASE анализируются оцен-ки, полученные студентами некоторо-го факультета при сдаче экзаменов.
USE UNIVER;
SELECT CASE 
		when (PROGRESS.NOTE = 5) then 'пять'
		when (PROGRESS.NOTE = 6) then 'шесть'
		when (PROGRESS.NOTE between 6 and 7) then 'семь'
		when (PROGRESS.NOTE between 7 and 8) then 'восемь'
		else 'другая отметка'
		end [Оценка],
		count(*) [Количество учеников с данной отметкой]
		FROM PROGRESS 
		Inner Join STUDENT ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
		GROUP BY CASE 
			when (PROGRESS.NOTE = 5) then 'пять'
			when (PROGRESS.NOTE = 6) then 'шесть'
			when (PROGRESS.NOTE between 6 and 7) then 'семь'
			when (PROGRESS.NOTE between 7 and 8) then 'восемь'
			else 'другая отметка'
			end
		ORDER BY [Количество учеников с данной отметкой]
