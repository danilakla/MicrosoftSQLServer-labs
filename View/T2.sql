/* работа с inner join двух таблиц в представлении */
USE UNIVER;
go
CREATE VIEW [Количество кафедр]
	as select FACULTY.FACULTY_NAME [Факультет],
			  count(*) [Количество кафедр]	/* агригатная ф-ия, вычисляющая кол-во строк с один. знач-м faculty_name  */
			  FROM FACULTY Inner Join PULPIT
			  ON FACULTY.FACULTY = PULPIT.FACULTY
			  GROUP BY FACULTY.FACULTY_NAME
go
SELECT * FROM [Количество кафедр]

DROP VIEW [Количество кафедр];