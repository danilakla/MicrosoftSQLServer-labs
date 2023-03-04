USE UNIVER;
go
/* секцию ORDER BY можно использовать только совместно с опцией TOP */
CREATE VIEW [Дисциплины]
	as select TOP 15  SUBJECT.SUBJECT_NAME [Код дисциплины],
					  SUBJECT.SUBJECT_NAME [Наименование дисциплины],
					  SUBJECT.PULPIT [Код кафедры]
	FROM SUBJECT
	ORDER BY SUBJECT.SUBJECT_NAME
go
SELECT * FROM [Дисциплины] 

DROP VIEW [Дисциплины] 
