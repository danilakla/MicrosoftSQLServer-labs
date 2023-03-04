--������������������ ������� �� ������ �� ���������� ������� ����� � �������
--������� ������������������ ��-���������� ��������� ������. 

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

SELECT count(*)[���������� �����] FROM #TEST2;
SELECT * FROM #TEST2

--������� �� ���������� �������� - ���������
--��������� ������������, ������������������ ������ #TEST2_NONCLU �� ���� �������� TKEY � CC ������� #EX:
CREATE index #TEST2_NONCLU on #TEST2(TKEY, CC)					
--����������� �� ��������� ����������
SELECT * from  #TEST2 where  TKEY > 1500 and  CC < 4500;  
SELECT * from  #TEST2 order by  TKEY, CC
--����������� ��������� ������, ��� ��� ���� �� �������� �������������
SELECT * from  #TEST2 where  TKEY = 556 and  CC > 3			

DROP index #TEST2_NONCLU on #TEST2
DROP TABLE #TEST2
