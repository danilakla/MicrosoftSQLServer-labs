-- работа с глобальными переменными

PRINT 'Число обработанных строк: ' + cast(@@ROWCOUNT as varchar(10))
PRINT 'Версия SQL Server: ' + cast(@@VERSION as varchar(10))
PRINT 'Системный идентификатор процесса, назначенный сервером текущему подключению: ' + cast(@@SPID as varchar(10))
PRINT 'Код последней ошибки: ' + cast(@@ERROR as varchar(10))
PRINT 'Имя сервера: ' + cast(@@SERVERNAME as varchar(10))
PRINT 'Возвращает уровень вложенности транзакции: ' + cast(@@TRANCOUNT as varchar(10));
PRINT 'Проверка результата считывания строк результирующего набора: ' + cast(@@FETCH_STATUS as varchar(10))
PRINT 'Уровень вложенности текущей процедуры: ' + cast(@@NESTLEVEL as varchar(10))
