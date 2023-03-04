USE UNIVER;
go
/* запрос из 2го задания */
CREATE VIEW [Количество кафедр]
	as select FACULTY.FACULTY_NAME [Факультет],
			  count(*) [Количество кафедр]
			  FROM FACULTY Inner Join PULPIT
			  ON FACULTY.FACULTY = PULPIT.FACULTY
			  GROUP BY FACULTY.FACULTY_NAME
go
SELECT * FROM [Количество кафедр]
/* Опция SCHEMABINDING устанавливает запрещение на операции с таблицами и представлениями, которые могут привести к 
   нарушению ра-ботоспособности представления.
   Также оно помогает установить свойство привязанности представления к ба-зовым таблицам */
go
ALTER VIEW [Количество кафедр] WITH SCHEMABINDING
	as select FACULTY.FACULTY_NAME [Факультет],
			  count(*) [Количество кафедр]
			  FROM dbo.FACULTY Inner Join dbo.PULPIT
			  ON FACULTY.FACULTY = PULPIT.FACULTY
			  GROUP BY FACULTY.FACULTY_NAME
go

SELECT * FROM [Количество кафедр]

DROP VIEW [Количество кафедр];