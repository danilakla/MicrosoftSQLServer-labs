--—оздать некластеризованный ин-декс покрыти€, уменьшающий стоимость SELECT-запроса. 
--Ќекластеризованный индекс покрыти€ запроса позвол€ет включить в состав ин-дексной строки значени€ одного или нескольких 
--неиндексируемых столбцов

CREATE table #TEST3
(
	TKEY int,
	CC int identity(1,1),
	TF varchar(100)
);
SET nocount on;
DECLARE @i int = 0;
WHILE @i < 20000
	begin
		INSERT #TEST3(TKEY, TF)
			values(floor(20000*RAND()),REPLICATE('text',3));
	SET @i = @i + 1;
	end;

--выделить три запроса, и показать что стоимость при include уменьшаетс€
SELECT CC from #TEST3 where TKEY>15000 
CREATE  index #TEST3_TKEY_X on #TEST3(TKEY) INCLUDE (CC)
SELECT CC from #TEST3 where TKEY>15000 

DROP index #TEST3_TKEY_X on #TEST3
DROP TABLE #TEST3