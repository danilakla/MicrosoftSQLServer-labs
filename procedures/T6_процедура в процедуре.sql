USE UNIVER
----добавляем данные в таблицу AUDITORIUM и в AUDITORIUM_TYPENAME

DROP PROCEDURE PAUDITORIUM_INSERTX

go
CREATE PROCEDURE PAUDITORIUM_INSERTX @a char(20), 
									 @n varchar(50), 
									 @c int = 0, 
									 @t char(10), 
									 @tn varchar(50) --AUDITORIUM_TYPE.AUDITORIUM_TYPENAME 
as 
begin try
	declare @rc int = 1;
	set transaction isolation level SERIALIZABLE;
		begin tran
		insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME)
			values (@t, @tn)
		exec @rc = PAUDITORIUM_INSERT @a, @n, @c, @t;	-- добавление второй строки, с такими же значениями
		commit tran;
	return @rc;
end try
begin catch
	print 'номер ошибки: ' + cast (error_number() as varchar(6));
	print 'сообщение:    ' + error_message();
	print 'уровень:      ' + cast (error_severity() as varchar(6));
	print 'метка:        ' + cast (error_state() as varchar(8));
	print 'номер строки: ' + cast (error_line() as varchar(8));
	if ERROR_PROCEDURE() is not null
	print 'имя процедуры: ' + cast (error_procedure() as varchar(8)); 
	if @@TRANCOUNT > 0 rollback tran;
	return -1;
end catch;
go
--------------------------------------------------

declare @rc int;

begin tran
exec @rc = PAUDITORIUM_INSERTX @a= '208-1', @n = '208-1', @c = 15, @t = 'ТУ2', @tn = 'Тип аудитории 2'
print @rc
if @rc = 1
	select * from AUDITORIUM
	select * from AUDITORIUM_TYPE
rollback
go 