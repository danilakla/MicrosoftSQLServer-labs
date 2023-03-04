
-- работа с if else
USE UNIVER;
DECLARE @capacity int = (select sum(AUDITORIUM.AUDITORIUM_CAPACITY) from AUDITORIUM)
IF (@capacity > 100)
begin 
PRINT 'Суммарная вместительность аудиторий больше 100';
PRINT 'Суммарная вместительность: ' + cast(@capacity as varchar(10));
end;
ELSE
begin
PRINT 'Суммарная вместительность аудиторий меньше или равна 100';
PRINT 'Суммарная вместительность: ' + cast(@capacity as varchar(10));
end;