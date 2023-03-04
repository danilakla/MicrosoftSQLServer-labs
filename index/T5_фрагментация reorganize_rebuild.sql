--�������� ���������� � ��������� ����� ���� ������ ����� ������� ����������� �������������� ���������� � ������� ������ 
--�������. ������� ����������� ����-���������� ���������� ������ ���������� �������������

--������������ �������� ������� ������ �� �� ����������. 

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

--�������� ���������� � ������� ������������ ������� ����� � ������� ���-�������: 
 SELECT name [������], avg_fragmentation_in_percent [������������ (%)]			--������� ������������ �������
        FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
        OBJECT_ID(N'#TEST5'), NULL, NULL, NULL) ss
        JOIN sys.indexes ii 
		ON ss.object_id = ii.object_id and ss.index_id = ii.index_id 
		WHERE name is not null;

--��� ���������� �� ������������ ������� ������������� ��� ����������� �����-���: ������������� � ����������� �������.
--������������� (REORGANIZE) ����������� ������, �� ����� ��� ������������ ����� ������ ������ �� ����� ������ ������

ALTER index #TEST5_TKEY on #TEST5 reorganize --������������� (-����� �� ������)
 SELECT name [������], avg_fragmentation_in_percent [������������ (%)]			--������� ������������ �������
        FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
        OBJECT_ID(N'#TEST5'), NULL, NULL, NULL) ss
        JOIN sys.indexes ii 
		ON ss.object_id = ii.object_id and ss.index_id = ii.index_id 
		WHERE name is not null;

--�������� ����������� (REBUILD) ����������� ��� ���� ������, ������� ����� �� ���������� ������� ������������ ����� ����

ALTER index #TEST5_TKEY on #TEST5 rebuild with (online = off) --����������� (������ ����� �������) �������� ����� ��� ������ => �����=0
 SELECT name [������], avg_fragmentation_in_percent [������������ (%)]			--������� ������������ �������
        FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), 
        OBJECT_ID(N'#TEST5'), NULL, NULL, NULL) ss
        JOIN sys.indexes ii 
		ON ss.object_id = ii.object_id and ss.index_id = ii.index_id 
		WHERE name is not null;


DROP index #TEST5_TKEY on #TEST5
DROP TABLE #TEST5