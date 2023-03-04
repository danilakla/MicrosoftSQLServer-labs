--Некластеризованные индексы не влияют на физический порядок строк в таблице
--Создать некластеризованный не-уникальный составной индекс. 

CREATE table #TEST2
(
	TKEY int,
	CC int identity(1,1),
	TF varchar(100)
);
SET nocount on;
DECLARE @i int = 0;
WHILE @i < 20000
	begin
		INSERT #TEST2(TKEY, TF)
			values(floor(20000*RAND()),REPLICATE('text',3));
	SET @i = @i + 1;
	end;

SELECT count(*)[количество строк] FROM #TEST2;
SELECT * FROM #TEST2

--индексы по нескольким столбцам - составные
--составной неуникальный, некластеризованный индекс #TEST2_NONCLU по двум столбцам TKEY и CC таблицы #EX:
CREATE index #TEST2_NONCLU on #TEST2(TKEY, CC)					
--оптимизатор не принимает индексатор
SELECT * from  #TEST2 where  TKEY > 1500 and  CC < 4500;  
SELECT * from  #TEST2 order by  TKEY, CC
--оптимизатор принимает индекс, так как одно из значений зафиксировано
SELECT * from  #TEST2 where  TKEY = 556 and  CC > 3			

DROP index #TEST2_NONCLU on #TEST2
DROP TABLE #TEST2
