
--ƒл€ объ€влени€ переменных, используемых в программах, предназначен оператор DECLARE
DECLARE 
--инициализаци€ в операторе объ€влени€
--»м€ переменной должно начинатьс€ с символа @
@h char = 'P',
@v varchar(4) = 'BSTU',
@datet date,
@dtime time,
@i int = 18,
@si smallint,
@ti tinyint,
@num numeric(12,5); 

--с помощью оператора SET можно переменной присвоить значение и выполн€ть вычислени€
SET @datet = '2022-03-31'
SET	@dtime = '20:20'

select @i = 3;
--с помощью оператора PRINT можно вывести строку в стандартный выходной поток.    
PRINT @h 
PRINT @v 
PRINT @datet
PRINT @dtime

--оператором SELECT можно сформировать выходной результирующий набор 
SELECT @i intv, @si smallintv, @ti tinyintv

