-- работа с формированием КТ через Save Tran

USE UNIVER;
DECLARE @point varchar(32);
BEGIN TRY
	BEGIN TRAN				--начало явной транзакции
		DELETE AUDITORIUM_TYPE WHERE AUDITORIUM_TYPENAME = 'Новая лекционная';
		SET @point = 'p1'; SAVE TRAN @point;	-- формируем контрольную точку транзакции.
		
		INSERT AUDITORIUM_TYPE VALUES ('ЛК-Н', 'Новая лекционная');
		SET @point = 'p2'; SAVE TRAN @point;	-- вторая КТ
		
		INSERT AUDITORIUM_TYPE VALUES ('ЛК-Н', 'Новая лекционная');
		--INSERT AUDITORIUM_TYPE VALUES ('ЛК-НН', 'НоваяНовая лекционная');
	COMMIT TRAN;	-- фиксируем тран после второй КТ (@point = p2)
END TRY
BEGIN CATCH 
		PRINT 'Ошибка: ' + CASE 
						   WHEN error_number() = 2627 and patindex('%AUDITORIUM_TYPE_PK%', error_message()) > 0
							THEN 'дублирование типа аудитории'
							ELSE 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + error_message()
						   end;
	IF @@TRANCOUNT > 0
		begin 
			print 'контрольная точка: ' + @point;
			rollback tran @point;		--откат к контрольной точке
			commit tran;				--фиксация изменений, выпоолненных до контрольной точки
		end
END CATCH

