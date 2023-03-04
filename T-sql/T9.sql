-- try-catch
declare @x int = 3, @y int = 0, @z int;
begin TRY
	set @z = @x / @y;
end TRY
begin CATCH 
	print 'Номер ошибки : ' + CAST(ERROR_NUMBER() as varchar(6));
	print 'Сообщение    : ' + ERROR_MESSAGE();
	print 'Номер строки : ' + CAST(ERROR_LINE() as varchar(8));
	print 'Процедура    : ' + CAST(ERROR_PROCEDURE() as varchar(6));
	print 'Уровень      : ' + CAST(ERROR_SEVERITY() as varchar(6));
	print 'Метка ошибки : ' + CAST(ERROR_STATE() as varchar(8));
end catch