
--������� ��������� ��������� ������� �� ���� �������� � 10 �����, �����-���� �� � ������� ����������. ��-���������� �������� WHILE.
CREATE TABLE #TEST 
(
	TIND int, 
	TFIELD varchar(100),
	THASH varchar(20)
)
--SET nocount on --�� ������� ��������� � ����� ������
-- ��������� �������� ������ ��������� ����� ���.
DECLARE @i int = 0
WHILE @i < 10
	begin
		insert #TEST(TIND, TFIELD, THASH) 
			values (@i, 'vladik', 1000 - @i)
		if (@i % 10 = 0) 
			print @i;
		set @i = @i + 1
	end
SELECT * FROM #TEST
DROP TABLE #TEST