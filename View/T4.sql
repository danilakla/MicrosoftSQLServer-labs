USE UNIVER;
------Выполнение INSERT и UPDATE допускается, но с учетом ограничения, задаваемого опцией WITH CHECK OPTION
go
CREATE VIEW [Лекционные аудитории]
	as select AUDITORIUM.AUDITORIUM [Код аудитории],
			  AUDITORIUM.AUDITORIUM_TYPE [Тип аудитории]
	FROM AUDITORIUM
	WHERE AUDITORIUM.AUDITORIUM_TYPE like('ЛК%') WITH CHECK OPTION
go
SELECT * FROM [Лекционные аудитории]

/* пробуем добавить строку, которая не будет удовлетворять условию */
--INSERT INTO [Лекционные аудитории]([Код аудитории], [Тип аудитории]) values ('1490-1', 'ЛБ-К'); 
/* выдается ошибка, если не поменять ЛБ-К на ЛК */
--INSERT INTO [Лекционные аудитории]([Код аудитории], [Тип аудитории]) values ('141-11', 'ЛК');
SELECT * FROM [Лекционные аудитории] WHERE [Код аудитории] = '140-1'



DROP VIEW [Лекционные аудитории]

