--Уровнем фрагментации можно в некоторой степени управлять, если при создании или изменении индекса использовать 
--параметры FILLFACTOR и PAD_INDEX. 

use tempdb;
CREATE table #TEST6
(
	TKEY int,
	CC int identity(1,1),
	TF varchar(100)
);
SET nocount on;
DECLARE @i int = 0;
WHILE @i < 20000
	begin
		INSERT #TEST6(TKEY, TF)
			values(floor(20000*RAND()),REPLICATE('text',3));
	SET @i = @i + 1;
	end;

--Параметр FILLFACTOR указывает процент заполнения индексных страниц ниж-него уровня.
CREATE index #TEST6_TKEY on #TEST6(TKEY) with (fillfactor = 65);

INSERT top(10000) #TEST6(TKEY, TF) select TKEY, TF from #TEST6;
--INSERT top(100) percent INTO #TEST6(TKEY, TF) 
--                       SELECT TKEY, TF  FROM #TEST6;

SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
       FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),    
       OBJECT_ID(N'#TEST6'), NULL, NULL, NULL) ss  JOIN sys.indexes ii 
                                     ON ss.object_id = ii.object_id and ss.index_id = ii.index_id  
                                                                                          WHERE name is not null;

drop index #TEST6_TKEY on #TEST6
drop table #TEST6

