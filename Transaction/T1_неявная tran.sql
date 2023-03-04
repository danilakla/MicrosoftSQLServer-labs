-- Транзакция -  это механизм базы данных, позволяющий таким образом объединять несколько операторов, изменя-ющих базу данных, чтобы 
-- при выполнении этой совокупности операторов они или все выполнились или все не выполни-лись. 
-- Основные свойства транзакции: 
-- атомарность (операторы изменения БД, включенные в транзакцию, либо выполнят-ся все, либо не выполнится ни один); 
-- согласованность (транзакция должна фиксировать новое согласованное состояние БД); 
-- изолированность (отсутствие взаимного влияния параллельных транзакций на результаты их выполнения); 
-- долговечность (изменения в БД, выполненные и зафиксированные транзакцией, могут быть отменены только с помощью новой транзакции).



USE [Vakulenchik-SALES]
SET nocount on

IF exists(SELECT * FROM SYS.OBJECTS			-- есть ли таблмца NewT
		  WHERE OBJECT_ID = object_id(N'DBO.NewT'))
DROP TABLE NewT;	-- если есть то удаляем ее


DECLARE @c int, @flag char = 'c';

SET IMPLICIT_TRANSACTIONS ON --включили режим неявной транзакции
CREATE TABLE NewT	-- начало транзакции
(
	K int
)
	INSERT NewT values (1),
					(2),
					(3);

	SET @c = (SELECT count(*) FROM NewT);

	PRINT 'Количество строк в таблице NewT: ' + cast(@c as varchar(2));
	IF  @flag = 'c' COMMIT;		-- завершение транзакции: фиксация 
	ELSE ROLLBACK;				-- завершение транзакции: откат  
SET IMPLICIT_TRANSACTIONS OFF --выключаем режим неявной транзакции

IF exists(SELECT * FROM SYS.OBJECTS
		  WHERE OBJECT_ID = object_id(N'DBO.NewT'))
PRINT 'Таблица NewT есть';
ELSE PRINT 'Таблицы NewT нет'
-----------------------------------------------------


--DECLARE @r char = '';
--IF exists(SELECT * FROM SYS.OBJECTS
--		  WHERE OBJECT_ID = object_id(N'DBO.#newtable'))
--		  SET @r = 'yes'
--ELSE set @r = 'no'

--SET IMPLICIT_TRANSACTIONS ON
--if @r = 'yes'
--begin
--CREATE TABLE #newtable
--(
--	K int
--)

--COMMIT --оператор фиксации
--end

---- else rollback; -- оператор отката 

--SET IMPLICIT_TRANSACTIONS OFF



--INSERT INTO #newtable 
--values (1),
--	   (2),
--	   (3),
--	   (4)

--SELECT * FROM #newtable
--DROP TABLE #newtable