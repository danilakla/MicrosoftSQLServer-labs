USE UNIVER;
go
/* работа с представлением (view) */
CREATE VIEW [Преподаватель]
	as select TEACHER [Код],
			  TEACHER_NAME[Имя преподавателя],
			  PULPIT [Кафедра] 
		FROM TEACHER
/* вывод на экран представления Преподаватнль */
go
SELECT * FROM Преподаватель
/* изменение представления с пом оператора Alter (добавляем ) */
go
ALTER VIEW [Преподаватель]
	as select TEACHER [Код],
			  TEACHER_NAME[Имя преподавателя],
			  GENDER [Пол],
			  PULPIT [Кафедра] 
		FROM TEACHER
go
SELECT * FROM Преподаватель
/* удаление представления */
DROP VIEW [Преподаватель]