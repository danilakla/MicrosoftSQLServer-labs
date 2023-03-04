use UNIVER;
SELECT PULPIT.PULPIT_NAME[Кафедра], isnull(TEACHER.TEACHER_NAME, '***')[Преподаватель]
	from TEACHER Left Outer Join PULPIT
	on TEACHER.PULPIT = PULPIT.PULPIT

--- аналогичный вывод через right outer join

SELECT PULPIT.PULPIT_NAME[Кафедра], isnull(TEACHER.TEACHER_NAME, '***')[Преподаватель]
	from PULPIT Right Outer Join TEACHER 
	on TEACHER.PULPIT = PULPIT.PULPIT