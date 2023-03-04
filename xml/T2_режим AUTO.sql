-- Особенность режима AUTO проявляется в многотабличных запросах. В этом случае режим AUTO позволяет построить XML-фрагмент с 
-- приме-нением вложенных элементов.
USE UNIVER
select a.AUDITORIUM_NAME, at.AUDITORIUM_TYPENAME, a.AUDITORIUM_CAPACITY
		from AUDITORIUM a 
		Inner Join AUDITORIUM_TYPE at on at.AUDITORIUM_TYPE=a.AUDITORIUM_TYPE
			where a.AUDITORIUM_TYPE='ЛК' 
for xml auto, 
root('Лекционные_аудитории'), -- корневой тег
elements;
go 
