USE UNIVER;
/* представления и like */
go
CREATE VIEW [Аудитории] ([Код аудитории], [Тип аудитории])
	as select AUDITORIUM.AUDITORIUM,
			  AUDITORIUM.AUDITORIUM_TYPE		
	FROM AUDITORIUM
	WHERE AUDITORIUM.AUDITORIUM_TYPE like('ЛК%')
go
SELECT * FROM [Аудитории]

/* добавляем дополнительные строки */
--INSERT INTO [Аудитории] ([Код аудитории], [Тип аудитории]) values ('138-5', 'ЛК');
SELECT * FROM [Аудитории] WHERE [Код аудитории] = '138-5'


DROP VIEW [Аудитории]