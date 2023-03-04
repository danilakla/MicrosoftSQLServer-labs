--Если запросы основаны на WHERE-фильтрации строк, то может быть эффектив-ным применение фильтруемых 
--некластеризованных индексов.
--Создать некластеризованный фильтруемый индекс, уменьшаю-щий стоимость SELECT-запроса.

CREATE table #TEST4
(
	TKEY int,
	CC int identity(1,1),
	TF varchar(100)
);
SET nocount on;
DECLARE @i int = 0;
WHILE @i < 20000
	begin
		INSERT #TEST4(TKEY, TF)
			values(floor(20000*RAND()),REPLICATE('text',3));
	SET @i = @i + 1;
	end;

SELECT TKEY from  #TEST4 where TKEY between 5000 and 19999; 
SELECT TKEY from  #TEST4 where TKEY>15000 and  TKEY < 20000; 
SELECT TKEY from  #TEST4 where TKEY=17000;

--некластеризованный фильтруемый индекс
CREATE index #TEST4_WHERE on #TEST4(TKEY) where (TKEY>=15000 and TKEY < 20000);  

SELECT TKEY from  #TEST4 where TKEY > 15000 and  TKEY < 20000;  
SELECT TKEY from  #TEST4 where TKEY = 17000;

DROP index #TEST4_WHERE on #TEST4
DROP TABLE #TEST4
