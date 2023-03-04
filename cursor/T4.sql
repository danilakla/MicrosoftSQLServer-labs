--ѕо умолчанию дл€ курсора установлен атрибут SCROLL, позвол€ющий при-мен€ть оператор FETCH с дополнительными опци€ми позиционировани€. 
--FIRST (перва€ строка), NEXT (следующа€ строка за текущей), PRIOR (предыдуща€ строка от текущей), ABSOLUTE 3 (треть€ строка от начала),  
--ABSOLUTE -3 (треть€ строка от конца),  RELATIVE  5 (п€та€ строка вперед от текущей),  RELATIVE  -5 (п€та€ строка назад от текущей). 


DECLARE @s char(10), @ps char(50), @p char(10);
set @ps = '»—и“'

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