USE UNIVER;
/* отобразить все элементы */
select * from AUDITORIUM;
/* №1 */
SELECT  max(AUDITORIUM.AUDITORIUM_CAPACITY)[Max вместимость], 
		min(AUDITORIUM.AUDITORIUM_CAPACITY)[Min вместимость], 
		avg(AUDITORIUM.AUDITORIUM_CAPACITY)[Средняя вместимость аудиторий], 
		sum(AUDITORIUM.AUDITORIUM_CAPACITY)[Суммарная вместимость всех аудиторий], 
		count(*)[Общее количество аудиторий]
	FROM AUDITORIUM

/* №2 */
/* Group By позволяет отсортировать строки с одинковыми именами. При sum при объедении таких строк их стоимость (например)
   будет суммироваться 
*/
USE UNIVER;
SELECT  AUDITORIUM_TYPE.AUDITORIUM_TYPENAME[Тип аудитории], 
		max(AUDITORIUM.AUDITORIUM_CAPACITY)[Max вместимость], 
		min(AUDITORIUM.AUDITORIUM_CAPACITY)[Min вместимость], 
		avg(AUDITORIUM.AUDITORIUM_CAPACITY)[Средняя вместимость аудиторий], 
		sum(AUDITORIUM.AUDITORIUM_CAPACITY)[Суммарная вместимость всех аудиторий], 
		count(*)[Общее количество аудиторий]
	FROM AUDITORIUM Inner Join AUDITORIUM_TYPE
	ON AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
	Group by AUDITORIUM_TYPE.AUDITORIUM_TYPENAME

/* №3 */
USE UNIVER;
SELECT * FROM 
			(SELECT Case 
				when PROGRESS.NOTE = 10 then '10'
				when PROGRESS.NOTE between 8 and 9 then '8-9'
				when PROGRESS.NOTE between 6 and 7 then '6-7'
				when PROGRESS.NOTE between 4 and 5 then '4-5'
				when PROGRESS.NOTE between 1 and 3 then '1-3'
				end [Оценки], count(*)[Количество]			/* после этой строчки будет несколько строк с одинаковыми значениями поля Оценки */
					FROM PROGRESS
					GROUP BY Case		/* уберем повторы с помощью Group By */
						when PROGRESS.NOTE = 10 then '10'	/* здесь прописываем имена строк которые будут объеденяться */
						when PROGRESS.NOTE between 8 and 9 then '8-9'
						when PROGRESS.NOTE between 6 and 7 then '6-7'
						when PROGRESS.NOTE between 4 and 5 then '4-5'
						when PROGRESS.NOTE between 1 and 3 then '1-3'
						end) as T
						ORDER BY Case [Оценки]	/* прописываем сортировку для получившихся приколов */
						when '10' then 1
						when '8-9' then 2
						when '6-7' then 3
						when '4-5' then 4
						else 0
						end;

/* №4(а) */
USE UNIVER;
/* Встроенная функция CAST используется в запросе для перевода значения в вещественное число. */
/* Функция ROUND обеспечивает расчет значений с точностью до двух знаков после запятой: */

SELECT  f.FACULTY[Факультет], /* задаем какие поля будут выводится (после точки, это столбцы, f,g - ) */
		g.PROFESSION[Специальность], 
		g.YEAR_FIRST[Год поступления],
		round(avg(cast(p.NOTE as float(4))),2)[Средняя оценка]	/* считаем среднюю */
	FROM FACULTY f 
	Inner Join GROUPS g ON f.FACULTY = g.FACULTY
	Inner Join STUDENT s ON g.IDGROUP = s.IDGROUP
	Inner Join PROGRESS p ON p.IDSTUDENT = s.IDSTUDENT
	GROUP BY f.FACULTY, g.PROFESSION, g.YEAR_FIRST
	ORDER BY [Средняя оценка] desc;

/* №4(б) */
-- значения оценок использовались оценки только по дисциплинам с кодами БД и ОАиП
USE UNIVER;
SELECT  f.FACULTY[Факультет], 
		g.PROFESSION[Специальность], 
		g.YEAR_FIRST[Год поступления],
		round(avg(cast(p.NOTE as float(4))),2)[Средняя оценка]
	FROM FACULTY f 
	Inner Join GROUPS g ON f.FACULTY = g.FACULTY
	Inner Join STUDENT s ON g.IDGROUP = s.IDGROUP
	Inner Join PROGRESS p ON p.IDSTUDENT = s.IDSTUDENT
	WHERE p.SUBJECT IN('БД', 'ОАиП')
	GROUP BY f.FACULTY, g.PROFESSION, g.YEAR_FIRST
	ORDER BY [Средняя оценка] desc;

/*#5*/
-- только средняя оценка
USE UNIVER;
SELECT  f.FACULTY[Факультет], 
		g.PROFESSION[Специальность], 
		p.SUBJECT[Дисциплина],
		round(avg(cast(p.NOTE as float(4))), 2)[Средняя оценка]
	FROM FACULTY f 
	Inner Join GROUPS g ON f.FACULTY = g.FACULTY
	Inner Join STUDENT s ON g.IDGROUP = s.IDGROUP
	Inner Join PROGRESS p ON p.IDSTUDENT = s.IDSTUDENT
	WHERE f.FACULTY IN('ТОВ')
	GROUP BY f.FACULTY, g.PROFESSION, p.SUBJECT

--ROLLUP выводит такие же результирующие группы строк как и при обычном group by и итоговые строки по значениям, указанными в скобках справа от ключ слова rollup
SELECT  f.FACULTY[Факультет], 
		g.PROFESSION[Специальность], 
		p.SUBJECT[Дисциплина],
		round(avg(cast(p.NOTE as float(4))), 2)[Средняя оценка]
	FROM FACULTY f 
	Inner Join GROUPS g ON f.FACULTY = g.FACULTY
	Inner Join STUDENT s ON g.IDGROUP = s.IDGROUP
	Inner Join PROGRESS p ON p.IDSTUDENT = s.IDSTUDENT
	WHERE f.FACULTY IN('ТОВ')
	GROUP BY ROLLUP (f.FACULTY, g.PROFESSION, p.SUBJECT)
-- выведет две строки со среднем значением, итоговую строку по специальности, факультету и всем факультетам

-- №6: CUBE возращает любую возможную комбинацию групп и итогвых cтрок
SELECT  f.FACULTY[Факультет], 
		g.PROFESSION[Специальность], 
		p.SUBJECT[Дисциплина],
		round(avg(cast(p.NOTE as float(4))), 2)[Средняя оценка]
	FROM FACULTY f 
	Inner Join GROUPS g ON f.FACULTY = g.FACULTY
	Inner Join STUDENT s ON g.IDGROUP = s.IDGROUP
	Inner Join PROGRESS p ON p.IDSTUDENT = s.IDSTUDENT
	WHERE f.FACULTY IN('ТОВ')
	GROUP BY CUBE (f.FACULTY, g.PROFESSION, p.SUBJECT)