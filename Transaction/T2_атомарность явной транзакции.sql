-- в случае если в try заполнение не получится, код перейдет в catch, выдаст ошибку и выполнится откат через rollback
-- доказали что работает св-во атомарности

USE UNIVER
DECLARE @trcount int
BEGIN TRY -- начало блока try
	BEGIN TRAN -- Переключение в режим явной транзакции
		DELETE AUDITORIUM_TYPE WHERE AUDITORIUM_TYPENAME = 'Новая лекционная';
		--DELETE AUDITORIUM_TYPE WHERE AUDITORIUM_TYPENAME = 'Самая новая лекционная';
		INSERT AUDITORIUM_TYPE VALUES ('ЛК-Н', 'Новая лекционная');
		INSERT AUDITORIUM_TYPE VALUES ('ЛК-Н', 'Новая лекционная');
		INSERT AUDITORIUM_TYPE VALUES ('ЛК-С', 'Самая новая лекционная');
		COMMIT TRAN;
	END TRY
BEGIN CATCH 
		PRINT 'Ошибка: ' + case -- PATINDEX определяет в строке позицию первого символа под-строки, заданную шаблоном
							WHEN error_number() = 2627 and patindex('%AUDITORIUM_TYPE_PK%', error_message()) > 0 -- 2627 - Ошибка дубл поля
								THEN 'дублирование типа аудитории'
						   else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + error_message()
						   end;
	SET @trcount = @@TRANCOUNT  -- возвращает уровень вложенности транзакции (если больше 0 то тран не закончена)
	PRINT @trcount
	IF @@TRANCOUNT > 0 ROLLBACK TRAN;
END CATCH;

-- в итоге получится что так как тран не заверш (@trancount будет = 1), то произойдет откат и изменен insert не вступят в силу
-- также мы не примере показали работу св-ва атомарности: опер-ы изм-я включе в тран-ю либо все выполня-я, либо нет.
