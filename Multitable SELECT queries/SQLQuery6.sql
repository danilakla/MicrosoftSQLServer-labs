--- если некоторые пол€ двух таблиц не соединились, то с помощью Left Outer Join, можно вывести
--- те несоед. пол€, которые наход€тс€ в таблице слева от ключ слов Left Outer Join

--- isnull принимает два параметра и выводит тот, что первым не равен null

USE UNIVER;
SELECT PULPIT.PULPIT_NAME[ афедра], isnull (TEACHER.TEACHER_NAME, '***')[ѕреподаватель]
	FROM PULPIT Left Outer Join TEACHER
		ON PULPIT.PULPIT = TEACHER.PULPIT