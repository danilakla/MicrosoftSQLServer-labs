--Операции добавления и изменения строк базы данных могут повлечь образование неиспользуемых фрагментов в области памяти 
--индекса. Процесс образования неис-пользуемых фрагментов памяти называется фрагментацией

--Фрагментация индексов снижает эффект от их применения. 

use tempdb
CREATE table #TEST5
(
	TKEY int,
	CC int identity(1,1),
	TF varchar(100)
);
SET nocount on;
DECLARE @i int = 0;
WHILE @i < 20000
	begin
		INSERT #TEST5(TKEY, TF)
			values(floor(20000*RAND()),REPLICATE('text',3));
	SET @i = @i + 1;
	end;

CREATE index #TEST5_TKEY ON #TEST5(TKEY); 
INSERT top(10000) #TEST5(TKEY, TF) select TKEY, TF from #TEST5;

--Получить информацию о степени фрагментации индекса можно с помощью опе-раторов: 
 SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]			--степень фрагментации индекса
        FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
        OBJECT_ID(N'#TEST5'), NULL, NULL, NULL) ss
        JOIN sys.indexes ii 
		ON ss.object_id = ii.object_id and ss.index_id = ii.index_id 
		WHERE name is not null;

--Для избавления от фрагментации индекса предусмотрены две специальные опера-ции: реорганизация и перестройка индекса.
--Реорганизация (REORGANIZE) выполняется быстро, но после нее фрагментация будет убрана только на самом нижнем уровне

ALTER index #TEST5_TKEY on #TEST5 reorganize --реорганизация (-фрагм на нижнем)
 SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]			--степень фрагментации индекса
        FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
        OBJECT_ID(N'#TEST5'), NULL, NULL, NULL) ss
        JOIN sys.indexes ii 
		ON ss.object_id = ii.object_id and ss.index_id = ii.index_id 
		WHERE name is not null;

--Операция перестройки (REBUILD) затрагивает все узлы дерева, поэтому после ее выполнения степень фрагментации равна нулю

ALTER index #TEST5_TKEY on #TEST5 rebuild with (online = off) --перестройка (меняет ветки местами) проходит через все дерево => фрагм=0
 SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]			--степень фрагментации индекса
        FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
        OBJECT_ID(N'#TEST5'), NULL, NULL, NULL) ss
        JOIN sys.indexes ii 
		ON ss.object_id = ii.object_id and ss.index_id = ii.index_id 
		WHERE name is not null;


DROP index #TEST5_TKEY on #TEST5
DROP TABLE #TEST5