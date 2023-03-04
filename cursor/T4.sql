--�� ��������� ��� ������� ���������� ������� SCROLL, ����������� ���-������ �������� FETCH � ��������������� ������� ����������������. 
--FIRST (������ ������), NEXT (��������� ������ �� �������), PRIOR (���������� ������ �� �������), ABSOLUTE 3 (������ ������ �� ������),  
--ABSOLUTE -3 (������ ������ �� �����),  RELATIVE  5 (����� ������ ������ �� �������),  RELATIVE  -5 (����� ������ ����� �� �������). 


DECLARE @s char(10), @ps char(50), @p char(10);
set @ps = '����'

DECLARE Dis CURSOR LOCAL DYNAMIC SCROLL
				FOR SELECT SUBJECT, PULPIT 
				FROM SUBJECT
				ORDER BY PULPIT
	OPEN Dis;
	FETCH Dis INTO @s, @p;
	WHILE @@FETCH_STATUS = 0
	begin
		PRINT @s+' '+@p
		FETCH Dis INTO @s, @p
	end
	
	PRINT '--last--'
	FETCH LAST FROM Dis into @s, @p
	PRINT @s+' '+@p

	PRINT '--first--'
	FETCH FIRST FROM Dis into @s, @p
	PRINT @s+' '+@p

	PRINT '--absolute 10--'
	FETCH ABSOLUTE 10 FROM Dis into @s, @p
	PRINT @s+' '+@p

	PRINT '--relative 5--'
	FETCH RELATIVE 5 FROM Dis into @s, @p
	PRINT @s+' '+@p

	PRINT '--relative -5--'
	FETCH RELATIVE -5 FROM Dis into @s, @p
	PRINT @s+' '+@p

	PRINT '--absolute -10--'
	FETCH ABSOLUTE -10 FROM Dis into @s, @p
	PRINT @s+' '+@p

	PRINT '--next--'
	FETCH NEXT FROM Dis into @s, @p
	PRINT @s+' '+@p

	PRINT '--prior--'
	FETCH PRIOR FROM Dis into @s, @p
	PRINT @s+' '+@p
	CLOSE Dis
	go